#prog 
```bash
"${VAR:-def}"   # def if VAR unset or empty
"${VAR:=def}"   # set VAR=def if unset/empty, then expand
"${VAR:?msg}"   # error if unset/empty
"${VAR:+alt}"   # alt if VAR set (even if empty)
```
diff between `:-` and `:=`
```bash
unset VAR
echo "${VAR:-A}"   # prints A (VAR still unset)
echo "${VAR:-B}"   # prints B (still unset)

echo "${VAR:=C}"   # prints C and sets VAR=C
echo "$VAR"        # prints C now
```
