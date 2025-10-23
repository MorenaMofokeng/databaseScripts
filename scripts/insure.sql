
drop table buyinfo cascade constraints;
drop table modelinfo cascade constraints;
drop table insuranceinfo cascade constraints;
drop table carclient cascade constraints;


create table carclient
(clientid char(4),
clientsurname varchar2(20),
clienttel varchar2(10),
clientsal number(8,2),
constraint clientpk primary key (clientid));

insert into carclient
values('0001','SMITH','0122343432',300000);
insert into carclient
values('0002','MURRAY','0123434343',200000);
insert into carclient
values('0003','MNCUBE','0112334423',150000);
insert into carclient
values('0004','XABA','0123234565',200000);
insert into carclient
values('0005','MUELLER','0134454443',300000);
insert into carclient
values('0006','BORNMAN','0112323232',100000);
insert into carclient
values('0007','PUCKER','0232343543',120000);
insert into carclient
values('0008','SIHLO','0932343234',200000);
insert into carclient
values('0009','MURRAY','0123287878',125000);
insert into carclient
values('0010','SKOSANA','0129876543',350000);


create table insuranceinfo
(insuranceid char(5),
contactperson varchar2(20),
companyname varchar2(20),
constraint insurepk primary key (insuranceid));

insert into insuranceinfo
values('X2353','SCHOEMAN','MANYCARS');
insert into insuranceinfo
values('Y3454','PITAU','CARMANIACS');
insert into insuranceinfo
values('Z9999','COLBE','PAYUP');
insert into insuranceinfo
values('T2331','ZIMMA','VERYCHEAP');

create table modelinfo
(modelid char(5),
modelprice number(9,2),
modelyear number(4),
constraint modelidpk primary key (modelid));

insert into modelinfo
values('XYZ3i','304000',2000);
insert into modelinfo
values('ABC50',295000,2002);
insert into modelinfo
values('AXX3i',100000,2000);
insert into modelinfo
values('BZN20',450000,2003);
insert into modelinfo
values('BZN30',250000,2000);

create table buyinfo
(buyid char(4),
clientid char(4),
insuranceid char(5),
modelid char(5),
paymethod char(1),
buydate date,
constraint buypk primary key (buyid),
constraint clientfk foreign key (clientid) references carclient(clientid),
constraint insurefk foreign key (insuranceid) references insuranceinfo(insuranceid),
constraint modelfk foreign key (modelid) references modelinfo(modelid));

insert into buyinfo
values('0001','0003','X2353','XYZ3i','A','20-MAR-2003');
insert into buyinfo
values('0002','0007','X2353','AXX3i','A','21-MAR-2003');
insert into buyinfo
values('0003','0008','Y3454','BZN20','A','23-MAR-2003');
insert into buyinfo
values('0004','0003','Z9999','XYZ3i','C','25-MAR-2003');
insert into buyinfo
values('0005','0002','X2353','AXX3i','C','25-MAR-2003');
insert into buyinfo
values('0006','0001','Y3454','XYZ3i','D','25-MAR-2003');
insert into buyinfo
values('0007','0010','Y3454','XYZ3i','A','26-MAR-2003');
insert into buyinfo
values('0008','0005','Z9999','AXX3i','A','28-MAR-2003');
insert into buyinfo
values('0009','0002','Z9999','ABC50','C','01-MAY-2003');
insert into buyinfo
values('0010','0004','Y3454','BZN30','A','03-MAY-2003');
insert into buyinfo
values('0011','0004','X2353','BZN20','D','03-MAY-2003');
insert into buyinfo
values('0012','0006','X2353','BZN20','A','04-MAY-2003');
insert into buyinfo
values('0013','0003','T2331','XYZ3i','A','05-MAY-2003');
insert into buyinfo
values('0014','0008','T2331','XYZ3i','B','05-MAY-2003');
insert into buyinfo
values('0015','0010','T2331','ABC50','B','06-MAY-2003');
insert into buyinfo
values('0016','0001','X2353','BZN20','D','08-MAY-2003');
insert into buyinfo
values('0017','0007','Y3454','ABC50','A','10-MAY-2003')
/
commit;

