-- Revert sandbox:simple-variable-test from pg

BEGIN;

  DROP SCHEMA IF EXISTS vartest CASCADE;

COMMIT;
