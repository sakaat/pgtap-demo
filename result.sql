INSERT INTO
  result_split_users
VALUES
  ('AAA', '111111', 'B111', '1234', 'aiba',      'masaki',   null)
, ('AAA', '222222', 'B666', '5678', 'matsumoto', 'jun',      'ERROR-DEPS')
, ('AAA', '333333', 'B111', '5678', 'ninomiya',  'kazunari', null)
, ('AAA', '444444', 'B111', '7777', 'ohno',      'satoshi',  'ERROR-DIVS')
, ('AAA', '555555', 'B111', '1234', 'sakurai',   'sho',      null)
;

INSERT INTO
  result_split_deps
VALUES
  ('B111', 'IT Dev 3.')
;

INSERT INTO
  result_split_divs
VALUES
  ('1234', 'IT Dev 31.')
, ('5678', 'IT Dev 32.')
;

INSERT INTO
  result_split_tels
VALUES
  ('AAA', '111111', '11111')
, ('AAA', '222222', '22222')
, ('AAA', '333333', '33333')
, ('AAA', '444444', '44444')
;

INSERT INTO
  result_users
VALUES
  ('AAA', '111111', 'B111', '1234', 'aiba',      'masaki',   '11111')
, ('AAA', '333333', 'B111', '5678', 'ninomiya',  'kazunari', '33333')
, ('AAA', '555555', 'B111', '1234', 'sakurai',   'sho',      null)
;