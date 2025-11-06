

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
	user_id bigint, -- user_id will be the requester by deault
	friend_user_id bigint,
	request_status request_status default 'PENDING',
	request_date timestamp default CURRENT_TIMESTAMP
)

-- linking via foreign key
-- https://neon.com/postgresql/postgresql-tutorial/postgresql-foreign-key
/*
[CONSTRAINT fk_name]
   FOREIGN KEY(fk_columns)
   REFERENCES parent_table(parent_key_columns)
   [ON DELETE delete_action]
   [ON UPDATE update_action]
   
   PostgreSQL supports the following actions:

		SET NULL
		SET DEFAULT
		RESTRICT
		NO ACTION - default
		CASCADE
   
*/

 -- add multiple column foreign key 
alter table friends 
add constraint fk_user_id
foreign key (user_id) 
references users(id) 
on delete cascade;

alter table friends 
add constraint fk_col_friend_user_id
foreign key (friend_user_id) 
references users(id) 
on delete cascade;

-- testing insert of non existence user_id

insert into friends (user_id, friend_user_id) values (500, 1000);


/*
 * Getting 
 * SQL Error [23503]: ERROR: insert or update on table "friends" violates foreign key constraint "fk_user_id"
  Detail: Key (user_id)=(500) is not present in table "users".
 * 
 */


-- composite key for user_id and friend_user_id

alter table friends 
add constraint pk_id_friends_table
primary key (user_id, friend_user_id);





