 SELECT CF.CUSTODYCD, AF.ACCTNO AFACCTNO, CF.FULLNAME, OD.TXDATE , OD.CLEARDATE,
            OD.EXECTYPE, OD.CODEID,SB.SYMBOL, AL.CDCONTENT EXECTYPE_NAME, OD.MATCHPRICE, OD.MATCHQTTY,
            OD.MATCHPRICE*OD.MATCHQTTY VAL_IO, OD.FEERATE,
            (case when cf.custtype = 'B' and cf.vat = 'N' then 0 else OD.TAXRATE end) TAXRATE, OD.FEEAMT,
            (case when cf.custtype = 'B' and cf.vat = 'N' then 0 else OD.TAXSELLAMT end) TAXSELLAMT, nvl(0,0) NUMBUY,
            OD.orderid, OD.orderqtty, TRIM(OD.quoteprice) quoteprice
        FROM SBSECURITIES SB, AFMAST AF, CFMAST CF, ALLCODE AL,
            (
                SELECT OD.orderid, MAX(OD.orderqtty) orderqtty, 
                    MAX(case when od.pricetype = 'LO' then to_char(OD.quoteprice,'999G9999G999G999G999') else od.pricetype end) quoteprice, 
                    OD.TXDATE, OD.CLEARDATE, OD.EXECTYPE, OD.AFACCTNO, OD.CODEID, OD.MATCHPRICE, SUM(OD.MATCHQTTY) MATCHQTTY,
                    ROUND( AVG(OD.FEERATE),4) FEERATE,ROUND( AVG(OD.TAXRATE),2) TAXRATE,
                    ROUND(  SUM( CASE WHEN  OD.iodfeeacr <>0 THEN OD.iodfeeacr ELSE od.MATCHPRICE*MATCHQTTY * FEERATE/100 END  )) FEEAMT,
                    ROUND(  SUM(CASE WHEN OD.iodtaxsellamt <>0 THEN OD.iodtaxsellamt ELSE od.MATCHPRICE*MATCHQTTY *TAXRATE/100 end  )) TAXSELLAMT
                FROM
                    (
                    SELECT  OD.orderid, OD.orderqtty, OD.quoteprice, OD.TXDATE,STS.CLEARDATE, OD.CODEID,od.pricetype,   --BSC-1744  HNX_update_GL
                        OD.EXECTYPE, IOD.iodfeeacr,iodtaxsellamt,
                        OD.AFACCTNO,IOD.MATCHPRICE, IOD.MATCHQTTY,
                        CASE WHEN OD.EXECAMT >0 AND OD.FEEACR =0 AND OD.STSSTATUS = 'N' THEN ROUND(ODT.DEFFEERATE,5) ELSE ROUND(OD.FEEACR/OD.EXECAMT*100,4) END FEERATE,
                        CASE WHEN OD.EXECAMT >0 AND INSTR(OD.EXECTYPE,'S')>0 AND OD.STSSTATUS = 'N'
                                THEN ROUND(TO_NUMBER(SYS.VARVALUE),5) ELSE NVL(OD.TAXRATE,0) END TAXRATE,
                        OD.FEEACR, OD.EXECAMT
                    FROM VW_ODMAST_ALL OD,VW_STSCHD_ALL STS, VW_IOD_ALL IOD, ODTYPE ODT, SYSVAR SYS
                    WHERE  OD.ORDERID = STS.ORGORDERID AND STS.DUETYPE IN ('RM', 'RS')
                        AND OD.ORDERID = IOD.ORGORDERID AND IOD.DELTD = 'N' AND STS.DELTD = 'N' AND OD.DELTD = 'N'
                        AND ODT.ACTYPE = OD.ACTYPE
                        AND SYS.GRNAME = 'SYSTEM' AND SYS.VARNAME = 'ADVSELLDUTY'
                        AND OD.TXDATE >= TO_DATE ('01/01/2018','DD/MM/YYYY')
                        AND OD.TXDATE <= TO_DATE ('31/12/2018','DD/MM/YYYY')
                        AND OD.EXECTYPE LIKE '%%'
                        --
                        AND OD.AFACCTNO in ('0001017311','0001017338')
                    ) OD
                GROUP BY OD.orderid, OD.TXDATE, OD.CLEARDATE, OD.EXECTYPE, OD.AFACCTNO, OD.CODEID, OD.MATCHPRICE
            ) OD
        WHERE OD.CODEID = SB.CODEID
            AND OD.AFACCTNO = AF.ACCTNO
            AND AF.CUSTID = CF.CUSTID
            AND AL.CDNAME = 'EXECTYPE' AND AL.CDTYPE = 'OD' AND AL.CDVAL = OD.EXECTYPE
            AND SB.SYMBOL LIKE '%%'
            AND AF.ACCTNO LIKE '%%'
            AND AF.ACTYPE NOT IN ('0000')
            AND CF.CUSTODYCD LIKE '%%'
            --and exists (select gu.grpid from tlgrpusers gu where af.careby = gu.grpid and gu.tlid = v_TLID)
        ORDER BY OD.AFACCTNO, OD.TXDATE, SB.SYMBOL, OD.MATCHPRICE;
