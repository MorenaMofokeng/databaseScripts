--script to create Clearwater Traders database
--revised 12/4/2000 JM

DROP TABLE CT_order_line CASCADE CONSTRAINTS;
DROP TABLE CT_shipment_line CASCADE CONSTRAINTS;
DROP TABLE CT_shipment CASCADE CONSTRAINTS;
DROP TABLE CT_inventory CASCADE CONSTRAINTS;
DROP TABLE CT_color CASCADE CONSTRAINTS;
DROP TABLE CT_item CASCADE CONSTRAINTS;
DROP TABLE CT_category CASCADE CONSTRAINTS;
DROP TABLE CT_cust_order CASCADE CONSTRAINTS;
DROP TABLE CT_order_source CASCADE CONSTRAINTS;
DROP TABLE CT_customer CASCADE CONSTRAINTS;

CREATE TABLE CT_customer
(cust_id NUMBER(5), 
last VARCHAR2(30),
first VARCHAR2(30),
mi CHAR(1),
address VARCHAR2(30),
city VARCHAR2(30),
state CHAR(2),
zip VARCHAR2(10),
d_phone VARCHAR2(10),
e_phone VARCHAR2(10),
CONSTRAINT CT_customer_cust_id_pk PRIMARY KEY (cust_id));

CREATE TABLE CT_order_source
(CT_order_source_id NUMBER(3),
source_desc VARCHAR2(30),
CONSTRAINT CT_ord_source_ord_sourcid_pk PRIMARY KEY(CT_order_source_id));

CREATE TABLE CT_cust_order
(order_id NUMBER(8), 
order_date DATE,
meth_pmt VARCHAR2(10),
cust_id NUMBER(5),
CT_order_source_id NUMBER(3),
CONSTRAINT CT_cust_order_order_id_pk PRIMARY KEY (order_id),
CONSTRAINT CT_cust_order_cust_id_fk FOREIGN KEY (cust_id) REFERENCES CT_customer(cust_id),
CONSTRAINT CT_cust_ord_ord_source_id_fk FOREIGN KEY (CT_order_source_id) 
REFERENCES CT_order_source(CT_order_source_id));

CREATE TABLE CT_category
(CT_category_id NUMBER(2),
CT_category_desc VARCHAR2(20),
CONSTRAINT CT_category_CT_category_id_pk PRIMARY KEY (CT_category_id));

CREATE TABLE CT_item
(CT_item_id NUMBER(8),
CT_item_desc VARCHAR2(100),
CT_category_id NUMBER(2),
CONSTRAINT CT_item_CT_item_id_pk PRIMARY KEY (CT_item_id),
CONSTRAINT CT_item_CT_category_id_fk FOREIGN KEY (CT_category_id) REFERENCES CT_category(CT_category_id));

CREATE TABLE CT_color
(CT_color VARCHAR2(20),
CONSTRAINT CT_color_CT_color_pk PRIMARY KEY (CT_color));

CREATE TABLE CT_inventory
(inv_id NUMBER(10),
CT_item_id NUMBER(8),
CT_item_size VARCHAR2(10),
CT_color VARCHAR2(20),
price NUMBER(6,2),
qoh NUMBER(4),
CONSTRAINT CT_inventory_inv_id_pk PRIMARY KEY (inv_id),
CONSTRAINT CT_inventory_CT_itemid_fk FOREIGN KEY (CT_item_id) REFERENCES CT_item(CT_item_id),
CONSTRAINT CT_inventory_CT_color_fk FOREIGN KEY (CT_color) REFERENCES CT_color(CT_color));

CREATE TABLE CT_shipment
(CT_shipment_id NUMBER(10),
date_expected DATE,
CONSTRAINT CT_shipment_CT_shipment_id_pk PRIMARY KEY (CT_shipment_id));

CREATE TABLE CT_shipment_line
(CT_shipment_id NUMBER(10), 
inv_id NUMBER(10),
ship_quantity NUMBER(4),
date_received DATE, 
CONSTRAINT CT_shipment_line_ship_id_fk FOREIGN KEY (CT_shipment_id) REFERENCES CT_shipment(CT_shipment_id),
CONSTRAINT CT_shipment_line_inv_id_fk FOREIGN KEY (inv_id) REFERENCES CT_inventory(inv_id),
CONSTRAINT ship_line_shipid_invid_pk PRIMARY KEY(CT_shipment_id, inv_id));

CREATE TABLE CT_order_line 
(order_id NUMBER(8), 
inv_id NUMBER(10), 
order_quantity NUMBER(4) NOT NULL,  
CONSTRAINT CT_ord_line_ord_id_fk FOREIGN KEY (order_id) REFERENCES CT_cust_order(order_id),
CONSTRAINT CT_ord_line_inv_id_fk FOREIGN KEY (inv_id) REFERENCES CT_inventory(inv_id),
CONSTRAINT CT_ord_line_ordid_invid_pk PRIMARY KEY (order_id, inv_id));


--- inserting records into CT_customer
INSERT INTO CT_customer VALUES
(107, 'Harris', 'Paula', 'E', '1156 Water Street, Apt. #3', 'Osseo', 'WI', 
'54705', '7155558943', '7155559035');

INSERT INTO CT_customer VALUES
(232, 'Edwards', 'Mitch', 'M', '4204 Garner Street', 'Washburn', 'WI', 
'54891', '7155558243', '7155556975');

INSERT INTO CT_customer VALUES
(133, 'Garcia', 'Maria', 'H', '2211 Pine Drive', 'Radisson', 'WI', 
'54867', '7155558332', '7155558332');

INSERT INTO CT_customer VALUES
(154, 'Miller', 'Lee', NULL, '699 Pluto St. NW', 'Silver Lake', 'WI', 
'53821', '7155554978', '7155559002');

INSERT INTO CT_customer VALUES
(179, 'Chang', 'Alissa', 'R', '987 Durham Rd.', 'Sister Bay', 'WI', 
'54234', '7155557651', '7155550087');

--- inserting records into CT_order_source
INSERT INTO CT_order_source VALUES (1, 'Winter 2002');
INSERT INTO CT_order_source VALUES (2, 'Spring 2003');
INSERT INTO CT_order_source VALUES (3, 'Summer 2003');
INSERT INTO CT_order_source VALUES (4, 'Outdoor 2003');
INSERT INTO CT_order_source VALUES (5, 'Children''s 2003');
INSERT INTO CT_order_source VALUES (6, 'Web Site');

--- inserting records into CT_cust_order
INSERT INTO CT_cust_order VALUES
(1057, TO_DATE('05/29/2003', 'MM/DD/YYYY'), 'CC', 107, 2);

INSERT INTO CT_cust_order VALUES
(1058, TO_DATE('05/29/2003', 'MM/DD/YYYY'), 'CC', 232, 6);

INSERT INTO CT_cust_order VALUES
(1059, TO_DATE('05/31/2003', 'MM/DD/YYYY'), 'CHECK', 133, 2);

INSERT INTO CT_cust_order VALUES
(1060, TO_DATE('05/31/2003', 'MM/DD/YYYY'), 'CC', 154, 3);

INSERT INTO CT_cust_order VALUES
(1061, TO_DATE('06/01/2003', 'MM/DD/YYYY'), 'CC', 179, 6);

INSERT INTO CT_cust_order VALUES
(1062, TO_DATE('06/01/2003', 'MM/DD/YYYY'), 'CC', 179, 3);

--- inserting records into CT_category
INSERT INTO CT_category VALUES (1, 'Women''s Clothing');
INSERT INTO CT_category VALUES (2, 'Children''s Clothing');
INSERT INTO CT_category VALUES (3, 'Men''s Clothing');
INSERT INTO CT_category VALUES (4, 'Outdoor Gear');

--- inserting records into CT_item
INSERT INTO CT_item VALUES
(894, 'Women''s Hiking Shorts', 1);

INSERT INTO CT_item VALUES
(897, 'Women''s Fleece Pullover', 1);

INSERT INTO CT_item VALUES
(995, 'Children''s Beachcomber Sandals', 2);

INSERT INTO CT_item VALUES
(559, 'Men''s Expedition Parka', 3);

INSERT INTO CT_item VALUES
(786, '3-Season Tent', 4);


--- inserting records into CT_color
INSERT INTO CT_color VALUES ('Sky Blue');
INSERT INTO CT_color VALUES ('Light Grey');
INSERT INTO CT_color VALUES ('Khaki');
INSERT INTO CT_color VALUES ('Navy');
INSERT INTO CT_color VALUES ('Royal');
INSERT INTO CT_color VALUES ('Eggplant');
INSERT INTO CT_color VALUES ('Blue');
INSERT INTO CT_color VALUES ('Red');
INSERT INTO CT_color VALUES ('Spruce');
INSERT INTO CT_color VALUES ('Turquoise');
INSERT INTO CT_color VALUES ('Bright Pink');

--- inserting records into CT_inventory
INSERT INTO CT_inventory VALUES
(11668, 786, NULL, 'Sky Blue', 259.99, 16);

INSERT INTO CT_inventory VALUES
(11669, 786, NULL, 'Light Grey', 259.99, 12);

INSERT INTO CT_inventory VALUES
(11775, 894, 'S', 'Khaki', 29.95, 150);

INSERT INTO CT_inventory VALUES
(11776, 894, 'M', 'Khaki', 29.95, 147);

INSERT INTO CT_inventory VALUES
(11777, 894, 'L', 'Khaki', 29.95, 0);

INSERT INTO CT_inventory VALUES
(11778, 894, 'S', 'Navy', 29.95, 139);

INSERT INTO CT_inventory VALUES
(11779, 894, 'M', 'Navy', 29.95, 137);

INSERT INTO CT_inventory VALUES
(11780, 894, 'L', 'Navy', 29.95, 115);

INSERT INTO CT_inventory VALUES
(11795, 897, 'S', 'Eggplant', 59.95, 135);

INSERT INTO CT_inventory VALUES
(11796, 897, 'M', 'Eggplant', 59.95, 168);

INSERT INTO CT_inventory VALUES
(11797, 897, 'L', 'Eggplant', 59.95, 187);

INSERT INTO CT_inventory VALUES
(11798, 897, 'S', 'Royal', 59.95, 0);

INSERT INTO CT_inventory VALUES
(11799, 897, 'M', 'Royal', 59.95, 124);

INSERT INTO CT_inventory VALUES
(11800, 897, 'L', 'Royal', 59.95, 112);

INSERT INTO CT_inventory VALUES
(11820, 995, '10', 'Turquoise', 15.99, 121);

INSERT INTO CT_inventory VALUES
(11821, 995, '11', 'Turquoise', 15.99, 111);

INSERT INTO CT_inventory VALUES
(11822, 995, '12', 'Turquoise', 15.99, 113);

INSERT INTO CT_inventory VALUES
(11823, 995, '1', 'Turquoise', 15.99, 121);

INSERT INTO CT_inventory VALUES
(11824, 995, '10', 'Bright Pink', 15.99, 148);

INSERT INTO CT_inventory VALUES
(11825, 995, '11', 'Bright Pink', 15.99, 137);

INSERT INTO CT_inventory VALUES
(11826, 995, '12', 'Bright Pink', 15.99, 134);

INSERT INTO CT_inventory VALUES
(11827, 995, '1', 'Bright Pink', 15.99, 123);

INSERT INTO CT_inventory VALUES
(11845, 559, 'S', 'Spruce', 199.95, 114);

INSERT INTO CT_inventory VALUES
(11846, 559, 'M', 'Spruce', 199.95, 17);

INSERT INTO CT_inventory VALUES
(11847, 559, 'L', 'Spruce', 209.95, 0);

INSERT INTO CT_inventory VALUES
(11848, 559, 'XL', 'Spruce', 209.95, 12);

--inserting records into CT_shipment

INSERT INTO CT_shipment VALUES
(211, TO_DATE('09/15/2003', 'MM/DD/YYYY'));

INSERT INTO CT_shipment VALUES
(212, TO_DATE('11/15/2003', 'MM/DD/YYYY'));

INSERT INTO CT_shipment VALUES
(213, TO_DATE('06/25/2003', 'MM/DD/YYYY'));

INSERT INTO CT_shipment VALUES
(214, TO_DATE('06/25/2003', 'MM/DD/YYYY'));

INSERT INTO CT_shipment VALUES
(215, TO_DATE('08/15/2003', 'MM/DD/YYYY'));

--inserting records into CT_shipment_LINE
INSERT INTO CT_shipment_line VALUES
(211, 11668, 25, TO_DATE('09/10/2003', 'MM/DD/YYYY'));

INSERT INTO CT_shipment_line VALUES
(211, 11669, 25, TO_DATE('09/10/2003', 'MM/DD/YYYY'));

INSERT INTO CT_shipment_line VALUES
(212, 11669, 25, NULL);

INSERT INTO CT_shipment_line VALUES
(213, 11777, 200, NULL);

INSERT INTO CT_shipment_line VALUES
(213, 11778, 200, NULL);

INSERT INTO CT_shipment_line VALUES
(213, 11779, 200, NULL);

INSERT INTO CT_shipment_line VALUES
(214, 11798, 100, TO_DATE('08/15/2003', 'MM/DD/YYYY'));

INSERT INTO CT_shipment_line VALUES
(214, 11799, 100, TO_DATE('08/25/2003', 'MM/DD/YYYY'));

INSERT INTO CT_shipment_line VALUES
(215, 11845, 50, TO_DATE('08/15/2003', 'MM/DD/YYYY'));

INSERT INTO CT_shipment_line VALUES
(215, 11846, 100, TO_DATE('08/15/2003', 'MM/DD/YYYY'));

INSERT INTO CT_shipment_line VALUES
(215, 11847, 100, TO_DATE('08/15/2003', 'MM/DD/YYYY'));

--- inserting records into CT_order_line
INSERT INTO CT_order_line VALUES (1057, 11668, 1);
INSERT INTO CT_order_line VALUES (1057, 11800, 2);
INSERT INTO CT_order_line VALUES (1058, 11824, 1);
INSERT INTO CT_order_line VALUES (1059, 11846, 1);
INSERT INTO CT_order_line VALUES (1059, 11848, 1);
INSERT INTO CT_order_line VALUES (1060, 11798, 2);
INSERT INTO CT_order_line VALUES (1061, 11779, 1);
INSERT INTO CT_order_line VALUES (1061, 11780, 1);
INSERT INTO CT_order_line VALUES (1062, 11799, 1);
INSERT INTO CT_order_line VALUES (1062, 11669, 3);

COMMIT;