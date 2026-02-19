---
tags:
  - uni
---
* [guide](https://chipmunklogic.com/digital-logic-design/designing-pequeno-risc-v-cpu-from-scratch-part-1-getting-hold-of-the-isa/)
* [old processor](https://www.semanticscholar.org/paper/Design-Of-16-bit-RISC-Processor-Gaonkar-Anitha/17d3fd611394c1038fd02b2a036a47b39788f0bb)
* [some intro](https://electronicsdesk.com/risc-processor.html)
* [Control Unit](https://stevengong.co/notes/Control-Unit)
* [bnf](https://informatics.msk.ru/mod/page/view.php?id=19543&forceview=1)
* [green sheet](https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_GREEN_CARD.pdf)
* 
![[Pasted image 20250519235343.png]]![[Pasted image 20250520000135.png]]

![[Pasted image 20250606192934.png]]
![[Pasted image 20250606193043.png]]
### Ход работы
```
[ Ассемблер ] → [ Машинный код (байты) ] → [ Эмулятор/Интерпретатор ]
```

| Этап  | Что сделать                                       | Зачем                                                                   |
| ----- | ------------------------------------------------- | ----------------------------------------------------------------------- |
| **1** | **Опиши структуру инструкций и регистров в коде** | Это твой "язык", нужен `enum` или `dict` для всех инструкций            |
| **2** | **Сделай парсер ассемблера**                      | Разбивает строки в токены: `add r1, r2, r3` → [`add`, `r1`, `r2`, `r3`] |
| **3** | **Напиши генератор машинного кода**               | Собирает бинарный код из токенов по шаблону (битовые поля)              |
| **4** | **Реализуй экспорт в `.bin` файл**                | Пишет результат в файл/массив байтов                                    |
| **5** | **Сделай простой эмулятор (интерпретатор)**       | Считывает байты и исполняет инструкцию — это будет твоё "железо"        |
| **6** | (опц.) Минимальный загрузчик или REPL             | Чтобы вручную загружать/тестировать код                                 |

## stream
Ввод-вывод осуществляется как поток токенов. Есть в примере. Логика работы:

- При старте модели у вас есть буфер, в котором представлены все данные ввода (['h', 'e', 'l', 'l', 'o']).
- При обращении к вводу (выполнение инструкции) модель процессора получает "токен" (символ) информации.
- Если данные в буфере кончились -- останавливайте моделирование.
- Вывод данных реализуется аналогично, по выполнении команд в буфер вывода добавляется ещё один символ.
- По окончании моделирования показать все выведенные данные.
- Логика работы с буфером реализуется в рамках модели на Python.
## ✅ Full Working Example
.data
out_addr: .word 0x02
```asm
.data
out_addr: .word 0x02

.text
main:
    lui  r3, out_addr >> 12       # upper bits of out_addr
    addi r3, r3, out_addr & 0xFFF # now r3 = full address of out_addr
    lw   r4, 0(r3)                # r4 = value at out_addr (0x02)

    halt

```
## ❗ Final Note

If your assembler **doesn't support expressions like `label >> 12`**, you have three options:
1. ❌ Hardcode the address (not preferred, as you said)
2. ✅ Extend your assembler to support label math
3. ✅ Use a macro like:
```asm
.macro la reg, label
    lui  \reg, label >> 12
    addi \reg, \reg, label & 0xFFF
.endm

la r3, out_addr
```
