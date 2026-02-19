#uni #prog
```
ssh -p 2222 s413015@helios.se.ifmo.ru
```

pgpass: 
```
r6ApAkeG6kMXvydk
```

helios pass:
```
ctCD$5318
```

```
psql -h pg -d ucheb
```

```
psql -h pg -d studs 
```

```
scp -rP 2222 /mnt/c/coding/itmo/Prog/lab s413015@helios.se.ifmo.ru:/home/studs/s413015/prog_labs
```

```
scp -P 2222 Laba.jar s413015@helios.se.ifmo.ru:/home/studs/s413015/prog_labs
```

```
 ssh -L 5432:localhost:5432 -p 2222 s413015@helios.cs.ifmo.ru
```

```
scp -rP 2222 C:\coding\itmo\Prog\ s413015@helios.se.ifmo.ru:/home/studs/s413015/prog_labs
```

```
 ssh -L 8080:localhost:12333 -p 2222 s413015@helios.cs.ifmo.ru
```

```
httpd -f ~/httpd-root/conf/httpd-conf.conf -k start
```

```
java -DFCGI_PORT=32767 -jar ~/httpd-root/fcgi-bin/app.jar
```

```
bash wildfly/wildfly-20.0.1.Final/bin/standalone.sh
```