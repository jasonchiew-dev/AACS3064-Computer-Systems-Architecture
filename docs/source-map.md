# Source Map

`src/FINAL.asm` is a single-file 8086 assembly program. It is organized into macro definitions, data constants, utility procedures, and application modules.

## Top-Level Order

| Section | Purpose |
| --- | --- |
| Macro definitions | Short wrappers for math, animation, I/O, type checks, strings, and system helpers. |
| `.MODEL`, `.STACK`, `.DATA` | MASM memory model, stack size, and global data. |
| Constants and screen layouts | Product data, UI screens, report labels, messages, input buffers, and totals. |
| `.CODE` and `MAIN` | Initializes `DS`, clears the screen, starts intro/login/menu flow, then exits. |
| Utility procedures | Shared math, animation, symbol, I/O, string/type, and date/time routines. |
| Application modules | Intro, exit, login, main menu, display product, sales report, purchase, payment, and totals. |

## Main Execution Flow

```text
MAIN
|-- ANIMATE_CLR_SCR_M
|-- INTRO_FUNCT
|-- LOGIN_FUNCT
|-- MAIN_MENU_FUNCT
`-- EXIT_ANIMATION_FUNCT
```

## Utility Procedure Groups

### Math

- `MATH_DIVISION_DW_FUNCT`
- `MATH_DIVISION_DB_FUNCT`
- `MATH_MULTIPLY_DW_FUNCT`
- `MATH_ROUNDOFF_FUNCT`
- `MATH_DECIMAL_PLACE_SHIFT_FUNCT`

### Animation

- `ANIMATE_DELAY_FUNCT`
- `ANIMATE_TYPING_ANIMATION_FUNCT`
- `ANIMATE_TYPING_DELETE_FUNCT`
- `ANIMATE_CLR_CONTAINER_LINE_FUNCT`
- `ANIMATE_MSG_BOX_FUNCT`
- `ANIMATE_BACKSPACE_DELETE_FUNCT`
- `ANIMATE_REMOVE_CUR_FUNCT`
- `ANIMATE_MOV_CUR_FUNCT`
- `ANIMATE_SYSTEM_PAUSE_FUNCT`
- `ANIMATE_WAITING_INPUT_FUNCT`
- `ANIMATE_FULLSCR_FUNCT`
- `ANIMATE_CLR_SCR_FUNCT`
- `ANIMATE_COOLDOWN_FUNCT`
- `ANIMATE_TIMER_FUNCT`

### I/O

- `IO_PRINT5D_DW_FUNCT`
- `IO_PRINT4D_DW_FUNCT`
- `IO_PRINT3D_DW_FUNCT`
- `IO_PRINT2D_DW_FUNCT`
- `IO_PRINT_DIGIT_FUNCT`
- `IO_PRINT_CHAR_FUNCT`
- `IO_PRINT_STR_FUNCT`
- `IO_SCANF_FUNCT`
- `IO_SCANF_HIDDEN_FUNCT`

### String And Type Helpers

- `TYPE_IS_DIGIT_FUNCT`
- `TYPE_IS_YES_NO_FUNCT`
- `STR_TO_UPPER_FUNCT`
- `STR_TO_DW_FUNCT`
- `STR_STRCMP_FUNCT`
- `STR_STRLEN_FUNCT`
- `STR_RESET_VALUES_FUNCT`

### System

- `RETURN_TRUE_FUNCT`
- `RETURN_FALSE_FUNCT`
- `GET_DATE_AND_TIME_FUNCT`

## Application Modules

| Module | Responsibility |
| --- | --- |
| `INTRO_FUNCT` | Startup display and animated welcome messages. |
| `LOGIN_FUNCT` | Username/password input, hidden password, validation, cooldown. |
| `MAIN_MENU_FUNCT` | Menu navigation and routing. |
| `DISPLAY_PROD_FUNCT` | Product table display. |
| `PURCHASE_PROD_FUNCT` | Product selection, quantity validation, purchase confirmation. |
| `PAYMENT_FUNCT` | Cash input validation. |
| `CHANGE_FUNCT` | Change calculation and report total updates. |
| `SALES_REPORT_FUNCT` | Transaction, product quantity, and gross income report. |
| `EXIT_ANIMATION_FUNCT` | Exit screen, progress animation, and process termination. |

## Editing Guidance

- Keep behavior changes small and verify in DOSBox.
- Avoid splitting the file unless the build instructions are updated and still work with MASM.
- Prefer comments for non-obvious register, pointer, and interrupt behavior.
- Do not commit generated `FINAL.OBJ` or `FINAL.EXE`.
