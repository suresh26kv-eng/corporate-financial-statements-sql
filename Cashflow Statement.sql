Select Rank,Type, Subtype,[2018],[2019],[2020] from (

Select Type, Subtype, Rank, Year(Date) as Varsha, 
Sum(
    Case when ValueType = 'All_FTP' then amount
         when ValueType = 'All_FTP_CS' then amount * -1
         when ValueType = 'All_FTP_Negative' and Amount < 0 then Amount
         When ValueType = 'All_FTP_Positive' and Amount > 0 then Amount
         When ValueType = 'ALL_FTP_Positive_CS' and Amount > 0 then amount * -1
         When Valuetype = 'All_FTP_Negative_CS' and Amount < 0 Then amount * -1
else 0 END) as Kasu


from GL
Join CF on GL.Account_key=CF.Account_key
Where ValueType not in ('Opening_Balance','Closing_Balance')
Group By Type, Subtype, Rank, Year(Date) ) as tabale1

Pivot( Sum(Kasu) for Varsha in ([2018],[2019],[2020])
) as table2

UNION
SELECT RANK, TYPE, SUBTYPE,[2018],[2019],[2020] FROM (

Select DISTINCT rank, type, subtype, Year(Date) AS Varsha,SUM(Amount) OVER (PARTITION BY RANK,TYPE, SUBTYPE ORDER BY YEAR(DATE) ) AS AMOUNT from GL
Join CF on GL.Account_key=CF.Account_key
WHERE TYPE = 'Cash and Cash equivalents at the END of the year' ) AS tabale1

PIVOT(SUM(AMOUNT) FOR VARSHA IN ([2018],[2019],[2020])

)AS TABLE2

UNION
SELECT RANK, TYPE, SUBTYPE,[2018],[2019],[2020] FROM (

SELECT RANK, TYPE, SUBTYPE, VARSHA, LAG(AMOUNT,1,0) OVER (ORDER BY VARSHA ASC) AS AMOUNT FROM(
Select DISTINCT rank, type, subtype, Year(Date) AS Varsha,SUM(Amount) OVER (PARTITION BY RANK,TYPE, SUBTYPE ORDER BY YEAR(DATE) ) AS Amount from GL
Join CF on GL.Account_key=CF.Account_key
WHERE TYPE = 'Cash and Cash equivalents at the sTART of the year' ) AS TABLE1 ) AS table2

PIVOT(SUM(AMOUNT) FOR VARSHA IN ([2018],[2019],[2020])) AS TABLE3


ORDER BY RANK