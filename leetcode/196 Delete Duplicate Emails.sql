delete
from Person
where id not in (select min(id)
                 from Person
                 where id is not null
                 group by email);
