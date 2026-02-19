#prog 
Чтобы настроить автоматическое заполнение имени и токена для коммитов и синхронизации с помощью плагина Obsidian Git, можно воспользоваться следующими шагами:

### Подготовка (just a reminder)
Если вы ещё этого не сделали, настройте глобальные параметры Git для имени пользователя и электронной почты: 
```bash
git config --global user.name "ВашеИмя"
git config --global user.email "ВашEmail"
``` 

Эти данные будут использоваться для всех коммитов, если не заданы локально в репозитории.

#### Не обязательно
Если вы хотите использовать токен напрямую в URL репозитория, можно указать его в `.gitconfig`:

1. Откройте или создайте файл `.git/config` в корне репозитория.
2. Замените URL для `origin` на следующее (с вашим токеном и именем пользователя):
```ini
[remote "origin"]
    url = https://<ваш_логин>:<ваш_токен>@github.com/<ваш_репозиторий>.git
    fetch = +refs/heads/*:refs/remotes/origin/*
```

## Actual way of doing it
Команда чтобы запустить daemon который прочтет логин пароль и сохранит их: 
```bash
git config credential.helper store
```
>[!TIP]
Можно использовать с флагом `--global`, тогда это будет актуально для всех репозиториев. Так как мне нужна работа только с obsidian_vault репой, я решил сделать именно так.

Затем можно сделать любое действие с удалённым репозитеорием, например (как сделал я), запушить туда изменения:
```bash
git add .
git commit -m "changes to make credential.helper work"
git push
<указываем логин>
<указываем токен от репы>
```
Готово:)
### 1. Где будут сохранены учетные данные?
Файл с сохранёнными учетными данными обычно располагается по пути:

- **Linux / macOS**: `~/.git-credentials`
- **Windows**: `C:\Users\<ваше_имя>\.git-credentials`

Этот файл содержит строки в формате:
```ini
https://<ваш_логин>:<ваш_токен>@github.com
```
### 2. Как удалить учетные данные?
Чтобы удалить сохранённые данные:
1. **Откройте файл с учетными данными**: 
```bash
nvim ~/.git-credentials
```
2. **Удалите ненужные записи или весь файл**.
3. **Если вы хотите полностью отключить `store`, выполните:**
```bash
git config --unset credential.helper
```
используем флаг `--global` если изначально ставили его.

### 3. Как хранить данные более безопасно?
Если вы хотите, чтобы данные хранились безопаснее, используйте вместо `store` системный менеджер учетных данных:
```bash
git config --global credential.helper cache
```
Или установите и используйте `libsecret` (предлагалось в [гайде для аутентификации git ](https://publish.obsidian.md/git-doc/Authentication)): 
```bash
git config set credential.helper libsecret
```


## Git/config
 Файл `.git/config`,настроенный с использованием `credential.helper=store`
### Что значат строки в конфигурации?

1. **Общие настройки репозитория:**
    
    ```plaintext
    core.repositoryformatversion=0
    core.filemode=true
    core.bare=false
    core.logallrefupdates=true
    ```
    
    - `core.repositoryformatversion=0` — версия формата репозитория. Обычно это всегда 0.
    - `core.filemode=true` — Git учитывает права доступа файлов (чтение/запись/исполнение). Обычно `true` на Linux/macOS.
    - `core.bare=false` — указывает, что это не bare-репозиторий (не просто "голый" репозиторий, а полноценный с рабочей директорией).
    - `core.logallrefupdates=true` — Git ведёт историю изменений ссылок (refs) в журнале.
2. **Удалённый репозиторий (`remote.origin`):**
    
    ```plaintext
    remote.origin.url=https://github.com/fefumo/obsidian_vault.git
    remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
    ```
    
    - `remote.origin.url` — URL вашего удалённого репозитория на GitHub.
    - `remote.origin.fetch` — правило для получения данных (fetch) из всех веток удалённого репозитория.
3. **Текущая ветка (`branch.main`):**
    
    ```plaintext
    branch.main.remote=origin
    branch.main.merge=refs/heads/main
    ```
    
    - `branch.main.remote` — указывает, что ветка `main` связана с удалённым репозиторием `origin`.
    - `branch.main.merge` — ветка `main` на вашем компьютере сливается с удалённой веткой `refs/heads/main`.
4. **Пользовательские данные:**
    
    ```plaintext
    user.name=fefumo
    ```
    
    - Ваше имя пользователя, которое Git использует для подписи коммитов в этом локальном репозитории.
5. **Хранение учетных данных:**
    
    ```plaintext
    credential.helper=store
    ```
    
    - Указывает, что Git использует `store` для сохранения учетных данных. Они записаны в файл `~/.git-credentials` и используются для автоматической аутентификации при работе с репозиторием.
