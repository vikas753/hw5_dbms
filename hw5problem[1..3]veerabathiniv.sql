/*******************************************************************************
   Drop database if it exists
********************************************************************************/
DROP DATABASE IF EXISTS `Perfect Pets`;


/*******************************************************************************
   Create database for Problem 1 and tables
********************************************************************************/
CREATE DATABASE `Perfect Pets`;

USE `Perfect Pets`;

CREATE TABLE IF NOT EXISTS clinics(
  `clinicNo` INT NOT NULL,
  `managerNo` INT NOT NULL ,
   PRIMARY KEY(clinicNo)
   );
   
CREATE TABLE IF NOT EXISTS Staff(
  `staffNo` INT NOT NULL,
  `clinicNo` INT NOT NULL ,
   PRIMARY KEY(staffNo),
   FOREIGN KEY(clinicNo) REFERENCES clinics(clinicNo)
   ON UPDATE RESTRICT ON DELETE RESTRICT
   );

CREATE TABLE IF NOT EXISTS ownerPet(
  `ownerNo` INT NOT NULL,
  PRIMARY KEY(ownerNo)
  );   
  
CREATE TABLE IF NOT EXISTS Pet(
  `petNo` INT NOT NULL,
  `clinicNo` INT NOT NULL ,
  `ownerNo` INT NOT NULL ,
   FOREIGN KEY(clinicNo) REFERENCES clinics(clinicNo)
   ON UPDATE RESTRICT ON DELETE RESTRICT,
   FOREIGN KEY(ownerNo) REFERENCES ownerPet(ownerNo)
   ON UPDATE RESTRICT ON DELETE RESTRICT,
   PRIMARY KEY(petNo)
   );  
   


CREATE TABLE IF NOT EXISTS Examinations(
  `examNo` INT NOT NULL,
  `staffNo` INT NOT NULL ,
  `petNo` INT NOT NULL ,
   FOREIGN KEY(staffNo) REFERENCES Staff(staffNo)
   ON UPDATE RESTRICT ON DELETE RESTRICT,
   FOREIGN KEY(petNo) REFERENCES Pet(ownerNo)
   ON UPDATE RESTRICT ON DELETE RESTRICT,
   PRIMARY KEY(examNo)
   );
 
CREATE TABLE IF NOT EXISTS TreatMents(
  `treatNo` INT NOT NULL,
  `examNo` INT NOT NULL ,
   FOREIGN KEY(examNo) REFERENCES Examinations(examNo)
   ON UPDATE RESTRICT ON DELETE RESTRICT,
   PRIMARY KEY(treatNo)
   );
 
 /*******************************************************************************
   Drop database if it exists
********************************************************************************/
DROP DATABASE IF EXISTS `Regional Council`;


/*******************************************************************************
   Create database for Problem 2 and tables
   Acronyms :  NIN - National Identification Number
   No : Number
   Name : First and Last Name
********************************************************************************/
CREATE DATABASE `Regional Council`;

USE `Regional Council`;

CREATE TABLE IF NOT EXISTS School(
  `School ID No` INT NOT NULL auto_increment,
  `Name` VARCHAR(200) NOT NULL,
  `Town` VARCHAR(200) NOT NULL,
  `Street` VARCHAR(200) NOT NULL,
  `Zipcode` INT NOT NULL,
  `Phone` VARCHAR(20) NOT NULL,
   PRIMARY KEY(`School ID No`)
   );
   
 CREATE TABLE IF NOT EXISTS Teacher(
  `Teacher NIN` INT NOT NULL,
  `Name` VARCHAR(200) NOT NULL,
  `Sex` VARCHAR(10) NOT NULL,
  `Qualifications` VARCHAR(200) NOT NULL,
  `School ID No` INT NOT NULL,
   PRIMARY KEY(`Teacher NIN`),
   FOREIGN KEY(`School ID No`) REFERENCES School(`School ID No`)
   ON UPDATE RESTRICT ON DELETE RESTRICT
   );  
   
 CREATE TABLE IF NOT EXISTS School_ManagingTeacher(
  `Managing Teacher NIN` INT NOT NULL,
  `School ID No` INT NOT NULL,
  `Start Date` TIMESTAMP NOT NULL,
  `End Date` TIMESTAMP NOT NULL,
  FOREIGN KEY(`School ID No`) REFERENCES School(`School ID No`)
  ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(`Managing Teacher NIN`) REFERENCES Teacher(`Teacher NIN`)
  ON UPDATE CASCADE ON DELETE CASCADE
  ); 

CREATE TABLE IF NOT EXISTS Pupil(
  `Pupil Id No` INT NOT NULL,
  `Name` VARCHAR(200) NOT NULL,
  `Sex` VARCHAR(10) NOT NULL,
  `Date of Birth` TIMESTAMP NOT NULL,
  `School ID No` INT NOT NULL,
   PRIMARY KEY(`Pupil Id No`),
   FOREIGN KEY(`School ID No`) REFERENCES School(`School ID No`)
   ON UPDATE RESTRICT ON DELETE RESTRICT
   );

CREATE TABLE IF NOT EXISTS Subjects(
  `Subject Id No` INT NOT NULL AUTO_INCREMENT,
  `Subject Title` VARCHAR(200) NOT NULL,
  `Subject Type`  VARCHAR(200) NOT NULL,
  `School ID No` INT NOT NULL,
   PRIMARY KEY(`Subject Id No`),
   FOREIGN KEY(`School ID No`) REFERENCES School(`School ID No`)
   ON UPDATE RESTRICT ON DELETE RESTRICT
   );
 
 CREATE TABLE IF NOT EXISTS PupilSubjects(
  `Pupil Id No` INT NOT NULL,
  `Subject ID` INT NOT NULL,
  FOREIGN KEY(`Pupil Id No`) REFERENCES Pupil(`Pupil Id No`)
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY(`Subject ID`) REFERENCES Subjects(`Subject Id No`)
  ON UPDATE RESTRICT ON DELETE RESTRICT
  ); 
 
 CREATE TABLE IF NOT EXISTS TeacherSubjects(
  `Teacher NIN` INT NOT NULL,
  `Subject Id No` INT NOT NULL,
  `Number of Hours` INT NOT NULL,
  FOREIGN KEY(`Teacher NIN`) REFERENCES Teacher(`Teacher NIN`)
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY(`Subject Id No`) REFERENCES Subjects(`Subject Id No`)
  ON UPDATE RESTRICT ON DELETE RESTRICT
  ); 
  
/*******************************************************************************
   Drop database if it exists
********************************************************************************/
DROP DATABASE IF EXISTS `BusyBee Cleaning Company`;


/*******************************************************************************
   Create database for Problem 3 and tables
   No : Number
********************************************************************************/
CREATE DATABASE `BusyBee Cleaning Company`;

USE `BusyBee Cleaning Company`;

CREATE TABLE IF NOT EXISTS `Client`(
  `Client No` INT NOT NULL auto_increment,
  `Requirements` VARCHAR(200) NOT NULL,
  `Name` VARCHAR(10) NOT NULL,
  `Cleaning Hours` INT NOT NULL,
  `Specialist Equipment` VARCHAR(200) NOT NULL,
  `ETA of Specialist Equipment` TIMESTAMP NOT NULL,
  PRIMARY KEY(`Client No`)
);  

CREATE TABLE IF NOT EXISTS CleaningStaff(
  `Staff ID` INT NOT NULL auto_increment,
  `Group No.` INT NOT NULL,
  `Client No` INT NOT NULL,
  PRIMARY KEY(`Staff ID`),
  FOREIGN KEY(`Client No`) REFERENCES `Client`(`Client No`)
  ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS AdministrativeStaff(
  `Staff ID` INT NOT NULL auto_increment,
  `Client No` INT NOT NULL,
  PRIMARY KEY(`Staff ID`),
  FOREIGN KEY(`Client No`) REFERENCES `Client`(`Client No`)
  ON UPDATE RESTRICT ON DELETE RESTRICT
);
  
CREATE TABLE IF NOT EXISTS CleaningSupervisor(
  `Staff ID` INT NOT NULL,
  `Group No` INT NOT NULL,
  `Client No` INT NOT NULL,
  FOREIGN KEY(`Staff ID`) REFERENCES CleaningStaff(`Staff ID`)
  ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY(`Client No`) REFERENCES `Client`(`Client No`)
  ON UPDATE RESTRICT ON DELETE RESTRICT
);
