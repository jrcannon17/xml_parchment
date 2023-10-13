
--select *
--  from sorxref
-- where trunc(sorxref_activity_date) = trunc(sysdate);
-- 
--select *
--  from stvdsts;
-- 
REM INSERTING/UPDATING into SORXREF
REM FICE codes
Insert into SORXREF (SORXREF_XLBL_CODE,SORXREF_EDI_VALUE,SORXREF_EDI_STANDARD_IND,SORXREF_DISP_WEB_IND,SORXREF_ACTIVITY_DATE,SORXREF_EDI_QLFR,SORXREF_DESC,SORXREF_BANNER_VALUE,SORXREF_PESC_XML_IND,SORXREF_VERSION,SORXREF_USER_ID,SORXREF_DATA_ORIGIN,SORXREF_VPDI_CODE) values ('STVSBGIC','009917','Y','N',sysdate,'FICE','Ivy Tech Comm Clg-Indianapolis','009917','Y',0,null,null,null);
Insert into SORXREF (SORXREF_XLBL_CODE,SORXREF_EDI_VALUE,SORXREF_EDI_STANDARD_IND,SORXREF_DISP_WEB_IND,SORXREF_ACTIVITY_DATE,SORXREF_EDI_QLFR,SORXREF_DESC,SORXREF_BANNER_VALUE,SORXREF_PESC_XML_IND,SORXREF_VERSION,SORXREF_USER_ID,SORXREF_DATA_ORIGIN,SORXREF_VPDI_CODE) values ('STVSBGIC','001843','Y','N',sysdate,'FICE','Vincennes University','001843','Y',0,null,null,null);

REM Level codes

Update SORXREF
   set SORXREF_EDI_QLFR = 'U',
       SORXREF_BANNER_VALUE = 'U'
 where SORXREF_XLBL_CODE = 'STVLEVL' and SORXREF_EDI_VALUE in ('Undergraduate','LowerDivision','Vocational','TechnicalPreparatory');
 
Update SORXREF
   set SORXREF_EDI_QLFR = 'G',
       SORXREF_BANNER_VALUE = 'G'
 where SORXREF_XLBL_CODE = 'STVLEVL' and SORXREF_EDI_VALUE in ('UpperDivision','Graduate','GraduateProfessional','Dual','Professional');
 
REM Term typee codes
Update SORXREF
   set SORXREF_EDI_QLFR = '1',
       SORXREF_BANNER_VALUE = '1'
 where SORXREF_XLBL_CODE = 'STVTRMT' and SORXREF_EDI_VALUE = 'FullYear';
 
Update SORXREF
   set SORXREF_EDI_QLFR = '2',
       SORXREF_BANNER_VALUE = '2'
 where SORXREF_XLBL_CODE = 'STVTRMT' and SORXREF_EDI_VALUE = 'Semester';

Update SORXREF
   set SORXREF_EDI_QLFR = '3',
       SORXREF_BANNER_VALUE = '3'
 where SORXREF_XLBL_CODE = 'STVTRMT' and SORXREF_EDI_VALUE = 'Trimester';

Update SORXREF
   set SORXREF_EDI_QLFR = '4',
       SORXREF_BANNER_VALUE = '4'
 where SORXREF_XLBL_CODE = 'STVTRMT' and SORXREF_EDI_VALUE = 'Quarter';

Update SORXREF
   set SORXREF_EDI_QLFR = '5',
       SORXREF_BANNER_VALUE = '5'
 where SORXREF_XLBL_CODE = 'STVTRMT' and SORXREF_EDI_VALUE = 'Quinmester';

Update SORXREF
   set SORXREF_EDI_QLFR = '6',
       SORXREF_BANNER_VALUE = '6'
 where SORXREF_XLBL_CODE = 'STVTRMT' and SORXREF_EDI_VALUE = 'MiniTerm';
 
Update SORXREF
   set SORXREF_EDI_QLFR = '7',
       SORXREF_BANNER_VALUE = '7'
 where SORXREF_XLBL_CODE = 'STVTRMT' and SORXREF_EDI_VALUE = 'SummerSession';
 
Update SORXREF
   set SORXREF_EDI_QLFR = '8',
       SORXREF_BANNER_VALUE = '8'
 where SORXREF_XLBL_CODE = 'STVTRMT' and SORXREF_EDI_VALUE = 'Intersession';
 
Update SORXREF
   set SORXREF_EDI_QLFR = '9',
       SORXREF_BANNER_VALUE = '9'
 where SORXREF_XLBL_CODE = 'STVTRMT' and SORXREF_EDI_VALUE = 'LongSession';

REM INSERTING into STVDSTS
SET DEFINE OFF;
Insert into STVDSTS (STVDSTS_CODE,STVDSTS_DESC,STVDSTS_DEF_PRIORITY,STVDSTS_TA_IND,STVDSTS_ARCH_IND,STVDSTS_ACTIVITY_DATE,STVDSTS_IMMUNIZATION_IND,STVDSTS_TESTS_IND,STVDSTS_MAIN_UDE_IND,STVDSTS_STUDENT_UDE_IND,STVDSTS_ACREC_UDE_IND,STVDSTS_COURSE_UDE_IND,STVDSTS_VERSION,STVDSTS_USER_ID,STVDSTS_DATA_ORIGIN,STVDSTS_VPDI_CODE) values ('ADMR','Admissions Review',10,'N','N',sysdate,'N','N','N','N','N','N',null,null,null,null);
Insert into STVDSTS (STVDSTS_CODE,STVDSTS_DESC,STVDSTS_DEF_PRIORITY,STVDSTS_TA_IND,STVDSTS_ARCH_IND,STVDSTS_ACTIVITY_DATE,STVDSTS_IMMUNIZATION_IND,STVDSTS_TESTS_IND,STVDSTS_MAIN_UDE_IND,STVDSTS_STUDENT_UDE_IND,STVDSTS_ACREC_UDE_IND,STVDSTS_COURSE_UDE_IND,STVDSTS_VERSION,STVDSTS_USER_ID,STVDSTS_DATA_ORIGIN,STVDSTS_VPDI_CODE) values ('ARTC','Ready for Transfer Articulatio',80,'Y','N',sysdate,'N','N','N','N','N','N',null,null,null,null);
Insert into STVDSTS (STVDSTS_CODE,STVDSTS_DESC,STVDSTS_DEF_PRIORITY,STVDSTS_TA_IND,STVDSTS_ARCH_IND,STVDSTS_ACTIVITY_DATE,STVDSTS_IMMUNIZATION_IND,STVDSTS_TESTS_IND,STVDSTS_MAIN_UDE_IND,STVDSTS_STUDENT_UDE_IND,STVDSTS_ACREC_UDE_IND,STVDSTS_COURSE_UDE_IND,STVDSTS_VERSION,STVDSTS_USER_ID,STVDSTS_DATA_ORIGIN,STVDSTS_VPDI_CODE) values ('ARCH','Archive EDI Transcript Data',99,'N','Y',sysdate,'N','N','N','N','N','N',null,null,null,null);

