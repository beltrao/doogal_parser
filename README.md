Doogal parser
=============

Parser for Doogal postcodes from http://www.doogal.co.uk/UKPostcodesCsvFrame.php

1) Run `ruby parse.rb`

2) import created sql file into your postcodes database `psql databasename < export.pgsql`

Queries
-------

```sql
insert into postcodes_new
select * from postcodes_codepo_gb_may_2013 c
where not EXISTS (select * from postcodes p where p.code=c.code)

insert into postcodes_new
select * from doogal_postcodes_jun_2013 c
where not EXISTS (select * from postcodes p where p.code=c.code)
and not EXISTS (select * from postcodes_new n where n.code=c.code)

select count(*) from postcodes
UNION
select count(*) from postcodes_codepo_gb_may_2013
union
select count(*) from doogal_postcodes_jun_2013
```
