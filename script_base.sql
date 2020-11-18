
--menu info
select * from cmdmenu where cmdid = '' order by cmdid;
select * from cmdmenu where en_cmdname like '%%'order by cmdid;
select * from cmdmenu where objname like '%%' order by cmdid;
--group info
select * from grmaster where objname like '%%' order by modcode;
--gv info
select * from search where searchcode like '%%' order by searchcode;
select * from searchfld where searchcode like '%%' order by position;

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
