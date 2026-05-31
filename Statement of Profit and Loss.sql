select Account_Key,Report,Class,SubClass,Details,[2018],[2019],[2020] from 
(
select GL.Account_key,Report,Class,Account,SubClass,Details,Year(Date) as Yr,Sum(Amount) as Amt from GL
Join COA on GL.Account_key=COA.Account_key
where Report = 'Profit and Loss'
Group by GL.Account_key,Report,Class,Account,SubClass,Details,Year(Date)
)as Table1
Pivot (sum(Amt) For Yr in ([2018],[2019],[2020])) as Table2
Order by Account_key
