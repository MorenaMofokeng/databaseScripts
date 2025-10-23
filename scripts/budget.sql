drop table b_monthly_costs cascade constraints;
drop table b_work_order_tasks cascade constraints;
drop table b_work_orders cascade constraints;
drop table b_projects cascade constraints;
drop table b_employees cascade constraints;
drop table b_departments cascade constraints;
drop table b_accounts cascade constraints;
drop table b_task_descriptions cascade constraints;

create table b_task_descriptions
 (task_id             varchar(5) primary key,
  task_description    varchar2(25));


insert into b_task_descriptions (task_id, task_description)
values ('GR','GRADING');

insert into b_task_descriptions (task_id, task_description)
values ('CE','CEMENT WORK');

insert into b_task_descriptions (task_id, task_description)
values ('TR','TRENCHING');

insert into b_task_descriptions (task_id, task_description)
values ('WI','WIRING');

insert into b_task_descriptions (task_id, task_description)
values ('RE','RELAY INSTALL');

insert into b_task_descriptions (task_id, task_description)
values ('RET','RELAY TIMING');

insert into b_task_descriptions (task_id, task_description)
values ('DE','DISTRIBUTION ELECTRICAL');

insert into b_task_descriptions (task_id, task_description)
values ('CP','CARPENTRY');

insert into b_task_descriptions (task_id, task_description)
values ('AW','AERIAL WORK');

insert into b_task_descriptions (task_id, task_description)
values ('WE','WELDING');

insert into b_task_descriptions (task_id, task_description)
values ('SE','SUBSTATION ELECTRICAL');

insert into b_task_descriptions (task_id, task_description)
values ('PC','PULLING CABLE');

insert into b_task_descriptions (task_id, task_description)
values ('TE','TRANSMISSION ELECTRICAL');



create table b_accounts
 (account_id          number(5,2) primary key,
  account_description varchar2(25) not null);


insert into b_accounts(account_id, account_description)
values (362.01,'SUBSTATION GRADING');

insert into b_accounts(account_id, account_description)
values (362.07,'SUBSTATION TRANSFORMER');

insert into b_accounts(account_id, account_description)
values (362.15,'SUBSTATION BUILDING');

insert into b_accounts(account_id, account_description)
values (362.52,'SUBSTATION RELAYS');

insert into b_accounts(account_id, account_description)
values (397.01,'STREETLIGHTS');

insert into b_accounts(account_id, account_description)
values (562.01,'TRANSMISSION OPERATIONS');

insert into b_accounts(account_id, account_description)
values (570.01,'TRANSMISSION MAINTENANCE');

insert into b_accounts(account_id, account_description)
values (582.01,'SUBSTATION OPERATIONS');

insert into b_accounts(account_id, account_description)
values (583.01,'DISTRIBUTION OPERATIONS');

insert into b_accounts(account_id, account_description)
values (592.01,'SUBSTATION MAINTENANCE');

insert into b_accounts(account_id, account_description)
values (593.01,'DISTRIBUTION MAINTENANCE');

insert into b_accounts(account_id, account_description)
values (370.01,'345 KV TRANSMISSION');


create table b_departments
(department_id        char(2) primary key,
 department_name      varchar2(30) not null,
 department_mgr       number(5,0));

insert into b_departments(department_id, department_name, department_mgr)
values('SE','SUBSTATION ENGINEERING',1);

insert into b_departments(department_id, department_name, department_mgr)
values('SC','SUBSTATION CONSTRUCTION',2);

insert into b_departments(department_id, department_name, department_mgr)
values('TE','TRANSMISSION ENGINEERING',3);

insert into b_departments(department_id, department_name, department_mgr)
values('TC','TRANSMISSION CONSTRUCTION',4);

insert into b_departments(department_id, department_name, department_mgr)
values('DE','DISTRIBUTION ENGINEERING',5);

insert into b_departments(department_id, department_name, department_mgr)
values('DC','DISTRIBUTION CONSTRUCTION',6);



create table b_employees
 (employee_id         number(5,0) primary key,
  employment_date     date not null,
  first_name          varchar2(10) not null,
  last_name           varchar2(20) not null,
  ssn                 number(9,0),
  address             varchar2(25),
  birth_date          date,
  city                varchar2(15),
  state               varchar2(2),
  classification      varchar2(20),
  department_id       char(2) references b_departments(department_id)); 

insert into b_employees(employee_id, department_id, employment_date, last_name, first_name, ssn, address, birth_date, city, state, classification)
values(1,'SE','01-Aug-1971','STELLA','TYSON',123984590,'3814 VALLEY ROAD','09-Sep-1948','OMAHA','NE','MANAGER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(2,'SC','11-Jan-1969','KATIE','BENFELDT',503908245,'8789 GLASGOW AVE','23-Aug-1952','OMAHA','NE','MANAGER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(3,'TE','23-May-1974','MATTHEW','PALINSKI',490093010,'9713 S. 23RD ST','31-Oct-1949','COUNCIL BLUFFS','IA','MANAGER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(4,'TC','30-Mar-1978','KEVIN','MILLER',290877908,'101 OHEARN ST','03-Jan-1958','BELLEVUE','NE','MANAGER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(5,'DE','23-Sep-1976','WILLIAM','MILCZSKI',452007493,'126 BOB BOOZER DRIVE','14-Nov-1951','LA VISTA','NE','MANAGER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(6,'DC','05-Feb-1972','ANNE','MILLER',790428731,'4567 ED GOMEZ AVE','25-Aug-1953','PAPILLION','NE','MANAGER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(7,'DE','23-Jun-1986','NICK','GUNIA',345096723,'5317 S. 33RD ST','30-Jun-1962','NORTH BEND','NE','ENGINEER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(8,'TE','03-Feb-1982','JANE','PALINSKI',870981267,'62 AIRDALE DRIVE','07-Dec-1959','GLENWOOD','IA','ENGINEER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(9,'DE','19-Oct-1993','TYLER','BRYSON',309973410,'11235 S. 107TH ST','23-Jul-1961','OMAHA','NE','ENGINEER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(10,'SE','12-Oct-1984','ALEX','BRYSON',912930001,'8841 HOLMES AVE','03-Nov-1960','OMAHA','NE','ENGINEER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(11,'TE','22-Dec-1982','JESSICA','LAVENDER',593099341,'812 FONTONELLE BLVD','06-Oct-1964','VALLEY','NE','ENGINEER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(12,'DE','14-Jan-1979','JOEL' ,'HAMPTON',634091267,'1010 PERSHING DRIVE','11-Mar-1958','NEBRASKA CIT','NE','ENGINEER');

insert into b_employees(employee_id, department_id, employment_date , last_name, first_name, ssn, address, birth_date , city, state, classification)
values(13,'SE','23-Apr-1980','LEAH','BRYSON',745094536,'8790 SEMIN AVENUE','12-Nov-1957','OMAHA','NE','ENGINEER');

 

create table b_projects
(project_id           varchar2(10) primary key,
 project_name         varchar2(60) not null,
 project_need_date    date,
 project_scope        varchar2(150),
 project_location     varchar2(50),
 assigned_department_id    char(2) references b_departments(department_id),
 assigned_to          number(5,0) references b_employees(employee_id));


insert into b_projects(project_id, project_name, project_need_date, project_scope, project_location, assigned_department_id, assigned_to)
values('S1000000','Build 345 kv substation 3467','10-Jul-2003','Construct a standard 345kv substation consisting of two feeder transformers.','320th West Center Rd','SE',12);

insert into b_projects(project_id, project_name, project_need_date, project_scope, project_location, assigned_department_id, assigned_to)
values('T1000001','Build 50 miles of transmission line to substation 3467','1-Sep-2003','Construct a 345 kv transmission line from North Bend to Substation 3467','Western Douglas County','TE',13);

insert into b_projects(project_id, project_name, project_need_date, project_scope, project_location, assigned_department_id, assigned_to)
values('D1000002','Build feeder circuit 102' ,'1-Jan-2004','Develop an electrical backbone for 160 lots in the new Turtle Creek Subdivision','Turtle Creek Subdivision','DE',13);

insert into b_projects(project_id, project_name, project_need_date, project_scope, project_location, assigned_department_id, assigned_to)
values('D1000003','Build feeder circuit 207','1-Mar-2004','Develop and electrical backbone for 206 lots in the new Gorzelanski Acres','Gorzelanski Acres','DE',11);

insert into b_projects(project_id, project_name, project_need_date, project_scope, project_location, assigned_department_id, assigned_to)
values('D1000004','Upgrade transformer for Lozier Foods','30-Apr-2003','Upgrade Lozier Foods 100 KVA transformer to 300 KVA','13678 Dodge street','DE',12);



create table b_work_orders
(work_order_id        number(5) primary key,
 Project_id           varchar2(10) references b_projects(project_id),
 wo_description       varchar2(100) not null,
 wo_location          varchar2(50),
 wo_instructions      varchar2(200),
 Approved_by          number(5,0) references b_employees(employee_id),
 Assigned_to          number(5,0) references b_employees(employee_id));


insert into b_work_orders(work_order_id, project_id, wo_description, wo_location, wo_instructions, assigned_to, approved_by)
values(30001,'S1000000','Sub 3467 - Grade Foundation','320th West Center Rd','Grade 1 acre lot per grading plan',10,1);

insert into b_work_orders(work_order_id, project_id, wo_description, wo_location, wo_instructions, assigned_to, approved_by)
values(30006,'S1000000','Sub 3467 - Construct Building','320th West Center Rd','Construct 50 by 20 building',13,1);

insert into b_work_orders(work_order_id, project_id, wo_description, wo_location, wo_instructions, assigned_to, approved_by)
values(30007,'S1000000','Sub 3467 - Construct Equipment Foundations','320th West Center Rd','Construct 3 transformer foundations per Drawing E-456 and 3 circuit break foundations per Drawing E-987',13,1);

insert into b_work_orders(work_order_id, project_id, wo_description, wo_location, wo_instructions, assigned_to, approved_by)
values(30008,'S1000000','Sub 3467 - Install Transformer and Circuit Breakers','320th West Center Rd','Install transformers C-12345, D-0965, and X-9809.  Install Circuit breakers C9809, C0984, and CV9098.',10,1);

insert into b_work_orders(work_order_id, project_id, wo_description, wo_location, wo_instructions, assigned_to, approved_by)
values(30002,'T1000001','Construct 15 miles of 345 kv transmission line from North Bend to Fremont','North Bend','Construct 15 miles of line using construction standard T-786',8,3);

insert into b_work_orders(work_order_id, project_id, wo_description, wo_location, wo_instructions, assigned_to, approved_by)
values(30009,'T1000001','Construct 20 miles of 345 kv transmission line from Fremont to Elkhorn','Fremont','Construct 20 miles of line using construction standard T-787',11,3);

insert into b_work_orders(work_order_id, project_id, wo_description, wo_location, wo_instructions, assigned_to, approved_by)
values(30010,'T1000001','Construct 15 miles of 345 kv transmission line from Fremont to Sub 3467','Sub 3467','Construct 15 miles of line using construction standard T-788',11,3);

insert into b_work_orders(work_order_id, project_id, wo_description, wo_location, wo_instructions, assigned_to, approved_by)
values(30003,'D1000002','Construct electrical backbone for lots 1 - 50 in the Turtle Creek Subdivision','14509 S. 102nd St','Install services per Distribution standard D-345',7,5);

insert into b_work_orders(work_order_id, project_id, wo_description, wo_location, wo_instructions, assigned_to, approved_by)
values(30004,'D1000003','Construct electrical backbone for lots 68 - 102 in the Gorzelanski Acres Subdivision','4590 S. 13th St','Install underground services per Distribution standard D-348',12,5);

insert into b_work_orders(work_order_id, project_id, wo_description, wo_location, wo_instructions, assigned_to, approved_by)
values(30005,'D1000004','Replace transformer 3PM8790 with 3PM98034 at Lozier Foods','13678 Dodge street','Replace transformer per Drawing C-98',7,5);


create table b_work_order_tasks
 (work_order_task_id          	number(5,0) primary key,
  wo_work_order_id    		number(5) not null references b_work_orders(work_order_id),
  task_description_id          	varchar(5) not null references b_task_descriptions(task_id),
  assigned_department_id   	char(2) not null references b_departments(department_id),
  account_id      		number(5,2) not null references b_accounts(account_id),
  labor_hours         		number(5,0),
  material_costs      		number(7,0),
  equipment_costs     		number(7,0));


insert into b_work_order_tasks(work_order_task_id, wo_work_order_id, task_description_id, assigned_department_id, account_id, labor_hours, material_costs, equipment_costs)
values(1,30001,'GR','SC',362.01,100,2589,3000);

insert into b_work_order_tasks(work_order_task_id, wo_work_order_id, task_description_id, assigned_department_id, account_id, labor_hours, material_costs, equipment_costs)
values(2,30001,'CE','SC',362.01,250,5000,4);

insert into b_work_order_tasks(work_order_task_id, wo_work_order_id, task_description_id, assigned_department_id, account_id, labor_hours, material_costs, equipment_costs)
values(3,30001,'CP','SC',362.01,160,4000,0);

insert into b_work_order_tasks(work_order_task_id, wo_work_order_id, task_description_id, assigned_department_id, account_id, labor_hours, material_costs, equipment_costs)
values(4,30006,'CE','SC',362.15,200,3700,370);

insert into b_work_order_tasks(work_order_task_id, wo_work_order_id, task_description_id, assigned_department_id, account_id, labor_hours, material_costs, equipment_costs)
values(5,30006,'CP','SC',362.15,250,4000,230);

insert into b_work_order_tasks(work_order_task_id, wo_work_order_id, task_description_id, assigned_department_id, account_id, labor_hours, material_costs, equipment_costs)
values(6,30007,'CE','SC',362.07,1280,7000,500);

insert into b_work_order_tasks(work_order_task_id, wo_work_order_id, task_description_id, assigned_department_id, account_id, labor_hours, material_costs, equipment_costs)
values(7,30007,'CP','SC',362.07,300,1000,0);

insert into b_work_order_tasks(work_order_task_id, wo_work_order_id, task_description_id, assigned_department_id, account_id, labor_hours, material_costs, equipment_costs)
values(8,30002,'TE','TC',370.01,0,70000,0);

insert into b_work_order_tasks(work_order_task_id, wo_work_order_id, task_description_id, assigned_department_id, account_id, labor_hours, material_costs, equipment_costs)
values(9,30009,'TE','TC',370.01,0,65000,0);

insert into b_work_order_tasks(work_order_task_id, wo_work_order_id, task_description_id, assigned_department_id, account_id, labor_hours, material_costs, equipment_costs)
values(10,30003,'DE','DC',583.01,600,2900,500);

insert into b_work_order_tasks(work_order_task_id, wo_work_order_id, task_description_id, assigned_department_id, account_id, labor_hours, material_costs, equipment_costs)
values(11,30004,'DE','DC',583.01,700,3500,800);


create table b_monthly_costs
(monthly_cost_id      number(5,0) primary key,
 work_order_task_id   number(5,0) references b_work_order_tasks,
 year                 char(4) not null,
 month                varchar2(9) not null,
 cost                 number(7) not null);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(1,1,'JANUARY','2003',5589);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(2,2,'JANUARY','2003',5004);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(3,3,'JANUARY','2003',4000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(4,4,'FEBRUARY','2003',2700);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(5,4,'MARCH','2003',1370);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(6,5,'FEBRUARY','2003',3000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(7,5,'MARCH','2003',1230);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(8,6,'APRIL','2003',2000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(9,6,'MAY','2003',2000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(10,6,'JUNE','2003',3500);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(11,7,'APRIL','2003',500);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(12,7,'APRIL','2003',500);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(13,8,'JANUARY','2003',25000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(14,8,'APRIL','2003',25000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(15,8,'AUGUST','2003',20000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(16,9,'AUGUST','2003',20000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(17,9,'OCTOBER','2003',20000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(18,9,'DECEMBER','2003',25000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(20,10,'SEPTEMBER','2003',400);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(21,10,'OCTOBER','2003',1000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(22,10,'NOVEMBER','2003',1000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(23,10,'DECEMBER','2003',1000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(24,11,'DECEMBER','2004',1000);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(25,11,'JANUARY','2004',2300);

insert into b_monthly_costs(monthly_cost_id, work_order_task_id, month, year, cost)
values(26,11,'FEBRUARY','2004',1000);

commit;
