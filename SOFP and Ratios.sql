WITH SOFP_Data AS
(
    SELECT DISTINCT
           YEAR([Date]) AS [Year],

           SUM(CASE
                   WHEN SubClass2 = 'Current Assets'
                   THEN Amount
                   ELSE 0
               END) OVER (
                   PARTITION BY YEAR([Date])
                   ORDER BY YEAR([Date])
               ) AS CA,

           SUM(CASE
                   WHEN SubClass2 = 'Non-Current Assets'
                   THEN Amount
                   ELSE 0
               END) OVER (
                   PARTITION BY YEAR([Date])
                   ORDER BY YEAR([Date])
               ) AS NCA,

           SUM(CASE
                   WHEN Class = 'Assets'
                   THEN Amount
                   ELSE 0
               END) OVER (
                   PARTITION BY YEAR([Date])
                   ORDER BY YEAR([Date])
               ) AS Total_Assets,

           SUM(CASE
                   WHEN SubClass2 = 'Current Liabilities'
                   THEN Amount
                   ELSE 0
               END) OVER (
                   PARTITION BY YEAR([Date])
                   ORDER BY YEAR([Date])
               ) AS CL,

           SUM(CASE
                   WHEN SubClass2 = 'Long Term Liabilities'
                   THEN Amount
                   ELSE 0
               END) OVER (
                   PARTITION BY YEAR([Date])
                   ORDER BY YEAR([Date])
               ) AS NCL,

           SUM(CASE
                   WHEN SubClass = 'Owners Equity'
                   THEN Amount
                   ELSE 0
               END) OVER (
                   PARTITION BY YEAR([Date])
                   ORDER BY YEAR([Date])
               ) AS Equity,

           SUM(CASE
                   WHEN Class = 'Liabilities and Owners Equity'
                   THEN Amount
                   ELSE 0
               END) OVER (
                   PARTITION BY YEAR([Date])
                   ORDER BY YEAR([Date])
               ) AS Equity_And_Liability,

           SUM(CASE
                   WHEN Account = 'Inventory'
                   THEN Amount
                   ELSE 0
               END) OVER (
                   PARTITION BY YEAR([Date])
                   ORDER BY YEAR([Date])
               ) AS Inventory

    FROM GL
    JOIN COA
        ON GL.Account_Key = COA.Account_Key
    JOIN Territory
        ON GL.Territory_Key = Territory.Territory_Key
)

SELECT
    *,

    FORMAT(CA / NULLIF(CL,0),'N2') + 'x' AS Current_Ratio,

    FORMAT((CA - Inventory) / NULLIF(CL,0),'N2') + 'x' AS Quick_Ratio,

    FORMAT(CA - CL,'N0') AS Working_Capital,

    FORMAT((CL + NCL) / NULLIF(Equity,0),'N2') + 'x' AS Debt_To_Equity,

    FORMAT(
        100.0 * (CL + NCL) / NULLIF(Total_Assets,0),
        'N2'
    ) + '%' AS Debt_Ratio,

    FORMAT(
        100.0 * Equity / NULLIF(Total_Assets,0),
        'N2'
    ) + '%' AS Equity_Ratio,

    FORMAT(
        Total_Assets / NULLIF(Equity,0),
        'N2'
    ) + 'x' AS Equity_Multiplier,

    FORMAT(
        100.0 * CA / NULLIF(Total_Assets,0),
        'N2'
    ) + '%' AS Current_Assets_Pct,

    FORMAT(
        100.0 * NCA / NULLIF(Total_Assets,0),
        'N2'
    ) + '%' AS Non_Current_Assets_Pct,

    FORMAT(
        100.0 * Inventory / NULLIF(Total_Assets,0),
        'N2'
    ) + '%' AS Inventory_Pct

FROM SOFP_Data
ORDER BY [Year];