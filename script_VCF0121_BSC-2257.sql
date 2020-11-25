--cfmast info:002C110931
--menu info
select * from cmdmenu where cmdid = '' order by cmdid;
select * from cmdmenu where en_cmdname like '%%'order by cmdid;
select * from cmdmenu where objname like '%%' order by cmdid;
--group info
select * from grmaster where objname like '%%' order by modcode;
--gv info
select * from search where searchcode like '%CF0121%' order by searchcode;
select * from searchfld where searchcode like '%%CF0121' order by position;

--trans info
select * from tltx where tltxcd like '%0023%' order by tltxcd;
select * from fldmaster where objname like '%0023%' order by objname, odrnum;
select * from fldval where objname like '%0023%' order by objname, odrnum;

--appcheck, appmap info
select * from appchk where tltxcd like '%%';
select * from appmap where tltxcd like '%%';
select * from v_appmap_by_tltxcd where tltxcd like '%%';
select * from v_appchk_by_tltxcd where tltxcd like '%%';

--report, genneral view info
select * from rptmaster where rptid like '%%'; -- V, R, D, S
select * from rptfields where objname like '%%';

--fix + test script here
select * from APIOpenAccount;

SELECT  * FROM ALLCODE WHERE CDTYPE = 'CF' AND CDNAME = 'API0121' and CDVAL in ('Y','R') ORDER BY LSTODR
---
select API.USERID, API.BRID, API.REQID, API.FULLNAME, A0.CDCONTENT SEX ,API.SEX SEX_CD, API.DATEOFBIRTH, API.IDCODE
, API.IDDATE, API.IDENDDATE, API.IDPLACE, API.EMAIL, API.MOBILE, API.ADDRESS, A3.CDCONTENT TRADEONLINE, API.TRADEONLINE TRADEONLINE_CD
, A1.CDCONTENT AUTHTYPE, API.AUTHTYPE AUTHTYPE_CD, A4.CDCONTENT CUSTTYPE, 'IMAGE' IDATTACH,'IMAGE' SIGNATTACH,API.LIFECYCLE LIFECYCLE_CD,
A2.CDCONTENT ARVSTATUS, API.AVRSTATUS ARVSTATUS_CD
 from (SELECT A.*,
case when b.parterid is null and b.cifid is null then '0000' else b.brid end brid_t
FROM APIOpenAccount A,
(select nvl(parterid,'0000') parterid, nvl(cifid,'0000') cifid, nvl(brid,'0000') brid, autoid from api_cifbroker) B
WHERE nvl(A.USERID,'0000') = B.PARTERID(+)
and nvl(a.brid,'0000') = b.cifid(+)
AND OPENTYPE='CONTROL') API, ALLCODE A0,ALLCODE A3, ALLCODE A4, ALLCODE A1, ALLCODE A2
 where 1=1
 AND API.SEX=A0.CDVAL AND A0.CDNAME='SEX' AND A0.CDTYPE='CF'
 AND API.AUTHTYPE=A1.CDVAL AND A1.CDTYPE='CF' AND A1.CDNAME='OTAUTHTYPE'
 AND API.AVRSTATUS=A2.CDVAL AND A2.CDTYPE='CF' AND A2.CDNAME='API0121'
 AND API.TRADEONLINE= A3.CDVAL AND A3.CDNAME = 'YESNO' AND A3.CDTYPE = 'SY'
 AND API.CUSTTYPE=A4.CDVAL AND A4.CDNAME='APICUSTYPE' AND A4.CDTYPE='CF'
 AND (API.brid_t = DECODE('<$BRID>', '<$HO_BRID>', API.brid_t, '<$BRID>')
    )
---
select * from user_source where upper(text) like '%INSERT INTO APIOPENACCOUNT%';
select fullname, idcode from cfmast where custodycd = '002C110931';
select * from APIOpenAccount;
update APIOpenAccount set fullname ='Phạm Ngọc Toàn', idcode = '151928415';
---
select * from allcode where cdname= 'API0121';

select * from cfmast where status = 'C';

select * from tlprofiles order by tlid;
---
select idcode from cfmast group by idcode;
---
select * from cfmast where custid = '0001000642';
insert into cfmast (CUSTID, SHORTNAME, FULLNAME, MNEMONIC, DATEOFBIRTH, IDTYPE, IDCODE, IDDATE, IDPLACE, IDEXPIRED, ADDRESS, PHONE, MOBILE, FAX, EMAIL, COUNTRY, PROVINCE, POSTCODE, RESIDENT, CLASS, GRINVESTOR, INVESTRANGE, TIMETOJOIN, CUSTODYCD, STAFF, COMPANYID, POSITION, SEX, SECTOR, BUSINESSTYPE, INVESTTYPE, EXPERIENCETYPE, INCOMERANGE, ASSETRANGE, FOCUSTYPE, BRID, CAREBY, APPROVEID, LASTDATE, AUDITORID, AUDITDATE, LANGUAGE, BANKACCTNO, BANKCODE, VALUDADDED, ISSUERID, DESCRIPTION, MARRIED, TAXCODE, INTERNATION, OCCUPATION, EDUCATION, CUSTTYPE, STATUS, PSTATUS, INVESTMENTEXPERIENCE, PCUSTODYCD, EXPERIENCECD, ORGINF, TLID, ISBANKING, PIN, USERNAME, MRLOANLIMIT, RISKLEVEL, TRADINGCODE, TRADINGCODEDT, LAST_CHANGE, OPNDATE, CFCLSDATE, MARGINALLOW, CUSTATCOM, T0LOANLIMIT, DMSTS, ACTIVEDATE, AFSTATUS, MOBILESMS, OPENVIA, OLAUTOID, VAT, REFNAME, TRADEFLOOR, TRADETELEPHONE, TRADEONLINE, COMMRATE, CONSULTANT, ACTIVESTS, LAST_MKID, LAST_OFID, ONLINELIMIT, ISCHKONLIMIT, MANAGETYPE, NSDSTATUS, NSDOPNDATE, NSDCLSDATE, CFTYPE, CFOPNDATE, CFEXDATE, CIFID)
values ('0001012736', null, 'PNTOANTEST', 'PNTOANTEST', to_date('19-08-1995', 'dd-mm-yyyy'), '001', '0375529879', to_date('02-02-2020', 'dd-mm-yyyy'), 'HN', to_date('20-02-2028', 'dd-mm-yyyy'), '315 TC', null, null, null, 'ngnthanhhang@gmail.com ', '234', 'HN', null, null, 'KHDT', '000', '000', '000', '002C008006', '000', null, '000', null, '000', '009', '000', '000', '000', '000', '000', '0001', '0017', null, null, null, null, '001', null, '000', '000', null, null, '004', null, null, '001', '000', 'I', 'A', null, null, null, '00000', null, '0001', 'N', null, '002C000120', 10000000000000.0000, 'M', null, null, null, to_date('09-04-2020', 'dd-mm-yyyy'), null, 'Y', 'Y', 10000000000000.0000, 'N', to_date('09-04-2020', 'dd-mm-yyyy'), 'N', '0375529879', 'F', null, 'Y', null, 'Y', 'Y', 'Y', 100.0000, 'Y', 'N', '0001', null, 0, 'Y', 'A', 'P', null, null, null, null, null, null);

---
select * from t
