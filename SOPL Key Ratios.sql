WITH pnl AS
(
    SELECT
        YEAR([Date]) AS Year,

        SUM(CASE WHEN Subclass = 'Sales'
                 THEN Amount ELSE 0 END) AS Revenue,

        SUM(CASE WHEN Class = 'Trading Account'
                 THEN Amount ELSE 0 END) AS Gross_Profit,

        SUM(CASE WHEN Class = 'Trading Account'
                  OR Subclass = 'Operating Expenses'
                 THEN Amount ELSE 0 END) AS EBITDA,

        SUM(CASE WHEN Class = 'Trading Account'
                  OR Class = 'Operating account'
                  OR Class = 'Non-operating'
                 THEN Amount ELSE 0 END) AS EBIT,

        ABS(SUM(CASE WHEN Subclass = 'Interest Expense'
                     THEN Amount ELSE 0 END)) AS Interest_Expense,

        SUM(CASE WHEN Class = 'Trading Account'
                  OR Class = 'Operating account'
                  OR Class = 'Non-operating'
                  OR Subclass = 'Interest Expense'
                 THEN Amount ELSE 0 END) AS EBT,

        SUM(CASE WHEN Report = 'Profit and Loss'
                 THEN Amount ELSE 0 END) AS Net_Profit,

        ABS(SUM(CASE WHEN Subclass = 'Operating Expenses'
                     THEN Amount ELSE 0 END)) AS Operating_Expenses

    FROM GL
    JOIN COA
        ON GL.Account_Key = COA.Account_Key
    WHERE Report = 'Profit and Loss'
    GROUP BY YEAR([Date])
)

SELECT
    Year,

    FORMAT(100.0 * Gross_Profit / NULLIF(Revenue,0),'N2') + '%' AS Gross_Margin,
    FORMAT(100.0 * EBITDA / NULLIF(Revenue,0),'N2') + '%' AS EBITDA_Margin,
    FORMAT(100.0 * EBIT / NULLIF(Revenue,0),'N2') + '%' AS EBIT_Margin,
    FORMAT(100.0 * EBT / NULLIF(Revenue,0),'N2') + '%' AS EBT_Margin,
    FORMAT(100.0 * Net_Profit / NULLIF(Revenue,0),'N2') + '%' AS Net_Margin,
    FORMAT(EBIT / NULLIF(Interest_Expense,0),'N2') + 'x' AS Interest_Coverage,
    FORMAT(100.0 * Operating_Expenses / NULLIF(Revenue,0),'N2') + '%' AS Opex_Ratio,
    FORMAT(100.0 * (EBT - Net_Profit) / NULLIF(EBT,0),'N2') + '%' AS Effective_Tax_Rate,

    Revenue,
    Gross_Profit,
    EBITDA,
    EBIT,
    Interest_Expense,
    EBT,
    Net_Profit

FROM pnl
ORDER BY Year;

