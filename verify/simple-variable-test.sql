-- Verify sandbox:simple-variable-test on pg

BEGIN;

CREATE TEMPORARY TABLE expected_values (
  valueLabel VARCHAR(50) NOT NULL,
  value VARCHAR(50)
);

INSERT INTO expected_values (valueLabel, value)
VALUES ( 'test_variable', :'test_variable' );

DO LANGUAGE plpgsql $$
    DECLARE error_message VARCHAR := '';
    DECLARE test_variable VARCHAR(50);
BEGIN
    test_variable := (SELECT value FROM expected_values WHERE valueLabel = 'test_variable');

    IF NOT EXISTS (SELECT * FROM vartest.test_table WHERE col1 = test_variable )
      THEN error_message := 'Variable substitution did not work as hoped.';
    END IF;

    IF error_message <> ''
      THEN RAISE '%', error_message;
    END IF;
END;
$$;


/* This version doesn't work because plpgsql hits a syntax error on the leading colon.
    DO LANGUAGE plpgsql $$
        DECLARE error_message VARCHAR := '';
    BEGIN
        error_message := '';

        IF NOT EXISTS (SELECT * FROM vartest.test_table WHERE col1 = :'test_variable' )
          THEN error_message := 'Variable substitution did not work as hoped.';
        END IF;

        IF error_message <> ''
          THEN RAISE '%', error_message;
        END IF;
    END;
    $$;
*/

ROLLBACK;
