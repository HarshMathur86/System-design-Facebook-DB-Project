SELECT * FROM users;

-- Isolation level testing 

SHOW TRANSACTION ISOLATION LEVEL; -- current

SHOW default_transaction_isolation; -- default

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- Your SQL queries here
COMMIT;

-- repeatable read
begin transaction isolation level repeatable read;

select * from users where id=1;
update users set username='Harsh' where id=1;

-- read committed 
begin transaction isolation level read committed;

-- read uncommitted 
begin transaction isolation level read uncommitted;

-- SERIALIZABLE 
begin transaction isolation level SERIALIZABLE;
