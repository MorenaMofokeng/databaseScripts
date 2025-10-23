rem File: cre_seq.sql
rem SQL*Plus script to create 2 sequences necessary for the labs in
rem the PL/SQL Program Units course.  To run, log onto SQL*Plus
rem and enter:
rem
rem         start cre_seq.sql
rem
rem NOTE: If the sequences have not been created, the user will see
rem two error messages - this is normal and to be expected.
rem
set echo off

DROP SEQUENCE SEQ_EMPNO;
DROP SEQUENCE ACCT_SEQ;

CREATE SEQUENCE SEQ_EMPNO
   INCREMENT BY 1
   START WITH 7950
   NOCACHE;

CREATE SEQUENCE ACCT_SEQ
   INCREMENT BY 1
   START WITH 1
   NOCACHE;

set echo on
