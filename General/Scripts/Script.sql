select count(1) from dummy_user;

-- Renaming the table 
select * from users;
select * from users_new;

alter table users rename to users_new;
alter table users_new rename to users;

-- adding column
alter table users add contact_no numeric [10]; 
desc users;

alter table users add address 
