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

-- read uncommitted  -- does not all dirty reads in Postgres SQL
begin transaction isolation level read uncommitted;

-- SERIALIZABLE -- does not use read locks instead use 
-- internal MVCC(Multi version concurrency control)
-- & anamoly detection
-- https://www.postgresql.org/docs/current/transaction-iso.html
begin transaction isolation level SERIALIZABLE;
