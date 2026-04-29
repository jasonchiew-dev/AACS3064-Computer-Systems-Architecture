# 8086 Notes

These notes summarize the assembly patterns used by `src/FINAL.asm`.

## DOSBox

```dos
mount c: c:\8086
c:
```

Fullscreen:

```text
Alt + Enter
```

## Build

```dos
masm final;
link final;
final.exe
```

## Data Segment

`DS` must point to the data segment before data labels are accessed.

```asm
MOV AX,@DATA
MOV DS,AX

MOV DX,OFFSET MSG
```

Many DOS calls use segment:offset addressing. For example, string output with `INT 21h` function `09h` reads the string address from `DS:DX`.

## Pointer-Style Access

Use index registers for indirect memory access.

```asm
.DATA
TESTING_NUM DB 0
TESTING_NUM_ADDRESS DW 0
TESTING_STR DB "Hello World","$"
TESTING_STR_ADDRESS DW 0

.CODE
MOV TESTING_NUM_ADDRESS,OFFSET TESTING_NUM
MOV AX,2
MOV SI,TESTING_NUM_ADDRESS
MOV [SI],AX

LEA DI,TESTING_STR
MOV AL,"B"
MOV [DI],AL
INC DI
MOV [DI],AL
```

Useful direct indexed forms:

```asm
MOV AL,[TESTING_STR + 6]
MOV AL,TESTING_STR[6]
MOV [TESTING_STR + 6],"T"
MOV TESTING_STR[6],"T"
```

## LEA And OFFSET

`LEA` loads an effective address into a register. `OFFSET` can also be used with `MOV`.

```asm
MOV DX,OFFSET TESTING_NUM
LEA DX,TESTING_NUM
LEA SI,TESTING_NUM
```

The destination for `LEA` must be a register.

## DUP

```asm
MSG_BOX DB 52 DUP (220)
        DB 26 DUP (2 DUP (223)),"$"
```

## LOOP

`LOOP` decrements `CX` and jumps while `CX` is not zero.

```asm
MOV CX,2
LOOP_TEST:
    LOOP LOOP_TEST
```

Be careful when setting only `CL` or `CH`; `LOOP` uses the full `CX` register.

## Jump Loop

```asm
.DATA
LOOP_TIMES DB 2

.CODE
LOOP_TEST:
    DEC LOOP_TIMES
    JNZ LOOP_TEST
```

## Carry Flag After Interrupts

Some DOS interrupts set the carry flag on error.

```asm
INT 21H
JC ERROR_HANDLER
```

## Procedures

```asm
CALL FUNCTION1

FUNCTION1 PROC
    ; work here
FUNCTION1 ENDP
```

## Macros

```asm
MACRO1 MACRO MACRO_NUM1
    MOV AH,MACRO_NUM1
ENDM

.MODEL SMALL
.STACK 4096
.DATA
NUM1 DB 1
.CODE
MACRO1 NUM1
```

## Control Characters

```text
08h = Backspace
09h = Horizontal tab
0Ah = Line feed
0Ch = Form feed
0Dh = Carriage return / Enter
1Bh = Escape
```

## CMP

The left operand should be a register or memory variable.

```asm
CMP AL,0
CMP TMP_DW,0
```

## Jump Distance

Conditional jumps can fail if the label is too far away for the encoded jump. Use nearby labels or an inverted condition plus an unconditional `JMP` when needed.

## Stack

```asm
MOV AX,"A"
MOV BX,"B"

PUSH AX
PUSH BX

POP AX ; AX = "B"
POP BX ; BX = "A"
```

## Common Interrupts

- `INT 10h`: BIOS video services
- `INT 16h`: BIOS keyboard services
- `INT 17h`: printer services
- `INT 1Ah`: time of day
- `INT 1Ch`: user timer interrupt
- `INT 21h`: MS-DOS services

## DOS INT 21h Examples

Character input with echo:

```asm
MOV AH,01H
INT 21H
MOV USR_INPUT,AL
```

Character output:

```asm
MOV DL,"A"
MOV AH,02H
INT 21H
```

Character input without echo:

```asm
MOV AH,07H
INT 21H
MOV USR_INPUT,AL
```

String output:

```asm
MOV AH,09H
MOV DX,OFFSET MSG
INT 21H
```

Get system date:

```asm
MOV AH,2AH
INT 21H
MOV YEAR,CX
MOV MONTH,DH
MOV DAY,DL
MOV DAYOFWEEK,AL
```

Get system time:

```asm
MOV AH,2CH
INT 21H
MOV HOURS,CH
MOV MINUTES,CL
MOV SECONDS,DH
```

Terminate process:

```asm
MOV AH,4CH
MOV AL,0
INT 21H
```

## BIOS INT 10h Cursor Move

```asm
MOV DH,ROW
MOV DL,COL
MOV AH,02H
MOV BH,0
INT 10H
```

## Arithmetic Examples

8-bit division:

```asm
MOV AL,DIVIDEND_DB
MOV BL,DIVISOR_DB
XOR AH,AH
DIV BL
MOV QUOTIENT_DB_TMP,AL
MOV REMAINDER_DB_TMP,AH
```

16-bit division:

```asm
MOV AX,DIVIDEND_DW
MOV BX,DIVISOR_DW
MOV DX,0
DIV BX
MOV QUOTIENT_DW_TMP,AX
MOV REMAINDER_DW_TMP,DX
```

8-bit multiplication:

```asm
MOV AL,MULTIPLICAND_DB
MOV BL,MULTIPLIER_DB
MUL BL
MOV PRODUCT_DB,AL
```

16-bit multiplication:

```asm
MOV AX,MULTIPLICAND_DW
MOV BX,MULTIPLIER_DW
MUL BX
MOV PRODUCT_DW1,DX
MOV PRODUCT_DW2,AX
```

## Reference

- 8086 BIOS and DOS interrupt reference: https://yassinebridi.github.io/asm-docs/8086_bios_and_dos_interrupts.html
