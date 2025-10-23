-- script to create NORTHWOODS database
-- revised 11/23/2000 JM

DROP TABLE N_enrollment CASCADE CONSTRAINTS;
DROP TABLE N_course_section CASCADE CONSTRAINTS;
DROP TABLE N_term CASCADE CONSTRAINTS;
DROP TABLE N_course CASCADE CONSTRAINTS;
DROP TABLE N_student CASCADE CONSTRAINTS;
DROP TABLE N_faculty CASCADE CONSTRAINTS;
DROP TABLE N_location CASCADE CONSTRAINTS;

CREATE TABLE N_LOCATION
(loc_id NUMBER(6),
bldg_code VARCHAR2(10),
room VARCHAR2(6),
capacity NUMBER(5), 
CONSTRAINT N_location_loc_id_pk PRIMARY KEY (loc_id));

CREATE TABLE N_faculty
(f_id NUMBER(6),
f_last VARCHAR2(30),
f_first VARCHAR2(30),
f_mi CHAR(1),
loc_id NUMBER(5),
f_phone VARCHAR2(10),
f_rank VARCHAR2(8),
f_pin NUMBER(4),
CONSTRAINT N_faculty_f_id_pk PRIMARY KEY(f_id),
CONSTRAINT N_faculty_loc_id_fk FOREIGN KEY (loc_id) REFERENCES N_location(loc_id));

CREATE TABLE N_student
(s_id NUMBER(6),
s_last VARCHAR2(30),
s_first VARCHAR2(30),
s_mi CHAR(1),
s_add VARCHAR2(25),
s_city VARCHAR2(20),
s_state CHAR(2),
s_zip VARCHAR2(9),
s_phone VARCHAR2(10),
s_class CHAR(2),
s_dob DATE,
s_pin NUMBER(4),
f_id NUMBER(6),
CONSTRAINT N_student_s_id_pk PRIMARY KEY (s_id),
CONSTRAINT N_student_f_id_fk FOREIGN KEY (f_id) REFERENCES N_faculty(f_id));

CREATE TABLE N_term
(N_term_id NUMBER(6),
N_term_desc VARCHAR2(20),
status VARCHAR2(20),
CONSTRAINT N_term_N_term_id_pk PRIMARY KEY (N_term_id),
CONSTRAINT N_term_status_cc CHECK ((status = 'OPEN') OR (status = 'CLOSED')));

CREATE TABLE N_course
(N_course_id NUMBER(6),
call_id VARCHAR2(10),
N_course_name VARCHAR2(25),
credits NUMBER(2),
CONSTRAINT N_course_N_course_id_pk PRIMARY KEY(N_course_id));

CREATE TABLE N_course_section
(c_sec_id NUMBER(6),
N_course_id NUMBER(6) CONSTRAINT N_course_section_N_courseid_nn NOT NULL,
N_term_id NUMBER(6) CONSTRAINT N_course_section_N_termid_nn NOT NULL,
sec_num NUMBER(2) CONSTRAINT N_course_section_secnum_nn NOT NULL,
f_id NUMBER(5),
day VARCHAR2(10),
time DATE,
loc_id NUMBER(6),
max_enrl NUMBER(4) CONSTRAINT N_course_section_maxenrl_nn NOT NULL,
CONSTRAINT N_course_section_csec_id_pk PRIMARY KEY (c_sec_id),
CONSTRAINT N_course_section_cid_fk FOREIGN KEY (N_course_id) REFERENCES N_course(N_course_id), 	
CONSTRAINT N_course_section_loc_id_fk FOREIGN KEY (loc_id) REFERENCES N_location(loc_id),
CONSTRAINT N_course_section_N_termid_fk FOREIGN KEY (N_term_id) REFERENCES N_term(N_term_id),
CONSTRAINT N_course_section_fid_fk FOREIGN KEY (f_id) REFERENCES N_faculty(f_id));

CREATE TABLE N_enrollment
(s_id NUMBER(6),
c_sec_id NUMBER(6),
grade CHAR(1),
CONSTRAINT N_enrollment_pk PRIMARY KEY (s_id, c_sec_id),
CONSTRAINT N_enrollment_sid_fk FOREIGN KEY (s_id) REFERENCES N_student(s_id),
CONSTRAINT N_enrollment_csecid_fk FOREIGN KEY (c_sec_id) REFERENCES N_course_section (c_sec_id),
CONSTRAINT N_enrollment_grade_cc
    CHECK ((grade = 'A') OR (grade = 'B') 
    OR (grade = 'C') OR (grade = 'D') OR (grade = 'F') OR (grade = 'N')));




---- inserting into N_LOCATION table
INSERT INTO N_location VALUES
(45, 'CR', '101', 150);

INSERT INTO N_location VALUES
(46, 'CR', '202', 40);

INSERT INTO N_location VALUES
(47, 'CR', '103', 35);

INSERT INTO N_location VALUES
(48, 'CR', '105', 35);

INSERT INTO N_location VALUES
(49, 'BUS', '105', 42);

INSERT INTO N_location VALUES
(50, 'BUS', '404', 35);

INSERT INTO N_location VALUES
(51, 'BUS', '421', 35);

INSERT INTO N_location VALUES
(52, 'BUS', '211', 55);

INSERT INTO N_location VALUES
(53, 'BUS', '424', 1);

INSERT INTO N_location VALUES
(54, 'BUS', '402', 1);

INSERT INTO N_location VALUES
(55, 'BUS', '433', 1);

INSERT INTO N_location VALUES
(56, 'LIB', '217', 2);

INSERT INTO N_location VALUES
(57, 'LIB', '222', 1);

--- inserting records into N_faculty
INSERT INTO N_faculty VALUES
(1, 'Cox', 'Kim', 'J', 53, '7155551234', 'ASSO', 1181);

INSERT INTO N_faculty VALUES
(2, 'Blanchard', 'John', 'R', 54, '7155559087', 'FULL', 1075);

INSERT INTO N_faculty VALUES
(3, 'Williams', 'Jerry', 'F', 56, '7155555412', 'ASST', 8531);

INSERT INTO N_faculty VALUES
(4, 'Sheng', 'Laura', 'M', 55, '7155556409', 'INST', 1690);

INSERT INTO N_faculty VALUES
(5, 'Brown', 'Philip', 'E', 57, '7155556082', 'ASSO', 9899);

--- inserting records into N_student
INSERT INTO N_student VALUES
(100, 'Miller', 'Sarah', 'M', '144 Windridge Blvd.', 'Eau Claire', 
'WI', '54703', '7155559876', 'SR', TO_DATE('07/14/1982', 'MM/DD/YYYY'), 8891, 1);

INSERT INTO N_student VALUES
(101, 'Umato', 'Brian', 'D', '454 St. John''s Street', 'Eau Claire', 
'WI', '54702', '7155552345', 'SR', TO_DATE('08/19/1982', 'MM/DD/YYYY'), 1230, 1);

INSERT INTO N_student VALUES
(102, 'Black', 'Daniel', NULL, '8921 Circle Drive', 'Bloomer', 
'WI', '54715', '7155553907', 'JR', TO_DATE('10/10/1979', 'MM/DD/YYYY'), 1613, 1);

INSERT INTO N_student VALUES
(103, 'Mobley', 'Amanda', 'J', '1716 Summit St.', 'Eau Claire', 
'WI', '54703', '7155556902', 'SO', TO_DATE('09/24/1981', 'MM/DD/YYYY'), 1841, 2);

INSERT INTO N_student VALUES
(104, 'Sanchez', 'Ruben', 'R', '1780 Samantha Court', 'Eau Claire', 
'WI', '54701', '7155558899', 'SO', TO_DATE('11/20/1981', 'MM/DD/YYYY'), 4420, 4);

INSERT INTO N_student VALUES
(105, 'Connoly', 'Michael', 'S', '1818 Silver Street', 'Elk Mound', 
'WI', '54712', '7155554944', 'FR', TO_DATE('12/4/1983', 'MM/DD/YYYY'), 9188, 3);

--- inserting records into N_term
INSERT INTO N_term VALUES
(1, 'Fall 2002', 'CLOSED');

INSERT INTO N_term VALUES
(2, 'Spring 2003', 'CLOSED');

INSERT INTO N_term VALUES
(3, 'Summer 2003', 'CLOSED');

INSERT INTO N_term VALUES
(4, 'Fall 2003', 'CLOSED');

INSERT INTO N_term VALUES
(5, 'Spring 2004', 'CLOSED');

INSERT INTO N_term VALUES
(6, 'Summer 2004', 'OPEN');

--- inserting records into N_course
INSERT INTO N_course VALUES
(1, 'MIS 101', 'Intro. to Info. Systems', 3);

INSERT INTO N_course VALUES
(2, 'MIS 301', 'Systems Analysis', 3);

INSERT INTO N_course VALUES
(3, 'MIS 441', 'Database Management', 3);

INSERT INTO N_course VALUES
(4, 'CS 155', 'Programming in C++', 3);

INSERT INTO N_course VALUES
(5, 'MIS 451', 'Web-Based Systems', 3);

--- inserting records into N_course_section
INSERT INTO N_course_section VALUES
(1000, 1, 4, 1, 2, 'MWF', TO_DATE('10:00 AM', 'HH:MI AM'), 45, 140);

INSERT INTO N_course_section VALUES
(1001, 1, 4, 2, 3, 'TTH', TO_DATE('09:30 AM', 'HH:MI AM'), 51, 35);

INSERT INTO N_course_section VALUES
(1002, 1, 4, 3, 3, 'MWF', TO_DATE('08:00 AM', 'HH:MI AM'), 46, 35);

INSERT INTO N_course_section VALUES
(1003, 2, 4, 1, 4, 'TTH', TO_DATE('11:00 AM', 'HH:MI AM'), 50, 35);

INSERT INTO N_course_section VALUES
(1004, 2, 5, 2, 4, 'TTH', TO_DATE('02:00 PM', 'HH:MI PM'), 50, 35);

INSERT INTO N_course_section VALUES
(1005, 3, 5, 1, 1, 'MWF', TO_DATE('09:00 AM', 'HH:MI AM'), 49, 30);

INSERT INTO N_course_section VALUES
(1006, 3, 5, 2, 1, 'MWF', TO_DATE('10:00 AM', 'HH:MI AM'), 49, 30);

INSERT INTO N_course_section VALUES
(1007, 4, 5, 1, 5, 'TTH', TO_DATE('08:00 AM', 'HH:MI AM'), 47, 35);

INSERT INTO N_course_section VALUES
(1008, 5, 5, 1, 2, 'MWF', TO_DATE('02:00 PM', 'HH:MI PM'), 49, 35);

INSERT INTO N_course_section VALUES
(1009, 5, 5, 2, 2, 'MWF', TO_DATE('03:00 PM', 'HH:MI PM'), 49, 35);

INSERT INTO N_course_section VALUES
(1010, 1, 6, 1, 1, 'M-F', TO_DATE('08:00 AM', 'HH:MI AM'), 45, 50);

INSERT INTO N_course_section VALUES
(1011, 2, 6, 1, 2, 'M-F', TO_DATE('08:00 AM', 'HH:MI AM'), 50, 35);

INSERT INTO N_course_section VALUES
(1012, 3, 6, 1, 3, 'M-F', TO_DATE('09:00 AM', 'HH:MI AM'), 49, 35);

--- inserting records into N_enrollment
INSERT INTO N_enrollment VALUES
(100, 1000, 'A');

INSERT INTO N_enrollment VALUES
(100, 1003, 'A');

INSERT INTO N_enrollment VALUES
(100, 1005, 'B');

INSERT INTO N_enrollment VALUES
(100, 1008, 'B');

INSERT INTO N_enrollment VALUES
(101, 1000, 'C');

INSERT INTO N_enrollment VALUES
(101, 1004, 'B');

INSERT INTO N_enrollment VALUES
(101, 1005, 'A');

INSERT INTO N_enrollment VALUES
(101, 1008, 'B');

INSERT INTO N_enrollment VALUES
(102, 1000, 'C');

INSERT INTO N_enrollment VALUES
(102, 1011, NULL);

INSERT INTO N_enrollment VALUES
(102, 1012, NULL);

INSERT INTO N_enrollment VALUES
(103, 1010, NULL);

INSERT INTO N_enrollment VALUES
(103, 1011, NULL);

INSERT INTO N_enrollment VALUES
(104, 1000, 'B');

INSERT INTO N_enrollment VALUES
(104, 1004, 'C');

INSERT INTO N_enrollment VALUES
(104, 1008, 'C');

INSERT INTO N_enrollment VALUES
(104, 1012, NULL);

INSERT INTO N_enrollment VALUES
(104, 1010, NULL);

INSERT INTO N_enrollment VALUES
(105, 1010, NULL);

INSERT INTO N_enrollment VALUES
(105, 1011, NULL);

COMMIT;
