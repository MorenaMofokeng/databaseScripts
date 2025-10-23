drop table login_nextval cascade constraints;
drop table customer_nextval cascade constraints;
drop table employee_nextval cascade constraints;
drop table charter_nextval cascade constraints;
drop table transaction_nextval cascade constraints;
drop table air_login cascade constraints;
drop table air_transaction cascade constraints;
drop table air_charter cascade constraints;
drop table air_aircraft cascade constraints;
drop table air_education cascade constraints;
drop table air_qualification cascade constraints;
drop table air_model cascade constraints;
drop table air_pilot cascade constraints;
drop table air_customer cascade constraints;
drop table air_employee cascade constraints;



create table air_customer
(cust_num number PRIMARY KEY,
cust_title varchar2(4),
cust_lname varchar2(15),
cust_fname varchar2(15),cust_ititial varchar2(1),
cust_address varchar2(35),
cust_city varchar2(35),
cust_state varchar2(2),
cust_zip varchar2(9),cust_areacode varchar2(3),
cust_phone varchar2(8),
cust_balance number,
cust_limit number,
constraint ck_title_cust check (cust_title in ('Mr.','Mrs.','Dr.','Ms.')));

create table air_employee
(emp_num number PRIMARY KEY,
emp_title varchar2(4),
emp_lname varchar2(15),
emp_fname varchar2(15),
emp_ititial varchar2(1),
emp_DOB date,
emp_hire_date date default sysdate,
constraint ck_title_emp check (emp_title in ('Mr.','Mrs.','Ms.')));

create table air_model
(mod_code varchar2(10) PRIMARY KEY,
mod_manufacturer varchar2(15),
mod_name varchar2(20),
mod_seats number,
mod_chg_mile number,
mod_wait_chg number,
mod_cruise number,
mod_fuel_hr number);

create table air_pilot
(emp_num number PRIMARY KEY,
pil_licence varchar2(25),
pil_ratings varchar2(25),
pil_med_type varchar2(1),
pil_med_date date,
pil_pt135_date date,
constraint ck_medtype_pilot CHECK (pil_med_type in('1','2','3')),
constraint fk_empnr_pilot FOREIGN KEY(emp_num) references air_employee(emp_num));



create table air_qualification
(qual_code varchar2(5) PRIMARY KEY,
qual_descript varchar2(65));

create table air_education
(emp_num number ,
qual_code varchar2(5),
edu_date date DEFAULT SYSDATE,
edu_source varchar2(35),
constraint fk_qualcode_education FOREIGN KEY(qual_code) references air_qualification(qual_code),
constraint pk_emp_qual_education PRIMARY KEY(emp_num,qual_code),
constraint fk_empnr_education FOREIGN KEY(emp_num) references air_employee(emp_num));

create table air_aircraft
(ac_number varchar2(5) PRIMARY KEY,
mod_code varchar2(10) constraint fk_modcode_aircraft references air_model(mod_code),
ac_ttaf number,
ac_ttel number,
ac_tter number,
ac_100hr_date date,
ac_ytdhrs number,
ac_since100 number
);

create table air_charter
(char_trip number PRIMARY KEY,
char_date date,
char_pilot number constraint fk_pilot_charter references air_pilot(emp_num),
char_copilot number constraint fk_copilot_charter references air_pilot(emp_num),
ac_num varchar2(5) constraint fk_acnum_charter references air_aircraft(ac_number),
char_destination varchar2(3),
char_distance number,
char_hours_flown number,
char_hours_wait number,
char_fuel_gallons number,
char_oil_qts number,
cust_num number constraint fk_custnum_charter references air_customer(cust_num)
);

create table air_transaction
(trans_num number PRIMARY KEY,
trans_date date default sysdate,
trans_descrip varchar2(50),
trans_pay_type varchar2(50),
trans_pay_num varchar2(50),
trans_amount number(10,2),
cust_num number constraint fk_cust_transaction references air_customer(cust_num),
char_trip number constraint fk_chartrip_transaction references air_charter(char_trip));

create table air_login
(usernr varchar2(4) primary key,
emp_nr  number,
password_char varchar2(10) not null,
constraint fk_empnr_login FOREIGN KEY (emp_nr) references air_employee(emp_num),
constraint ck_usernr_login check (usernr like '%M' OR usernr like '%U'),
constraint un_passw_login UNIQUE(password_char) 
);

create table customer_nextval
( current_custnr number 
);

create table employee_nextval
( current_empnr number 
);

create table charter_nextval
( current_charternr number 
);

create table transaction_nextval
( current_transnr number 
);

create table login_nextval
(Manager_lastnr varchar2(4),
 User_lastnr varchar2(4)
);

insert into air_customer
values(10010,'Dr.','Ramas','Alfred','A','2123 Braynard Ln.','Nashville','TN','35432','615','844-2573',0.00,170000.00);
insert into air_customer
values(10011,'Ms.','Dunne','Leona','K','5467 Lake View Dr.','Murfreesboro','TN','37130','615','894-1238',0.00,17000.00);
insert into air_customer
values(10012,'Ms.','Smith','Kathy','W','2190 Larkspur Road','Lexington','KY','40025','623','894-2285',16120.59,29750.00);
insert into air_customer
values(10013,'Mr.','Olowski','Paul','F','6112 Hampton Circle','Smyrna','KY','38789','615','894-2180',11009.46,29750.00);
insert into air_customer
values(10014,'Mr.','Orlando','Myron',null,'3216 Meadow Song Dr.','Nashville','TN','35432','615','222-1672',14268.70,34000.00);
insert into air_customer
values(10015,'Dr.','O''Brian','Amy','B','2209 Briar Ln.','Huntsville','AL','32276','713','442-3381',8874.68,29750.00);
insert into air_customer
values(10016,'Mr.','Brown','James','G','2113 Jasmine Crt.','Smyrna','TN','38789','615','297-1228',0.00,29750.00);
insert into air_customer
values(10017,'Mr.','Williams','George',null,'3108 Winding Road','Nashville','TN','35437','615','290-2556',0.00,42500.00);
insert into air_customer
values(10018,'Mrs.','Farriss','Anne','G','1121 Babbling Brook Ln.','Nashville','TN','35432','615','382-7185',0.00,17000.00);
insert into air_customer
values(10019,'Ms.','Smith','Olette','K','8793 Valley Drive','Nashville','TN','35441','615','297-3809',12374.22,17000.00);


insert into air_employee
values(100,'Ms.','Coetsee','Hannelie','H','17-May-1972','15-Mar-1995');
insert into air_employee
values(101,'Ms.','Lewis','Rhonda','G','19-Mar-1965','25-Apr-1986');
insert into air_employee
values(102,'Mr.','Vandam','Rhett',null,'14-Nov-1958','20-Dec-1990');
insert into air_employee
values(103,'Ms.','Jones','Anne','M','16-Oct-1974','28-Aug-1994');
insert into air_employee
values(104,'Mr.','Lange','John','P','08-Nov-1971','20-Oct-1994');
insert into air_employee
values(105,'Mr.','Williams','Robert','D','14-Mar-1975','08-Nov-1994');
insert into air_employee
values(106,'Mrs.','Duzak','Jeanine','K','12-Feb-1968','05-Jan-1989');
insert into air_employee
values(107,'Mr.','Diante','Jorge','D','21-Aug-1974','02-Jul-1994');
insert into air_employee
values(108,'Mr.','Wiesenbach','Paul','R','14-Feb-1966','18-Nov-1992');
insert into air_employee
values(109,'Ms.','Travis','Elizabeth','K','18-Jun-1961','14-Apr-1989');
insert into air_employee
values(110,'Mrs.','Genkazi','Leighla','W','19-May-1970','01-Dec-1990');


insert into air_model
values('C-90A','Beechcraft','KingAir',8,22.70,722.50,195,66);
insert into air_model
values('PA23-250','Piper','Aztec',6,16.41,459.00,160,32);
insert into air_model
values('PA31-350','Piper','Navajo Chieftain',10,19.98,654.50,180,40);

insert into air_pilot
values(101,'ATP','SEL/MEL/Instr/CFII','1','12-Apr-2001','15-Jun-2003');
insert into air_pilot
values(104,'ATP','SEL/MEL/Instr','1','10-Jun-2001','23-Dec-2003');
insert into air_pilot
values(105,'COM','SEL/MEL/Instr/CFI','2','25-Feb-2000','12-Feb-2003');
insert into air_pilot
values(106,'COM','SEL/MEL/Instr','2','02-Apr-2002','24-Aug-2003');
insert into air_pilot
values(109,'COM','SEL/MEL/SES/Instr/CFII','1','14-Apr-2002','21-May-2003');



insert into air_qualification
values('A+P','Airframe and Powerplant Mechanic');
insert into air_qualification
values('AA','Associate of Arts');
insert into air_qualification
values('AI','Airframe and Powerplant Mechanic, Inspection Authorization');
insert into air_qualification
values('ATP','Airline Transport Pilot');
insert into air_qualification
values('BA','Bachelor of Arts');
insert into air_qualification
values('BS','Bachelor of Science');
insert into air_qualification
values('CFI','Certified Flight Instructor');
insert into air_qualification
values('CFII','Certified Flight Instructor, Instrument');
insert into air_qualification
values('COMM','Commercial Pilot');
insert into air_qualification
values('I','Instrument rating');
insert into air_qualification
values('MBA','Master of Business Administration');
insert into air_qualification
values('MEL','Multi-Engine, Land');


insert into air_education
values(100,'ATP','12-May-1999','Embry-Riddle');
insert into air_education
values(100,'I','28-Sep-1987',null);	
insert into air_education
values(100,'A+P','31-Jul-1995',null);	
insert into air_education
values(102,'COMM','03-Apr-1986',null);	
insert into air_education
values(102,'I','03-Jun-1986',null);	
insert into air_education
values(103,'COMM','04-Jun-1986',null);	
insert into air_education
values(103,'I','10-Dec-1986',null);	
insert into air_education
values(103,'MEL','01-Dec-1987',null);	
insert into air_education
values(104,'ATP','04-Dec-1987','Embry-Riddle');
insert into air_education
values(104,'COMM','07-Jan-1987',null);	
insert into air_education
values(104,'MEL','02-Apr-1986',null);	
insert into air_education
values(106,'COMM','15-Dec-1993',null);	
insert into air_education
values(106,'I','03-Mar-1992',null);	
insert into air_education
values(106,'MEL','03-Mar-1993',null);	
insert into air_education
values(109,'COMM','09-Aug-1989',null);	
insert into air_education
values(109,'I','06-Sep-1989',null);	
insert into air_education
values(109,'MEL','09-Oct-1990',null);	
insert into air_education
values(110,'COMM','12-Apr-1997',null);	
insert into air_education
values(110,'I','12-Apr-1997',null);
insert into air_education
values(110,'MEL','22-Jun-1998',null);	



insert into air_aircraft
values('1484P',	'PA23-250',1833.10,1833.10,101.80,'12-Jul-2003',896.70,79.00);
insert into air_aircraft
values('2289L',	'C-90A',4243.80,768.90,1123.40,'12-Sep-2003',723.40,63.80);
insert into air_aircraft
values('2778V',	'PA31-350',7992.90,1513.10,789.50,'22-Jul-2003',798.20,	82.10);
insert into air_aircraft
values('4278Y','PA31-350',2147.30,622.10,243.20	,'02-Oct-2003',690.90,	45.30);



insert into air_charter
values(9422,'12-Mar-2003',109,null,'2289L','MOB',895,4.6,0,302.9,0,10011);
insert into air_charter
values(9423,'13-Mar-2003',106,104,'4278Y','STL',486,2.7,1.3,108,1,10012);
insert into air_charter
values(9424,'16-Mar-2003',105,null,'2778V','TYS',602,3.4,0,133.8,2,10017);
insert into air_charter
values(9425,'16-Mar-2003',104,109,'1484P','BNA',363,2,2.4,72.6,0,10011);
insert into air_charter
values(9426,'17-Mar-2003',101,null,'2289L','GNV',1522,7.8,0,515.2,0,10013);
insert into air_charter
values(9427,'19-Mar-2003',109,null,'4278Y','MOB',842,4.4,6.1,187.9,1,10010);
insert into air_charter
values(9428,'19-Mar-2003',106,104,'1484P','MQY',302,1.8,0,60.4,2,10019);
insert into air_charter
values(9429,'20-Mar-2003',105,null,'2778V','BNA',387,2.2,3.6,86,1,10012);
insert into air_charter
values(9430,'22-Mar-2003',101,105,'2289L','STL',455,2.3,0,154.4,0,10014);
insert into air_charter
values(9431,'23-Mar-2003',104,null,'1484P','ATL',958,5.9,0,218.6,0,10011);
insert into air_charter
values(9432,'24-Mar-2003',109,101,'4278Y','TYS',687,3.6,1.8,155.6,2,10018);
insert into air_charter
values(9433,'25-Mar-2003',106,null,'2289L','MOB',806,4.1,3.1,272.8,1,10016);
insert into air_charter
values(9434,'25-Mar-2003',101,null,'2778V','BNA',338,2.5,2.6,155.1,0,10015);
insert into air_charter
values(9435,'26-Mar-2003',105,109,'1484P','MQY',361,3.1,0,104.2,0,10013);
insert into air_charter
values(9436,'28-Mar-2003',104,null,'2289L','STL',512,2.6,0,115.8,1,10017);
insert into air_charter
values(9437,'30-Mar-2003',106,101,'4278Y','GNV',1623,9,4.2,360.7,1,10019);
insert into air_charter
values(9438,'30-Mar-2003',109,null,'2778V','MOB',824,4.6,0,183.1,1,10010);
insert into air_charter
values(9439,'01-Apr-2003',105,null,'1484P','STL',479,3.5,0,124,0,10012);
insert into air_charter
values(9440,'02-Apr-2003',104,null,'2289L','MQY',348,1.8,4.1,117.8,0,10014);
insert into air_charter
values(9441,'03-Apr-2003',106,null,'4278Y','ATL',1011,6.4,2.8,256.6,2,10011);
insert into air_charter
values(9442,'04-Apr-2003',109,105,'1484P','MOB',797,5.2,0,169,2,10018);
insert into air_charter
values(9443,'06-Apr-2003',101,106,'2778V','TYS',701,3.9,1.5,155.8,1,10013);
insert into air_charter
values(9444,'06-Apr-2003',104,null,'4278Y','ATL',965,5.4,0,214.4,0,10016);
insert into air_charter
values(9445,'08-Apr-2003',105,null,'2289L','BNA',385,1.9,3.1,130.3,1,10019);
insert into air_charter
values(9446,'09-Apr-2003',106,104,'1484P','GNV',1682,10.5,8.7,336.4,0,10015);
insert into air_charter
values(9447,'10-Apr-2003',109,null,'2289L','MOB',874,4.5,0,295.8,1,10017);
insert into air_charter
values(9448,'13-Apr-2003',101,null,'2778V','STL',524,2.9,0,116.4,0,10010);
insert into air_charter
values(9449,'13-May-2003',104,109,'4278Y','MQY',397,2.3,0,85.2,2,10014);
insert into air_charter
values(9450,'14-May-2003',105,null,'2289L','BNA',315,1.6,6.5,106.6,1,10012);
insert into air_charter
values(9451,'15-May-2003',106,101,'1484P','TYS',658,4.1,0,131.6,2,10011);
insert into air_charter
values(9452,'17-May-2003',109,104,'2778V','MOB',810,4.5,0,180,1,10018);
insert into air_charter
values(9453,'18-Apr-2003',101,null,'4278Y','ATL',978,5.4,8.2,217.3,0,10016);
insert into air_charter
values(9454,'18-Apr-2003',105,null,'1484P','STL',505,3.2,4.3,101.8,0,10013);
insert into air_charter
values(9455,'22-May-2003',104,109,'2289L','GNV',1701,8.7,4.1,575.7,1,10017);


insert into air_transaction
values(1,'16-Jun-2003','Charter payment','Credit Card','4321-3345-7678-8765',704.99,10012,9450);
insert into air_transaction
values(2,'16-Jun-2003',	'Charter payment','Cash',null,1009.8,10013,9454);
insert into air_transaction
values(3,'16-Jun-2003','Charter charge','Credit on Account',null,2249.10,10019,9445);
insert into air_transaction
values(4,'16-Jun-2003','Charter payment','Check','0000000015',2145.83,10016,9453);
insert into air_transaction
values(5,'16-Jun-2003','Payment on Account','Check','0000000105',1275.00,10019,9445);	
insert into air_transaction
values(6,'16-Jun-2003','Payment on Account','Cash',null,425.00,	10017,9455);	
insert into air_transaction
values(7,'16-Jun-2003','Charter payment','Check','0000000053',2482.26,10011,9441);
insert into air_transaction
values(8,'16-Jun-2003','Charter payment','Credit Card','3212-3456-7776-5432',1767.15,10016,9453);
insert into air_transaction
values(9,'20-Jun-2003','Charter payment','Credit Card','3234-4444-4444-4444',9400.01,10012,9450);
insert into air_transaction
values(10,'20-Jun-2003','Payment on Account','Cash',null,2125.00,10011,9451);	
insert into air_transaction
values(11,'20-Jun-2003','Payment on Account','Cash',null,1700,10011,9441);	
insert into air_transaction
values(12,'20-Jun-2003','Payment on Account','Cash',null,850.00,10013,9443);	
insert into air_transaction
values(13,'27-Jun-2003','Charter charge','Credit on Account',null,698.11,10010,9448);
insert into air_transaction
values(14,'27-Jun-2003','Payment on Account','Credit Card','1212-3332-3323-3223',850.00,10014,9449);	
insert into air_transaction
values(15,'27-Jun-2003','Charter payment','Credit Card','5454-4454-4333-3333',1450.01,10012,9439);
insert into air_transaction
values(16,'27-Jun-2003','Charter charge','Credit on Account',null,2891.79,10016,9444);
insert into air_transaction
values(17,'20-Jul-2003','Payment on Account','Credit Card','3432-4334-4455-5543',4250.00,10018,9432);	
insert into air_transaction
values(18,'20-Jul-2003','Payment on Account','Cash',null,850.00,10011,9441);
insert into air_transaction
values(19,'22-Jul-2003','Charter charge','Credit on Account',null,805.54,10015,9434);
insert into air_transaction
values(20,'22-Jul-2003','Payment on Account','Credit Card','4455-5666-7677-8788',1700.00,10010,9438);	

insert into air_login
values('1M',100,'TEST1');
insert into air_login
values('1U',100,'USER@WORK');
insert into air_login
values('2U',101,'SPIDER');


insert into customer_nextval values(10019);
insert into  employee_nextval values(110);
insert into  charter_nextval values(9455);
insert into  transaction_nextval values(20);
insert into login_nextval values('1M','2U');


desc login_nextval;
select * from login_nextval;
desc customer_nextval;
select * from  customer_nextval;
desc employee_nextval;
select * from  employee_nextval;
desc charter_nextval;
select * from  charter_nextval;
desc transaction_nextval;
select * from  transaction_nextval;
desc air_login;
select * from  air_login;
desc air_transaction;
select * from  air_transaction;
desc air_charter;
select * from  air_charter;
decs air_aircraft;
select * from  air_aircraft;
desc air_education;
select * from  air_education;
desc air_qualification;
select * from  air_qualification;
 desc air_model;
select * from  air_model;
desc air_pilot;
select * from  air_pilot;
 desc air_customer;
select * from  air_customer;
desc air_employee;
select * from  air_employee;
commit;




