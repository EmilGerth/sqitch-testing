-- Deploy sandbox:simple-variable-test to pg

BEGIN;

  CREATE SCHEMA vartest AUTHORIZATION emil;

  CREATE TABLE IF NOT EXISTS vartest.test_table (
    col1 varchar(50) NOT NULL
  );

  INSERT INTO vartest.test_table (col1)
  VALUES ( :'test_variable' );

COMMIT;
