DROP TABLE IF EXISTS import_users;
DROP TABLE IF EXISTS import_deps;
DROP TABLE IF EXISTS import_divs;
DROP TABLE IF EXISTS import_tels;
DROP TABLE IF EXISTS split_users;
DROP TABLE IF EXISTS split_deps;
DROP TABLE IF EXISTS split_divs;
DROP TABLE IF EXISTS split_tels;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS result_split_users;
DROP TABLE IF EXISTS result_split_deps;
DROP TABLE IF EXISTS result_split_divs;
DROP TABLE IF EXISTS result_split_tels;
DROP TABLE IF EXISTS result_users;

CREATE TABLE import_users ( userdata text );
CREATE TABLE import_deps  ( depdata text  );
CREATE TABLE import_divs  ( divdata text  );
CREATE TABLE import_tels  ( teldata text  );

CREATE TABLE split_users (
  cf_company varchar(3)
, cd_person  varchar(6)
, cd_dep     varchar(4)
, cd_div     varchar(4)
, lastname   varchar(20)
, firstname  varchar(20)
, error      varchar(40)
, CONSTRAINT split_users_pkey PRIMARY KEY(cf_company, cd_person)
);
CREATE TABLE split_deps (
  cd_dep varchar(4)
, nm_dep varchar(40)
, CONSTRAINT split_deps_pkey PRIMARY KEY(cd_dep)
);
CREATE TABLE split_divs (
  cd_div varchar(4)
, nm_div varchar(40)
, CONSTRAINT split_divs_pkey PRIMARY KEY(cd_div)
);
CREATE TABLE split_tels (
  cf_company varchar(3)
, cd_person  varchar(6)
, no_tel     varchar(20)
, CONSTRAINT split_tels_pkey PRIMARY KEY(cf_company, cd_person)
);

CREATE TABLE result_split_users (
  cf_company varchar(3)
, cd_person  varchar(6)
, cd_dep     varchar(4)
, cd_div     varchar(4)
, lastname   varchar(20)
, firstname  varchar(20)
, error      varchar(40)
, CONSTRAINT result_split_users_pkey PRIMARY KEY(cf_company, cd_person)
);
CREATE TABLE result_split_deps (
  cd_dep varchar(4)
, nm_dep varchar(40)
, CONSTRAINT result_split_deps_pkey PRIMARY KEY(cd_dep)
);
CREATE TABLE result_split_divs (
  cd_div varchar(4)
, nm_div varchar(40)
, CONSTRAINT result_split_divs_pkey PRIMARY KEY(cd_div)
);
CREATE TABLE result_split_tels (
  cf_company varchar(3)
, cd_person  varchar(6)
, no_tel     varchar(20)
, CONSTRAINT result_split_tels_pkey PRIMARY KEY(cf_company, cd_person)
);

CREATE TABLE users (
  cf_company varchar(3)
, cd_person  varchar(6)
, cd_dep     varchar(4)
, cd_div     varchar(4)
, lastname   varchar(20)
, firstname  varchar(20)
, no_tel     varchar(20)
, CONSTRAINT users_pkey PRIMARY KEY(cf_company, cd_person)
);

CREATE TABLE result_users (
  cf_company varchar(3)
, cd_person  varchar(6)
, cd_dep     varchar(4)
, cd_div     varchar(4)
, lastname   varchar(20)
, firstname  varchar(20)
, no_tel     varchar(20)
, CONSTRAINT result_users_pkey PRIMARY KEY(cf_company, cd_person)
);
