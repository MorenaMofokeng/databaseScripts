--script to create Software Experts database
--revised 1/15/2001 JM

DROP TABLE SE_evaluation CASCADE CONSTRAINTS;
DROP TABLE SE_project_consultant CASCADE CONSTRAINTS;
DROP TABLE SE_project_skill CASCADE CONSTRAINTS;
DROP TABLE SE_project CASCADE CONSTRAINTS;
DROP TABLE SE_client CASCADE CONSTRAINTS;
DROP TABLE SE_consultant_skill CASCADE CONSTRAINTS;
DROP TABLE SE_skill CASCADE CONSTRAINTS;
DROP TABLE SE_consultant CASCADE CONSTRAINTS;

CREATE TABLE SE_consultant
(c_id NUMBER(6),
c_last VARCHAR2(20),
c_first VARCHAR2(20),
c_mi CHAR(1),
c_add VARCHAR2(30),
c_city VARCHAR2(20),
c_state CHAR(2),
c_zip VARCHAR2(10),
c_phone VARCHAR2(15),
c_email VARCHAR2(30), 
CONSTRAINT SE_consultant_c_id_pk PRIMARY KEY (c_id));

CREATE TABLE SE_skill
(SE_skill_id NUMBER(3),
SE_skill_description VARCHAR2(50),
CONSTRAINT SE_skill_id_pk PRIMARY KEY (SE_skill_id));

CREATE TABLE SE_consultant_skill
(c_id NUMBER(6),
SE_skill_id NUMBER(3),
certification VARCHAR2(8),
CONSTRAINT SE_consultant_skill_pk PRIMARY KEY (c_id, SE_skill_id),
CONSTRAINT SE_consultant_skill_c_id_fk FOREIGN KEY (c_id) REFERENCES SE_consultant(c_id),
CONSTRAINT SE_consult_skill_skill_id_fk FOREIGN KEY (SE_skill_id) REFERENCES SE_skill(SE_skill_id));

CREATE TABLE SE_client
(SE_client_id NUMBER(6),
SE_client_name VARCHAR2(30),
contact_last VARCHAR2(30),
contact_first VARCHAR2(30),
contact_phone VARCHAR2(15),
CONSTRAINT SE_client_SE_client_id_pk PRIMARY KEY (SE_client_id));

CREATE TABLE SE_project
(p_id NUMBER(6),
SE_project_name VARCHAR2(30),
SE_client_id NUMBER(6),
mgr_id NUMBER(6),
parent_p_id NUMBER(6),
CONSTRAINT SE_project_pid_pk PRIMARY KEY (p_id),
CONSTRAINT SE_project_SE_client_id_fk FOREIGN KEY (SE_client_id) REFERENCES SE_client(SE_client_id),
CONSTRAINT SE_project_mgr_id_fk FOREIGN KEY (mgr_id) REFERENCES SE_consultant(c_id));

ALTER TABLE SE_project
ADD CONSTRAINT SE_project_parent_pid_fk FOREIGN KEY (parent_p_id) REFERENCES SE_project(p_id);

CREATE TABLE SE_project_skill
(p_id NUMBER(6),
SE_skill_id NUMBER(3),
CONSTRAINT SE_project_skill_pk PRIMARY KEY (p_id, SE_skill_id),
CONSTRAINT SE_project_skill_pid_fk FOREIGN KEY (p_id) REFERENCES SE_project(p_id),
CONSTRAINT SE_proj_skill_skill_id_fk FOREIGN KEY (SE_skill_id) REFERENCES SE_skill(SE_skill_id));

CREATE TABLE SE_project_consultant
(p_id NUMBER(6),
c_id NUMBER(6),
roll_on_date DATE,
roll_off_date DATE,
total_hours NUMBER(6),
CONSTRAINT SE_project_consultant_pk PRIMARY KEY (p_id, c_id),
CONSTRAINT SE_project_consultant_pid FOREIGN KEY (p_id) REFERENCES SE_project(p_id),
CONSTRAINT SE_project_consultant_cid FOREIGN KEY (c_id) REFERENCES SE_consultant(c_id));

CREATE TABLE SE_evaluation
(e_id NUMBER(8),
e_date DATE,
p_id NUMBER(6),
evaluator_id NUMBER(6),
evaluatee_id NUMBER(6),
score NUMBER(3),
comments varchar(20),
CONSTRAINT SE_evaluation_eid_pk PRIMARY KEY (e_id),
CONSTRAINT SE_evaluation_pid_fk FOREIGN KEY (p_id) REFERENCES SE_project(p_id),
CONSTRAINT SE_evaluation_evaluatorid FOREIGN KEY (evaluator_id) REFERENCES SE_consultant(c_id),
CONSTRAINT SE_evaluation_evaluateeid FOREIGN KEY (evaluatee_id) REFERENCES SE_consultant(c_id),
CONSTRAINT SE_evaluation_score_cc CHECK ((score >= 0) AND (score <= 100)));


--insert values into SE_consultant
INSERT INTO SE_consultant VALUES
(100, 'Myers', 'Mark', 'F', '1383 Alexander Ave.', 'Eau Claire', 'WI', '54703', '7155559652', 'mmyers@swexpert.com');

INSERT INTO SE_consultant VALUES
(101, 'Hernandez', 'Sheila', 'R', '3227 Brian Street', 'Eau Claire', 'WI', '54702', '7155550282', 'shernandez@earthware.com');

INSERT INTO SE_consultant VALUES
(102, 'Zhang', 'Brian', NULL, '2227 Calumet Place', 'Altoona', 'WI', '54720', '7155558383', 'zhang@swexpert.com');

INSERT INTO SE_consultant VALUES
(103, 'Carlson', 'Sarah', 'J', '1334 Water Street', 'Eau Claire', 'WI', '54703', '7155558008', 'carlsons@swexpert.com');

INSERT INTO SE_consultant VALUES
(104, 'Courtlandt', 'Paul', 'R', '1911 Pine Drive', 'Eau Claire', 'WI', '54701', '7155555225', 'courtlpr@yamail.com');

INSERT INTO SE_consultant VALUES
(105, 'Park', 'Janet', 'S', '2333 157th Street', 'Chippewa Falls', 'WI', '54712', '7155554944', 'jpark@swexpert.com');

--insert values into SE_skill
INSERT INTO SE_skill VALUES
(1, 'Visual Basic Programming');

INSERT INTO SE_skill VALUES
(2, 'COBOL Programming');

INSERT INTO SE_skill VALUES
(3, 'Java Programming');

INSERT INTO SE_skill VALUES
(4, 'SE_project Management');

INSERT INTO SE_skill VALUES
(5, 'Web Application Programming');

INSERT INTO SE_skill VALUES
(6, 'Oracle Developer Programming');

INSERT INTO SE_skill VALUES
(7, 'Oracle Database Administration');

INSERT INTO SE_skill VALUES
(8, 'Windows NT Network Administration');

INSERT INTO SE_skill VALUES
(9, 'Windows 2000 Network Administration');

--insert values into SE_consultant_skill
INSERT INTO SE_consultant_skill VALUES
(100, 1, 'Y');

INSERT INTO SE_consultant_skill VALUES
(100, 3, 'N');

INSERT INTO SE_consultant_skill VALUES
(100, 6, 'Y');

INSERT INTO SE_consultant_skill VALUES
(101, 4, 'N');

INSERT INTO SE_consultant_skill VALUES
(101, 5, 'N');

INSERT INTO SE_consultant_skill VALUES
(102, 7, 'Y');

INSERT INTO SE_consultant_skill VALUES
(103, 1, 'Y');

INSERT INTO SE_consultant_skill VALUES
(103, 6, 'Y');

INSERT INTO SE_consultant_skill VALUES
(103, 8, 'Y');

INSERT INTO SE_consultant_skill VALUES
(103, 9, 'Y');

INSERT INTO SE_consultant_skill VALUES
(104, 8, 'N');

INSERT INTO SE_consultant_skill VALUES
(104, 9, 'Y');

INSERT INTO SE_consultant_skill VALUES
(105, 2, 'N');

INSERT INTO SE_consultant_skill VALUES
(105, 3, 'N');

INSERT INTO SE_consultant_skill VALUES
(105, 4, 'Y');

--insert into SE_client
INSERT INTO SE_client VALUES (1, 'Crisco Systems', 'Martin', 'Andrew', '5215557220');
INSERT INTO SE_client VALUES (2, 'Supreme Data Corporation', 'Martinez', 'Michelle', '5205559821');
INSERT INTO SE_client VALUES (3, 'Lucid Technologies', 'Brown', 'Jack', '7155552311');
INSERT INTO SE_client VALUES (4, 'Morningstar Bank', 'Wright', 'Linda', '9215553320');
INSERT INTO SE_client VALUES (5, 'Maverick Petroleum', 'Miller', 'Tom', '4085559822');
INSERT INTO SE_client VALUES (6, 'Birchwood Mall', 'Brenner', 'Nicole', '7155550828');

--insert into SE_project
INSERT INTO SE_project VALUES
(1, 'Hardware Support Intranet', 2, 105, NULL);

INSERT INTO SE_project VALUES
(2, 'Hardware Support Interface', 2, 103, 1);

INSERT INTO SE_project VALUES
(3, 'Hardware Support Database', 2, 102, 1);

INSERT INTO SE_project VALUES
(4, 'Teller Support System', 4, 105, NULL);

INSERT INTO SE_project VALUES
(5, 'Internet Advertising', 6, 105, NULL);

INSERT INTO SE_project VALUES
(6, 'Network Design', 6, 104, 5);

INSERT INTO SE_project VALUES
(7, 'Exploration Database', 5, 102, NULL);

--insert into SE_project_skill
INSERT INTO SE_project_skill VALUES (1, 8);
INSERT INTO SE_project_skill VALUES (1, 9);
INSERT INTO SE_project_skill VALUES (2, 3);
INSERT INTO SE_project_skill VALUES (3, 6);
INSERT INTO SE_project_skill VALUES (3, 7);
INSERT INTO SE_project_skill VALUES (4, 2);
INSERT INTO SE_project_skill VALUES (4, 7);
INSERT INTO SE_project_skill VALUES (5, 5);
INSERT INTO SE_project_skill VALUES (5, 9);
INSERT INTO SE_project_skill VALUES (6, 9);
INSERT INTO SE_project_skill VALUES (7, 6);
INSERT INTO SE_project_skill VALUES (7, 7);

--insert into SE_project_consultant
INSERT INTO SE_project_consultant VALUES
(1, 101, TO_DATE('06/15/2002', 'MM/DD/YYYY'), TO_DATE('12/15/2002', 'MM/DD/YYYY'), 175);

INSERT INTO SE_project_consultant VALUES
(1, 104, TO_DATE('01/05/2002', 'MM/DD/YYYY'), TO_DATE('12/15/2002', 'MM/DD/YYYY'), 245);

INSERT INTO SE_project_consultant VALUES
(1, 103, TO_DATE('01/05/2002', 'MM/DD/YYYY'), TO_DATE('06/05/2002', 'MM/DD/YYYY'), 50);

INSERT INTO SE_project_consultant VALUES
(1, 105, TO_DATE('01/05/2002', 'MM/DD/YYYY'), TO_DATE('12/15/2002', 'MM/DD/YYYY'), 45);

INSERT INTO SE_project_consultant VALUES
(2, 105, TO_DATE('07/17/2002', 'MM/DD/YYYY'), TO_DATE('09/17/2002', 'MM/DD/YYYY'), 25);

INSERT INTO SE_project_consultant VALUES
(2, 100, TO_DATE('07/17/2002', 'MM/DD/YYYY'), TO_DATE('09/17/2002', 'MM/DD/YYYY'), 0);

INSERT INTO SE_project_consultant VALUES
(3, 103, TO_DATE('09/15/2002', 'MM/DD/YYYY'), TO_DATE('03/15/2003', 'MM/DD/YYYY'), 125);

INSERT INTO SE_project_consultant VALUES
(3, 104, TO_DATE('10/15/2002', 'MM/DD/YYYY'), TO_DATE('12/15/2002', 'MM/DD/YYYY'), 50);

INSERT INTO SE_project_consultant VALUES
(4, 105, TO_DATE('06/05/2002', 'MM/DD/YYYY'), TO_DATE('06/05/2003', 'MM/DD/YYYY'), 25);

INSERT INTO SE_project_consultant VALUES
(4, 104, TO_DATE('06/15/2002', 'MM/DD/YYYY'), TO_DATE('12/15/2002', 'MM/DD/YYYY'), 125);

INSERT INTO SE_project_consultant VALUES
(4, 102, TO_DATE('07/15/2002', 'MM/DD/YYYY'), TO_DATE('12/15/2002', 'MM/DD/YYYY'), 30);

INSERT INTO SE_project_consultant VALUES
(5, 105, TO_DATE('09/19/2002', 'MM/DD/YYYY'), TO_DATE('03/19/2003', 'MM/DD/YYYY'), 15);

INSERT INTO SE_project_consultant VALUES
(5, 103, TO_DATE('09/19/2002', 'MM/DD/YYYY'), TO_DATE('03/19/2003', 'MM/DD/YYYY'), 15);

INSERT INTO SE_project_consultant VALUES
(6, 103, TO_DATE('09/19/2002', 'MM/DD/YYYY'), TO_DATE('03/19/2003', 'MM/DD/YYYY'), 5);

INSERT INTO SE_project_consultant VALUES
(6, 104, TO_DATE('09/19/2002', 'MM/DD/YYYY'), TO_DATE('03/19/2003', 'MM/DD/YYYY'), 10);

INSERT INTO SE_project_consultant VALUES
(7, 102, TO_DATE('05/20/2002', 'MM/DD/YYYY'), TO_DATE('12/20/2002', 'MM/DD/YYYY'), 125);

INSERT INTO SE_project_consultant VALUES
(7, 100, TO_DATE('05/25/2002', 'MM/DD/YYYY'), TO_DATE('12/20/2002', 'MM/DD/YYYY'), 100);

--insert into SE_evaluation
INSERT INTO SE_evaluation VALUES
(100, TO_DATE('01/07/2003', 'MM/DD/YYYY'), 1, 105, 101, 90, NULL);

INSERT INTO SE_evaluation VALUES
(101, TO_DATE('01/07/2003', 'MM/DD/YYYY'), 1, 105, 104, 85, NULL);

INSERT INTO SE_evaluation VALUES
(102, TO_DATE('01/08/2003', 'MM/DD/YYYY'), 1, 105, 103, 90, NULL);

INSERT INTO SE_evaluation VALUES
(103, TO_DATE('12/20/2002', 'MM/DD/YYYY'), 1, 103, 105, 100, NULL);

INSERT INTO SE_evaluation VALUES
(104, TO_DATE('12/29/2002', 'MM/DD/YYYY'), 1, 104, 105, 75, NULL);

INSERT INTO SE_evaluation VALUES
(105, TO_DATE('01/15/2003', 'MM/DD/YYYY'), 1, 101, 105, 90, NULL);

COMMIT;















































