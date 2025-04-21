create database project;
use project;
select*from `brokerage c`;
drop table `brokerage c`;

# 1 number of invoices by account executives

select*from invoice;
select `account executive`, count(`account executive`)as Invoice_count from project.invoice group by `account executive`;

# 2 yearly meeting count 

select*from meeting;
select distinct year(meeting_date)as year, count(year(meeting_date)) as `Total no of meetings` from meeting group by 1;

# 3 Renewal, Target, Achieved , invoiced

set @targetR = (select sum(`Renewal budget`) as Target from individual_budgets);
set @brokR = (select sum(amount) as achieved from brokerage where income_class ="Renewal");
set @feesR = (select sum(amount) as achieved from fees where income_class ="Renewal");
set @invoiceR = (select sum(amount) as Invoiced from invoice where income_class ="Renewal");
select @targetR as Renwal_Target, @brokR + @feesR as Renwal_Achieved, @invoiceR as Renwal_invoiced;

set @targetN = (select sum(`New budget`) as New_Target from individual_budgets);
set @brokN = (select sum(amount) as achieved from brokerage where income_class ="New");
set @feesN = (select sum(amount) as achieved from fees where income_class ="New");
set @invoiceN = (select sum(amount) as Invoiced from invoice where income_class ="New");
select @targetN as New_Target, @brokN + @feesN as New_Achieved, @invoiceN as New_invoiced;

set @targetC = (select sum(`Cross sell bugdet`) as Cross_sell_Target from individual_budgets);
set @brokC = (select sum(amount) as achieved from brokerage where income_class ="Cross Sell");
set @feesC = (select sum(amount) as achieved from fees where income_class ='Cross Sell');
set @invoiceC = (select sum(amount) as Invoiced from invoice where income_class ='Cross Sell');
select @targetC as Cross_sell_Target, @brokC+ @feesC as Cross_sell_Achieved, @invoiceC as Cross_sell_invoiced;

# 4 Stage funnel by revenue

select*from opportunity;
select stage, sum(revenue_amount) as revenue from opportunity group by 1;

# 5 number of meetings by account executive

select*from meeting;
select `Account Executive`, count(`Account Executive`) as `Total number of meetings` from meeting group by 1;


# 6 top 5 opportunities

select*from opportunity;
select opportunity_name, sum(revenue_amount) as `Total revenue` from opportunity group by 1 order by 2 desc limit 5;

#7 count of customers according to their ages

select Range_of_age,count(Range_of_age)Total_customers from(
select name,age, 
if(age>=80, "above 80",if(age>=60 and age< 80, "Between 60-80", if(age>=40 and age<60," between 40-60","less than 40"))) as Range_of_age  
from customer_info order by age desc) abc group by 1;











