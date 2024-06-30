create  role read_role;
grant select on *.* TO read_role;

create user read_user identified with sha256_password by 'reader_12345' ;
grant read_role to read_user;

create role stage_role;
grant create, insert ON stage.* TO stage_role;

create user stage_user identified with sha256_password by 'stager_12345' ;
grant stage_role to stage_user;