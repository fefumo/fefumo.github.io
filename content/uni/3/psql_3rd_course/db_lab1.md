# Этап 1
установка переменных окружения
```bash
export PGDATA=$HOME/hpd54
export PGLOCALE=en_US.KOI8-R
export PGENCODE=KOI8-R
```
создание кластера
```shell
initdb -D "$PGDATA" --encoding=$PGENCODE  --locale=$PGLOCALE 
```
т.к. 
на сервере не установлена локаль `en_US.KOI-8R`:
```
[postgres1@pg113 ~]$ locale -a | grep -i 'koi8'
ru_RU.KOI8-R
uk_UA.KOI8-U
```
, то придётся использовать utf-8:
```bash
initdb -D "$PGDATA" --locale=$PGLOCALE 
```
старт 
```bash
pg_ctl -D $PGDATA -l $PGDATA/server.log start
```
# Этап 2
конфигурация
- Способы подключения: 1) Unix-domain сокет в режиме peer; 2) сокет TCP/IP, принимать подключения к любому IP-адресу узла
- Номер порта: `9000`
```bash
cat > $PGDATA/postgresql.conf <<'EOF'
port = 9000
listen_addresses = '*'
EOF
```
- Способ аутентификации TCP/IP клиентов: по паролю MD5
- Остальные способы подключений запретить.
```bash
cat > $PGDATA/pg_hba.conf <<'EOF'
# 1) Unix-domain socket (local)
local   all             all                                     peer

# 2) TCP/IP from anywhere (IPv4 / IPv6) with password (md5)
host    all             all             0.0.0.0/0               md5
host    all             all             ::/0                    md5

# Reject everything else explicitly (defense in depth)
local   all             all                                     reject
host    all             all             0.0.0.0/0               reject
host    all             all             ::/0                    reject
EOF
```

```bash
pg_ctl -D $PGDATA restart
```

### Проверка:
unix
```bash
psql -p 9000 -d postgres -U postgres1
```
tcp по ipv4 (тут попросит пароль, т.к. выставлен md5) 
```bash
psql "host=127.0.0.1 port=9000 dbname=postgres user=postgres1"
```
по ipv6:
```bash
psql "host=::1 port=9000 dbname=postgres user=postgres1"
```

- Настроить следующие параметры сервера БД:
    - max_connections
    - shared_buffers
    - temp_buffers
    - work_mem
    - checkpoint_timeout
    - effective_cache_size
    - fsync
    - commit_delay
    
    Параметры должны быть подобраны в соответствии с аппаратной конфигурацией:  
    оперативная память 16ГБ, хранение на жёстком диске (HDD).
```bash
cat >> "$PGDATA/postgresql.conf" <<'EOF'

# --------------------------
# TUNING (16GB RAM, HDD)
# --------------------------

# Connections
max_connections = 200

# Memory
shared_buffers = 4GB
effective_cache_size = 12GB
work_mem = 16MB
temp_buffers = 16MB

# Checkpoints (HDD: реже чекпоинты, чтобы меньше дергать диск)
checkpoint_timeout = 15min

# Durability (оставляем надежность)
fsync = on

# Group commit tuning (имеет смысл при конкуренции коммитов)
# commit_delay работает только если commit_siblings > 0 (иначе обычно игнорируется)
commit_delay = 1000          # microseconds (1ms)
commit_siblings = 5

EOF
```
- Директория WAL файлов: `$PGDATA/pg_wal`
установлена по дефолту:
```bash
ls -la "$PGDATA/pg_wal"
```
- Формат лог-файлов: `.csv`
- Уровень сообщений лога: `INFO`
- Дополнительно логировать: попытки подключения и завершение сессий
```bash
cat >> "$PGDATA/postgresql.conf" <<'EOF'

# --------------------------
# LOGGING (CSV, INFO, connections)
# --------------------------

logging_collector = on
log_destination = 'csvlog'

# Where to write logs
log_directory = 'log'
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.csv'
log_rotation_age = 1d
log_rotation_size = 0
log_truncate_on_rotation = on

# Log level
log_min_messages = info

# Extra logging
log_connections = on
log_disconnections = on

EOF
```
создаем директорию для логгирования и перезапускаем
```bash
mkdir -p "$PGDATA/log"
chmod 700 "$PGDATA/log"
pg_ctl -D "$PGDATA" restart
```
# Этап 3
- Пересоздать шаблон template1 в новом табличном пространстве: `$HOME/cwv52`
создаем директорию
```bash
mkdir -p "$HOME/cwv52"
chmod 700 "$HOME/cwv52"
```
создаем темплейт
```bash
psql -p 9000 -d postgres -U postgres1 -v ON_ERROR_STOP=1 <<'SQL'
CREATE TABLESPACE ts_template1 LOCATION '/var/db/postgres1/cwv52';
SQL
```
переносим темплейт в ts_tempate1
```bash
psql -p 9000 -d postgres -U postgres1 -v ON_ERROR_STOP=1 <<'SQL'
-- На всякий: запретить подключения к template1
UPDATE pg_database SET datallowconn = false WHERE datname = 'template1';

-- Убить активные сессии к template1 (если вдруг есть)
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'template1' AND pid <> pg_backend_pid();

-- Перенос
ALTER DATABASE template1 SET TABLESPACE ts_template1;

-- Вернуть возможность подключаться (обычно template1 оставляют allowconn=true)
UPDATE pg_database SET datallowconn = true WHERE datname = 'template1';

SELECT datname, pg_tablespace_location(dattablespace) AS tablespace_location
FROM pg_database
WHERE datname IN ('template0','template1');
SQL
```
- На основе template0 создать новую базу: `bestpinkfood`
```bash
psql -p 9000 -d postgres -U postgres1 -v ON_ERROR_STOP=1 <<'SQL'
CREATE DATABASE bestpinkfood
  WITH TEMPLATE = template0
       ENCODING = 'UTF8'
       LC_COLLATE = 'C'
       LC_CTYPE = 'C';
SQL
```
проверка:
```bash
psql -p 9000 -d postgres -U postgres1 -c "\l+ bestpinkfood"
```
подключение:
```bash
psql -p 9000 -d bestpinkfood -U postgres1
```
- Создать новую роль, предоставить необходимые права, разрешить подключение к базе.
```bash
psql -p 9000 -d postgres -U postgres1 -v ON_ERROR_STOP=1 <<'SQL'
-- 1) role/user
CREATE ROLE bestpinkfood_user
  WITH LOGIN
       PASSWORD 'CHANGE_ME_STRONG'
       NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT;

-- 2) allow connect + basic db privileges
GRANT CONNECT, TEMPORARY ON DATABASE bestpinkfood TO bestpinkfood_user;
SQL
```
отдельно подключаемся и выдаем права, т.к. \connect не работает на freeBSD
```bash
psql -p 9000 -d bestpinkfood -U postgres1 -v ON_ERROR_STOP=1 <<'SQL'
-- 3) schema privileges (public schema in that DB)
GRANT USAGE ON SCHEMA public TO bestpinkfood_user;
GRANT CREATE ON SCHEMA public TO bestpinkfood_user;

GRANT CONNECT ON DATABASE postgres     TO bestpinkfood_user;
GRANT CONNECT ON DATABASE bestpinkfood TO bestpinkfood_user;

GRANT CREATE ON TABLESPACE ts_template1 TO bestpinkfood_user;
SQL
```
- От имени новой роли (не администратора) произвести наполнение ВСЕХ созданных баз тестовыми наборами данных. ВСЕ табличные пространства должны использоваться по назначению.
```bash
for db in postgres bestpinkfood; do
  echo "== Seeding $db =="
  psql "host=127.0.0.1 port=9000 dbname=$db user=bestpinkfood_user" -v ON_ERROR_STOP=1 <<'SQL'
-- отдельная схема под тестовые данные
CREATE SCHEMA IF NOT EXISTS seed AUTHORIZATION bestpinkfood_user;
SET search_path = seed, public;

-- 1) Таблица в DEFAULT tablespace (pg_default)
CREATE TABLE IF NOT EXISTS customers (
  id        bigserial PRIMARY KEY,
  name      text NOT NULL,
  email     text NOT NULL UNIQUE,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- 2) Таблица ЯВНО в ts_template1 (чтобы tablespace реально использовался)
-- (в задании "все табличные пространства должны использоваться" — это самый прямой способ)
CREATE TABLE IF NOT EXISTS events_ts1 (
  id        bigserial PRIMARY KEY,
  customer_id bigint NOT NULL,
  kind      text NOT NULL,
  payload   text,
  created_at timestamptz NOT NULL DEFAULT now()
) TABLESPACE ts_template1;

-- Заполняем customers
INSERT INTO customers(name, email)
SELECT
  'Customer ' || g,
  'customer' || g || '@example.com'
FROM generate_series(1, 2000) g
ON CONFLICT (email) DO NOTHING;

-- Заполняем events_ts1 (много строк, чтобы tablespace точно использовался)
INSERT INTO events_ts1(customer_id, kind, payload)
SELECT
  (random() * 1999)::int + 1,
  (ARRAY['signup','login','purchase','logout','support'])[ (random()*4)::int + 1 ],
  md5(random()::text)
FROM generate_series(1, 20000)
ON CONFLICT DO NOTHING;

-- Индекс тоже можно положить в tablespace (опционально, но полезно)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_class c
    JOIN pg_namespace n ON n.oid=c.relnamespace
    WHERE n.nspname='seed' AND c.relname='events_ts1_created_at_idx'
  ) THEN
    EXECUTE 'CREATE INDEX events_ts1_created_at_idx ON seed.events_ts1(created_at) TABLESPACE ts_template1';
  END IF;
END$$;

-- Проверка: где лежат объекты (tablespace)
SELECT
  current_database() as db,
  n.nspname as schema,
  c.relname as object,
  COALESCE(t.spcname, 'pg_default') as tablespace
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
WHERE n.nspname='seed' AND c.relkind IN ('r','i')
ORDER BY c.relkind, c.relname;
SQL
done
```
- Вывести список всех табличных пространств кластера и содержащиеся в них объекты.

Список табличных пространств (OID, имя, путь на диске):
```bash
psql -p 9000 -d postgres -U postgres1 -v ON_ERROR_STOP=1 <<'SQL'
SELECT
  oid,
  spcname,
  pg_tablespace_location(oid) AS location,
  spcowner::regrole AS owner
FROM pg_tablespace
ORDER BY spcname;
SQL
```

Все объекты по табличным пространствам (включая pg_default):
```bash
psql -p 9000 -d postgres -U postgres1 -v ON_ERROR_STOP=1 <<'SQL'
WITH rels AS (
  SELECT
    d.datname,
    n.nspname,
    c.relname,
    c.relkind,
    COALESCE(NULLIF(c.reltablespace, 0), d.dattablespace) AS ts_oid,
    c.relpersistence
  FROM pg_class c
  JOIN pg_namespace n ON n.oid = c.relnamespace
  JOIN pg_database d ON d.oid = c.reldatabase
)
SELECT
  t.spcname AS tablespace,
  r.datname AS db,
  r.nspname AS schema,
  r.relname AS object,
  CASE r.relkind
    WHEN 'r' THEN 'table'
    WHEN 'i' THEN 'index'
    WHEN 'm' THEN 'materialized_view'
    WHEN 't' THEN 'toast'
    WHEN 'S' THEN 'sequence'
    WHEN 'p' THEN 'partitioned_table'
    WHEN 'I' THEN 'partitioned_index'
    ELSE r.relkind::text
  END AS kind
FROM rels r
JOIN pg_tablespace t ON t.oid = r.ts_oid
WHERE r.nspname NOT IN ('pg_toast')  -- убери эту строку, если хочешь видеть pg_toast схемы тоже
  AND r.relkind IN ('r','p','i','I','m','S','t')
ORDER BY t.spcname, r.datname,
```