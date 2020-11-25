--cfmast info:002C110931 002C110950 0001012707 0001012736
select * from cfmast where custodycd in ('002C110931','002C110950');
--menu info
select * from cmdmenu where cmdid = '' order by cmdid;
select * from cmdmenu where en_cmdname like '%%'order by cmdid;
select * from cmdmenu where objname like '%CFMAST%' order by cmdid;
--obj info
select * from objmaster where objname like '%CFMAST%';
--group info
select * from grmaster where objname like '%CFMAST%' order by modcode;
--gv info
select * from search where searchcode like '%CFMAST%' order by searchcode;
select * from searchfld where searchcode like '%CFMAST%' order by position;

--trans info
select * from tltx where tltxcd like '%%' order by tltxcd;
select * from fldmaster where objname like '%%' order by objname, odrnum;
select * from fldval where objname like '%%' order by objname, odrnum;

--appcheck, appmap info
select * from appchk where tltxcd like '%%';
select * from appmap where tltxcd like '%%';
select * from v_appmap_by_tltxcd where tltxcd like '%%';
select * from v_appchk_by_tltxcd where tltxcd like '%%';

--report, genneral view info
select * from rptmaster where rptid like '%%'; -- V, R, D, S
select * from rptfields where objname like '%%';
----

select * from fldmaster where objname like '%CFAUTH%';
select * from cfauth where autoid = '35181' for update;

--
Select AU.CUSTID, case when nvl(AU.CUSTID,'XXX') <> 'XXX' then CF.FULLNAME else AU.FULLNAME end FULLNAME, 
case when nvl(AU.CUSTID,'XXX') <> 'XXX' then CF.IDCODE else AU.licenseno end IDCODE, 
case when nvl(AU.CUSTID,'XXX') <> 'XXX' then CF.ADDRESS else AU.ADDRESS end ADDRESS, 
case when nvl(AU.CUSTID,'XXX') <> 'XXX' then CF.MOBILESMS else AU.telephone end MOBILE, 
case when nvl(AU.CUSTID,'XXX') <> 'XXX' then CF.IDDATE else AU.lniddate end IDDATE, 
case when nvl(AU.CUSTID,'XXX') <> 'XXX' then CF.IDPLACE else AU.lnplace end IDPLACE, 
to_char(valdate,'DD/MM/RRRR') valdate, to_char(expdate,'DD/MM/RRRR') expdate  
, AU.DESCAUTH
from CFAUTH AU, CFMAST CF WHERE AU.AUTOID ='35181' and AU.custid = cf.custid(+) 

-----
select * from version order by actualversion desc; 6510136
