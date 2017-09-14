-- Deploy sandbox:simple-variable-test to pg

BEGIN;

  DROP SCHEMA IF EXISTS vartest CASCADE;
  
  CREATE SCHEMA vartest AUTHORIZATION emil;

  CREATE TABLE IF NOT EXISTS vartest.test_table (
    col1 varchar(50) NOT NULL
  );

  INSERT INTO vartest.test_table (col1)
  VALUES ( :'test_variable' );

COMMIT;
