with RedSalesPerson as (
    select p.sales_id
    from Orders o
        left join SalesPerson p on o.sales_id = p.sales_id
        left join Company c on o.com_id = c.com_id
    where c.name = 'RED'
)
select name
from SalesPerson
where sales_id not in (select * from RedSalesPerson)
;
