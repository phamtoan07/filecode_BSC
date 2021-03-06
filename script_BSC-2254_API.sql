 SELECT ROUND(TO_NUMBER(SYS.VARVALUE)/100,5) v_sysvalue FROM sysvar sys WHERE  SYS.GRNAME = 'SYSTEM' AND SYS.VARNAME = 'ADVSELLDUTY';
 
 SELECT OD.CUSTODYCD,OD.TXDATE, A1.CDCONTENT EXECTYPE, OD.AFACCTNO,OD.AFACCTNOFULL, OD.ORDERID, OD.CODEID, OD.SYMBOL,
            IOD.MATCHQTTY, IOD.MATCHPRICE, IOD.MATCHQTTY*IOD.MATCHPRICE MATCHAMT,
            FLOOR(IOD.MATCHQTTY*IOD.MATCHPRICE*OD.FEERATE) FEE_AMT,OD.FEERATE,
           /* IOD.MATCHQTTY*IOD.MATCHPRICE*OD.FEERATE FEE1,
            FLOOR(IOD.MATCHQTTY*IOD.MATCHPRICE*OD.FEERATE) FEE2,*/
            CASE WHEN INSTR(OD.EXECTYPE,'S')>0 and od.vat ='Y' THEN IOD.MATCHQTTY*IOD.MATCHPRICE*OD.TAXRATE ELSE 0 END SELLTAXAMT,
            CASE WHEN INSTR(OD.EXECTYPE,'B')>0 THEN IOD.MATCHQTTY ELSE 0 END RECVQTTY,
            CASE WHEN INSTR(OD.EXECTYPE,'S')>0 THEN IOD.MATCHQTTY ELSE 0 END TRANFQTTY,
            CASE WHEN INSTR(OD.EXECTYPE,'B')>0 THEN IOD.MATCHQTTY*IOD.MATCHPRICE
             + ROUND(IOD.MATCHQTTY*IOD.MATCHPRICE*OD.FEERATE) ELSE 0 END TRANFAMT,
            CASE WHEN INSTR(OD.EXECTYPE,'B')>0 THEN IOD.MATCHQTTY*IOD.MATCHPRICE
                + ROUND(IOD.MATCHQTTY*IOD.MATCHPRICE*OD.FEERATE)
                WHEN INSTR(OD.EXECTYPE,'S')>0 THEN IOD.MATCHQTTY*IOD.MATCHPRICE
                - ROUND(IOD.MATCHQTTY*IOD.MATCHPRICE*OD.FEERATE) - IOD.MATCHQTTY*IOD.MATCHPRICE*OD.TAXRATE ELSE 0 END RECVAMT,
            OD.tlname maker_name
        FROM
            (SELECT CF.CUSTODYCD,OD.TXDATE, OD.EXECTYPE, OD.AFACCTNO,OD.AFACCTNO|| '-'|| aft.afshortname AFACCTNOFULL, OD.ORDERID, OD.CODEID, SB.SYMBOL, OD.EXECAMT, OD.EXECQTTY,
                CASE WHEN OD.EXECAMT >0 AND OD.FEEACR =0 AND OD.STSSTATUS = 'N' THEN ROUND(ODT.DEFFEERATE/100,5) ELSE ROUND(OD.FEEACR/OD.EXECAMT,5) END FEERATE,
                CASE WHEN OD.EXECAMT >0 AND INSTR(OD.EXECTYPE,'S')>0 AND OD.STSSTATUS = 'N'
                            THEN 0.001 ELSE OD.TAXRATE/100 END TAXRATE, cf.vat, TLP.tlname
            FROM VW_ODMAST_ALL OD, SBSECURITIES SB, AFMAST AF, aftype aft, ODTYPE ODT, cfmast cf, tlprofiles TLP
            WHERE OD.CODEID = SB.CODEID AND AF.ACCTNO = OD.AFACCTNO and af.custid = cf.custid and af.actype = aft.actype
                AND OD.ORSTATUS IN ('4','5','7','12') AND OD.EXECQTTY>0
                AND OD.ACTYPE = ODT.ACTYPE
                AND OD.TLID = TLP.TLID(+)
            --    AND AF.CUSTID LIKE V_CUSTID
                AND AF.ACCTNO IN( '0001017311')
                AND SB.SYMBOL LIKE '%%'
                AND OD.EXECTYPE LIKE '%%'
                AND OD.TXDATE >= TO_DATE('01/01/2018','DD/MM/YYYY')
                AND OD.TXDATE <= TO_DATE('31/12/2018','DD/MM/YYYY')
             /*   AND EXISTS(
                            SELECT *
                            FROM tlgrpusers tl, tlgroups gr
                            WHERE AF.careby = tl.grpid AND tl.grpid= gr.grpid and gr.grptype='2' and tl.tlid LIKE V_STRTLID
                            )*/
        ) OD, VW_IODS IOD, ALLCODE A1
        WHERE OD.ORDERID = IOD.ORGORDERID
            AND A1.CDTYPE = 'OD' AND A1.CDNAME = 'EXECTYPE' AND A1.CDVAL = OD.EXECTYPE
        ORDER BY OD.TXDATE DESC, SUBSTR(OD.ORDERID,11,6) DESC,OD.AFACCTNO, OD.EXECTYPE, OD.SYMBOL;
