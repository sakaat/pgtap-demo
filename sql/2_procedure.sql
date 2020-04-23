CREATE OR REPLACE PROCEDURE proc_split_users() LANGUAGE SQL AS $$
  INSERT INTO
    split_users
  SELECT
    trim(convert_from(substring(userdata::bytea,  1,  4), 'UTF8'))
  , trim(convert_from(substring(userdata::bytea,  5, 10), 'UTF8'))
  , trim(convert_from(substring(userdata::bytea, 15,  4), 'UTF8'))
  , trim(convert_from(substring(userdata::bytea, 19,  4), 'UTF8'))
  , trim(convert_from(substring(userdata::bytea, 23, 20), 'UTF8'))
  , trim(convert_from(substring(userdata::bytea, 43, 20), 'UTF8'))
  FROM
    import_users
  ON CONFLICT ON CONSTRAINT split_users_pkey
  DO UPDATE SET
    cd_dep    = EXCLUDED.cd_dep
  , cd_div    = EXCLUDED.cd_div
  , lastname  = EXCLUDED.lastname
  , firstname = EXCLUDED.firstname
  ;
$$;

CREATE OR REPLACE PROCEDURE proc_split_deps() LANGUAGE SQL AS $$
  INSERT INTO
    split_deps
  SELECT
    trim(convert_from(substring(depdata::bytea, 1,  4), 'UTF8'))
  , trim(convert_from(substring(depdata::bytea, 5, 40), 'UTF8'))
  FROM
    import_deps
  ON CONFLICT ON CONSTRAINT split_deps_pkey
  DO UPDATE SET
    nm_dep = EXCLUDED.nm_dep
  ;
$$;

CREATE OR REPLACE PROCEDURE proc_split_divs() LANGUAGE SQL AS $$
  INSERT INTO
    split_divs
  SELECT
    trim(convert_from(substring(divdata::bytea, 1,  4), 'UTF8'))
  , trim(convert_from(substring(divdata::bytea, 5, 40), 'UTF8'))
  FROM
    import_divs
  ON CONFLICT ON CONSTRAINT split_divs_pkey
  DO UPDATE SET
    nm_div = EXCLUDED.nm_div
  ;
$$;

CREATE OR REPLACE PROCEDURE proc_split_tels() LANGUAGE SQL AS $$
  INSERT INTO
    split_tels
  SELECT
    trim(convert_from(substring(teldata::bytea,  1,  4), 'UTF8'))
  , trim(convert_from(substring(teldata::bytea,  5,  6), 'UTF8'))
  , trim(convert_from(substring(teldata::bytea, 11, 20), 'UTF8'))
  FROM
    import_tels
  ON CONFLICT ON CONSTRAINT split_tels_pkey
  DO UPDATE SET
    no_tel = EXCLUDED.no_tel
  ;
$$;

CREATE OR REPLACE PROCEDURE proc_check_deps() LANGUAGE SQL AS $$
  UPDATE
    split_users
  SET
    error = 'ERROR-DEPS'
  WHERE
    (cf_company, cd_person)
  NOT IN
  (
    SELECT
      u.cf_company
    , u.cd_person
    FROM
      split_users u
    , split_deps d
    WHERE
      u.cd_dep = d.cd_dep
  );
$$;

CREATE OR REPLACE PROCEDURE proc_check_divs() LANGUAGE SQL AS $$
  UPDATE
    split_users
  SET
    error = 'ERROR-DIVS'
  WHERE
    (cf_company, cd_person)
  NOT IN
  (
    SELECT
      u.cf_company
    , u.cd_person
    FROM
      split_users u
    , split_divs d
    WHERE
      u.cd_div = d.cd_div
  );
$$;

CREATE OR REPLACE PROCEDURE proc_complete_users() LANGUAGE SQL AS $$
  INSERT INTO
    users
  SELECT
    u.cf_company
  , u.cd_person
  , u.cd_dep
  , u.cd_div
  , u.lastname
  , u.firstname
  , t.no_tel
  FROM
    split_users u
  LEFT OUTER JOIN
    split_tels t
  ON
  (
    t.cf_company = u.cf_company
    AND t.cd_person = u.cd_person
  )
  WHERE
    u.error IS NULL
  ON CONFLICT ON CONSTRAINT users_pkey
  DO UPDATE SET
    cd_dep    = EXCLUDED.cd_dep
  , cd_div    = EXCLUDED.cd_div
  , lastname  = EXCLUDED.lastname
  , firstname = EXCLUDED.firstname
  , no_tel    = EXCLUDED.no_tel
  ;
$$;

CALL proc_split_users();
CALL proc_split_deps();
CALL proc_split_divs();
CALL proc_split_tels();

CALL proc_check_deps();
CALL proc_check_divs();

CALL proc_complete_users();