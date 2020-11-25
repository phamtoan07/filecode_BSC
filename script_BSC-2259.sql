--cfmast info:002C110931 002C110950
--menu info
select * from cmdmenu where cmdid = '' order by cmdid;
select * from cmdmenu where en_cmdname like '%%'order by cmdid;
select * from cmdmenu where objname like '%%' order by cmdid;
--group info
select * from grmaster where objname like '%%' order by modcode;
--gv info
select * from search where tltxcd like '%0017%' order by searchcode;
select * from search where searchcode like '%%' order by searchcode;
select * from searchfld where searchcode like '%%' order by position;

--trans info
select * from tltx where tltxcd like '%0017%' order by tltxcd;
select * from fldmaster where objname like '%0017%' order by objname, odrnum;
select * from fldval where objname like '%0017%' order by objname, odrnum;

--appcheck, appmap info
select * from appchk where tltxcd like '%%';
select * from appmap where tltxcd like '%%';
select * from v_appmap_by_tltxcd where tltxcd like '%0017%';
select * from v_appchk_by_tltxcd where tltxcd like '%0017%';
select * from appchk where rulecd = '03' and acfld = '03'and apptype = 'CF';

--report, genneral view info
select * from rptmaster where rptid like '%0017%'; -- V, R, D, S
select * from rptfields where objname like '%%';
---

select tradingcode from cfmast where tradingcode is not null;
select * from fldmaster where objname= 'CF.CFMAST';
select * from fldval where objname= 'CF.CFMAST';

select * from allcode where cdname = 'IDTYPE';
select * from user_source where upper(text) like '%INSERT INTO CFMAST%';

select * from afmast;
select * from cimast;


SP_DEMO_CREATE_CUSTOMER
PR_IMPORT_CUSTOMER
CSPKS_FILEMASTER
CSPKS_FILEMASTER

select * from 

---
select * from apiopenaccount for update;
select tradingcodedt from cfmast where idcode = '151928426';

select * from tlog where luser = user order by id desc;
select * from aftype;
---
select * from API_CIFBROKER  where PARTERID = '0002'for update ;
SELECT a.cifid,a.careby, a.custid_rd,a.custid_rm, a.aftype, a.retype, a.recfdef, a.brid
          --INTO l_cifid,l_careby, l_custid_rd, l_custid_rm, l_aftype, l_retype_rm, l_retype_rd, l_branch
FROM API_CIFBROKER a WHERE PARTERID = '0002' AND CIFID IS NULL;
