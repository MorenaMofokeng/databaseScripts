drop table doctor cascade constraints;
drop table allergylookup cascade constraints;
drop table appointtypes cascade constraints;
drop table payments cascade constraints;
drop table patient cascade constraints;
drop table respaccount cascade constraints;
drop table respmedfund cascade constraints;
drop table medicalfund cascade constraints;
drop table patientvisit cascade constraints;
drop table patienthistory cascade constraints;
drop table patientmedicine cascade constraints;
drop table prescribed cascade constraints;
drop table contra cascade constraints;
drop table appointment cascade constraints;
drop table medicalconditions cascade constraints;
drop table patienttreatment cascade constraints;
drop table patientallergy cascade constraints;
drop table treatment cascade constraints;
drop table treatcost cascade constraints;

create table doctor
(doctorid varchar2(13) primary key constraint id_check
 check (doctorid = upper(doctorid)),
 doctorname varchar2(25) constraint name_check
 check (doctorname = upper(doctorname)),
 doctorcode char(7) not null);

create table respaccount
(idnumber varchar2(13) primary key,
TITLE VARCHAR2(5),
firstname varchar2(15) constraint first_check
check (firstname = upper(firstname)),
INITIALS VARCHAR2(3),
lastname varchar2(25) constraint last_check
check (lastname = upper(lastname)),
address1 varchar2(15),
address2 varchar2(15),
POSTALADDRESS1 VARCHAR2(20),
POSTALADDRESS2 VARCHAR2(30),
postalcode char(4),
empname varchar2(30) constraint emp_check
check (empname = upper(empname)),
empaddress varchar2(30),
telno varchar2(20),
cellno varchar2(15),
telnowork varchar2(20),
emptelno varchar2(15));

create table medicalfund
(medfund varchar2(30) primary key constraint med_check
 check (medfund = upper(medfund)),
address1 varchar2(20),
  address2 varchar2(20),
  postalcode char(4),
  telno varchar2(20),
  e_mail varchar2(20));


create table respmedfund
  (respid varchar2(13) references respaccount(idnumber),
   medfund varchar2(30) references medicalfund(medfund),
   medfundtype varchar2(15) constraint fundtype_check
   check (medfundtype = upper(medfundtype)),
   medfundnumber varchar2(15),
  primary key (respid, medfund));


create table patient
 (patientid varchar2(13) primary key,
  firstname varchar2(15) constraint pat_first_check
  check (firstname = upper(firstname)),
  lastname varchar2(30) constraint pat_last_check
  check (lastname = upper(lastname)),
  resp varchar2(13) references respaccount(idnumber),
  sex char(1) check (sex in ('M','F')),
  initials varchar2(5));


 create table treatment
  (treatid char(5) primary key,
  treatdescription varchar2(30));


 create table treatcost
  (treatid char(5) references treatment(treatid),
  startdate date,
  fee number(6,2),
  cost number (6,2),
  primary key (treatid,startdate));


 create table patienttreatment
  (treatid char(5) references treatment(treatid),
  patientid varchar2(13) references patient(patientid),
  treatmentdate date,
  doctorid varchar2(13) references doctor(doctorid),
  primary key (treatid,patientid,treatmentdate));

 create table allergylookup
  (allergy varchar2(30) primary key);

 create table patientallergy
   (patientid varchar2(13) references patient(patientid),
   allergy varchar2(30) references allergylookup(allergy),
   primary key (patientid,allergy));
create table medicalconditions
  (event char(5) primary key,
  description varchar2(30));

 create table patienthistory
  (patientid varchar2(13) references patient(patientid),
  medicalevent char(5) references medicalconditions(event),
  date_of_event date,
  primary key (patientid,medicalevent,date_of_event));


 create table appointtypes
   (appointtype varchar2(20) primary key,
  typetime number);


 create table appointment
  (patientid varchar2(13) references patient(patientid),
  doctorid varchar2(13) references doctor(doctorid),
  appointtype varchar2(20) references appointtypes(appointtype),
  appointdate date,
  CANCELLED CHAR(1) CHECK (CANCELLED IN ('Y','N')),
  primary key (patientid,doctorid,appointdate));

 create table payments
 (respaccount varchar2(13) references respaccount(idnumber),
  paydate date,
  method varchar2(10),
  paytype varchar2(15),
  chequenumber varchar2(10),
  banknumber varchar2(20),
  AMOUNT NUMBER(8,2),
  primary key (respaccount,paydate));


 create table patientvisit
  (patientid varchar2(13) references patient(patientid),
  comments long,
  visitdate date,
  diagnosis varchar2(30),
  primary key (patientid,visitdate));
 create table prescribed
  (prescode char(5) primary key,
  description varchar2(30));
  create table contra
   (prescode char(5) references prescribed(prescode),
   allergy varchar2(30) references allergylookup(allergy));
 create table patientmedicine
  (patientid varchar2(13) references patient(patientid),
  presc_date date,
  prescode char(5) references prescribed(prescode),
  primary key(patientid,presc_date,prescode));

INSERT INTO medicalconditions VALUES
('TONSI','TONSILLECTOMY');                                                                                 
INSERT INTO medicalconditions VALUES
('APPEN','APPENDECTOMY');                                                                                  

INSERT INTO doctor VALUES
('5302140156083','ALBERTS CJ','1234567');
INSERT INTO doctor VALUES                                                     
('7309185346084','VAN WYK PJ','5555555');
INSERT INTO doctor VALUES                                                     
('6812313524082','THUKWANE TF','9876543');                                                     
INSERT INTO doctor VALUES
('7101136748073','PADIACHY KL','4646464');                                                     


insert into respaccount values
('12345',null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null);                                                                                               
insert into respaccount values
('5601145053083','MR','WOUTER',null,'DE WAARDT','CHURCH ST 549','MIDDELBURG',null,null,'1050','HIGHVELD STEEL',
'P.O.BOX 3546 WITBANK','013-2456835','082-6712309','013-69019111',
'013-69019111');
insert into respaccount values                      
('4909085015089','DR','PETRUS',null,'MHLANGA','SADC STREET 23','MIDDELBURG',null,null,'1050','COLUMBUS STAINLESS','P.O.BOX 2467','013-2454888','082-8912370',
'013-2479111','013-2479114');
insert into respaccount values                                                                                                    
('5106137845084','ME','LARA','T.L','LEWIS','VOS STREET 15','MIDDELBURG',null,null,'1145','HIGHVELD STEEL','P.O.BOX 4213 WITBANK',
null,null,null,null);
insert into respaccount values                                                                                                                                                                                              
('7412087432082','MR','LUCAS','P','DE WET','SADC ST 25','MIDDELBURG',null,null,'1050','COLUMBUS STAINLESS',NULL,
'013-2446610',NULL,'013-247911','013-247911');
insert into respaccount values
('3806070156084','MRS','GERDA','H','VAN DER WATT','PRESIDENT AVE','WITBANK',null,null,'1051',NULL,NULL,'013-69045678',
NULL,NULL,NULL);                                                                                                    
insert into respaccount values
('7504157082085','MR','PETRUS','R.T','MAHLANGU','25 FIRST STREET','MIDDELBURG',null,null,'1050','BARLOWS','MILLI STREET MIDDELBURG',
'013-2546879',NULL,'013-2486789','013-2486789');
insert into respaccount values   
('6806035034074','DR','RICUS','P','MOORCROFT','23 LIMPOPO AVE','MIDDELBURG',
null,null,null,null,null,'013-2546234',NULL,NULL,NULL);

INSERT INTO MEDICALFUND VALUES
('TOPMED','P.O.BOX 2467','PRETORIA','2010','012-6534747','topmed@mweb.com');
INSERT INTO MEDICALFUND VALUES
('MOMENTUM DISCOVERY','P.O.BOX 5367','PRETORIA','2015',
'012-5724848','discovery@medweb.com');                                                                                

                                                                                                    
INSERT INTO RESPMEDFUND VALUES
('12345','TOPMED',NULL,'12345');
INSERT INTO RESPMEDFUND VALUES
('5601145053083','TOPMED','OPTION A','DW100023A');
INSERT INTO RESPMEDFUND VALUES
('4909085015089','MOMENTUM DISCOVERY','MA','DAPM0001');
INSERT INTO RESPMEDFUND VALUES
('7412087432082','MOMENTUM DISCOVERY','MB','DBLDW0001');
INSERT INTO RESPMEDFUND VALUES
('7504157082085','TOPMED','T1','T1PM0008');

INSERT INTO PATIENT VALUES
('7911020534084','PETRU','DE WAARDT','5601145053083','F','M.M');
INSERT INTO PATIENT VALUES
('8106070534083','JOHAN','DE WAARDT','5601145053083','M',NULL);
INSERT INTO PATIENT VALUES
('7609097812034','WANDA','DE WAARDT','5601145053083','F','R');
INSERT INTO PATIENT VALUES
('7503305057803','PATRICIA','LEWIS','5106137845084','F','P');
INSERT INTO PATIENT VALUES
('8110102467081','LIAAN','LEWIS','5106137845084','F','P');
INSERT INTO PATIENT VALUES
('54321','TANIA','LEWIS','5106137845084','F','T');
INSERT INTO PATIENT VALUES
('7809124123456','JAMES','MHLANGA','4909085015089','F','P');

INSERT INTO PATIENTVISIT VALUES
('7911020534084','FEVER,SORE THROAT, PULSE 85, BODY ACHES AND PAINS',
'05-JAN-00','FLUE');                                                                                      
INSERT INTO PATIENTvisit VALUES                                                                                                    
('7609097812034','FEVER, RUNNY NOSE',
'13-JAN-00','UPPER AIRWAYS INFECTION');
INSERT INTO PATIENTVISIT VALUES
('8106070534083','FEVER, WET COUGH, VOMITING','05-JAN-00','BRONCHITUS');
INSERT INTO PATIENTVISIT VALUES
('7809124123456','CRAVINGS, VOMITING, TIRED','18-JAN-00','PREGNANT');                                                                   

INSERT INTO PATIENTHISTORY VALUES
('7911020534084','TONSI',TO_DATE('12-MAR-1994','DD-MON-YYYY'));                                                                       

INSERT INTO allergylookup VALUES
('IODINE');                                                                                              
INSERT INTO allergylookup VALUES
('BEE STING');                                                                                           
INSERT INTO allergylookup VALUES
('ASPIRIN');                                                                                             
INSERT INTO allergylookup VALUES
('PENICYLLIN');
INSERT INTO allergylookup VALUES                                                                                          
('LACTOSE');                                                                                             



INSERT INTO PATIENTALLERGY VALUES
('7911020534084','ASPIRIN');                                                                               
INSERT INTO PATIENTALLERGY VALUES
('7911020534084','BEE STING');                                                                             

INSERT INTO APPOINTTYPES VALUES
('Consultation',15);
INSERT INTO appointTYPES VALUES                                                            
('Stitches',15);                                                            
INSERT INTO appointTYPES VALUES
('Full medical',30);                                                            

INSERT INTO appointment VALUES
('8106070534083','5302140156083','Full medical','05-JAN-00','N');
INSERT INTO appointment VALUES                                        
('7809124123456','7309185346084','Consultation','18-JAN-00','N');
INSERT INTO appointment VALUES                                        
('8110102467081','7101136748073','Consultation','18-JAN-00','N');
INSERT INTO appointment VALUES                                        
('8110102467081','5302140156083','Full medical','17-JAN-00','N');                                        
INSERT INTO appointment VALUES
('7809124123456','7309185346084','Stitches','12-JAN-00','N');                                        

INSERT INTO TREATMENT VALUES
('FM001','FULL MEDICAL');
INSERT INTO TREATMENT VALUES                                                                                  
('CSTTN','CONSULTATION');
INSERT INTO TREATMENT VALUES                                                                                  
('IVN40','INJECTION - VOLTAREN 40');
INSERT INTO TREATMENT VALUES                                                                       
('IVN20','INJECTION - VOLTAREN 20');
INSERT INTO TREATMENT VALUES                                                                       
('STRMV','STITCHES REMOVE');                                                                               
INSERT INTO TREATMENT VALUES
('STTHS','STITCHES');                                                                                      

INSERT INTO Treatcost VALUES
('IVN40',TO_DATE('19-JUL-1999','DD-MON-YYYY'),25,15);
INSERT INTO Treatcost VALUES                                                                 
('IVN40','09-JAN-00',30,18);
INSERT INTO Treatcost VALUES                                                                 
('CSTTN','09-JAN-00',50,40);
INSERT INTO Treatcost VALUES                                                                 
('FM001','09-JAN-00',80,65);                                                                 
INSERT INTO Treatcost VALUES
('STRMV','09-JAN-00',10,5);
INSERT INTO Treatcost VALUES                                                                 
('STTHS','09-JAN-00',25,17);
INSERT INTO Treatcost VALUES                                                                 
('IVN40',to_date('19-DEC-1998','DD-MON-YYYY'),20,12);
INSERT INTO Treatcost VALUES                                                                 
('STRMV',to_date('17-DEC-1998','dd-mon-yyyy'),8,4);                                                                 


INSERT INTO PRESCRIBED VALUES
('AMO50','AMOXICICILLIN 50 MG');                                                                           

INSERT INTO patientmedicine VALUES
('7911020534084','05-JAN-00','AMO50');                                                                       
INSERT INTO patientmedicine VALUES
('7609097812034','13-JAN-00','AMO50');                                                                       

INSERT INTO CONTRA VALUES
('AMO50','PENICYLLIN');                                                                                    


INSERT INTO patienttreatment VALUES
('FM001','7911020534084','05-JAN-00','5302140156083');
INSERT INTO patienttreatment VALUES
('CSTTN','8106070534083','13-JAN-00','5302140156083');
INSERT INTO patienttreatment VALUES
('IVN40','7911020534084','05-JAN-00','5302140156083');
INSERT INTO patienttreatment VALUES
('CSTTN','7609097812034','13-JAN-00','5302140156083');
INSERT INTO patienttreatment VALUES
('STRMV','7911020534084','05-JAN-00','5302140156083');
INSERT INTO patienttreatment VALUES
('CSTTN','7503305057803','13-JAN-00','5302140156083');

insert into payments values
('5106137845084',to_date('15-DEC-1999','DD-MON-YYYY'),'MEDFUND','BANK TRANSFER',
NULL,'346',256);

insert into payments values
('5106137845084',to_date('12-JUL-1999','DD-MON-YYYY'),'MEDFUND','BANK TRANSFER',
NULL,'346',100);


insert into payments values
('5106137845084',to_date('12-JAN-1999','DD-MON-YYYY'),'MEDFUND','BANK TRANSFER',
NULL,'346',500);



insert into payments values
('7412087432082',to_date('14-JAN-1999','DD-MON-YYYY'),'MEDFUND','BANK TRANSFER',
NULL,'213',450);


insert into payments values
('7412087432082',to_date('17-JUN-1999','DD-MON-YYYY'),'MEDFUND','BANK TRANSFER',
NULL,'213',275);

insert into payments values
('7412087432082',to_date('17-FEB-2000','DD-MON-YYYY'),'MEDFUND','BANK TRANSFER',
NULL,'213',455);


insert into payments values
('6806035034074',to_date('14-FEB-2000','DD-MON-YYYY'),'MEDFUND','BANK TRANSFER',
NULL,'213',250);


 insert into payments values
 ('6806035034074',to_date('15-MAR-1999','DD-MON-YYYY'),'PRIVATE','CHEQUE',
 '244','213',250);


insert into payments values
('6806035034074',to_date('19-AUG-1999','DD-MON-YYYY'),'PRIVATE','CHEQUE',
'275','213',325);


insert into payments values
('3806070156084',to_date('14-AUG-1999','DD-MON-YYYY'),'PRIVATE','CASH',
null,null,150);

commit;





