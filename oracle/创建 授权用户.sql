-- Create the user 
create user HCCPMS identified by "123456"
  default tablespace USERS
  temporary tablespace TEMP
  password expire;
-- Grant/Revoke object privileges 
-- Grant/Revoke role privileges 
grant connect to HCCPMS;
grant resource to HCCPMS;

--grant connect,resource to hccpms

