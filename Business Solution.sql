/*
DROP TABLE POLICY;
DROP TABLE COVERAGE;
DROP TABLE POLICYCOVERAGE;
DROP TABLE VEHICLE;
DROP TABLE VEHICLECOVERAGE; 
DROP TABLE DRIVER;
DROP TABLE VEHICLEDRIVER;
DROP TABLE DRIVERADDRESS;
DROP TABLE CUSTOMERSUPPORT;
DROP TABLE BILL;
DROP TABLE PAYMENTDETAIL;
*/

CREATE TABLE POLICY (
                     PolicyID NUMBER(10) NOT NULL,
                     PolicyNumber VARCHAR(20) NOT NULL,
                     PolicyEffectiveDate DATE NOT NULL,
                     PolicyExpireDate DATE NOT NULL,
                     PaymentOption VARCHAR(100) NOT NULL,
                     TotalAmount NUMBER(10) NOT NULL,
                     AdditionalInfo VARCHAR(50) NOT NULL,
                     Active VARCHAR(20) NOT NULL,
                     CreatedDate DATE NOT NULL,
                     CONSTRAINT policy_pk PRIMARY KEY(PolicyID)
);

CREATE TABLE COVERAGE (
                       CoverageID NUMBER(10) NOT NULL,
                       CoverageName CHAR(100) NOT NULL,
                       CoverageGroup CHAR(50) NOT NULL,
                       Code VARCHAR(50) NOT NULL,
                       IsPolicyCoverage VARCHAR(20) NOT NULL,
                       IsVehicleCoverage VARCHAR(20) NOT NULL,
                       Descriptions VARCHAR(100),
                       CONSTRAINT coverage_pk PRIMARY KEY (CoverageID)
);

CREATE TABLE POLICYCOVERAGE (
                             PolicyCoverageID NUMBER(10) NOT NULL,
                             PolicyID NUMBER(10) NOT NULL,
                             CoverageID NUMBER(10) NOT NULL,
                             Active VARCHAR(20) NOT NULL,
                             CreatedDate DATE NOT NULL,
                             CONSTRAINT policycoverage_pk PRIMARY KEY (PolicyCoverageID),
                             CONSTRAINT policyid_fk FOREIGN KEY (PolicyID) REFERENCES POLICY (PolicyID),
                             CONSTRAINT coverageid_fk FOREIGN KEY (CoverageID) REFERENCES COVERAGE (CoverageID)
);

CREATE TABLE VEHICLE (
                       VehicleID NUMBER(10) NOT NULL,
                       PolicyID NUMBER(10) NOT NULL,
                       Trim VARCHAR(50), 
                       Color VARCHAR(50),
                       Model VARCHAR(50) NOT NULL,
                       Make VARCHAR(50) NOT NULL,
                       Mfg_year VARCHAR(50) NOT NULL,
                       Mileage NUMBER(10) NOT NULL,
                       VINNumber VARCHAR(50) NOT NULL,
                       VehicleNumberPlate VARCHAR(50) NOT NULL,
                       VehicleRegisteredState VARCHAR(50) NOT NULL,
                       CreatedDate DATE NOT NULL,
                       Active VARCHAR(20) NOT NULL,
                       CONSTRAINT vehicle_pk PRIMARY KEY (VehicleID),
                       CONSTRAINT vehiclepolicy_fk FOREIGN KEY(PolicyID) REFERENCES POLICY(PolicyID)                       
);

CREATE TABLE VEHICLECOVERAGE (
                       VehicleCoverageID NUMBER(10) NOT NULL,
                       VehicleID NUMBER(10) NOT NULL,
                       CoverageID NUMBER(10) NOT NULL,
                       Active VARCHAR(20) NOT NULL,
                       CreatedDate DATE NOT NULL,
                       CONSTRAINT vehiclecoverage_pk PRIMARY KEY (VehicleCoverageID),
                       CONSTRAINT vehicle_fk FOREIGN KEY(VehicleID) REFERENCES VEHICLE(VehicleID),
                       CONSTRAINT coverage_fk FOREIGN KEY(CoverageID) REFERENCES COVERAGE(CoverageID)
);

create table Driver(
                DriverID NUMBER(10) NOT NULL,
                PolicyID NUMBER(10) NOT NULL,
                FirstName varchar(50) NOT NULL,
                LastName varchar(50) NOT NULL,
                EmailAddress varchar(50),
                SSN varchar(12) NOT NULL,
                PhoneNumber varchar(50) NOT NULL,
                DOB date NOT NULL,
                LicenseIssueDate date NOT NULL,
                LicenseIssueState varchar(20) NOT NULL,
                LicenseNumber varchar(20) NOT NULL,
                IsPrimaryHolder VARCHAR(5) NOT NULL,
                RelationWithPrimaryHolder varchar(50) NOT NULL,
                Gender varchar(10),
                MaritalStatus varchar(20),
                CreatedDate date NOT NULL,
                Active VARCHAR(10) NOT NULL,
                CONSTRAINT Driver_pk PRIMARY KEY (DriverID),
                CONSTRAINT Driver_fk1 FOREIGN KEY (PolicyID) REFERENCES Policy(PolicyID)
);

create table VehicleDriver(
                        VehicleDriverID NUMBER(10) NOT NULL,
                        VehicleID NUMBER(10) NOT NULL,
                        DriverID NUMBER(10) NOT NULL, 	 
                        IsPrimaryDriver VARCHAR(5) NOT NULL,
                        Active VARCHAR(20) NOT NULL,
                        CreatedDate date NOT NULL,
                        CONSTRAINT VehicleDriver_pk PRIMARY KEY (VehicleDriverID), 
                        CONSTRAINT VehicleDriver_fk1 FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID),
                        CONSTRAINT VehicleDriver_fk2 FOREIGN KEY (DriverID) REFERENCES Driver(DriverID)
); 
    
create table DriverAddress(
                        DriverAddressID NUMBER(10) NOT NULL,
                        DriverID NUMBER(20) NOT NULL, 
                        Address varchar(100) NOT NULL,
                        City varchar(50) NOT NULL,
                        State varchar(50) NOT NULL,
                        Zipcode varchar(50) NOT NULL, 
                        Country varchar(50) NOT NULL, 
                        CONSTRAINT driveraddress_pk PRIMARY KEY (DriverAddressID), 
                        FOREIGN KEY (DriverID) REFERENCES Driver(DriverID)
); 


create table CustomerSupport(
                            SupportID VARCHAR(10) NOT NULL,
                            DriverID NUMBER(20) NOT NULL,
                            Grievance VARCHAR(100) NOT NULL,
                            Review VARCHAR(100) NOT NULL,
                            CreatedDate DATE NOT NULL,
                            PRIMARY KEY (SupportID),
                            FOREIGN KEY (DriverID)REFERENCES Driver(DriverID)
);

CREATE TABLE BILL(
                  BillID NUMBER(10) NOT NULL,
                  PolicyID NUMBER(10) NOT NULL,
                  MinimumPayment NUMBER(10) NOT NULL,
                  CreatedDate DATE NOT NULL,
                  Status VARCHAR(50) NOT NULL,
                  Balance NUMBER(10) NOT NULL,
                  CONSTRAINT bill_pk PRIMARY KEY(BillID),
                  CONSTRAINT bill_fk FOREIGN KEY(PolicyID)REFERENCES POLICY (PolicyID)
);

CREATE TABLE PAYMENTDETAIL(
                           PaymentID NUMBER(10) NOT NULL,
                           BillID NUMBER(10) NOT NULL,
                           PaidDate DATE NOT NULL,
                           Amount NUMBER(10) NOT NULL,
                           PaymentMethod VARCHAR(100) NOT NULL,
                           PayerFirstName VARCHAR(50) NOT NULL,
                           CardNumber VARCHAR(50),
                           ZipCode VARCHAR(10),
                           CardExpiredDate DATE,
                           CardType VARCHAR(20),
                           BankName VARCHAR(100),
                           AccountNumber VARCHAR(20),
                           RoutingNumber VARCHAR(20),
                           CreatedDate DATE NOT NULL,
                           CheckNumber VARCHAR(20),
                           CheckImage VARCHAR(10),
                           Comments VARCHAR(100),
                           CONSTRAINT paymentdetail_pk PRIMARY KEY(PaymentID),
                           CONSTRAINT paymentdetail_fk FOREIGN KEY(BillID) REFERENCES BILL(BillID)
);



INSERT INTO POLICY VALUES(100247,'ABC21',TO_DATE('08-30-2021','MM-DD-YYYY'),TO_DATE('08-29-2022','MM-DD-YYYY'),'Credit Card',5000,'Penalty of $50 for every late payment','Active',TO_DATE('08-01-2021','MM-DD-YYYY'));
INSERT INTO POLICY VALUES(100248,'AF2021',TO_DATE('01-01-2021','MM-DD-YYYY'),TO_DATE('12-31-2021','MM-DD-YYYY'),'Debit Card',4881,'Penalty of $18 for every late payment','Active',TO_DATE('01-01-2021','MM-DD-YYYY'));
INSERT INTO POLICY VALUES(100249,'BED22',TO_DATE('01-01-2021','MM-DD-YYYY'),TO_DATE('12-31-2022','MM-DD-YYYY'),'Internet Banking',9899,'Penalty of $20 for every late payment','Active',TO_DATE('01-01-2021','MM-DD-YYYY'));
INSERT INTO POLICY VALUES(100250,'IIFA21',TO_DATE('02-01-2021','MM-DD-YYYY'),TO_DATE('07-31-2022','MM-DD-YYYY'),'Credit Card',6500,'Penalty of $50 for every late payment','Active',TO_DATE('01-01-2021','MM-DD-YYYY'));
INSERT INTO POLICY VALUES(100251,'ROS11',TO_DATE('08-30-2020','MM-DD-YYYY'),TO_DATE('08-29-2021','MM-DD-YYYY'),'Credit Card',5000,'Penalty of $50 for every late payment','Expired',TO_DATE('08-01-2020','MM-DD-YYYY'));
INSERT INTO POLICY VALUES(100252,'AF2020',TO_DATE('01-01-2020','MM-DD-YYYY'),TO_DATE('12-31-2020','MM-DD-YYYY'),'Credit Card',5000,'Penalty of $50 for every late payment','Expired',TO_DATE('01-01-2020','MM-DD-YYYY'));
INSERT INTO POLICY VALUES(100253,'XYA1',TO_DATE('03-30-2018','MM-DD-YYYY'),TO_DATE('03-29-2019','MM-DD-YYYY'),'Internet Banking',5000,'Penalty of $50 for every late payment','Expired',TO_DATE('03-01-2018','MM-DD-YYYY'));
INSERT INTO POLICY VALUES(100254,'ZC45',TO_DATE('08-30-2017','MM-DD-YYYY'),TO_DATE('08-29-2018','MM-DD-YYYY'),'Credit Card',5000,'Penalty of $21 for every late payment','Expired',TO_DATE('08-01-2017','MM-DD-YYYY'));
INSERT INTO POLICY VALUES(100255,'IFK81',TO_DATE('07-01-2021','MM-DD-YYYY'),TO_DATE('12-31-021','MM-DD-YYYY'),'Debit Card',2500,'Penalty of $14 for every late payment','Active',TO_DATE('06-25-2021','MM-DD-YYYY'));
INSERT INTO POLICY VALUES(100256,'BUS23',TO_DATE('01-01-2022','MM-DD-YYYY'),TO_DATE('12-31-2023','MM-DD-YYYY'),'Credit Card',13498,'Penalty of $72 for every late payment','Upcoming',TO_DATE('08-01-2021','MM-DD-YYYY'));
INSERT INTO POLICY VALUES(100257,'CAS45',TO_DATE('01-01-2022','MM-DD-YYYY'),TO_DATE('12-31-2022','MM-DD-YYYY'),'Internet Banking',6199,'Penalty of $49 for every late payment','Upcoming',TO_DATE('07-20-2021','MM-DD-YYYY'));


INSERT INTO COVERAGE VALUES (011,'Property Damage Liability 25000/50000','Damage',01,'YES','NO','Covers damages for amount upto $25000');
INSERT INTO COVERAGE VALUES (012,'Property Damage Liability 100000/300000','Damage',01,'YES','NO','NA');
INSERT INTO COVERAGE VALUES (013,'Collision 20000/50000','Collision',02,'YES','YES','NA');
INSERT INTO COVERAGE VALUES (014,'Personal Injury Protection 59999/120000','Medical',03,'YES','NO','Refer policy details for claim process');
INSERT INTO COVERAGE VALUES (015,'Property Injury Protection','Medical',03,'YES','NO','NA');
INSERT INTO COVERAGE VALUES (016,'Uninsured Motorist','Insurance',04,'YES','YES','For those without insurance');
INSERT INTO COVERAGE VALUES (017,'Underinsured Motorist','Insurance',04,'YES','YES','For those without adequate inusrance');
INSERT INTO COVERAGE VALUES (018,'Bodily Injury Liability','Medical',03,'YES','NO','NA');
INSERT INTO COVERAGE VALUES (019,'Medical Payments','Medical',03,'YES','NO','NA');
INSERT INTO COVERAGE VALUES (020,'Comprehensive 25000/50000','Damage',01,'YES','YES','NA');


INSERT INTO POLICYCOVERAGE VALUES (12011,100247,011,'Active',TO_DATE('08-01-2021','MM-DD-YYYY'));
INSERT INTO POLICYCOVERAGE VALUES (12012,100248,012,'Expired',TO_DATE('01-01-2020','MM-DD-YYYY'));
INSERT INTO POLICYCOVERAGE VALUES (12013,100249,013,'Active',TO_DATE('01-01-2021','MM-DD-YYYY'));
INSERT INTO POLICYCOVERAGE VALUES (12044,100250,014,'Active',TO_DATE('01-01-2021','MM-DD-YYYY'));
INSERT INTO POLICYCOVERAGE VALUES (12045,100251,015,'Expired',TO_DATE('08-01-2020','MM-DD-YYYY'));
INSERT INTO POLICYCOVERAGE VALUES (12046,100252,016,'Expired',TO_DATE('01-01-2020','MM-DD-YYYY'));
INSERT INTO POLICYCOVERAGE VALUES (12047,100253,017,'Expired',TO_DATE('03-01-2018','MM-DD-YYYY'));
INSERT INTO POLICYCOVERAGE VALUES (12048,100254,018,'Expired',TO_DATE('08-01-2017','MM-DD-YYYY'));
INSERT INTO POLICYCOVERAGE VALUES (12019,100255,019,'Active',TO_DATE('06-25-2021','MM-DD-YYYY'));
INSERT INTO POLICYCOVERAGE VALUES (12020,100256,020,'Upcoming',TO_DATE('08-01-2021','MM-DD-YYYY'));
INSERT INTO POLICYCOVERAGE VALUES (12021,100257,016,'Upcoming',TO_DATE('07-20-2021','MM-DD-YYYY'));
INSERT INTO POLICYCOVERAGE VALUES (12022,100257,014,'Upcoming',TO_DATE('07-20-2021','MM-DD-YYYY'));


INSERT INTO VEHICLE VALUES (880001,100247,'X1','Blue','A7','Audi','1996',15000,'XYA2100789','AYB 0487','Illinois',TO_DATE('08-21-1996','MM-DD-YYYY'),'Active');
INSERT INTO VEHICLE VALUES (880002,100248,'Y1','Red','A2','Audi','2001',10000,'XBA2100790','BYA 0487','Chiacgo',TO_DATE('12-21-2001','MM-DD-YYYY'),'Active');
INSERT INTO VEHICLE VALUES (880003,100249,'Z1','Blue','C1','Honda','2000',10500,'AAA2100791','XXX 0488','Florida',TO_DATE('09-21-2000','MM-DD-YYYY'),'Active');
INSERT INTO VEHICLE VALUES (880004,100250,'A1','Blue','C4','Honda','1999',18000,'YYA2100792','AYB 0477','Michigan',TO_DATE('05-02-1999','MM-DD-YYYY'),'Active');
INSERT INTO VEHICLE VALUES (880005,100251,'B1','Green','C2','Honda','1990',20000,'XYA2100793','ABB 0497','Indianapolis',TO_DATE('05-21-1990','MM-DD-YYYY'),'Active');
INSERT INTO VEHICLE VALUES (880006,100252,'C1','Yellow','A3','Audi','1991',16000,'ABC2100794','AYB 0997','Illinois',TO_DATE('03-12-1991','MM-DD-YYYY'),'Active');
INSERT INTO VEHICLE VALUES (880007,100253,'D1','Blue','A1','Audi','1992',21000,'XYA2100795','OOB 0987','Michigan',TO_DATE('08-12-1992','MM-DD-YYYY'),'Active');
INSERT INTO VEHICLE VALUES (880008,100254,'E1','Black','F1','Ford','1994',20000,'POK2100796','AYB 0480','Michigan',TO_DATE('02-01-1994','MM-DD-YYYY'),'Active');
INSERT INTO VEHICLE VALUES (880009,100255,'F1','Blue','F3','Ford','1996',10000,'LOK2100797','AYH 0407','Michigan',TO_DATE('09-05-1996','MM-DD-YYYY'),'Active');
INSERT INTO VEHICLE VALUES (880010,100256,'F1','Black','F3','Ford','1996',12000,'XYA21007898','YUB 4087','Illinois',TO_DATE('12-05-1996','MM-DD-YYYY'),'Active');


INSERT INTO VEHICLECOVERAGE VALUES (0001,880001,011,'Active',TO_DATE('02-01-2008', 'MM-DD-YYYY'));  
INSERT INTO VEHICLECOVERAGE VALUES (0002,880002,012,'Active',TO_DATE('02-01-2009', 'MM-DD-YYYY'));
INSERT INTO VEHICLECOVERAGE VALUES (0003,880003,013,'Active',TO_DATE('02-21-2008', 'MM-DD-YYYY'));
INSERT INTO VEHICLECOVERAGE VALUES (0004,880004,014,'Active',TO_DATE('12-01-2005', 'MM-DD-YYYY'));
INSERT INTO VEHICLECOVERAGE VALUES (0005,880005,015,'Active',TO_DATE('03-03-2008', 'MM-DD-YYYY'));
INSERT INTO VEHICLECOVERAGE VALUES (0006,880006,016,'Expired',TO_DATE('02-01-2009', 'MM-DD-YYYY'));
INSERT INTO VEHICLECOVERAGE VALUES (0007,880007,017,'Active',TO_DATE('02-10-2004', 'MM-DD-YYYY'));
INSERT INTO VEHICLECOVERAGE VALUES (0008,880008,018,'Active',TO_DATE('10-01-2008', 'MM-DD-YYYY'));
INSERT INTO VEHICLECOVERAGE VALUES (0009,880009,019,'Active',TO_DATE('02-10-2008', 'MM-DD-YYYY'));
INSERT INTO VEHICLECOVERAGE VALUES (0010,880010,020,'Upcoming',TO_DATE('02-01-2010', 'MM-DD-YYYY'));


INSERT INTO DRIVER VALUES(0001, 100247 , 'James', 'Conor', 'jc12@gmail.com', '647284627462', '4567657644', TO_DATE('08-30-1995','MM-DD-YYYY'), TO_DATE('04-02-2014','MM-DD-YYYY'),'Arizona', 'HG7653','Yes', 'NA', 'Male', 'Single', TO_DATE('05-14-2018','MM-DD-YYYY'),'Yes');
INSERT INTO DRIVER VALUES(0002, 100248 , 'Hailey', 'Mason', 'Haily2@gmail.com', '746284674622', '45756298454', TO_DATE('02-12-1994','MM-DD-YYYY'), TO_DATE('07-17-2017','MM-DD-YYYY'),'New Jersey', 'HY7645','No', 'Daughter', 'Female', 'Single', TO_DATE('02-18-2017','MM-DD-YYYY'),'Yes');
INSERT INTO DRIVER VALUES(0003, 100249 , 'Michael', 'Philips', 'M_phil@outlook.com', '657484746352', '7563657864', TO_DATE('03-18-1997','MM-DD-YYYY'), TO_DATE('04-22-2015','MM-DD-YYYY'),'California', 'JB6453','Yes', 'NA', 'Male', 'Married', TO_DATE('09-22-2018','MM-DD-YYYY'),'Yes');
INSERT INTO DRIVER VALUES(0004, 100250 , 'Paul', 'Kutcher', 'Paul32@gmail.com', '612284746254', '6562757641', TO_DATE('07-12-1996','MM-DD-YYYY'), TO_DATE('02-15-2016','MM-DD-YYYY'),'Washington', 'GE7233','No', 'Son', 'Male', 'Single', TO_DATE('08-12-2018','MM-DD-YYYY'),'Yes');
INSERT INTO DRIVER VALUES(0005, 100251 , 'Anna', 'Watson', 'Anna_W@yahoo.com', '647284654382', '4574727612', TO_DATE('01-23-1992','MM-DD-YYYY'), TO_DATE('03-25-2014','MM-DD-YYYY'),'Connecticut', 'KI8573','Yes', 'NA', 'Female', 'Single', TO_DATE('11-14-2017','MM-DD-YYYY'),'Yes');
INSERT INTO DRIVER VALUES(0006, 100252 , 'Jason', 'Bateman', 'JB_21@gmail.com', '75628910941', '456794997', TO_DATE('08-18-1996','MM-DD-YYYY'), TO_DATE('04-16-2014','MM-DD-YYYY'),'NewYork', 'WR3453','No', 'NA', 'Male', 'Single', TO_DATE('05-14-2017','MM-DD-YYYY'),'Yes');
INSERT INTO DRIVER VALUES(0007, 100253 , 'Kim', 'Bowen', 'Kim_Next@gmail.com', '337429847424', '7867657698', TO_DATE('04-23-1991','MM-DD-YYYY'), TO_DATE('05-08-2017','MM-DD-YYYY'),'Michigan', 'NV7562','Yes', 'NA', 'Female', 'Married', TO_DATE('12-14-2018','MM-DD-YYYY'),'No');
INSERT INTO DRIVER VALUES(0008, 100254 , 'Meghan', 'Hampton', 'Megzz@outlook.com', '991356274323', '1767657123', TO_DATE('09-30-1992','MM-DD-YYYY'), TO_DATE('06-02-2015','MM-DD-YYYY'),'Virginia', 'PW2345','No', 'Wife', 'Female', 'Single', TO_DATE('03-14-2016','MM-DD-YYYY'),'Yes');
INSERT INTO DRIVER VALUES(0009, 100255 , 'Laura', 'Vesco', 'Lauprof@gmail.com', '173284671974', '7543657649', TO_DATE('11-13-1995','MM-DD-YYYY'), TO_DATE('08-09-2016','MM-DD-YYYY'),'Arizona', 'AD6452','Yes', 'NA', 'Female', 'Married', TO_DATE('08-14-2016','MM-DD-YYYY'),'Yes');
INSERT INTO DRIVER VALUES(0010, 100256 , 'Kaitlyn', 'Helmes', 'Kate98@gmail.com', '125446278733', '9457657612', TO_DATE('12-18-1992','MM-DD-YYYY'), TO_DATE('12-19-2017','MM-DD-YYYY'),'NewYork', 'CR2375','No', 'Daughter', 'Female', 'Single', TO_DATE('09-14-2018','MM-DD-YYYY'),'No');


INSERT INTO VEHICLEDRIVER VALUES(199001,880001, 0001, 'Yes', 'Active', TO_DATE('07-24-2012','MM-DD-YYYY'));
INSERT INTO VEHICLEDRIVER VALUES(199002,880002, 0002, 'Yes', 'Active', TO_DATE('03-13-2017','MM-DD-YYYY'));
INSERT INTO VEHICLEDRIVER VALUES(199003,880003, 0003, 'No', 'Active', TO_DATE('09-04-2015','MM-DD-YYYY'));
INSERT INTO VEHICLEDRIVER VALUES(199004,880004, 0004, 'Yes', 'Expired', TO_DATE('11-21-2016','MM-DD-YYYY'));
INSERT INTO VEHICLEDRIVER VALUES(199005,880005, 0005, 'No', 'Expired', TO_DATE('04-18-2017','MM-DD-YYYY'));
INSERT INTO VEHICLEDRIVER VALUES(19006,880006, 0006, 'Yes', 'Active', TO_DATE('12-11-2018','MM-DD-YYYY'));
INSERT INTO VEHICLEDRIVER VALUES(19007,880007, 0007, 'No', 'Active', TO_DATE('12-03-2016','MM-DD-YYYY'));
INSERT INTO VEHICLEDRIVER VALUES(19008,880008, 0008, 'Yes', 'Active', TO_DATE('06-20-2017','MM-DD-YYYY'));
INSERT INTO VEHICLEDRIVER VALUES(19009,880009, 0009, 'No', 'Active', TO_DATE('08-08-2018','MM-DD-YYYY'));
INSERT INTO VEHICLEDRIVER VALUES(19010,880010, 0010, 'Yes', 'Active', TO_DATE('07-14-2019','MM-DD-YYYY'));


INSERT INTO DriverAddress VALUES (8817101,0001, '95 Morgan ST', 'Stamford', 'Connecticut', '06905', 'United States');
INSERT INTO DriverAddress VALUES (8817102,0002, '85 Morgan ST', 'Stamford', 'Connecticut', '06905', 'United States');
INSERT INTO DriverAddress VALUES (8817103, 0003, 'Hoytt', 'Stamford', 'Connecticut', '06906', 'United States');
INSERT INTO DriverAddress VALUES (8817104, 0004, '85 Indian Street', 'Jersey City', 'New Jersey', '07097', 'United States');
INSERT INTO DriverAddress VALUES (8817105, 0005, '85 S MAIN', 'LOS ANGELES', 'California', '90003', 'United States');
INSERT INTO DriverAddress VALUES (8817106, 0006, '100 N MCCADDEN', 'LOS ANGELES', 'California', '90004', 'United States');
INSERT INTO DriverAddress VALUES (8817107, 0007, '2821 Sardis Sta', 'Grand Prairie', 'Texas', '75051', 'United States');
INSERT INTO DriverAddress VALUES (8817108, 0008, '2794 Cantebury Drive', 'New York', 'New York', '10003', 'United States');
INSERT INTO DriverAddress VALUES (8817109, 0009, '1953 Ferry Street', 'Florence', 'Alabama', '35630', 'United States');
INSERT INTO DriverAddress VALUES (8817110, 0010, '5048 Benson Park Drive', 'Oklahoma City', 'Oklahoma', '73129', 'United States');

INSERT INTO CustomerSupport VALUES (7354170001, 0001, 'Not Satisfied', 'Support Not able to answer properly',TO_DATE('07-24-2012','MM-DD-YYYY') );
INSERT INTO CustomerSupport VALUES (7354170002, 0002, 'Not Satisfied', 'NA',TO_DATE('05-28-2014','MM-DD-YYYY') );
INSERT INTO CustomerSupport VALUES (7354170003, 0003, 'Satisfied', 'Good Service',TO_DATE('03-14-2012','MM-DD-YYYY') );
INSERT INTO CustomerSupport VALUES (7354170004, 0004, 'Satisfied', 'NA',TO_DATE('01-05-2011','MM-DD-YYYY') );
INSERT INTO CustomerSupport VALUES (7354170005, 0005, 'Very Satisfied', 'excellent',TO_DATE('08-23-2013','MM-DD-YYYY') );
INSERT INTO CustomerSupport Values (7354170006, 0006, 'Not Satisfied', 'Bad Serivice',TO_DATE('07-07-2017','MM-DD-YYYY') );
INSERT INTO CustomerSupport VALUES (7354170007, 0007, 'Very Satisfied', 'excellent',TO_DATE('03-02-2012','MM-DD-YYYY') );
INSERT INTO CustomerSupport VALUES (7354170008, 0008, 'Not Satisfied', 'excellent',TO_DATE('05-08-2013','MM-DD-YYYY') );
INSERT INTO CustomerSupport VALUES (7354170009, 0009, 'On Long Hold', 'Very Poor Service',TO_DATE('12-12-2013','MM-DD-YYYY') );
INSERT INTO CustomerSupport VALUES (7354170010, 0010, 'NA', 'NA',TO_DATE('08-23-2013','MM-DD-YYYY') );


INSERT INTO BILL VALUES(11101,100247,500,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',345);
INSERT INTO BILL VALUES(11102,100247,1000,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',0);
INSERT INTO BILL VALUES(11103,100248,2020,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',0);
INSERT INTO BILL VALUES(11104,100248,5000,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',380);
INSERT INTO BILL VALUES(11105,100248,400,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',10);
INSERT INTO BILL VALUES(11106,100249,3000,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',7);
INSERT INTO BILL VALUES(11107,100250,1500,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',0);
INSERT INTO BILL VALUES(11108,100251,5600,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',9);
INSERT INTO BILL VALUES(11109,100252,5009,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',120);
INSERT INTO BILL VALUES(11110,100253,1221,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',200);
INSERT INTO BILL VALUES(11111,100254,359,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',4000);
INSERT INTO BILL VALUES(11112,100255,290,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',200);
INSERT INTO BILL VALUES(11113,100256,123,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',190);
INSERT INTO BILL VALUES(11114,100257,190,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',20);
INSERT INTO BILL VALUES(11115,100257,101,TO_DATE('12-03-2021','MM-DD-YYYY'),'Paid',10);



INSERT INTO PAYMENTDETAIL VALUES(101,11101,TO_DATE('12-03-2020','MM-DD-YYYY'),3000,'CASH','James','4270-4890-5567-3320','06902',TO_DATE('08-23-2023','MM-DD-YYYY'),'American Express','BOFA','1234ABC12','989009',TO_DATE('09-08-2021','MM-DD-YYYY'),'ABC','ABC','Done');
INSERT INTO PAYMENTDETAIL VALUES(102,11102,TO_DATE('12-03-2020','MM-DD-YYYY'),2000,'DEBIT','Hailey','3350-2290-8890-7890','06905',TO_DATE('09-23-2022','MM-DD-YYYY'),'American Express','BOFA','3890CB','1234567890',TO_DATE('12-03-2020','MM-DD-YYYY'),'X08','0O9','Done');
INSERT INTO PAYMENTDETAIL VALUES(103,11103,TO_DATE('11-12-2021','MM-DD-YYYY'),3500,'CREDIT','Mike','2234-9008-2202-1234','06907',TO_DATE('12-23-2025','MM-DD-YYYY'),'VISA','BOFA','2345RT','33445545',TO_DATE('09-08-2021','MM-DD-YYYY'),'MKL','G7J','Done');
INSERT INTO PAYMENTDETAIL VALUES(104,11104,TO_DATE('12-03-2021','MM-DD-YYYY'),5000,'CASH','Paul','2234-5690-7890-4567','06908',TO_DATE('05-23-2023','MM-DD-YYYY'),'MASTER CARD','CHASE','6098UB','678768678',TO_DATE('07-03-2018','MM-DD-YYYY'),'DDD','J8K','Done');
INSERT INTO PAYMENTDETAIL VALUES(105,11105,TO_DATE('02-04-2001','MM-DD-YYYY'),7800,'DEBIT','Laura','9089-1234-9087-1209','06909',TO_DATE('12-23-2021','MM-DD-YYYY'),'MASTER CARD','CHASE','334590P','34325436',TO_DATE('02-04-2019','MM-DD-YYYY'),'ZXE','J9L','NA');
INSERT INTO PAYMENTDETAIL VALUES(106,11106,TO_DATE('03-05-2012','MM-DD-YYYY'),2500,'CREDIT','Anna','3456-9012-3245-9009','06907',TO_DATE('04-21-2024','MM-DD-YYYY'),'American Express','BOFA','ABC123','353467',TO_DATE('07-08-2021','MM-DD-YYYY'),'SDS','D7J','Done');
INSERT INTO PAYMENTDETAIL VALUES(107,11107,TO_DATE('04-03-2019','MM-DD-YYYY'),900,'DEBIT','Kaitlyn','9012-8901-7890-9012','06902',TO_DATE('12-23-2023','MM-DD-YYYY'),'American Express','CANARA','A123BCM','12312345',TO_DATE('12-12-2020','MM-DD-YYYY'),'GEG','S9K','Incomplete');
INSERT INTO PAYMENTDETAIL VALUES(108,11108,TO_DATE('09-09-2018','MM-DD-YYYY'),1200,'DEBIT','Micheal','1221-1023-2323-2323','06908',TO_DATE('11-17-2027','MM-DD-YYYY'),'American Express','CANARA','90SDFWFE','5986340',TO_DATE('09-18-2020','MM-DD-YYYY'),'DGF','A9L','Done');
INSERT INTO PAYMENTDETAIL VALUES(109,11109,TO_DATE('11-12-2020','MM-DD-YYYY'),1800,'DEBIT','Jenny','1213-2467-2356-2349','06907',TO_DATE('07-20-2023','MM-DD-YYYY'),'VISA','CNBC','32325DFE','2487334',TO_DATE('07-02-2021','MM-DD-YYYY'),'0O9','W3K','NA');
INSERT INTO PAYMENTDETAIL VALUES(110,11110,TO_DATE('06-03-2021','MM-DD-YYYY'),9000,'DEBIT','Kail','1209-4444-2390-7865','06907',TO_DATE('06-19-2023','MM-DD-YYYY'),'American Express','BOFA','544FERF','43974835',TO_DATE('03-29-2021','MM-DD-YYYY'),'WFR','EHW','Done');


/*
Business Problem - 1
When a customer approaches our insurance agent to request for a new or updated policy, it is good business sense to show them a template in which they can contrast and compare policies on their own. As customers are mostly concerned about the pricing of the policies, this report helps the agent in quickly zeroing down to what best price scenario or rates will be accepted by the customer. As there are many variables pertaining to picking an insurance policy, the best way to tackle this is to divide and conquer the different factors according to what a customer is looking for. This helps in automating the recommendation process.

*/

SELECT MAKE,MODEL,AVG(Mileage),MIN(MinimumPayment) as "Expected Cost of Policy" FROM
VEHICLE
JOIN BILL ON BILL.POLICYID = VEHICLE.POLICYID
GROUP BY MAKE,MODEL;


/*
Business Problem - 2
When recommending an insurance plan, it also serves for the system to know which insurance companies and plans are more popular among customers. Popularity could mean many things like the customers are satisfied with the service or they have no complaints even after constant use. Using this report, we can judge which type of insurances are most customers preferring so that we can recommend the same to new customers. This will ensure that more and more customers will be badged to agreeable plans; which will in turn help in boosting the profits of the agents.

*/

SELECT CoverageName,CoverageGroup,count(DriverID) as "Policy Holders" FROM COVERAGE
JOIN POLICYCOVERAGE ON POLICYCOVERAGE.COVERAGEID = COVERAGE.COVERAGEID
JOIN DRIVER ON DRIVER.POLICYID = POLICYCOVERAGE.POLICYID
GROUP BY COVERAGENAME,COVERAGEGROUP
ORDER BY COUNT(DRIVERID) DESC;


/*
Business Problem - 3
The system needs inputs keyed in to generate recommendations. One of such inputs we can give the system is how well an insurance policy or the provider is working. Grievance redressal is an important part of any sales operation, so it is crucial to not let down customers in the starting stages of trust. By comparing and contrasting which companies and policies have high grievances, we can choose to eliminate those companies from our recommendations that are prone to negative feedback. This will go a long way in helping the company maintain the trust and loyalty of its customers.

*/

SELECT COVERAGENAME,COVERAGEGROUP,COUNT(GRIEVANCE) FROM
CUSTOMERSUPPORT
JOIN DRIVER ON DRIVER.DRIVERID = CUSTOMERSUPPORT.DRIVERID
JOIN POLICYCOVERAGE ON POLICYCOVERAGE.POLICYID = DRIVER.POLICYID
JOIN COVERAGE ON COVERAGE.COVERAGEID = POLICYCOVERAGE.COVERAGEID
GROUP BY COVERAGENAME,COVERAGEGROUP
ORDER BY COUNT(GRIEVANCE) DESC;

/*
Business Problem - 4
A major flaw of the process before correction was that there was a lot of time draining for the customers. This is usually the case when there is less automation among the processes. For the payment process, something as simple as the credit card charges that companies bill their customers was going through manual calculations before the system is put in place. This report reveals how the whole payment process from the generation of the bill to dropping the charges to the customer is automated. This will save a lot of time and effort for the company

*/

SELECT PAYMENTID,BILLID,
CASE UPPER(PAYMENTMETHOD) WHEN 'CASH' THEN AMOUNT
WHEN 'DEBIT' THEN AMOUNT + 0.1 * AMOUNT
WHEN 'CREDIT' THEN AMOUNT + 0.2 * AMOUNT
END AS "AMOUNT TO BE PAID"
FROM PAYMENTDETAIL;

/*
Business Problem - 5
Automating a business process only works when we deal with every step of the process. If there is delay at any step, then the whole process is thrown into jeopardy. Another step that we can automate is to check which policies are expiring soon and notify the customers about them. This will ensure that the customers will pay their dues on time and the company will not have to wait around or suffer incomplete payments.

*/

SELECT DriverID, FirstName, LastName, PolicyID From DRIVER
WHERE POLICYID = ANY (
SELECT PolicyID FROM POLICY WHERE CEIL((POLICYEXPIREDATE-SYSDATE)/30)=1) ;


