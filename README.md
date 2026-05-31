# Relational Financial Statement Automation and Ratio Analysis Engine

A specialized SQL framework designed to model core financial accounting statements and automate corporate finance metrics directly within a relational database. This project translates raw general ledger data into structured accounting schedules—including the Statement of Profit or Loss (SOPL), Statement of Financial Position (SOFP), and Statement of Cash Flows—and programmatically derives key liquidity, solvency, and profitability ratios.

---

## Core Capabilities

### 1. Statement of Profit or Loss (SOPL) and Key Ratios
* **Structure:** Automates the aggregation of raw transactional ledgers into multi-step income statements, isolating Gross Profit, Operating Profit (EBIT), and Net Income.
* **Analytics:** Computes vertical analysis percentages and core operational profitability metrics, including Gross Profit Margin, Operating Margin, and Net Profit Margin.

### 2. Statement of Financial Position (SOFP) and Asset Ratios
* **Structure:** Models the balance sheet equation (Assets = Liabilities + Equity) by structuring current/non-current assets and liabilities alongside equity capital components.
* **Analytics:** Features programmatic calculation of balance sheet health ratios, evaluating working capital efficiency, asset turnover, and capital structure leverage metrics.

### 3. Statement of Cash Flows
* **Structure:** Constructs the cash flow schedule from ledger changes, accurately segregating cash dynamics into Operating Activities (via the indirect or direct method), Investing Activities, and Financing Activities.
* **Validation:** Reconciles net cash changes back to the cash and cash equivalents balance held on the Statement of Financial Position.

---

## Repository Structure

* **`Statement_of_Profit_and_Loss.sql`**: Generates structured revenue, cost of sales, and operating expense schedules from transactional data.
* **`SOPL_Key_Ratios.sql`**: Evaluates operating efficiency, margin distributions, and return profiles.
* **`SOFP_and_Ratios.sql`**: Establishes the financial position snapshot and computes liquidity metrics (Current Ratio, Quick Ratio) and solvency metrics.
* **`Cashflow_statement.sql`**: Aggregates cash inflows and outflows across operational, investment, and capital financing activities.

---

## Technical Features Demonstrated

* **Complex Aggregations:** Uses conditional aggregations (`SUM(CASE WHEN...)`) to dynamically map general ledger codes to correct financial statement line items.
* **Common Table Expressions (CTEs):** Implements multi-layered CTEs to handle sub-totals (e.g., calculating Gross Profit before executing Operating Expense deductions).
* **Data Normalization:** Built upon a normalized database schema mapping accounts, trial balances, and fiscal periods.

---

## How to Review the Queries

The queries are written in standard ANSI SQL and are compatible with enterprise relational database management systems (RDBMS) such as PostgreSQL, MySQL, or SQL Server. They assume a structured general ledger or trial balance table architecture.
