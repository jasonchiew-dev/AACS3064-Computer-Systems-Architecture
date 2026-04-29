# Formulas And Sales Report Data Model

The project implements a small bookstore POS system with three products.

## Products

| Product | Price |
| --- | ---: |
| JAVA | RM 23.79 |
| Assembly | RM 15.50 |
| JavaScript | RM 9.99 |

In `src/FINAL.asm`, prices are stored as separate integer and decimal words:

```asm
PROD1_PRICE_DIGIT   DW 23
PROD1_PRICE_DECIMAL DW 79
PROD2_PRICE_DIGIT   DW 15
PROD2_PRICE_DECIMAL DW 50
PROD3_PRICE_DIGIT   DW 9
PROD3_PRICE_DECIMAL DW 99
```

This avoids floating-point arithmetic in the 8086 program.

## Purchase Formulas

```text
Product1Amount = Product1Price * Product1Quantity
Product2Amount = Product2Price * Product2Quantity
Product3Amount = Product3Price * Product3Quantity

Subtotal = Product1Amount + Product2Amount + Product3Amount

Discount = 0% if Subtotal < RM75
Discount = 3% if Subtotal >= RM75
Discount = 7% if Subtotal >= RM150

SST = Subtotal * 5%
Total = Subtotal - Discount + SST
Change = Cash - Total
```

The source stores purchase totals with digit and decimal variables:

```asm
ALL_PROD_SUBTOTAL_PRICE_DIGIT   DW 0
ALL_PROD_SUBTOTAL_PRICE_DECIMAL DW 0
DISCOUNT_DIGIT                  DW 0
DISCOUNT_DECIMAL                DW 0
SST_DIGIT                       DW 0
SST_DECIMAL                     DW 0
TOTAL_DIGIT                     DW 0
TOTAL_DECIMAL                   DW 0
CHANGE_DIGIT                    DW 0
CHANGE_DECIMAL                  DW 0
```

## Sales Report Formulas

```text
TotalTransaction = ExistingTotalTransaction + 1
TotalQuantityProductN = ExistingProductNQuantity + ProductNQuantity
TotalGrossIncomeProductN = ProductNPrice * TotalQuantityProductN
```

The sales report uses these accumulated fields:

```asm
TOTAL_TRANSACTION          DW 0
PROD1_SALES                DW 0
PROD2_SALES                DW 0
PROD3_SALES                DW 0
PROD1_TOTAL_SALES_DIGIT    DW 0
PROD2_TOTAL_SALES_DIGIT    DW 0
PROD3_TOTAL_SALES_DIGIT    DW 0
PROD1_TOTAL_SALES_DECIMAL  DW 0
PROD2_TOTAL_SALES_DECIMAL  DW 0
PROD3_TOTAL_SALES_DECIMAL  DW 0
```

## Related Procedures

- `PRINT_AMOUNT_FUNCT`
- `DISCOUNT_FUNCT`
- `SST_FUNCT`
- `TOTAL_FUNCT`
- `PAYMENT_FUNCT`
- `CHANGE_FUNCT`
- `SALES_REPORT_FUNCT`
