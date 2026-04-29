# Animation And Screen Flow

`src/FINAL.asm` uses macros and procedures to keep the DOS text UI consistent across intro, login, purchase, report, and exit screens.

## Macro Layer

| Macro | Purpose |
| --- | --- |
| `ANIMATE_DELAY_M` | Runs a delay loop for visible animation pacing. |
| `ANIMATE_TYPING_M` | Prints a `$`-terminated string one character at a time. |
| `ANIMATE_DELETE_M` | Deletes previously typed animated text. |
| `ANIMATE_CLR_CONTAINER_LINE_M` | Clears a line inside the UI container. |
| `ANIMATE_MSG_BOX_M` | Displays an animated message box and prints a message. |
| `ANIMATE_BACKSPACE_DELETE_M` | Handles visible deletion for input backspace behavior. |
| `ANIMATE_REMOVE_CUR_M` | Hides/removes the cursor visually. |
| `ANIMATE_MOV_CUR_M` | Moves the cursor using BIOS video services. |
| `ANIMATE_SYSTEM_PAUSE_M` | Displays a pause prompt. |
| `ANIMATE_WAITING_INPUT_M` | Waits for one keyboard input. |
| `ANIMATE_FULLSCR_M` | Adjusts the display mode used by the intro. |
| `ANIMATE_CLR_SCR_M` | Clears the screen. |
| `ANIMATE_COOLDOWN_M` | Starts the login cooldown flow. |
| `ANIMATE_TIMER_M` | Displays the cooldown timer. |

## Procedure Layer

The macros call matching procedures in the utility section:

```text
ANIMATE_DELAY_FUNCT
ANIMATE_TYPING_ANIMATION_FUNCT
ANIMATE_TYPING_DELETE_FUNCT
ANIMATE_CLR_CONTAINER_LINE_FUNCT
ANIMATE_MSG_BOX_FUNCT
ANIMATE_BACKSPACE_DELETE_FUNCT
ANIMATE_REMOVE_CUR_FUNCT
ANIMATE_MOV_CUR_FUNCT
ANIMATE_SYSTEM_PAUSE_FUNCT
ANIMATE_WAITING_INPUT_FUNCT
ANIMATE_FULLSCR_FUNCT
ANIMATE_CLR_SCR_FUNCT
ANIMATE_COOLDOWN_FUNCT
ANIMATE_TIMER_FUNCT
```

## Interrupts Used

Cursor movement and display mode behavior use BIOS video interrupt `10h`.

Character and keyboard-related behavior uses DOS interrupt `21h`.

## Intro Flow

`INTRO_FUNCT` performs:

1. Fullscreen/display setup.
2. Typing animation for the startup page.
3. Animated welcome messages.
4. Pause prompt.
5. Screen clear before login.

## Login Cooldown Flow

`LOGIN_FUNCT` calls `ANIMATE_COOLDOWN_M` after failed login validation. The cooldown procedure tracks failed attempts and then calls the timer routine to display a countdown.

## Message Box Flow

`ANIMATE_MSG_BOX_M` is used for validation feedback such as:

- Invalid username/password
- Successful login
- Invalid product option
- Invalid quantity
- Purchase confirmation
- Cash input errors
- Exit confirmation errors

## Exit Flow

`EXIT_ANIMATION_FUNCT` clears the screen, renders the exit page, animates a progress line, shows `Exit successfully!`, waits for a key, clears the screen, and terminates through DOS interrupt `21h` function `4Ch`.

## Notes For Future Changes

- Do not tune delay values blindly; DOSBox speed and host CPU settings affect perceived timing.
- Keep CP437 box/symbol characters visible by running in a DOS-compatible environment.
- If animation is changed, verify intro, login cooldown, message boxes, and exit in the same DOSBox session.
