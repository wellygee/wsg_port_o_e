-- Check if database exists and create if not
SELECT 'CREATE DATABASE xxxxxxxxxx' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'xxxxxxxxxx')\gexec

-- Check if role exists before creating
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'foobar') THEN
    CREATE USER foobar WITH ENCRYPTED PASSWORD '1234';
  END IF;
END
$$;

GRANT ALL PRIVILEGES ON DATABASE xxxxxxxxxx TO foobar;

-- Connect to the database before creating tables
\c xxxxxxxxxx

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    is_superuser BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);