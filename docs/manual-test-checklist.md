# Manual Test Checklist

Use this checklist after assembling and running `FINAL.EXE` in DOSBox.

## Environment

- DOSBox starts successfully.
- Project folder is mounted correctly.
- `MASM FINAL;` completes.
- `LINK FINAL;` completes.
- `FINAL.EXE` starts.
- `Alt + Enter` toggles fullscreen.

## Login

- Correct username and password succeeds.
- Wrong username fails.
- Wrong password fails.
- Empty username or password is rejected.
- Extra characters or spaces do not bypass validation.
- Password characters are hidden.
- Backspace/delete removes typed characters correctly.
- Maximum input length is enforced.
- Four failed attempts trigger cooldown.
- Repeated failed attempts increase cooldown time.

## Main Menu

- Main menu appears after successful login.
- Keyboard navigation moves the selected option.
- Enter opens the selected module.
- Returning from a module goes back to the main menu where expected.

## Display Product

- Product table displays JAVA, Assembly, and JavaScript.
- Prices match the source:
  - JAVA: RM 23.79
  - Assembly: RM 15.50
  - JavaScript: RM 9.99
- Pressing any key returns to the main menu.

## Purchase

- Product options `1`, `2`, and `3` are accepted.
- Invalid product options are rejected.
- Quantity input accepts normal values such as `5`.
- Quantity input accepts leading zero values such as `05`.
- Invalid quantity input is rejected.
- Product subtotal updates after a valid selection.
- `X` triggers quit purchase confirmation.
- `C` triggers confirm purchase.
- Confirming with no selected product shows an error.
- `Y` confirms purchase.
- `N` cancels purchase confirmation.
- Invalid confirmation input is rejected.

## Payment

- Cash prompt appears after purchase confirmation.
- Valid cash amount is accepted.
- Invalid characters are rejected.
- More than two decimal places is rejected.
- Amounts above RM9999 are rejected.
- Insufficient cash is rejected.
- Valid payment calculates and displays change.
- Successful purchase updates report totals.

## Sales Report

- Report screen opens from main menu.
- Current date and time display.
- Total transaction count updates after successful purchases.
- Product quantity totals update correctly.
- Product gross income totals update correctly.
- Pressing any key returns to the main menu.

## Exit

- Exit option asks for confirmation.
- `Y` exits.
- `N` cancels and returns to the menu.
- Lowercase `y` and `n` are accepted.
- Invalid input is rejected.
- Exit progress animation displays before termination.
