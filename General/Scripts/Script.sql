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


