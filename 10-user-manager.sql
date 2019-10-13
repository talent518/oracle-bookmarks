--Oracle自带帐户
  -- sys 拥有dba、sysdba、sysoper（系统操作员 ）角色或权限，是Oracle权限最高的用户，只能以sysdba或sysoper登录，不能以normal形式登录。
  -- system 拥有dba、sysdba权限或角色，可以以普通用户的身份登录。
  -- sysdba、sysoper、dba区别
    -- sysdba 可以改变字符集、创建删除数据库、登录之后用户是 sys（shutdown、startup）
    -- sysoper 用户不可改变字符集、不能创、删数据库、登陆之后用户是 public（shutdown、startup）
    -- dba 只有在启动数据库后才能执行各种管理工作。
  -- 从大到小权限的用户 sysdba > sysoper > dba

-- 创建帐户
create user test identified by 1234;
-- 授予帐户角色权限
  -- connect 登录并连接权限
  -- resource 数据操作权限
  -- dba 基本dba权限
grant connect,resource,dba to test;
-- 删除帐户权限
revoke dba from test;

-- 查询帐户权限
select * from dba_role_privs where grantee='TEST';
-- 查询被激活的全部角色
select * from session_roles;
-- 当前用户被授予的角色
select * from user_role_privs;
-- 全部用户被授予的角色
select * from dba_role_privs;
-- 查看某个角色所拥有的权限
select * from dba_sys_privs where grantee='CONNECT';
-- 查看所有角色
select * from dba_roles;
