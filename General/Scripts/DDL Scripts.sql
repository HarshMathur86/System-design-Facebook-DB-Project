

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


-- altering user table to add more things

alter table users add first_name varchar(25);
alter table users add last_name varchar(25);

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

insert into friends (user_id, friend_user_id) values (1, 3); -- user_id 1-Requester, 3-Approver


-- composite key for user_id and friend_user_id

alter table friends 
add constraint pk_id_friends_table
primary key (user_id, friend_user_id);



-- Posts table
CREATE TABLE posts (
	post_id SERIAL PRIMARY KEY, 
	author_user_id bigint not null, 
	post_message VARCHAR(500) NOT NULL, --in HTML enbedded text for hyperlink suppport
	posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	constraint fk_author_user_id foreign key (author_user_id) references users(id) on delete cascade
);

-- Reaction table
--reaction_type rnum
CREATE TYPE reaction_type_enum AS ENUM ('LIKE', 'EMOJI'); -- this way new feature reaction acan added in future like upvotes for example

-- alter type reaction_type rename to reaction_type_enum;


CREATE TABLE post_reactions (
	post_id bigint not null, 
	reactor_user_id bigint not null, 
	reaction_type reaction_type_enum NOT NULL, --in HTML enbedded text for hyperlink suppport
	emoji varchar(2), -- stored in UTF-8 encoding
	constraint fk_post_id_reaction foreign key (post_id) references posts(post_id) on delete cascade,
	constraint fk_reactor_user_id_reaction foreign key (reactor_user_id) references users(id)
	
);

alter table post_reactions drop constraint fk_reactor_user_id_reaction;


-- comments only - L1 (Not integrating with reaction table for future to add L2 level comment)

CREATE TABLE post_comments (
	post_id bigint not null, 
	commenter_user_id bigint not null, 
	comment_message reaction_type_enum NOT NULL, --Plain text support only like youtube
	constraint fk_post_id_comment foreign key (post_id) references posts(post_id) on delete cascade
	
);
