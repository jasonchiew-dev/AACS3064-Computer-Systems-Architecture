; AACS3064 Computer Systems Architecture
; UMT Bookstore POS System
;
; Source map:
;   1. Macros: math, animation, symbols, I/O, type checks, strings, system helpers
;   2. Data: shared constants, screens, product prices, purchase totals, report totals
;   3. Main: data segment setup, intro, login, main menu, exit animation
;   4. Utility procedures: math, animation, I/O, string/type, date/time helpers
;   5. Application modules: intro, exit, login, main menu, display, report, purchase, payment
;
; Build in DOSBox with:
;   masm final;
;   link final;
;   final.exe

;-----------------------------------------------
;------------------MACRO START------------------
;-----------------------------------------------

;---------------MATH MACRO START---------------
MATH_DIVISION_DW_M MACRO DIVIDEND_DW,DIVISOR_DW
  MOV AX,DIVIDEND_DW
  MOV BX,DIVISOR_DW
  CALL MATH_DIVISION_DW_FUNCT
ENDM

MATH_DIVISION_DB_M MACRO DIVIDEND_DB,DIVISOR_DB
  MOV AL,DIVIDEND_DB
  MOV BL,DIVISOR_DB
  CALL MATH_DIVISION_DB_FUNCT
ENDM

MATH_MULTIPLY_DW_M MACRO MULTIPLICAND_DIGIT,MULTIPLICAND_DECIMAL,MULTIPLIER,PRODUCT_DIGIT,PRODUCT_DECIMAL
  MOV AX,MULTIPLICAND_DIGIT
  MOV BX,MULTIPLICAND_DECIMAL
  MOV DX,MULTIPLIER
  MOV SI,OFFSET PRODUCT_DIGIT
  MOV DI,OFFSET PRODUCT_DECIMAL

  CALL MATH_MULTIPLY_DW_FUNCT
ENDM

MATH_ROUNDOFF_M MACRO ROUNDOFF_DIGIT,ROUNDOFF_DECIMAL,ROUNDOFF_DECIMAL_PLACES
  MOV ROUNDOFF_DECIMAL_PLACES_TMP,ROUNDOFF_DECIMAL_PLACES
  MOV SI,OFFSET ROUNDOFF_DIGIT
  MOV DI,OFFSET ROUNDOFF_DECIMAL
  CALL MATH_ROUNDOFF_FUNCT
ENDM

MATH_DECIMAL_PLACE_SHIFT_M MACRO SHIFT_DIGIT,SHIFT_DECIMAL
  MOV SI,OFFSET SHIFT_DIGIT
  MOV DI,OFFSET SHIFT_DECIMAL
  CALL MATH_DECIMAL_PLACE_SHIFT_FUNCT
ENDM
;---------------MATH MACRO END---------------

;---------------ANIMATE MACRO START---------------
ANIMATE_DELAY_M MACRO DELAY_SEC
  MOV CX,DELAY_SEC
  CALL ANIMATE_DELAY_FUNCT
ENDM

ANIMATE_TYPING_M MACRO STR_TYPING_ANIMATION,TYPING_SPEED
  MOV SI,OFFSET STR_TYPING_ANIMATION
  MOV TYPING_LOOP_DELAY_TMP,TYPING_SPEED
  CALL ANIMATE_TYPING_ANIMATION_FUNCT
ENDM

ANIMATE_DELETE_M MACRO
  CALL ANIMATE_TYPING_DELETE_FUNCT
ENDM

ANIMATE_CLR_CONTAINER_LINE_M MACRO CLR_CONTAINER_BOX_LINE
  MOV AL,CLR_CONTAINER_BOX_LINE
  CALL ANIMATE_CLR_CONTAINER_LINE_FUNCT
ENDM

ANIMATE_MSG_BOX_M MACRO MSG_BOX_STR
  STR_STRLEN_M MSG_BOX_STR
  CALL ANIMATE_MSG_BOX_FUNCT
  IO_PRINT_STR_M MSG_BOX_STR
ENDM

ANIMATE_BACKSPACE_DELETE_M MACRO BACKSPACE_TIMES
  MOV CX,BACKSPACE_TIMES
  CALL ANIMATE_BACKSPACE_DELETE_FUNCT
ENDM

ANIMATE_REMOVE_CUR_M MACRO
  CALL ANIMATE_REMOVE_CUR_FUNCT
ENDM

ANIMATE_MOV_CUR_M MACRO MOV_CUR_ROW,MOV_CUR_COL
  MOV DH,MOV_CUR_ROW
  MOV DL,MOV_CUR_COL
  CALL ANIMATE_MOV_CUR_FUNCT
ENDM

ANIMATE_SYSTEM_PAUSE_M MACRO
  CALL ANIMATE_SYSTEM_PAUSE_FUNCT
ENDM

ANIMATE_WAITING_INPUT_M MACRO
  CALL ANIMATE_WAITING_INPUT_FUNCT
ENDM

ANIMATE_FULLSCR_M MACRO
  CALL ANIMATE_FULLSCR_FUNCT
ENDM

ANIMATE_CLR_SCR_M MACRO
  CALL ANIMATE_CLR_SCR_FUNCT
ENDM

ANIMATE_COOLDOWN_M MACRO
  CALL ANIMATE_COOLDOWN_FUNCT
ENDM

ANIMATE_TIMER_M MACRO
  CALL ANIMATE_TIMER_FUNCT
ENDM
;---------------ANIMATE MACRO END---------------

;---------------SYMBOL MACRO START---------------
SYMBOL_LEFT_ARROW_M MACRO
  CALL SYMBOL_LEFT_ARROW_FUNCT
ENDM

SYMBOL_RIGHT_ARROW_M MACRO
  CALL SYMBOL_RIGHT_ARROW_FUNCT
ENDM
;---------------SYMBOL MACRO END---------------

;---------------IO MACRO START---------------
PRINT2D MACRO PRINT2D_NUM
  MOV AL,PRINT2D_NUM
  CALL PRINT2D_FUNCT
ENDM

IO_PRINT5D_DW_M MACRO PRINT5D_DW_NUM
    MOV AX,PRINT5D_DW_NUM
    CALL IO_PRINT5D_DW_FUNCT
ENDM

IO_PRINT4D_DW_M MACRO PRINT4D_DW_NUM
    MOV AX,PRINT4D_DW_NUM
    CALL IO_PRINT4D_DW_FUNCT
ENDM

IO_PRINT3D_DW_M MACRO PRINT3D_DW_NUM
    MOV AX,PRINT3D_DW_NUM
    CALL IO_PRINT3D_DW_FUNCT
ENDM

IO_PRINT2D_DW_M MACRO PRINT2D_DW_NUM
    MOV AX,PRINT2D_DW_NUM
    CALL IO_PRINT2D_DW_FUNCT
ENDM

IO_PRINT_DIGIT_M MACRO DIGIT_PRINTF_M
  MOV DL,DIGIT_PRINTF_M
  CALL IO_PRINT_DIGIT_FUNCT
ENDM

IO_PRINT_CHAR_M MACRO CHAR_PRINTF
  MOV DL,CHAR_PRINTF
  CALL IO_PRINT_CHAR_FUNCT
ENDM

IO_PRINT_STR_M MACRO STRING_PRINTF
  MOV DX,OFFSET STRING_PRINTF
  CALL IO_PRINT_STR_FUNCT
ENDM

IO_SCANF_M MACRO STR_SCANF,LENGTH_SCANF
  MOV DI,OFFSET STR_SCANF
  MOV INPUT_LENGTH_TMP,LENGTH_SCANF
  CALL IO_SCANF_FUNCT
ENDM

IO_SCANF_HIDDEN_M MACRO STR_SCANF_HIDDEN,LENGTH_SCANF_HIDDEN
  MOV DI,OFFSET STR_SCANF_HIDDEN
  MOV INPUT_LENGTH_HIDDEN_TMP,LENGTH_SCANF_HIDDEN
  CALL IO_SCANF_HIDDEN_FUNCT
ENDM
;---------------IO MACRO END---------------

;---------------TYPE MACRO START---------------
TYPE_IS_END_M MACRO IS_END_CHAR
  CMP IS_END_CHAR,"$"
ENDM

TYPE_IS_SPACE_M MACRO IS_SPACE_CHAR
  CMP IS_SPACE_CHAR," "
ENDM

TYPE_IS_DOT_M MACRO IS_DOT_CHAR
  CMP IS_DOT_CHAR,"."
ENDM

TYPE_IS_DIGIT_M MACRO IS_DIGIT_CHAR
  MOV IS_DIGIT_TMP,IS_DIGIT_CHAR
  CALL TYPE_IS_DIGIT_FUNCT
ENDM

TYPE_IS_YES_NO_M MACRO IS_YES_NO_CHAR
  MOV AL,IS_YES_NO_CHAR[0]
  CALL TYPE_IS_YES_NO_FUNCT
ENDM
;---------------TYPE MACRO END---------------

;---------------STR MACRO START---------------
STR_TO_UPPER_M MACRO TO_UPPER_CHAR
  MOV DI,OFFSET TO_UPPER_CHAR
  CALL STR_TO_UPPER_FUNCT
ENDM

STR_TO_DW_M MACRO STR_TO_DW_STR,STR_TO_DW_NUM
  STR_STRLEN_M STR_TO_DW_STR
  MOV DI,OFFSET STR_TO_DW_STR
  CALL STR_TO_DW_FUNCT
  MOV STR_TO_DW_NUM,AX
ENDM

STR_STRCMP_M MACRO STR_CMP1,STR_CMP2
  LEA SI,STR_CMP1
  LEA DI,STR_CMP2
  CALL STR_STRCMP_FUNCT
ENDM

STR_STRLEN_M MACRO STRLEN_STR
  MOV DI,OFFSET STRLEN_STR
  CALL STR_STRLEN_FUNCT
ENDM

STR_RESET_VALUES_M MACRO STR_RESET
  MOV DI,OFFSET STR_RESET
  CALL STR_RESET_VALUES_FUNCT
ENDM
;---------------STR MACRO END---------------

;---------------SYS MACRO START---------------
RETURN_TRUE_M MACRO
  CALL RETURN_TRUE_FUNCT
ENDM

RETURN_FALSE_M MACRO
  CALL RETURN_FALSE_FUNCT
ENDM

GET_DATE_AND_TIME_M MACRO
  CALL GET_DATE_AND_TIME_FUNCT
ENDM
;---------------SYS MACRO END---------------

;---------------------------------------------
;------------------MACRO END------------------
;---------------------------------------------

.MODEL SMALL
.STACK 4096
.DATA

;--------------------------------------------------
;------------------CONSTANT START------------------
;--------------------------------------------------

;---------------MATH CONSTANT START---------------
QUOTIENT_DW_TMP DW 0
REMAINDER_DW_TMP DW 0
QUOTIENT_DB_TMP DB 0
REMAINDER_DB_TMP DB 0
MULTIPLICAND_DIGIT_TMP DW 0
MULTIPLICAND_DECIMAL_TMP DW 0
MULTIPLIER_TMP DW 0
;---------------MATH CONSTANT END---------------

;---------------ANIMATE CONSTANT START---------------
DELAY_LOOP_COUNTER DW 0
TYPING_LOOP_COUNTER DW 0
TYPING_LOOP_DELAY_TMP DW 0
ROW DB 0
COL DB 0
;---------------ANIMATE CONSTANT END---------------

;---------------IO CONSTANT START---------------
PRINT2D_NUM_TMP DB 0
PRINT2D_DW_NUM_TMP DW 0
PRINT3D_DW_NUM_TMP DW 0
PRINT4D_DW_NUM_TMP DW 0
PRINT5D_DW_NUM_TMP DW 0
INPUT_LENGTH_TMP DW 0
INPUT_LENGTH_HIDDEN_TMP DW 0
;---------------IO CONSTANT END---------------

;---------------TYPE CONSTANT START---------------
IS_DIGIT_TMP DB 0
IS_YES_NO_TMP DB 0
SHIFT_DECIMAL_TMP DW 0
ROUNDOFF_DECIMAL_PLACES_TMP DW 0
;---------------TYPE CONSTANT END---------------

;---------------STR CONSTANT START---------------
STRLEN_TMP DB 0
;---------------STR CONSTANT END---------------

;---------------SYS CONSTANT START---------------
CURRENT_YEAR DW 0
CURRENT_MONTH DB 0
CURRENT_DAY DB 0
CURRENT_DAYOFWEEK DB 0
CURRENT_HOURS DB 0
CURRENT_MINUTES DB 0
CURRENT_SECONDS DB 0

MONDAY_MSG DB "MONDAY","$"
TUESDAY_MSG DB "TUESDAY","$"
WEDNESDAY_MSG DB "WEDNESDAY","$"
THURSDAY_MSG DB "THURSDAY","$"
FRIDAY_MSG DB "FRIDAY","$"
SATURDAY_MSG DB "SATURDAY","$"
SUNDAY_MSG DB "SUNDAY","$"
;---------------SYS CONSTANT END---------------

;---------------OTHER CONSTANT START---------------
DELETE DB 8,' ',8,"$"
SYSTEM_PAUSE_LINE DB 13,10,"         ",221,"               Press any key to continue...","$"
SYSTEM_PAUSE_MSG DB "Press any key to continue...","$"
NEWLINE DB 13,10,"$"
CONTAINER_BOX DB 13,10,"         ",221,"                                                          ",222,"         ","$"
DIV_NUM DW 0
STR_TO_DW_NUM_TMP DW 0
TEN DB 10
TEN_DW DW 10
HUNDRED_DW DW 100
FULLSCR_LOOP_TIMES DB 0
MSG_BOX DB "   "
        DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
        DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
        DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
        DB "   "
        DB 13,10,"   ",221,"                                                                      ",222,"   "
        DB 13,10,"   ",221,"                                                                      ",222,"   "
        DB 13,10,"   ",221,"                                                                      ",222,"   "
        DB 13,10,"   ",221,"                                                                      ",222,"   "
        DB 13,10,"   ",221,"                                                                      ",222,"   "
        DB 13,10,"   "
        DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
        DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
        DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
        DB "   ","$"
ANIMATE_COOLDOWN_MSG DB "COOLDOWN: ","$"
ANIMATE_COOLDOWN_FAILCOUNT_TMP DW 1
ANIMATE_COOLDOWN_MIN1_TMP DB 0
ANIMATE_COOLDOWN_MIN2_TMP DB 0
ANIMATE_COOLDOWN_SEC1_TMP DB 0
ANIMATE_COOLDOWN_SEC2_TMP DB 0
;---------------OTHER CONSTANT END---------------

;---------------INTRO CONSTANT START---------------
STARTUP_ANIMATION_PAGE DB 13,10,"                     "
                       DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
                       DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
                       DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
                       DB       "                     "
                       DB 13,10,"                     ",221,"                        ....  ....  ...       ...   .........                      ",222,"                     "
                       DB 13,10,"                     ",221,"                      ###!: ###!: ##!:      ##!: #########!:                       ",222,"                     "
                       DB 13,10,"                     ",221,"                      ###!: ###!: ###!:    ###!: #########!            /  /        ",222,"                     "
                       DB 13,10,"                     ",221,"                      ###!: ###!: ####!:  ####!:    ###!:             /  /         ",222,"                     "
                       DB 13,10,"                     ",221,"                *     ###!: ###!: ############!:    ###!:    _|_     // /    +     ",222,"                     "
                       DB 13,10,"                     ",221,"                      ###!: ###!: ###!####!###!:    ###!:     |      / /           ",222,"                     "
                       DB 13,10,"                     ",221,"     *                #########!: ###!:##! ###!:    ###!:           / .            ",222,"                     "
                       DB 13,10,"                     ",221,"                       #######!:  ###:     ###!     ###!           .               ",222,"                     "
                       DB 13,10,"                     ",221,"                                                                                   ",222,"                     "
                       DB 13,10,"                     ",221,"                         "
                       DB 218,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,191
                       DB       "     +                   ",222,"                     "
                       DB 13,10,"                     ",221,"                         ",179," TAR UMT Programming Bookstore ",179,"                         ",222,"                     "
                       DB 13,10,"                     ",221,"                         "
                       DB 192,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,217
                       DB       "     +                   ",222,"                     "
                       DB 13,10,"                     ",221,"       _|_         *                                                    *          ",222,"                     "
                       DB 13,10,"                     ",221,"        |                 ____________________                                     ",222,"                     "
                       DB 13,10,"                     ",221,"                         / / / / / / / / / / /|         _|_                        ",222,"                     "
                       DB 13,10,"                     ",221,"                        / / / / / / / / / / / |          |                         ",222,"                     "
                       DB 13,10,"                     ",221,"                       / / / / / / / / / / /  |                                    ",222,"                     "
                       DB 13,10,"                     ",221,"                 _|_  / / / / / / / / / / /   |     +                              ",222,"                     "
                       DB 13,10,"                     ",221,"                  |  |-|-|-|-|-|-|-|-|-|-|  / |             __                     ",222,"                     "
                       DB 13,10,"                     ",221,"      +              | | | | | | | | | | | // |            / /   +       _|_       ",222,"                     "
                       DB 13,10,"                     ",221,"                     | | | | | | | | | | | // |           /-/\\           |        ",222,"                     "
                       DB 13,10,"                     ",221,"                     |A|D|D| | | | | | | | // |          / ///                     ",222,"                     "
                       DB 13,10,"                     ",221,"                     |S|E|A|R|C|H| | | | | /  |         / ///                      ",222,"                     "
                       DB 13,10,"                     ",221,"                     |M|O|D|I|F|Y| | | | |    |        / ///                       ",222,"                     "
                       DB 13,10,"                     ",221,"                     |D|E|L|E|T|E| | | | |    |       / ///                        ",222,"                     "
                       DB 13,10,"                     ",221,"              *      |C|A|L|C|U|L|A|T|E| |  //       / ///               *         ",222,"                     "
                       DB 13,10,"                     ",221,"                     |D|I|S|P|L|A|Y| | | | //       / /_/             _|_          ",222,"                     "
                       DB 13,10,"                     ",221,"       _|_           | | | | | | | | | | | /       / /                 |           ",222,"                     "
                       DB 13,10,"                     ",221,"        |            |_|_|_|_|_|_|_|_|_|_|/       / /                              ",222,"                     "
                       DB 13,10,"                     ",221,"                                                 /_/                               ",222,"                     "
                       DB 13,10,"                     ",221,"                 +                               |/                                ",222,"                     "
                       DB 13,10,"                     ",221,"                                             .___/                                 ",222,"                     "
                       DB 13,10,"                     ",221,"                                              \__________________TAR UMT POS SYSTEM",222,"                     "
                       DB 13,10,"                     "
                       DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
                       DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
                       DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
                       DB       "                    "
                       DB 13,10,"                                                                                                                                ","$"
STARTUP_ANIMATION_MSG1  DB "Welcome to TAR UMT Programming Bookstore","$"
STARTUP_ANIMATION_MSG2  DB " Please login first to get started ^_^","$"
STARTUP_ANIMATION_MSG3  DB "                 Enjoy!","$"
;---------------INTRO CONSTANT END---------------

;---------------EXIT CONSTANT START---------------
EXIT_PAGE DB       "         "
          DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
          DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
          DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
          DB       "         "
          DB 13,10,"         ",221,"           ....  ....  ...       ...   .........          ",222,"         "
          DB 13,10,"         ",221,"          ###!: ###!: ##!:      ##!: #########!:          ",222,"         "
          DB 13,10,"         ",221,"          ###!: ###!: ###!:    ###!: #########!           ",222,"         "
          DB 13,10,"         ",221,"          ###!: ###!: ####!:  ####!:    ###!:             ",222,"         "
          DB 13,10,"         ",221,"          ###!: ###!: ############!:    ###!:             ",222,"         "
          DB 13,10,"         ",221,"          ###!: ###!: ###!####!###!:    ###!:             ",222,"         "
          DB 13,10,"         ",221,"          #########!: ###!:##! ###!:    ###!:             ",222,"         "
          DB 13,10,"         ",221,"           #######!:  ###:     ###!     ###!              ",222,"         "
          DB 13,10,"         ",221,"                                                          ",222,"         "
          DB 13,10,"         ",221,"                         "
          DB 218,196,196,196,196,196,196,191
          DB       "                         ",222,"         "
          DB 13,10,"         ",221,"                         ",179," EXIT ",179,"                         ",222,"         "
          DB 13,10,"         ",221,"                         "
          DB 192,196,196,196,196,196,196,217
          DB       "                         ",222,"         "
          DB 13,10,"         ",221,"                                                          ",222,"         "
          DB 13,10,"         ",221,"                                                          ",222,"         "
          DB 13,10,"         ",221,"                                                          ",222,"         "
          DB 13,10,"         ",221,"                                                          ",222,"         "
          DB 13,10,"         ",221,"                                                          ",222,"         "
          DB 13,10,"         ",221,"               ="
          DB 196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196
          DB       "               ",222,"         "
          DB 13,10,"         ",221,"                        Exiting...                        ",222,"         "
          DB 13,10,"         ",221,"                                                          ",222,"         "
          DB 13,10,"         ",221,"                                                          ",222,"         "
          DB 13,10,"         ",221,"                                                          ",222,"         "
          DB 13,10,"         ",221,"                                        TAR UMT POS SYSTEM",222,"         "
          DB 13,10,"         "
          DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
          DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
          DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
          DB       "         ","$"
EXIT_COUNTER DB 45
EXIT_PROGRESS_COUNTER DB 0
EXIT_SUCCESS_MSG DB "Exit successfully!","$"
;---------------EXIT CONSTANT END---------------

;---------------LOGIN CONSTANT START---------------
LOGIN_PAGE DB       "         "
           DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
           DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
           DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
           DB       "         "
           DB 13,10,"         ",221,"           ....  ....  ...       ...   .........          ",222,"         "
           DB 13,10,"         ",221,"          ###!: ###!: ##!:      ##!: #########!:          ",222,"         "
           DB 13,10,"         ",221,"          ###!: ###!: ###!:    ###!: #########!           ",222,"         "
           DB 13,10,"         ",221,"          ###!: ###!: ####!:  ####!:    ###!:             ",222,"         "
           DB 13,10,"         ",221,"          ###!: ###!: ############!:    ###!:             ",222,"         "
           DB 13,10,"         ",221,"          ###!: ###!: ###!####!###!:    ###!:             ",222,"         "
           DB 13,10,"         ",221,"          #########!: ###!:##! ###!:    ###!:             ",222,"         "
           DB 13,10,"         ",221,"           #######!:  ###:     ###!     ###!              ",222,"         "
           DB 13,10,"         ",221,"                                                          ",222,"         "
           DB 13,10,"         ",221,"                         ",218,196,196,196,196,196,196,196,191,"                        ",222,"         "
           DB 13,10,"         ",221,"                         ",179," LOGIN ",179,"                        ",222,"         "
           DB 13,10,"         ",221,"                         ",192,196,196,196,196,196,196,196,217,"                        ",222,"         "
           DB 13,10,"         ",221,"                                                          ",222,"         "
           DB 13,10,"         ",221,"                                                          ",222,"         "
           DB 13,10,"         ",221,"                                                          ",222,"         "
           DB 13,10,"         ",221,"          Account Username:                               ",222,"         "
           DB 13,10,"         ",221,"          Account Password:                               ",222,"         "
           DB 13,10,"         ",221,"                                                          ",222,"         "
           DB 13,10,"         ",221,"                                                          ",222,"         "
           DB 13,10,"         ",221,"                                                          ",222,"         "
           DB 13,10,"         ",221,"                                                          ",222,"         "
           DB 13,10,"         ",221,"                                                          ",222,"         "
           DB 13,10,"         ",221,"                                        TAR UMT POS SYSTEM",222,"         "
           DB 13,10,"         "
           DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
           DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
           DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
           DB       "         ","$"

USRNAME DB "Burger$"
PASSWORD DB "admin123$"

USR_USRNAME DB 20 DUP("$")
USR_PASSWORD DB 20 DUP("$")

INVALID_LOGIN_MSG DB "Error: Either Username or Password is INCORRECT!","$"
VALID_LOGIN_MSG DB "Login Successfully!","$"
;---------------LOGIN CONSTANT END---------------

;---------------MAIN MENU CONSTANT START---------------
MAIN_MENU_PAGE DB       "         "
               DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
               DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
               DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
               DB       "         "
               DB 13,10,"         ",221,"           ....  ....  ...       ...   .........          ",222,"         "
               DB 13,10,"         ",221,"          ###!: ###!: ##!:      ##!: #########!:          ",222,"         "
               DB 13,10,"         ",221,"          ###!: ###!: ###!:    ###!: #########!           ",222,"         "
               DB 13,10,"         ",221,"          ###!: ###!: ####!:  ####!:    ###!:             ",222,"         "
               DB 13,10,"         ",221,"          ###!: ###!: ############!:    ###!:             ",222,"         "
               DB 13,10,"         ",221,"          ###!: ###!: ###!####!###!:    ###!:             ",222,"         "
               DB 13,10,"         ",221,"          #########!: ###!:##! ###!:    ###!:             ",222,"         "
               DB 13,10,"         ",221,"           #######!:  ###:     ###!     ###!              ",222,"         "
               DB 13,10,"         ",221,"                                                          ",222,"         "
               DB 13,10,"         ",221,"                      ",218,196,196,196,196,196,196,196,196,196,196,196,191,"                       ",222,"         "
               DB 13,10,"         ",221,"                      ",179," MAIN MENU ",179,"                       ",222,"         "
               DB 13,10,"         ",221,"                      ",192,196,196,196,196,196,196,196,196,196,196,196,217,"                       ",222,"         "
               DB 13,10,"         ",221,"                                                          ",222,"         "
               DB 13,10,"         ",221,"                     Display Products                     ",222,"         "
               DB 13,10,"         ",221,"                                                          ",222,"         "
               DB 13,10,"         ",221,"                    Purchase Products                     ",222,"         "
               DB 13,10,"         ",221,"                                                          ",222,"         "
               DB 13,10,"         ",221,"                       Sales Report                       ",222,"         "
               DB 13,10,"         ",221,"                                                          ",222,"         "
               DB 13,10,"         ",221,"                           Exit                           ",222,"         "
               DB 13,10,"         ",221,"                                                          ",222,"         "
               DB 13,10,"         ",221,"                                                          ",222,"         "
               DB 13,10,"         ",221,"                                        TAR UMT POS SYSTEM",222,"         "
               DB 13,10,"         "
               DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
               DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
               DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
               DB       "         ","$"
USR_CONFIRM_QUIT_PROGRAM_OPT DB 20 DUP("$")
CONFIRMATION_QUIT_PROGRAM_MSG DB "Are you confirm to QUIT this program? (Y-Yes/N-No): ","$"
;---------------MAIN MENU CONSTANT END---------------

;---------------DISPLAY CONSTANT START---------------
DISPLAY_PROD_MENU DB       "         "
                  DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
                  DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
                  DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
                  DB       "         "
                  DB 13,10,"         ",221,"           ....  ....  ...       ...   .........          ",222,"         "
                  DB 13,10,"         ",221,"          ###!: ###!: ##!:      ##!: #########!:          ",222,"         "
                  DB 13,10,"         ",221,"          ###!: ###!: ###!:    ###!: #########!           ",222,"         "
                  DB 13,10,"         ",221,"          ###!: ###!: ####!:  ####!:    ###!:             ",222,"         "
                  DB 13,10,"         ",221,"          ###!: ###!: ############!:    ###!:             ",222,"         "
                  DB 13,10,"         ",221,"          ###!: ###!: ###!####!###!:    ###!:             ",222,"         "
                  DB 13,10,"         ",221,"          #########!: ###!:##! ###!:    ###!:             ",222,"         "
                  DB 13,10,"         ",221,"           #######!:  ###:     ###!     ###!              ",222,"         "
                  DB 13,10,"         ",221,"                                                          ",222,"         "
                  DB 13,10,"         ",221,"                   ",218,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,191,"                    ",222,"         "
                  DB 13,10,"         ",221,"                   ",179," DISPLAY PRODUCT ",179,"                    ",222,"         "
                  DB 13,10,"         ",221,"                   ",192,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,217,"                    ",222,"         "
                  DB 13,10,"         ",221,"               ",218,196,196,194,196,196,196,196,196,196,196,196,196,196,196,196,194,196,196,196,196,196,196,196,196,196,191,"                ",222,"         "
                  DB 13,10,"         ",221,"               ",179,"NO",179,"PRODUCT NAME",179,"  PRICE  ",179,"                ",222,"         "
                  DB 13,10,"         ",221,"               ",195,196,196,197,196,196,196,196,196,196,196,196,196,196,196,196,197,196,196,196,196,196,196,196,196,196,180,"                ",222,"         "
                  DB 13,10,"         ",221,"               ",179,"1.",179,"JAVA        ",179," RM 23.79",179,"                ",222,"         "
                  DB 13,10,"         ",221,"               ",179,"2.",179,"Assembly    ",179," RM 15.50",179,"                ",222,"         "
                  DB 13,10,"         ",221,"               ",179,"3.",179,"JavaScript  ",179," RM  9.99",179,"                ",222,"         "
                  DB 13,10,"         ",221,"               ",192,196,196,193,196,196,196,196,196,196,196,196,196,196,196,196,193,196,196,196,196,196,196,196,196,196,217,"                ",222,"         "
                  DB 13,10,"         ",221,"                                                          ",222,"         "
                  DB 13,10,"         ",221,"               Press any key to continue...               ",222,"         "
                  DB 13,10,"         ",221,"                                                          ",222,"         "
                  DB 13,10,"         ",221,"                                        TAR UMT POS SYSTEM",222,"         "
                  DB 13,10,"         "
                  DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
                  DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
                  DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
                  DB        "         ","$"
;---------------DISPLAY CONSTANT END---------------

;---------------PURCHASE CONSTANT START---------------
PURCHASE_PROD_MENU DB       "         "
                   DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
                   DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
                   DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
                   DB       "         "
                   DB 13,10,"         ",221,"             (Enter X to Exit / C to Confirm)             ",222,"         "
                   DB 13,10,"         ",221,"                         Invoice                          ",222,"         "
                   DB 13,10,"         ",221,"       "
                   DB 218,196,196,194
                   DB 196,196,196,196,196,196,196,196,196,196,196,196,194
                   DB 196,196,196,196,196,196,196,196,196,194
                   DB 196,196,196,194
                   DB 196,196,196,196,196,196,196,196,196,196,196,196,191
                   DB "       ",222,"         "
                   DB 13,10,"         ",221,"       ",179,"NO",179,"PRODUCT NAME",179,"  PRICE  ",179,"QTY",179,"   AMOUNT   ",179,"       ",222,"         "
                   DB 13,10,"         ",221,"       "
                   DB 195,196,196,197
                   DB 196,196,196,196,196,196,196,196,196,196,196,196,197
                   DB 196,196,196,196,196,196,196,196,196,197
                   DB 196,196,196,197
                   DB 196,196,196,196,196,196,196,196,196,196,196,196,180
                   DB "       ",222,"         "
                   DB 13,10,"         ",221,"       ",179,"1.",179,"JAVA        ",179," RM 23.79",179," 00",179," RM 0000.000",179,"       ",222,"         "
                   DB 13,10,"         ",221,"       ",179,"2.",179,"Assembly    ",179," RM 15.50",179," 00",179," RM 0000.000",179,"       ",222,"         "
                   DB 13,10,"         ",221,"       ",179,"3.",179,"JavaScript  ",179," RM  9.99",179," 00",179," RM 0000.000",179,"       ",222,"         "
                   DB 13,10,"         ",221,"       "
                   DB 195,196,196,193
                   DB 196,196,196,196,196,196,196,196,196,196,196,196,193
                   DB 196,196,196,196,196,196,196,196,196,193
                   DB 196,196,196,193
                   DB 196,196,196,196,196,196,196,196,196,196,196,196,180
                   DB "       ",222,"         "
                   DB 13,10,"         ",221,"       ",179,"                 SUBTOTAL    : RM 0000.000",179,"       ",222,"         "
                   DB 13,10,"         ",221,"       ",179,"                 DISCOUNT(0%): RM 0000.000",179,"       ",222,"         "
                   DB 13,10,"         ",221,"       ",179,"                 SST(5%)     : RM 0000.000",179,"       ",222,"         "
                   DB 13,10,"         ",221,"       ",179,"                 TOTAL       : RM 0000.000",179,"       ",222,"         "
                   DB 13,10,"         ",221,"       "
                   DB 195,196,196,196,196,196,196,196,196,196,196
                   DB 196,196,196,196,196,196,196,196,196,196,196
                   DB 196,196,196,196,196,196,196,196,196,196,196
                   DB 196,196,196,196,196,196,196,196,196,196,180
                   DB "       ",222,"         "
                   DB 13,10,"         ",221,"       ",179,"                 CASH        : RM 0000.000",179,"       ",222,"         "
                   DB 13,10,"         ",221,"       ",179,"                 CHANGE      : RM 0000.000",179,"       ",222,"         "
                   DB 13,10,"         ",221,"       "
                   DB 192,196,196,196,196,196,196,196,196,196,196
                   DB 196,196,196,196,196,196,196,196,196,196,196
                   DB 196,196,196,196,196,196,196,196,196,196,196
                   DB 196,196,196,196,196,196,196,196,196,196,217
                   DB "       ",222,"         "
                   DB 13,10,"         ",221,"              (More than RM75  ",26," 3% Discount)             ",222,"         "
                   DB 13,10,"         ",221,"              (More than RM150 ",26," 7% Discount)             ",222,"         "
                   DB 13,10,"         ",221,"                                                          ",222,"         "
                   DB 13,10,"         ",221,"                                                          ",222,"         "
                   DB 13,10,"         ",221,"                                                          ",222,"         "
                   DB 13,10,"         ",221,"                                        TAR UMT POS SYSTEM",222,"         "
                   DB 13,10,"         "
                   DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
                   DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
                   DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
                   DB        "         ","$"
PROD_OPT_PROMPT DB "Product to purchase  : ","$"
PROD_QTY_PROMPT DB "Quantity to purchase : ","$"
USR_PROD_OPT DB 20 DUP("$")
USR_PROD_QTY_STR DB 20 DUP("$")
USR_PROD_QTY DW 0
INVALID_PROD_OPT_MSG DB "Error: Please select option between 1 to 3","$"
INVALID_PROD_QTY_MSG DB "Error: Please enter a valid quantity","$"

LENGTH_OF_PROD_QTY DB 0

PROD1_QTY DW 0
PROD2_QTY DW 0
PROD3_QTY DW 0
;---------------PURCHASE CONSTANT END---------------

;---------------REPORT CONSTANT START---------------
REPORT_PAGE DB       "         "
            DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
            DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
            DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220
            DB       "         "
            DB 13,10,"         ",221,"           ....  ....  ...       ...   .........          ",222,"         "
            DB 13,10,"         ",221,"          ###!: ###!: ##!:      ##!: #########!:          ",222,"         "
            DB 13,10,"         ",221,"          ###!: ###!: ###!:    ###!: #########!           ",222,"         "
            DB 13,10,"         ",221,"          ###!: ###!: ####!:  ####!:    ###!:             ",222,"         "
            DB 13,10,"         ",221,"          ###!: ###!: ############!:    ###!:             ",222,"         "
            DB 13,10,"         ",221,"          ###!: ###!: ###!####!###!:    ###!:             ",222,"         "
            DB 13,10,"         ",221,"          #########!: ###!:##! ###!:    ###!:             ",222,"         "
            DB 13,10,"         ",221,"           #######!:  ###:     ###!     ###!              ",222,"         "
            DB 13,10,"         ",221,"                                                          ",222,"         "
            DB 13,10,"         ",221,"                   ",218,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,191,"                  ",222,"         "
            DB 13,10,"         ",221,"                   ",179," SALES REPORT XXXX ",179,"                  ",222,"         "
            DB 13,10,"         ",221,"                   ",192,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,217,"                  ",222,"         "
            DB 13,10,"         ",221,"    "
            DB 218,196,196,194
            DB 196,196,196,196,196,196,196,196,196,196,196,196,194
            DB 196,196,196,196,196,196,196,196,196,194
            DB 196,196,196,196,196,196,196,194
            DB 196,196,196,196,196,196,196,196,196,196,196,196,196,196,191
            DB "    ",222,"         "
            DB 13,10,"         ",221,"    ",179,"NO",179,"PRODUCT NAME",179,"  PRICE  ",179,"  QTY  ",179,"    AMOUNT    ",179,"    ",222,"         "
            DB 13,10,"         ",221,"    "
            DB 195,196,196,197
            DB 196,196,196,196,196,196,196,196,196,196,196,196,197
            DB 196,196,196,196,196,196,196,196,196,197
            DB 196,196,196,196,196,196,196,197
            DB 196,196,196,196,196,196,196,196,196,196,196,196,196,196,180
            DB "    ",222,"         "
            DB 13,10,"         ",221,"    ",179,"1.",179,"JAVA        ",179," RM 23.79",179," 00000 ",179," RM 00000.000 ",179,"    ",222,"         "
            DB 13,10,"         ",221,"    ",179,"2.",179,"Assembly    ",179," RM 15.50",179," 00000 ",179," RM 00000.000 ",179,"    ",222,"         "
            DB 13,10,"         ",221,"    ",179,"3.",179,"JavaScript  ",179," RM  9.99",179," 00000 ",179," RM 00000.000 ",179,"    ",222,"         "
            DB 13,10,"         ",221,"    "
            DB 192,196,196,193
            DB 196,196,196,196,196,196,196,196,196,196,196,196,193
            DB 196,196,196,196,196,196,196,196,196,193
            DB 196,196,196,196,196,196,196,193
            DB 196,196,196,196,196,196,196,196,196,196,196,196,196,196,217
            DB "    ",222,"         "
            DB 13,10,"         ",221,"                 Total Transaction: 00000                 ",222,"         "
            DB 13,10,"         ",221,"               Press any key to continue...               ",222,"         "
            DB 13,10,"         ",221,"                                                          ",222,"         "
            DB 13,10,"         ",221,"                                        TAR UMT POS SYSTEM",222,"         "
            DB 13,10,"         "
            DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
            DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
            DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223
            DB        "         ","$"
TOTAL_TRANSACTION DW 0
PROD1_SALES DW 0
PROD2_SALES DW 0
PROD3_SALES DW 0
PROD1_TOTAL_SALES_DIGIT DW 0
PROD2_TOTAL_SALES_DIGIT DW 0
PROD3_TOTAL_SALES_DIGIT DW 0
PROD1_TOTAL_SALES_DECIMAL DW 0
PROD2_TOTAL_SALES_DECIMAL DW 0
PROD3_TOTAL_SALES_DECIMAL DW 0
;---------------REPORT CONSTANT END---------------

;---------------AMOUNT CONSTANT START---------------
PROD1_PRICE_DIGIT DW 23
PROD1_PRICE_DECIMAL DW 79
PROD2_PRICE_DIGIT DW 15
PROD2_PRICE_DECIMAL DW 50
PROD3_PRICE_DIGIT DW 9
PROD3_PRICE_DECIMAL DW 99

PROD1_TOTAL_PRICE_DIGIT DW 0
PROD1_TOTAL_PRICE_DECIMAL DW 0
PROD2_TOTAL_PRICE_DIGIT DW 0
PROD2_TOTAL_PRICE_DECIMAL DW 0
PROD3_TOTAL_PRICE_DIGIT DW 0
PROD3_TOTAL_PRICE_DECIMAL DW 0
ALL_PROD_SUBTOTAL_PRICE_DIGIT DW 0
ALL_PROD_SUBTOTAL_PRICE_DECIMAL DW 0
;---------------AMOUNT CONSTANT END---------------

;---------------DISCOUNT CONSTANT START---------------
DISCOUNT_RATE DW 0
DISCOUNT_DIGIT DW 0
DISCOUNT_DECIMAL DW 0
;---------------DISCOUNT CONSTANT END---------------

;---------------SST CONSTANT START---------------
SST_RATE DW 5
SST_DIGIT DW 0
SST_DECIMAL DW 0
;---------------SST CONSTANT END---------------

;---------------TOTAL CONSTANT START---------------
TOTAL_DIGIT DW 0
TOTAL_DECIMAL DW 0
;---------------TOTAL CONSTANT END---------------

;---------------CONFIRMATION CONSTANT START---------------
USR_CONFIRM_QUIT_PURCHASE_OPT DB 20 DUP("$")
USR_CONFIRM_PURCHASE_OPT DB 20 DUP("$")

ERROR_NO_PROD_PURCHASED_MSG DB "Nothing is purchased, please try again","$"
CONFIRMATION_PURCHASE_MSG DB "Are you confirm your purchase? (Y-Yes/N-No): ","$"
CONFIRMATION_QUIT_MSG     DB "Are you confirm to QUIT purchase? (Y-Yes/N-No): ","$"
INVALID_YES_NO_INPUT DB "Error: Please enter eiter 'Y' or 'N'","$"
USR_CONFIRMATION_PROD DB 20 DUP("$")
USR_CONFIRMATION_QUIT_PROD DB 20 DUP("$")
;---------------CONFIRMATION CONSTANT END---------------

;---------------CHANGE CONSTANT START---------------
CHANGE_DIGIT DW 0
CHANGE_DECIMAL DW 0
;---------------CHANGE CONSTANT END---------------

;---------------CASH CONSTANT START---------------
USR_CASH DB 20 DUP("$")
USR_CASH_LENGTH DW 0
USR_CASH_DOT DW 0
USR_CASH_DIGIT DW 0
USR_CASH_DECIMAL DW 0
CASH_DIGIT_STR DB 20 DUP("$")
CASH_DECIMAL_STR DB 20 DUP("$")
CASH_DIGIT DW 0
CASH_DECIMAL DW 0

INVALID_CASH_INPUT_MSG DB "Error: Please enter a valid Cash Amount","$"
INVALID_CASH_DIGIT_MSG DB "Error: The Cash Amount is more than RM 9999","$"
INVALID_CASH_DECIMAL_MSG DB "Error: The Cash Amount cannot exceed 2 decimal places","$"
INSUFFICIENT_CASH_AMOUNT_MSG DB "Error: Your payment is not enough to cover the Total Amount","$"

CASH_PROMPT DB "Cash for payment: RM ","$"
INVALID_USR_CASH_MSG DB "Invalid Cash Input!","$"
PURCHASE_SUCCESS_MSG DB "Purchase successfully!","$"
THANK_MSG DB "Thank you for choosing us! ",01,"$"
;---------------CASH CONSTANT END---------------

;------------------------------------------------
;------------------CONSTANT END------------------
;------------------------------------------------

;-------------------------------------------------------
;------------------MAIN FUNCTION START------------------
;-------------------------------------------------------

.CODE
MAIN PROC FAR
    MOV AX,@DATA
    MOV DS,AX

    ANIMATE_CLR_SCR_M
    CALL INTRO_FUNCT
    CALL LOGIN_FUNCT
    CALL MAIN_MENU_FUNCT
    CALL EXIT_ANIMATION_FUNCT
MAIN ENDP

;-----------------------------------------------------
;------------------MAIN FUNCTION END------------------
;-----------------------------------------------------

;--------------------------------------------------------
;------------------OTHER FUNCTION START------------------
;--------------------------------------------------------

;---------------MATH FUNCTION START---------------
MATH_DIVISION_DW_FUNCT PROC
  MOV DX,0
  DIV BX
  MOV QUOTIENT_DW_TMP,AX
  MOV REMAINDER_DW_TMP,DX

  RET
MATH_DIVISION_DW_FUNCT ENDP

MATH_DIVISION_DB_FUNCT PROC
  XOR AH,AH
  DIV BL
  MOV QUOTIENT_DB_TMP,AL
  MOV REMAINDER_DB_TMP,AH

  RET
MATH_DIVISION_DB_FUNCT ENDP

MATH_MULTIPLY_DW_FUNCT PROC
  MOV MULTIPLICAND_DIGIT_TMP,AX
  MOV MULTIPLICAND_DECIMAL_TMP,BX
  MOV MULTIPLIER_TMP,DX

  MOV AX,MULTIPLICAND_DIGIT_TMP
  MOV BX,MULTIPLIER_TMP
  MUL BX
  MOV [SI],AX

  MOV AX,MULTIPLICAND_DECIMAL_TMP
  MOV BX,MULTIPLIER_TMP
  MUL BX
  MOV [DI],AX

  MATH_DIVISION_DW_M [DI],100

  MOV AX,REMAINDER_DW_TMP
  MOV [DI],AX
    
  MOV AX,QUOTIENT_DW_TMP
  ADD [SI],AX
    
  RET
MATH_MULTIPLY_DW_FUNCT ENDP

MATH_ROUNDOFF_FUNCT PROC
  MATH_DIVISION_DW_M [DI],ROUNDOFF_DECIMAL_PLACES_TMP

  MOV AX,REMAINDER_DW_TMP
  MOV [DI],AX
    
  MOV AX,QUOTIENT_DW_TMP
  ADD [SI],AX

  RET
MATH_ROUNDOFF_FUNCT ENDP

MATH_DECIMAL_PLACE_SHIFT_FUNCT PROC
  MATH_DIVISION_DW_M [SI],100
  MOV AX,QUOTIENT_DW_TMP
  MOV [SI],AX

  MOV AX,REMAINDER_DW_TMP
  MOV BX,10
  MUL BX
  MOV SHIFT_DECIMAL_TMP,AX

  MATH_DIVISION_DW_M [DI],10

  CMP REMAINDER_DW_TMP,5
  JB FINAL_SHIFT
  INC QUOTIENT_DW_TMP

  FINAL_SHIFT:
    MOV AX,QUOTIENT_DW_TMP
    MOV [DI],AX
    
    MOV AX,SHIFT_DECIMAL_TMP
    ADD [DI],AX
    RET
MATH_DECIMAL_PLACE_SHIFT_FUNCT ENDP
;---------------MATH FUNCTION END---------------

;---------------ANIMATE FUNCTION START---------------
ANIMATE_DELAY_FUNCT PROC
  DELAY_LOOP1:
  MOV DELAY_LOOP_COUNTER,20

  DELAY_LOOP2:
    DEC DELAY_LOOP_COUNTER
    JNZ DELAY_LOOP2

    LOOP DELAY_LOOP1

  RET
ANIMATE_DELAY_FUNCT ENDP

ANIMATE_TYPING_ANIMATION_FUNCT PROC
  MOV TYPING_LOOP_COUNTER,0

  TYPING_ANIMATION_LOOP:
    MOV AH,02h
    MOV DL,[SI]
        
    ANIMATE_DELAY_M TYPING_LOOP_DELAY_TMP

    INC SI
    INC TYPING_LOOP_COUNTER

    CMP DL,"$"
    JNE TYPING_ANIMATION_PRINT
    RET

  TYPING_ANIMATION_PRINT:
    INT 21h
    JMP TYPING_ANIMATION_LOOP
ANIMATE_TYPING_ANIMATION_FUNCT ENDP

ANIMATE_TYPING_DELETE_FUNCT PROC
  TYPING_DELETE_LOOP:
    IO_PRINT_STR_M DELETE

    ANIMATE_DELAY_M 1000

    DEC TYPING_LOOP_COUNTER

    CMP TYPING_LOOP_COUNTER,0
    JNE TYPING_DELETE_LOOP
    RET
ANIMATE_TYPING_DELETE_FUNCT ENDP

ANIMATE_CLR_CONTAINER_LINE_FUNCT PROC
  DEC AL
  ANIMATE_MOV_CUR_M AL,0
  IO_PRINT_STR_M CONTAINER_BOX

  RET
ANIMATE_CLR_CONTAINER_LINE_FUNCT ENDP

ANIMATE_MSG_BOX_FUNCT PROC
  ANIMATE_MOV_CUR_M 9,0
  IO_PRINT_STR_M MSG_BOX
  
  MOV AL,78
  SUB AL,STRLEN_TMP
  MATH_DIVISION_DB_M AL,2
  ANIMATE_MOV_CUR_M 12,QUOTIENT_DB_TMP

  RET
ANIMATE_MSG_BOX_FUNCT ENDP

ANIMATE_BACKSPACE_DELETE_FUNCT PROC
  MOV AH,02h
  MOV DL,DELETE

  BACKSPACE_DELETE_LOOP:
    INT 21H
    LOOP BACKSPACE_DELETE_LOOP

  RET
ANIMATE_BACKSPACE_DELETE_FUNCT ENDP

ANIMATE_REMOVE_CUR_FUNCT PROC
  ANIMATE_MOV_CUR_M 24,69

  RET
ANIMATE_REMOVE_CUR_FUNCT ENDP

ANIMATE_MOV_CUR_FUNCT PROC
  MOV AH,02H
  MOV BH,0
  INT 10H

  RET
ANIMATE_MOV_CUR_FUNCT ENDP

ANIMATE_SYSTEM_PAUSE_FUNCT PROC
  IO_PRINT_STR_M SYSTEM_PAUSE_LINE
  ANIMATE_WAITING_INPUT_M

  RET
ANIMATE_SYSTEM_PAUSE_FUNCT ENDP

ANIMATE_WAITING_INPUT_FUNCT PROC
  MOV AH,07H
  INT 21H

  RET
ANIMATE_WAITING_INPUT_FUNCT ENDP

ANIMATE_FULLSCR_FUNCT PROC
  FULLSCR_LOOP:
    MOV AL,FULLSCR_LOOP_TIMES
    DEC FULLSCR_LOOP_TIMES

    MOV AH,0
    INT 10H
    CMP FULLSCR_LOOP_TIMES,155
    JNE FULLSCR_LOOP

    RET
ANIMATE_FULLSCR_FUNCT ENDP

ANIMATE_CLR_SCR_FUNCT PROC
  MOV AX,03H
  INT 10H

  RET
ANIMATE_CLR_SCR_FUNCT ENDP

ANIMATE_COOLDOWN_FUNCT PROC
  INC ANIMATE_COOLDOWN_FAILCOUNT_TMP
  MATH_DIVISION_DW_M ANIMATE_COOLDOWN_FAILCOUNT_TMP, 5
  CMP REMAINDER_DW_TMP,0
  JNE COOLDOWN_EXIT

  MATH_DIVISION_DW_M QUOTIENT_DW_TMP,10
  MOV AX,QUOTIENT_DW_TMP
  MOV ANIMATE_COOLDOWN_MIN1_TMP,AL
  MOV AX,REMAINDER_DW_TMP
  MOV ANIMATE_COOLDOWN_MIN2_TMP,AL

  ANIMATE_MOV_CUR_M 13,31
  IO_PRINT_STR_M ANIMATE_COOLDOWN_MSG

  ANIMATE_TIMER_M

  ANIMATE_MSG_BOX_M SYSTEM_PAUSE_MSG
  ANIMATE_WAITING_INPUT_M

  COOLDOWN_EXIT:
    RET
ANIMATE_COOLDOWN_FUNCT ENDP

ANIMATE_TIMER_FUNCT PROC
  ANIMATE_COUNTDOWN_MSG_REFRESH:
    ANIMATE_MOV_CUR_M 13,41

    IO_PRINT_DIGIT_M ANIMATE_COOLDOWN_MIN1_TMP
    IO_PRINT_DIGIT_M ANIMATE_COOLDOWN_MIN2_TMP

    IO_PRINT_CHAR_M ":"

    IO_PRINT_DIGIT_M ANIMATE_COOLDOWN_SEC1_TMP
    IO_PRINT_DIGIT_M ANIMATE_COOLDOWN_SEC2_TMP
        
    ANIMATE_REMOVE_CUR_M
    ANIMATE_DELAY_M 65535

    ANIMATE_BACKSPACE_DELETE_M 5

    ANIMATE_COOLDOWN_SEC2_INUS:
      CMP ANIMATE_COOLDOWN_SEC2_TMP,0
      JE ANIMATE_COOLDOWN_SEC1_MINUS
      DEC ANIMATE_COOLDOWN_SEC2_TMP

      JMP ANIMATE_COUNTDOWN_MSG_REFRESH

    ANIMATE_COOLDOWN_SEC1_MINUS:
      CMP ANIMATE_COOLDOWN_SEC1_TMP,0
      JE ANIMATE_COOLDOWN_MIN1_MINUS
      DEC ANIMATE_COOLDOWN_SEC1_TMP

      ADD ANIMATE_COOLDOWN_SEC2_TMP,9
      JMP ANIMATE_COUNTDOWN_MSG_REFRESH

    ANIMATE_COOLDOWN_MIN1_MINUS:
      CMP ANIMATE_COOLDOWN_MIN2_TMP,0
      JE ANIMATE_COOLDOWN_MIN2_MINUS
      DEC ANIMATE_COOLDOWN_MIN2_TMP

      ADD ANIMATE_COOLDOWN_SEC1_TMP,5
      ADD ANIMATE_COOLDOWN_SEC2_TMP,9
      JMP ANIMATE_COUNTDOWN_MSG_REFRESH

    ANIMATE_COOLDOWN_MIN2_MINUS:
      CMP ANIMATE_COOLDOWN_MIN1_TMP,0
      JE DONE
      DEC ANIMATE_COOLDOWN_MIN1_TMP

      ADD ANIMATE_COOLDOWN_MIN2_TMP,9
      JMP ANIMATE_COUNTDOWN_MSG_REFRESH

    DONE:
      RET
ANIMATE_TIMER_FUNCT ENDP
;---------------ANIMATE FUNCTION END---------------

;---------------SYMBOL FUNCTION END---------------
SYMBOL_LEFT_ARROW_FUNCT PROC
  IO_PRINT_CHAR_M 16

  RET
SYMBOL_LEFT_ARROW_FUNCT ENDP

SYMBOL_RIGHT_ARROW_FUNCT PROC
  IO_PRINT_CHAR_M 17

  RET
SYMBOL_RIGHT_ARROW_FUNCT ENDP
;---------------SYMBOL FUNCTION START---------------

;---------------IO FUNCTION START---------------
PRINT2D_FUNCT PROC
  MOV PRINT2D_NUM_TMP,AL
  CMP PRINT2D_NUM_TMP,10
  JAE PRINT2D_NUM_10
  JMP PRINT2D_NUM_1

  PRINT2D_NUM_10:
    MATH_DIVISION_DB_M PRINT2D_NUM_TMP,10

    IO_PRINT_DIGIT_M QUOTIENT_DB_TMP
    IO_PRINT_DIGIT_M REMAINDER_DB_TMP
    RET

  PRINT2D_NUM_1:
    IO_PRINT_DIGIT_M 0
    IO_PRINT_DIGIT_M PRINT2D_NUM_TMP
    RET
PRINT2D_FUNCT ENDP

IO_PRINT5D_DW_FUNCT PROC
  MOV PRINT5D_DW_NUM_TMP,AX

  MATH_DIVISION_DW_M PRINT5D_DW_NUM_TMP,10000
  MOV DX,QUOTIENT_DW_TMP
  IO_PRINT_DIGIT_M DL

  IO_PRINT4D_DW_M REMAINDER_DW_TMP
  
  RET
IO_PRINT5D_DW_FUNCT ENDP

IO_PRINT4D_DW_FUNCT PROC
  MOV PRINT4D_DW_NUM_TMP,AX

  MATH_DIVISION_DW_M PRINT4D_DW_NUM_TMP,1000
  MOV DX,QUOTIENT_DW_TMP
  IO_PRINT_DIGIT_M DL
  
  IO_PRINT3D_DW_M REMAINDER_DW_TMP

  RET
IO_PRINT4D_DW_FUNCT ENDP

IO_PRINT3D_DW_FUNCT PROC
  MOV PRINT3D_DW_NUM_TMP,AX

  MATH_DIVISION_DW_M PRINT3D_DW_NUM_TMP,100
  MOV DX,QUOTIENT_DW_TMP
  IO_PRINT_DIGIT_M DL

  IO_PRINT2D_DW_M REMAINDER_DW_TMP

  RET
IO_PRINT3D_DW_FUNCT ENDP

IO_PRINT2D_DW_FUNCT PROC
  MOV PRINT2D_DW_NUM_TMP,AX

  MATH_DIVISION_DW_M PRINT2D_DW_NUM_TMP,10
  MOV DX,QUOTIENT_DW_TMP
  IO_PRINT_DIGIT_M DL

  MOV DX,REMAINDER_DW_TMP
  IO_PRINT_DIGIT_M DL

  RET
IO_PRINT2D_DW_FUNCT ENDP

IO_PRINT_DIGIT_FUNCT PROC
  ADD DL,48
  MOV AH,02H
  INT 21H

  RET
IO_PRINT_DIGIT_FUNCT ENDP

IO_PRINT_CHAR_FUNCT PROC
  MOV AH,02H
  INT 21H

  RET
IO_PRINT_CHAR_FUNCT ENDP

IO_PRINT_STR_FUNCT PROC
  MOV AH,09H
  INT 21H

  RET
IO_PRINT_STR_FUNCT ENDP

IO_SCANF_FUNCT PROC
  MOV SI,0

  ENTERING:
    MOV AH,07H
    INT 21H

    CMP AL,0DH
    JE ENTERING_FINISH

    CMP AL,08H
    JE ENTERING_BACKSPACE

    CMP SI,INPUT_LENGTH_TMP
    JE ENTERING

    MOV [DI],AL

    IO_PRINT_CHAR_M [DI]

    INC SI
    INC DI

    JMP ENTERING

  ENTERING_BACKSPACE:
    CMP SI,0
    JE  ENTERING

    IO_PRINT_STR_M DELETE
      
    DEC SI
    DEC DI

    MOV AL,"$"
    MOV [DI],AL
    
    JMP ENTERING

  ENTERING_FINISH:
    RET
IO_SCANF_FUNCT ENDP

IO_SCANF_HIDDEN_FUNCT PROC
  MOV SI,0

  ENTERING_HIDDEN:
    MOV AH,07H
    INT 21H

    CMP AL,0DH
    JE ENTERING_FINISH_HIDDEN

    CMP AL,08H
    JE ENTERING_BACKSPACE_HIDDEN

    CMP SI,INPUT_LENGTH_HIDDEN_TMP
    JE ENTERING_HIDDEN

    MOV [DI],AL

    IO_PRINT_CHAR_M "*"

    INC SI
    INC DI

    JMP ENTERING_HIDDEN

  ENTERING_BACKSPACE_HIDDEN:
    CMP SI,0
    JE  ENTERING_HIDDEN

    IO_PRINT_STR_M DELETE
      
    DEC SI
    DEC DI

    MOV AL,"$"
    MOV [DI],AL
    
    JMP ENTERING_HIDDEN

  ENTERING_FINISH_HIDDEN:
    RET
IO_SCANF_HIDDEN_FUNCT ENDP
;---------------IO FUNCTION END---------------

;---------------TYPE FUNCTION START---------------
TYPE_IS_DIGIT_FUNCT PROC
  CMP IS_DIGIT_TMP,"0"
  JB IS_NOT_DIGIT

  CMP IS_DIGIT_TMP,"9"
  JA IS_NOT_DIGIT

  RETURN_TRUE_M
  RET

  IS_NOT_DIGIT:
    RETURN_FALSE_M
    RET
TYPE_IS_DIGIT_FUNCT ENDP

TYPE_IS_YES_NO_FUNCT PROC
  MOV IS_YES_NO_TMP,AL

  CMP IS_YES_NO_TMP,"Y"
  JE IS_YES_NO_TRUE

  CMP IS_YES_NO_TMP,"y"
  JE IS_YES_NO_TRUE

  CMP IS_YES_NO_TMP,"N"
  JE IS_YES_NO_TRUE

  CMP IS_YES_NO_TMP,"n"
  JE IS_YES_NO_TRUE

  RETURN_FALSE_M
  RET

  IS_YES_NO_TRUE:
    RETURN_TRUE_M
    RET
TYPE_IS_YES_NO_FUNCT ENDP
;---------------TYPE FUNCTION END---------------

;---------------STR FUNCTION START---------------
STR_TO_UPPER_FUNCT PROC
  MOV BL,[DI]
  CMP BL,"a"
  JB TO_UPPER_FUNCT_INVALID

  CMP BL,"z"
  JA TO_UPPER_FUNCT_INVALID

  SUB BL,32
  MOV [DI],BL

  TO_UPPER_FUNCT_INVALID:
    RET
STR_TO_UPPER_FUNCT ENDP

STR_TO_DW_FUNCT PROC
  MOV CH,STRLEN_TMP
  MOV STR_TO_DW_NUM_TMP,0

  CMP CH,1
  JE STR_TO_DW_LAST_CALC

  CMP CH,0
  JE STR_TO_DW_END

  STR_TO_DW_LOOP:
    MOV CL,CH
    DEC CL

    MOV AH,0
    MOV AL,[DI]
    SUB AL,"0"

  STR_TO_DW_TIMES:
    MUL TEN_DW
    DEC CL
    JNZ STR_TO_DW_TIMES

  STR_TO_DW_CALC:
    ADD STR_TO_DW_NUM_TMP,AX

    INC DI
    DEC CH
    CMP CH,1
    JNE STR_TO_DW_LOOP
  
  STR_TO_DW_LAST_CALC:
    MOV AH,0
    MOV AL,[DI]
    SUB AL,"0"
    ADD STR_TO_DW_NUM_TMP,AX

  STR_TO_DW_END:
    MOV AX,STR_TO_DW_NUM_TMP
    RET
STR_TO_DW_FUNCT ENDP

STR_STRCMP_FUNCT PROC
  STRCMP_LOOP:
    MOV AL,[SI]
    MOV BL,[DI]
    CMP AL,BL
    JNE STRCMP_NOT_EQUAL

    CMP BL,"$"
    JNE NOT_END_OF_STR
    JMP STRCMP_EQUAL

  NOT_END_OF_STR:
    INC SI
    INC DI
    JMP STRCMP_LOOP

  STRCMP_EQUAL:
    RETURN_TRUE_M
    RET

  STRCMP_NOT_EQUAL:
    RETURN_FALSE_M
    RET
STR_STRCMP_FUNCT ENDP

STR_STRLEN_FUNCT PROC
  MOV STRLEN_TMP,0

  STRLEN_LOOP:
    MOV AL,"$"
    CMP AL,[DI]
    JNE STRLEN_COUNTER_INC_LOOP
    RET

  STRLEN_COUNTER_INC_LOOP:
    INC DI
    INC STRLEN_TMP
    JMP STRLEN_LOOP

  RET
STR_STRLEN_FUNCT ENDP

STR_RESET_VALUES_FUNCT PROC
  MOV CX,20

  RESET_LOOP:
    MOV AL,"$"
    MOV [DI],AL

    INC DI
    LOOP RESET_LOOP

    RET
STR_RESET_VALUES_FUNCT ENDP
;---------------STR FUNCTION END---------------

;---------------SYS FUNCTION START---------------
RETURN_TRUE_FUNCT PROC
    MOV AL,1
    CMP AL,1

    RET
RETURN_TRUE_FUNCT ENDP

RETURN_FALSE_FUNCT PROC
    MOV AL,1
    CMP AL,2

    RET
RETURN_FALSE_FUNCT ENDP

GET_DATE_AND_TIME_FUNCT PROC
    MOV AH, 2AH
    INT 21H

    MOV CURRENT_YEAR, CX
    MOV CURRENT_MONTH, DH
    MOV CURRENT_DAY, DL
    MOV CURRENT_DAYOFWEEK, AL

    MOV AH, 2CH
    INT 21H

    MOV CURRENT_HOURS, CH
    MOV CURRENT_MINUTES, CL
    MOV CURRENT_SECONDS, DH

    ANIMATE_MOV_CUR_M 23,10

    IO_PRINT_CHAR_M "("
    CMP CURRENT_DAYOFWEEK,1
    JE MON_PRINT

    CMP CURRENT_DAYOFWEEK,2
    JE TUE_PRINT
    
    CMP CURRENT_DAYOFWEEK,3
    JE WED_PRINT
    
    CMP CURRENT_DAYOFWEEK,4
    JE THU_PRINT
    
    CMP CURRENT_DAYOFWEEK,5
    JE FRI_PRINT
    
    CMP CURRENT_DAYOFWEEK,6
    JE SAT_PRINT
    JMP SUN_PRINT
    
    MON_PRINT:
      IO_PRINT_STR_M MONDAY_MSG
      JMP PRINT_DAY_OF_WEEK_DONE

    TUE_PRINT:
      IO_PRINT_STR_M TUESDAY_MSG
      JMP PRINT_DAY_OF_WEEK_DONE

    WED_PRINT:
      IO_PRINT_STR_M WEDNESDAY_MSG
      JMP PRINT_DAY_OF_WEEK_DONE

    THU_PRINT:
      IO_PRINT_STR_M THURSDAY_MSG
      JMP PRINT_DAY_OF_WEEK_DONE

    FRI_PRINT:
      IO_PRINT_STR_M FRIDAY_MSG
      JMP PRINT_DAY_OF_WEEK_DONE

    SAT_PRINT:
      IO_PRINT_STR_M SATURDAY_MSG
      JMP PRINT_DAY_OF_WEEK_DONE

    SUN_PRINT:
      IO_PRINT_STR_M SUNDAY_MSG
      JMP PRINT_DAY_OF_WEEK_DONE

    PRINT_DAY_OF_WEEK_DONE:
      IO_PRINT_CHAR_M ")"

      IO_PRINT_CHAR_M " "

      PRINT2D CURRENT_DAY
      IO_PRINT_CHAR_M "/"
      PRINT2D CURRENT_MONTH
      IO_PRINT_CHAR_M "/"
      IO_PRINT4D_DW_M CURRENT_YEAR
     
      IO_PRINT_CHAR_M " "

      PRINT2D CURRENT_HOURS
      IO_PRINT_CHAR_M ":"
      PRINT2D CURRENT_MINUTES
      IO_PRINT_CHAR_M ":"
      PRINT2D CURRENT_SECONDS

      RET
GET_DATE_AND_TIME_FUNCT ENDP
;---------------SYS FUNCTION END---------------

;------------------------------------------------------
;------------------OTHER FUNCTION END------------------
;------------------------------------------------------

;------------------------------------------------
;------------------MODULE START------------------
;------------------------------------------------

;---------------------------------------------INTRO MODULE START--------------------------------------------
INTRO_FUNCT PROC
  ANIMATE_FULLSCR_M
  ANIMATE_TYPING_M STARTUP_ANIMATION_PAGE,75
  IO_PRINT_STR_M NEWLINE

  ANIMATE_MOV_CUR_M 36,46
  ANIMATE_TYPING_M STARTUP_ANIMATION_MSG1,1000
  ANIMATE_DELAY_M 65535
  ANIMATE_DELETE_M

  ANIMATE_TYPING_M STARTUP_ANIMATION_MSG2,1000
  ANIMATE_DELAY_M 65535
  ANIMATE_DELETE_M

  ANIMATE_TYPING_M STARTUP_ANIMATION_MSG3,1000
  ANIMATE_DELAY_M 65535
  ANIMATE_DELETE_M

  ANIMATE_MOV_CUR_M 36,52
  IO_PRINT_STR_M SYSTEM_PAUSE_MSG

  ANIMATE_WAITING_INPUT_M
  ANIMATE_CLR_SCR_M
  RET
INTRO_FUNCT ENDP
;---------------------------------------------INTRO MODULE END--------------------------------------------

;---------------------------------------------EXIT MODULE START--------------------------------------------
EXIT_ANIMATION_FUNCT PROC
  ANIMATE_CLR_SCR_M

  IO_PRINT_STR_M EXIT_PAGE

  MOV EXIT_PROGRESS_COUNTER,25
  LOOP_PROGRESS_EXIT:
    DEC EXIT_COUNTER
    JZ EXIT_PROMPT

    ANIMATE_MOV_CUR_M 18,EXIT_PROGRESS_COUNTER
    IO_PRINT_CHAR_M "="
      
    ANIMATE_MOV_CUR_M 19,44
    ANIMATE_DELAY_M 7500

    ANIMATE_MOV_CUR_M 18,EXIT_PROGRESS_COUNTER
    IO_PRINT_CHAR_M 196

    INC EXIT_PROGRESS_COUNTER

    CMP EXIT_PROGRESS_COUNTER,53
    JAE RESET_PROGRESS
    JMP LOOP_PROGRESS_EXIT

  RESET_PROGRESS:
    MOV EXIT_PROGRESS_COUNTER,25
    JMP LOOP_PROGRESS_EXIT

  EXIT_PROMPT:
    ANIMATE_CLR_CONTAINER_LINE_M 20

    ANIMATE_MOV_CUR_M 19,30
    IO_PRINT_STR_M EXIT_SUCCESS_MSG

    ANIMATE_CLR_CONTAINER_LINE_M 20

    ANIMATE_SYSTEM_PAUSE_M
    ANIMATE_CLR_SCR_M

    MOV AX,4C00h
    INT 21h
EXIT_ANIMATION_FUNCT ENDP
;---------------------------------------------EXIT MODULE END--------------------------------------------

;---------------------------------------------LOGIN FUNCTION START--------------------------------------------
LOGIN_FUNCT PROC
  RELOGIN:
    ANIMATE_CLR_SCR_M
    IO_PRINT_STR_M LOGIN_PAGE

    STR_RESET_VALUES_M USR_USRNAME
    STR_RESET_VALUES_M USR_PASSWORD

    ANIMATE_MOV_CUR_M 16,38
    IO_SCANF_M USR_USRNAME,14H

    ANIMATE_MOV_CUR_M 17,38
    IO_SCANF_HIDDEN_M USR_PASSWORD,14H

    STR_STRCMP_M USR_PASSWORD,PASSWORD
    JNE LOGIN_FAILED

    STR_STRCMP_M USR_USRNAME,USRNAME
    JNE LOGIN_FAILED
    JMP LOGIN_SUCCESS

  LOGIN_FAILED:
    ANIMATE_MSG_BOX_M INVALID_LOGIN_MSG
    ANIMATE_COOLDOWN_M
    ANIMATE_WAITING_INPUT_M

    JMP RELOGIN

  LOGIN_SUCCESS:
    ANIMATE_MSG_BOX_M VALID_LOGIN_MSG
    ANIMATE_WAITING_INPUT_M

    RET
LOGIN_FUNCT ENDP
;---------------------------------------------LOGIN FUNCTION END--------------------------------------------

;---------------------------------------------MAINMENU FUNCTION START--------------------------------------------
MAIN_MENU_FUNCT PROC
  OPT1:
    CALL OPT1_CODE

    MOV AH,00H
    INT 16H

    CMP AH,80
    JE OPT2

    CMP AL,0DH
    JNE OPT4
    CALL DISPLAY_PROD_FUNCT
    JMP OPT1

  OPT2:
    CALL OPT2_CODE

    MOV AH,00H
    INT 16H

    CMP AH,80
    JE OPT3

    CMP AH,72
    JE OPT1

    CMP AL,0DH
    JNE OPT2
    CALL PURCHASE_PROD_FUNCT
    JMP OPT2

  OPT3:
    CALL OPT3_CODE

    MOV AH,00H
    INT 16H

    CMP AH,72
    JE OPT2

    CMP AL,0DH
    JNE OPT4

    CALL SALES_REPORT_FUNCT
    JMP OPT3

  OPT4:
    CALL OPT4_CODE

    MOV AH,00H
    INT 16H

    CMP AH,72
    JE OPT3

    CMP AL,0DH
    JNE OPT1

    CALL CONFIRMATION_EXIT_PROGRAM
    JMP OPT4

  RET
MAIN_MENU_FUNCT ENDP

OPT1_CODE PROC
  ANIMATE_CLR_SCR_M
  IO_PRINT_STR_M MAIN_MENU_PAGE

  ANIMATE_MOV_CUR_M 14,29
  SYMBOL_LEFT_ARROW_M

  ANIMATE_MOV_CUR_M 14,"0"
  SYMBOL_RIGHT_ARROW_M

  ANIMATE_REMOVE_CUR_M

  RET
OPT1_CODE ENDP

OPT2_CODE PROC
  ANIMATE_CLR_SCR_M
  IO_PRINT_STR_M MAIN_MENU_PAGE

  ANIMATE_MOV_CUR_M 16,28
  SYMBOL_LEFT_ARROW_M

  ANIMATE_MOV_CUR_M 16,"0"
  SYMBOL_RIGHT_ARROW_M

  ANIMATE_REMOVE_CUR_M
  
  RET
OPT2_CODE ENDP

OPT3_CODE PROC
  ANIMATE_CLR_SCR_M
  IO_PRINT_STR_M MAIN_MENU_PAGE

  ANIMATE_MOV_CUR_M 18,31
  SYMBOL_LEFT_ARROW_M

  ANIMATE_MOV_CUR_M 18,46
  SYMBOL_RIGHT_ARROW_M

  ANIMATE_REMOVE_CUR_M
  
  RET
OPT3_CODE ENDP

OPT4_CODE PROC
  ANIMATE_CLR_SCR_M
  IO_PRINT_STR_M MAIN_MENU_PAGE

  ANIMATE_MOV_CUR_M 20,35
  SYMBOL_LEFT_ARROW_M

  ANIMATE_MOV_CUR_M 20,42
  SYMBOL_RIGHT_ARROW_M

  ANIMATE_REMOVE_CUR_M
  
  RET
OPT4_CODE ENDP

CONFIRMATION_EXIT_PROGRAM PROC
  QUIT_PROGRAM_LOOP:
    STR_RESET_VALUES_M USR_CONFIRM_QUIT_PROGRAM_OPT

    ANIMATE_MSG_BOX_M CONFIRMATION_QUIT_PROGRAM_MSG
    IO_SCANF_M USR_CONFIRM_QUIT_PROGRAM_OPT,1

    STR_TO_UPPER_M USR_CONFIRM_QUIT_PROGRAM_OPT
    
    CMP USR_CONFIRM_QUIT_PROGRAM_OPT[0],"Y"
    JE CONFIRMATION_QUIT_PROGRAM_YES

    CMP USR_CONFIRM_QUIT_PROGRAM_OPT[0],"N"
    JE CONFIRMATION_QUIT_PROGRAM_NO

    ANIMATE_MSG_BOX_M INVALID_YES_NO_INPUT
    ANIMATE_WAITING_INPUT_M
    JMP QUIT_PROGRAM_LOOP

    CONFIRMATION_QUIT_PROGRAM_YES:
      CALL EXIT_ANIMATION_FUNCT

    CONFIRMATION_QUIT_PROGRAM_NO:
      RET
CONFIRMATION_EXIT_PROGRAM ENDP
;---------------------------------------------MAINMENU FUNCTION END--------------------------------------------

;---------------------------------------------DISPLAY FUNCTION START--------------------------------------------
DISPLAY_PROD_FUNCT PROC
  ANIMATE_CLR_SCR_M
  IO_PRINT_STR_M DISPLAY_PROD_MENU

  ANIMATE_MOV_CUR_M 20,0
  ANIMATE_SYSTEM_PAUSE_M

  RET
DISPLAY_PROD_FUNCT ENDP
;---------------------------------------------DISPLAY FUNCTION END--------------------------------------------

;---------------------------------------------REPORT FUNCTION START--------------------------------------------
SALES_REPORT_FUNCT PROC
  ANIMATE_CLR_SCR_M
  IO_PRINT_STR_M REPORT_PAGE
  GET_DATE_AND_TIME_M

  ANIMATE_MOV_CUR_M 11,44
  IO_PRINT4D_DW_M CURRENT_YEAR

  ANIMATE_MOV_CUR_M 16,42
  IO_PRINT5D_DW_M PROD1_SALES

  ANIMATE_MOV_CUR_M 17,42
  IO_PRINT5D_DW_M PROD2_SALES

  ANIMATE_MOV_CUR_M 18,42
  IO_PRINT5D_DW_M PROD3_SALES

  MATH_ROUNDOFF_M PROD1_TOTAL_SALES_DIGIT,PROD1_TOTAL_SALES_DECIMAL,100
  MATH_ROUNDOFF_M PROD2_TOTAL_SALES_DIGIT,PROD2_TOTAL_SALES_DECIMAL,100
  MATH_ROUNDOFF_M PROD3_TOTAL_SALES_DIGIT,PROD3_TOTAL_SALES_DECIMAL,100

  ANIMATE_MOV_CUR_M 16,53
  IO_PRINT5D_DW_M PROD1_TOTAL_SALES_DIGIT
  IO_PRINT_CHAR_M "."
  IO_PRINT2D_DW_M PROD1_TOTAL_SALES_DECIMAL

  ANIMATE_MOV_CUR_M 17,53
  IO_PRINT5D_DW_M PROD2_TOTAL_SALES_DIGIT
  IO_PRINT_CHAR_M "."
  IO_PRINT2D_DW_M PROD2_TOTAL_SALES_DECIMAL

  ANIMATE_MOV_CUR_M 18,53
  IO_PRINT5D_DW_M PROD3_TOTAL_SALES_DIGIT
  IO_PRINT_CHAR_M "."
  IO_PRINT2D_DW_M PROD3_TOTAL_SALES_DECIMAL

  ANIMATE_MOV_CUR_M 20,46
  IO_PRINT5D_DW_M TOTAL_TRANSACTION

  ANIMATE_MOV_CUR_M 20,0
  ANIMATE_SYSTEM_PAUSE_M

  RET
SALES_REPORT_FUNCT ENDP
;---------------------------------------------REPORT FUNCTION END--------------------------------------------

;---------------------------------------------PURCHASE FUNCTION START--------------------------------------------
PURCHASE_PROD_FUNCT PROC
  PURCHASE_AGAIN:
    MOV PROD1_QTY,0
    MOV PROD2_QTY,0
    MOV PROD3_QTY,0

  RESET_PURCHASE_PROD:
    ANIMATE_CLR_SCR_M
    IO_PRINT_STR_M PURCHASE_PROD_MENU
    GET_DATE_AND_TIME_M

  RE_ENTER_PURCHASE_PROD:
    CALL PRINT_AMOUNT_FUNCT

    STR_RESET_VALUES_M USR_PROD_OPT
    STR_RESET_VALUES_M USR_PROD_QTY_STR

    ANIMATE_MOV_CUR_M 20,25
    IO_PRINT_STR_M PROD_OPT_PROMPT

    ANIMATE_MOV_CUR_M 21,25
    IO_PRINT_STR_M PROD_QTY_PROMPT

    ANIMATE_MOV_CUR_M 20,48
    IO_SCANF_M USR_PROD_OPT,1

    JMP CHK_USR_PROD_OPT

  CONFIRM_PROD_PURCHASE:
    CALL CONFIRM_PURCHASE_FUNCT
    JNE RESET_PURCHASE_PROD
    JMP PURCHASE_AGAIN

  INVALID_PROD_OPT:
    ANIMATE_MSG_BOX_M INVALID_PROD_OPT_MSG
    ANIMATE_WAITING_INPUT_M
    JMP RESET_PURCHASE_PROD

  EXIT_PROD_PURCHASE:
    CALL QUIT_PURCHASE_FUNCT
    JNE RESET_PURCHASE_PROD
    RET

  CHK_USR_PROD_OPT:
    STR_TO_UPPER_M USR_PROD_OPT

    CMP USR_PROD_OPT[0],"X"
    JE EXIT_PROD_PURCHASE

    CMP USR_PROD_OPT[0],"C"
    JE CONFIRM_PROD_PURCHASE

    CMP USR_PROD_OPT[0],"1"
    JB INVALID_PROD_OPT

    CMP USR_PROD_OPT[0],"3"
    JA INVALID_PROD_OPT

  ANIMATE_MOV_CUR_M 21,48
  IO_SCANF_M USR_PROD_QTY_STR,2

  LEA SI,USR_PROD_QTY_STR

  PROD_QTY_CHK:
    MOV BL,[SI]

    TYPE_IS_END_M BL
    JE PROD_JUMPBOARD

    TYPE_IS_DIGIT_M BL
    JE PROD_QTY_CHK_NEXT
    
    ANIMATE_MSG_BOX_M INVALID_CASH_INPUT_MSG
    ANIMATE_WAITING_INPUT_M
    JMP RESET_PURCHASE_PROD

  PROD_QTY_CHK_NEXT:
    INC SI
    JMP PROD_QTY_CHK

  PROD_JUMPBOARD:
    STR_TO_DW_M USR_PROD_QTY_STR,USR_PROD_QTY
    MOV AX,USR_PROD_QTY

    CMP USR_PROD_OPT[0],"1"
    JE P1

    CMP USR_PROD_OPT[0],"2"
    JE P2

    CMP USR_PROD_OPT[0],"3"
    JE P3

  P1:
    MOV PROD1_QTY,AX
    ANIMATE_CLR_SCR_M
    IO_PRINT_STR_M PURCHASE_PROD_MENU
    JMP RESET_PURCHASE_PROD
  P2:
    MOV PROD2_QTY,AX
    ANIMATE_CLR_SCR_M
    IO_PRINT_STR_M PURCHASE_PROD_MENU
    JMP RESET_PURCHASE_PROD
  P3:
    MOV PROD3_QTY,AX
    JMP RESET_PURCHASE_PROD

    RET
PURCHASE_PROD_FUNCT ENDP

QUIT_PURCHASE_FUNCT PROC
  QUIT_PURCHASE_LOOP:
    STR_RESET_VALUES_M USR_CONFIRM_QUIT_PURCHASE_OPT

    ANIMATE_MSG_BOX_M CONFIRMATION_QUIT_MSG
    IO_SCANF_M USR_CONFIRM_QUIT_PURCHASE_OPT,1

    STR_TO_UPPER_M USR_CONFIRM_QUIT_PURCHASE_OPT
    
    CMP USR_CONFIRM_QUIT_PURCHASE_OPT[0],"Y"
    JE CONFIRMATION_QUIT_PROD_YES

    CMP USR_CONFIRM_QUIT_PURCHASE_OPT[0],"N"
    JE CONFIRMATION_QUIT_PROD_NO

    ANIMATE_MSG_BOX_M INVALID_YES_NO_INPUT
    ANIMATE_WAITING_INPUT_M
    JMP QUIT_PURCHASE_LOOP

    CONFIRMATION_QUIT_PROD_YES:
      RETURN_TRUE_M
      RET

    CONFIRMATION_QUIT_PROD_NO:
      RETURN_FALSE_M
      RET
QUIT_PURCHASE_FUNCT ENDP

CONFIRM_PURCHASE_FUNCT PROC
  CMP PROD1_QTY,0
  JNE CONFIRM_PURCHASE_LOOP
  CMP PROD2_QTY,0
  JNE CONFIRM_PURCHASE_LOOP
  CMP PROD3_QTY,0
  JNE CONFIRM_PURCHASE_LOOP


  ANIMATE_MSG_BOX_M ERROR_NO_PROD_PURCHASED_MSG
  ANIMATE_WAITING_INPUT_M
  RET

  CONFIRM_PURCHASE_LOOP:
    ANIMATE_MSG_BOX_M CONFIRMATION_PURCHASE_MSG
    IO_SCANF_M USR_CONFIRM_PURCHASE_OPT,1

    STR_TO_UPPER_M USR_CONFIRM_PURCHASE_OPT
    
    CMP USR_CONFIRM_PURCHASE_OPT[0],"Y"
    JE CONFIRMATION_CONFIRM_PURCHASE_YES

    CMP USR_CONFIRM_PURCHASE_OPT[0],"N"
    JE CONFIRMATION_CONFIRM_PURCHASE_NO

    ANIMATE_MSG_BOX_M INVALID_YES_NO_INPUT
    ANIMATE_WAITING_INPUT_M
    JMP CONFIRM_PURCHASE_LOOP

    CONFIRMATION_CONFIRM_PURCHASE_YES:
      CALL PAYMENT_FUNCT

      ANIMATE_MOV_CUR_M 15,52
      IO_PRINT4D_DW_M CASH_DIGIT
      IO_PRINT_CHAR_M "."
      IO_PRINT3D_DW_M CASH_DECIMAL

      CALL CHANGE_FUNCT
      RETURN_TRUE_M
      RET

    CONFIRMATION_CONFIRM_PURCHASE_NO:
      RETURN_FALSE_M
      RET
CONFIRM_PURCHASE_FUNCT ENDP
;---------------------------------------------PURCHASE FUNCTION END--------------------------------------------

;---------------------------------------------PAYMENT FUNCTION START--------------------------------------------
PAYMENT_FUNCT PROC
  RE_ENTER_USR_CASH:
    ANIMATE_CLR_SCR_M
    IO_PRINT_STR_M PURCHASE_PROD_MENU
    GET_DATE_AND_TIME_M
    CALL PRINT_AMOUNT_FUNCT

    STR_RESET_VALUES_M USR_CASH
    STR_RESET_VALUES_M CASH_DIGIT_STR
    STR_RESET_VALUES_M CASH_DECIMAL_STR
    MOV CASH_DIGIT,0
    MOV CASH_DECIMAL,0
    MOV USR_CASH_DIGIT,0
    MOV USR_CASH_DECIMAL,0
    
    ANIMATE_MOV_CUR_M 21,25
    IO_PRINT_STR_M CASH_PROMPT
    IO_SCANF_M USR_CASH,8

  MOV SI, OFFSET USR_CASH
  MOV DI, OFFSET CASH_DIGIT_STR

  CASH_DIGIT_CHK:
    MOV BL,[SI]

    TYPE_IS_END_M BL
    JE USR_CASH_DONE

    TYPE_IS_DOT_M BL
    JE CASH_DECIMAL_CHK

    TYPE_IS_DIGIT_M BL
    JE USR_CASH_DIGIT_STORE
    
    ANIMATE_MSG_BOX_M INVALID_CASH_INPUT_MSG
    ANIMATE_WAITING_INPUT_M
    JMP RE_ENTER_USR_CASH

  USR_CASH_DIGIT_STORE:
    MOV [DI],BL
    INC DI
    INC SI
    INC USR_CASH_DIGIT
    CMP USR_CASH_DIGIT,4
    JA CASH_DIGIT_ERROR
    JMP CASH_DIGIT_CHK

  CASH_DIGIT_ERROR:
    ANIMATE_MSG_BOX_M INVALID_CASH_DIGIT_MSG
    ANIMATE_WAITING_INPUT_M
    JMP RE_ENTER_USR_CASH

  USR_CASH_DONE:
    CALL CASH_COMPARE_CODE
    JNE CASH_INSUFFICIENT_ERROR

    CMP CASH_DIGIT_STR[0],"0"
    JE CASH_INSUFFICIENT_ERROR

    RET

  CASH_DECIMAL_CHK:
    MOV DI, OFFSET CASH_DECIMAL_STR
    INC SI

  CASH_DECIMAL_CHK_LOOP:
    MOV BL,[SI]

    TYPE_IS_END_M BL
    JE USR_CASH_DONE

    TYPE_IS_DOT_M BL
    JE CASH_DOT_ERROR

    TYPE_IS_DIGIT_M BL
    JE USR_CASH_DECIMAL_STORE

    ANIMATE_MSG_BOX_M INVALID_CASH_INPUT_MSG
    ANIMATE_WAITING_INPUT_M
    JMP RE_ENTER_USR_CASH

  USR_CASH_DECIMAL_STORE:
    MOV [DI],BL
    INC DI
    INC SI
    INC USR_CASH_DECIMAL
    CMP USR_CASH_DECIMAL,2
    JA CASH_DECIMAL_ERROR
    JMP CASH_DECIMAL_CHK_LOOP

  CASH_DECIMAL_ERROR:
    ANIMATE_MSG_BOX_M INVALID_CASH_DECIMAL_MSG
    ANIMATE_WAITING_INPUT_M
    JMP RE_ENTER_USR_CASH

  CASH_DOT_ERROR:
    ANIMATE_MSG_BOX_M INVALID_CASH_INPUT_MSG
    ANIMATE_WAITING_INPUT_M
    JMP RE_ENTER_USR_CASH
  
  CASH_INSUFFICIENT_ERROR:
    ANIMATE_MSG_BOX_M INSUFFICIENT_CASH_AMOUNT_MSG
    ANIMATE_WAITING_INPUT_M
    JMP RE_ENTER_USR_CASH
PAYMENT_FUNCT ENDP

CASH_COMPARE_CODE PROC
  CMP CASH_DIGIT_STR[0],"$"
  JE CASH_INSUFFICIENT

  STR_STRLEN_M CASH_DECIMAL_STR
  CMP STRLEN_TMP,1
  JNE STR_CONVERTER
  MOV CASH_DECIMAL_STR[1],"0"

  STR_CONVERTER:
    STR_TO_DW_M CASH_DIGIT_STR,CASH_DIGIT
    STR_TO_DW_M CASH_DECIMAL_STR,CASH_DECIMAL

  MOV AX,CASH_DECIMAL
  MUL TEN_DW
  MOV CASH_DECIMAL,AX

  MOV BX,CASH_DIGIT

  MOV AX,CASH_DECIMAL
  CMP AX,TOTAL_DECIMAL
  JAE CASH_DIGIT_COMPARE
  DEC BX

  CASH_DIGIT_COMPARE:
    CMP BX,TOTAL_DIGIT
    JB CASH_INSUFFICIENT
    JMP CASH_SUFFICIENT

  CASH_INSUFFICIENT:
    RETURN_FALSE_M
    RET

  CASH_SUFFICIENT: 
    RETURN_TRUE_M
    RET
CASH_COMPARE_CODE ENDP
;---------------------------------------------PAYMENT FUNCTION END--------------------------------------------

;---------------------------------------------CASH FUNCTION START--------------------------------------------
CHANGE_FUNCT PROC
  ANIMATE_MOV_CUR_M 16,52

  MOV AX,CASH_DECIMAL
  CMP AX,TOTAL_DECIMAL
  JAE CASH_CALC
  ADD AX,1000
  DEC CASH_DIGIT

  CASH_CALC:
    SUB AX,TOTAL_DECIMAL
    MOV CHANGE_DECIMAL,AX

    MOV AX,CASH_DIGIT
    SUB AX,TOTAL_DIGIT
    MOV CHANGE_DIGIT,AX

    IO_PRINT4D_DW_M CHANGE_DIGIT
    IO_PRINT_CHAR_M "."
    IO_PRINT3D_DW_M CHANGE_DECIMAL

    INC TOTAL_TRANSACTION
    
    MOV AX,PROD1_QTY
    ADD PROD1_SALES,AX
    
    MOV AX,PROD2_QTY
    ADD PROD2_SALES,AX

    MOV AX,PROD3_QTY
    ADD PROD3_SALES,AX

    MOV AX,PROD1_TOTAL_PRICE_DIGIT
    ADD PROD1_TOTAL_SALES_DIGIT,AX

    MOV AX,PROD2_TOTAL_PRICE_DIGIT
    ADD PROD2_TOTAL_SALES_DIGIT,AX

    MOV AX,PROD3_TOTAL_PRICE_DIGIT
    ADD PROD3_TOTAL_SALES_DIGIT,AX

    MOV AX,PROD1_TOTAL_PRICE_DECIMAL
    ADD PROD1_TOTAL_SALES_DECIMAL,AX

    MOV AX,PROD2_TOTAL_PRICE_DECIMAL
    ADD PROD2_TOTAL_SALES_DECIMAL,AX

    MOV AX,PROD3_TOTAL_PRICE_DECIMAL
    ADD PROD3_TOTAL_SALES_DECIMAL,AX

    ANIMATE_MOV_CUR_M 20,25
    IO_PRINT_STR_M THANK_MSG

    ANIMATE_MOV_CUR_M 20,0
    ANIMATE_SYSTEM_PAUSE_M
  
  RET
CHANGE_FUNCT ENDP
;---------------------------------------------CASH FUNCTION END--------------------------------------------

;---------------------------------------------CASH FUNCTION START--------------------------------------------
PRINT_AMOUNT_FUNCT PROC
  MATH_MULTIPLY_DW_M PROD1_PRICE_DIGIT,PROD1_PRICE_DECIMAL,PROD1_QTY,PROD1_TOTAL_PRICE_DIGIT,PROD1_TOTAL_PRICE_DECIMAL
  MATH_MULTIPLY_DW_M PROD2_PRICE_DIGIT,PROD2_PRICE_DECIMAL,PROD2_QTY,PROD2_TOTAL_PRICE_DIGIT,PROD2_TOTAL_PRICE_DECIMAL
  MATH_MULTIPLY_DW_M PROD3_PRICE_DIGIT,PROD3_PRICE_DECIMAL,PROD3_QTY,PROD3_TOTAL_PRICE_DIGIT,PROD3_TOTAL_PRICE_DECIMAL

  ANIMATE_MOV_CUR_M 6,45
  IO_PRINT2D_DW_M PROD1_QTY

  ANIMATE_MOV_CUR_M 7,45
  IO_PRINT2D_DW_M PROD2_QTY

  ANIMATE_MOV_CUR_M 8,45
  IO_PRINT2D_DW_M PROD3_QTY

  ANIMATE_MOV_CUR_M 6,52
  IO_PRINT4D_DW_M PROD1_TOTAL_PRICE_DIGIT
  IO_PRINT_CHAR_M "."
  IO_PRINT2D_DW_M PROD1_TOTAL_PRICE_DECIMAL

  ANIMATE_MOV_CUR_M 7,52
  IO_PRINT4D_DW_M PROD2_TOTAL_PRICE_DIGIT
  IO_PRINT_CHAR_M "."
  IO_PRINT2D_DW_M PROD2_TOTAL_PRICE_DECIMAL

  ANIMATE_MOV_CUR_M 8,52
  IO_PRINT4D_DW_M PROD3_TOTAL_PRICE_DIGIT
  IO_PRINT_CHAR_M "."
  IO_PRINT2D_DW_M PROD3_TOTAL_PRICE_DECIMAL

  MOV ALL_PROD_SUBTOTAL_PRICE_DECIMAL,0
  MOV ALL_PROD_SUBTOTAL_PRICE_DIGIT,0

  MOV AX,0
  ADD AX,PROD1_TOTAL_PRICE_DECIMAL
  ADD AX,PROD2_TOTAL_PRICE_DECIMAL
  ADD AX,PROD3_TOTAL_PRICE_DECIMAL
  MOV ALL_PROD_SUBTOTAL_PRICE_DECIMAL,AX

  MOV AX,0
  ADD AX,PROD1_TOTAL_PRICE_DIGIT
  ADD AX,PROD2_TOTAL_PRICE_DIGIT
  ADD AX,PROD3_TOTAL_PRICE_DIGIT
  MOV ALL_PROD_SUBTOTAL_PRICE_DIGIT,AX

  MATH_ROUNDOFF_M ALL_PROD_SUBTOTAL_PRICE_DIGIT,ALL_PROD_SUBTOTAL_PRICE_DECIMAL,100

  ANIMATE_MOV_CUR_M 10,52
  IO_PRINT4D_DW_M ALL_PROD_SUBTOTAL_PRICE_DIGIT
  IO_PRINT_CHAR_M "."
  IO_PRINT2D_DW_M ALL_PROD_SUBTOTAL_PRICE_DECIMAL

  CALL DISCOUNT_FUNCT
  CALL SST_FUNCT
  CALL TOTAL_FUNCT

  RET
PRINT_AMOUNT_FUNCT ENDP
;---------------------------------------------CASH FUNCTION END--------------------------------------------

;---------------------------------------------DISCOUNT FUNCTION START--------------------------------------------
DISCOUNT_FUNCT PROC
  MOV DISCOUNT_DIGIT,0
  MOV DISCOUNT_DECIMAL,0

  ANIMATE_MOV_CUR_M 11,44
  CMP ALL_PROD_SUBTOTAL_PRICE_DIGIT,75
  JAE DISCOUNT3
  
  IO_PRINT_CHAR_M "0"
  MOV DISCOUNT_RATE,0
  RET

  DISCOUNT3:
    CMP ALL_PROD_SUBTOTAL_PRICE_DIGIT,150
    JAE DISCOUNT7
    
    IO_PRINT_CHAR_M "3"
    MOV DISCOUNT_RATE,3

    JMP DISCOUNT_CALC

  DISCOUNT7:
    IO_PRINT_CHAR_M "7"
    MOV DISCOUNT_RATE,7

  DISCOUNT_CALC:
    MATH_MULTIPLY_DW_M ALL_PROD_SUBTOTAL_PRICE_DIGIT,ALL_PROD_SUBTOTAL_PRICE_DECIMAL,DISCOUNT_RATE,DISCOUNT_DIGIT,DISCOUNT_DECIMAL

    MATH_DECIMAL_PLACE_SHIFT_M DISCOUNT_DIGIT,DISCOUNT_DECIMAL

    ANIMATE_MOV_CUR_M 11,52
    IO_PRINT4D_DW_M DISCOUNT_DIGIT
    IO_PRINT_CHAR_M "."
    IO_PRINT3D_DW_M DISCOUNT_DECIMAL

    RET
DISCOUNT_FUNCT ENDP
;---------------------------------------------DISCOUNT FUNCTION END--------------------------------------------

;---------------------------------------------SST FUNCTION START--------------------------------------------
SST_FUNCT PROC
  MOV SST_DIGIT,0
  MOV SST_DECIMAL,0

  MATH_MULTIPLY_DW_M ALL_PROD_SUBTOTAL_PRICE_DIGIT,ALL_PROD_SUBTOTAL_PRICE_DECIMAL,SST_RATE,SST_DIGIT,SST_DECIMAL

  MATH_DECIMAL_PLACE_SHIFT_M SST_DIGIT,SST_DECIMAL

  ANIMATE_MOV_CUR_M 12,52
  IO_PRINT4D_DW_M SST_DIGIT
  IO_PRINT_CHAR_M "."
  IO_PRINT3D_DW_M SST_DECIMAL

  RET
SST_FUNCT ENDP
;---------------------------------------------SST FUNCTION END--------------------------------------------

;---------------------------------------------TOTAL FUNCTION START--------------------------------------------
TOTAL_FUNCT PROC
  MOV TOTAL_DIGIT,0
  MOV TOTAL_DECIMAL,0

  MOV AX,ALL_PROD_SUBTOTAL_PRICE_DIGIT
  SUB AX,DISCOUNT_DIGIT
  ADD AX,SST_DIGIT
  MOV TOTAL_DIGIT,AX

  MOV AX,ALL_PROD_SUBTOTAL_PRICE_DECIMAL
  MOV BX,10
  MUL BX
  
  CMP AX,DISCOUNT_DECIMAL
  JAE TOTAL_DECIMAL_CALC
  ADD AX,1000
  DEC TOTAL_DIGIT

  TOTAL_DECIMAL_CALC:
    SUB AX,DISCOUNT_DECIMAL
    ADD AX,SST_DECIMAL
    MOV TOTAL_DECIMAL,AX

  MATH_ROUNDOFF_M TOTAL_DIGIT,TOTAL_DECIMAL,1000

  ANIMATE_MOV_CUR_M 13,52
  IO_PRINT4D_DW_M TOTAL_DIGIT
  IO_PRINT_CHAR_M "."
  IO_PRINT3D_DW_M TOTAL_DECIMAL

  RET
TOTAL_FUNCT ENDP
;---------------------------------------------TOTAL FUNCTION END--------------------------------------------

;----------------------------------------------
;------------------MODULE END------------------
;----------------------------------------------

END MAIN
