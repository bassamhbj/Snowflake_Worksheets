use role accountadmin;

--- Create Database
create or replace database COMMON_DB_1;


--- Create liquibase schema
create or replace schema liquibase_schema;


--- Create Project A schema
create or replace schema project_a_schema;


--- Create Project B schema
create or replace schema project_b_schema;


--- Create Project A CD Pipeline user
create or replace user project_a_cd_user
    password = '*********';


--- Create Project B CD Pipeline user
create or replace user project_b_cd_user
    password = '*********';


--- Creare Project A CD Pipeline warehouse
create or replace warehouse project_a_cd_wh
  warehouse_size = XSMALL
  auto_suspend = 10
  initially_suspended = TRUE
  auto_resume = TRUE;


--- Create Project B CD Pipeline warehouse
create or replace warehouse project_b_cd_wh
  warehouse_size = XSMALL
  auto_suspend = 10
  initially_suspended = TRUE
  auto_resume = TRUE;


--- Create Project A CD Pipeline role
create or replace role project_a_cd_role;


--- Create Project B CD Pipeline role
create or replace role project_b_cd_role;


--- Grant Privileges to Project A CD Pipeline role
grant all on schema liquibase_schema to role project_a_cd_role;
grant all on schema project_a_schema to role project_a_cd_role;
grant all on warehouse project_a_cd_wh to role project_a_cd_role;
grant usage on database COMMON_DB_1 to role project_a_cd_role;


--- Grant Privileges to Project B CD Pipeline role
grant all on schema liquibase_schema to role project_b_cd_role;
grant all on schema project_b_schema to role project_b_cd_role;
grant all on warehouse project_b_cd_wh to role project_b_cd_role;
grant usage on database COMMON_DB_1 to role project_b_cd_role;


-- Grant role to Project A CD User
grant role project_a_cd_role to user project_a_cd_user;


-- Grant role to Project B CD User
grant role project_b_cd_role to user project_b_cd_user;


--- Set default role and warehouse for Project A CD User
alter user project_a_cd_user set default_role = project_a_cd_role;
alter user project_a_cd_user set default_warehouse = project_a_cd_wh;


--- Set default role and warehouse for Project B CD User
alter user project_b_cd_user set default_role = project_b_cd_role;
alter user project_b_cd_user set default_warehouse = project_b_cd_wh;