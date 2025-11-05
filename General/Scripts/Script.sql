-- Dummy table to test aything 
CREATE TABLE dummy_table (
	id SERIAL PRIMARY KEY, 
	username VARCHAR(50) NOT NULL, 
	email VARCHAR(100) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from dummy_table;

-- Step 1: Create the ENUM type
CREATE TYPE dummy_verification_status AS ENUM ('YES', 'NO');

-- Step 2: Add column using that type
ALTER TABLE dummy_table 
ADD COLUMN verified dummy_verification_status DEFAULT 'NO';




-- create table --> ERD --> /Users/harshmathur/Library/DBeaverData/workspace6/General/Diagrams/Facebook Public ERD.erd
CREATE TABLE dummy_user (
	id SERIAL PRIMARY KEY, 
	username VARCHAR(50) NOT NULL, 
	email VARCHAR(100) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select count(1) from dummy_user;

-- Renaming the table 
select * from users;
select * from users_new;

alter table users rename to users_new;
alter table users_new rename to users;

-- adding column
alter table users add contact_no numeric [10]; 
desc users;

alter table users add address varchar(150);

-- TODO add column to add image for profile photo

alter table users add work varchar(50);
alter table users add age numeric [3];
alter table users add friends numeric [7];
alter table users add followers numeric [7];
alter table users add work varchar(50);

--changing data type 
alter table users alter column id type bigint;


insert into users(username, email) values ('deepak', 'deepak@gmail.com');


-- creting Friends table 
CREATE TYPE request_status AS ENUM ('ACCEPTED', 'REJECTED', 'PENDING');


create table friends(
	user_id bigint
)


