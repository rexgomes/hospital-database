CREATE SCHEMA crownfielddb DEFAULT CHARACTER SET utf8mb4;
USE crownfielddb ;

CREATE TABLE patient (
  patient_id VARCHAR(45) NOT NULL primary key,
  patient_firstname VARCHAR(45) NOT NULL,
  patient_lastname VARCHAR(45) NOT NULL,
  postcode VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  phone VARCHAR(45) NOT NULL);

CREATE TABLE specialty (
  specialty_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  specialty_name VARCHAR(45) NOT NULL UNIQUE) ;

CREATE TABLE clinician (
  clinician_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  clinician_firstname VARCHAR(45) NOT NULL,
  clinician_lastname VARCHAR(45) NOT NULL,
  specialty_id INT NULL,
  CONSTRAINT FK_clinician_specialty
    FOREIGN KEY (specialty_id)
    REFERENCES specialty(specialty_id));

CREATE TABLE clinic (
  clinic_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  clinic_name VARCHAR(45) NOT NULL UNIQUE);

CREATE TABLE appointment (
  appointment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  patient_id VARCHAR(45) NULL,
  clinician_id INT NULL,
  clinic_id INT NULL,
  app_date date NOT NULL,
  app_time time NOT NULL,
  CONSTRAINT FK_patient_apt
    FOREIGN KEY (patient_id)
    REFERENCES patient (patient_id),
  CONSTRAINT FK_clinician_apt
    FOREIGN KEY (clinician_id)
    REFERENCES clinician (clinician_id),
  CONSTRAINT FK_clinic_apt
    FOREIGN KEY (clinic_id)
    REFERENCES clinic (clinic_id));

CREATE TABLE diagnosis (
  diagnosis_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  appointment_id INT NULL,
  diagnosis VARCHAR(45) NOT NULL,
  CONSTRAINT FK_diagnosis_apt
    FOREIGN KEY (appointment_id)
    REFERENCES appointment (appointment_id));

CREATE TABLE prescription (
  prescription_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  appointment_id INT NULL,
  CONSTRAINT FK_prescription_apt
    FOREIGN KEY (appointment_id)
    REFERENCES appointment (appointment_id));

CREATE TABLE medicines (
  medicine_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  prescription_id INT NOT NULL,
  medicine_name VARCHAR(45) NOT NULL,
  dose VARCHAR(45) NOT NULL,
  frequency VARCHAR(45) NOT NULL,
  duration VARCHAR(45) NOT NULL,
  CONSTRAINT FK_medicine_prescription
    FOREIGN KEY (prescription_id)
    REFERENCES prescription (prescription_id));

CREATE TABLE follow_up (
  followup_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  appointment_id INT NULL,
  due_date date NOT NULL,
  priority VARCHAR(45) NOT NULL,
  status VARCHAR(45) NOT NULL,
  notes VARCHAR(45) NULL,
  CONSTRAINT FK_followup_apt
    FOREIGN KEY (appointment_id)
    REFERENCES appointment (appointment_id));

ALTER TABLE clinician
ADD designation VARCHAR(45);

ALTER TABLE medicines
ADD route VARCHAR(45);

ALTER TABLE follow_up
MODIFY due_date VARCHAR(45),
DROP status;

INSERT INTO patient (patient_ID, patient_firstname, patient_lastname, Postcode, email, phone) VALUES
('OP001', 'Amina', 'Yusuf', 'NE1 4AB','amina@gmail.com', 07412345224),
('OP002', 'Daniel', 'Reed', 'N16 7QP', 'daniel@gmail.com' , 07389988023),
('OP003', 'Sofia', 'Bennett', 'E8 2LD', 'sofia@gmail.com', 0342422953),
('OP004', 'Michael', 'Okoro', 'SE6 3RT', 'micheal@gmail.com', 45647356356),
('OP005', 'Sarah', 'Jenkins', 'M1 2WD', 'sarah@gmail.com', 2342342332),
('OP006', 'James', 'Taylor', 'B1 1AA', 'james@gmail.com', 264565456756),
('OP007', 'Lucy', 'Nguyen', 'g2 8JQ' , 'lucy@gmail.com', 234252627),
('OP008', 'John', 'Smith', 'G1 1XQ', 'john@gmail.com', 234252685),
('OP009', 'Elena', 'Rossi', 'CF10 1EP', 'elena@gmail,com', 98347875364 ),
('OP010', 'Dwyane', 'Johnson', 'EH1 1YZ', 'dwayne@gmail.com', 32526574674),
('OP011', 'Aneesa', 'Ali', 'GS1 2AB', 'aneesa@gmail.com', 234234242),
('OP012', 'Ian', 'Wei', 'FB1 2CD', 'ian@gmail.com', 6757575675),
('OP013', 'Rachel', 'Brown', 'OX1 3EF', 'rachel@gmail.com', 322342332),
('OP014', 'Thomes', 'Green', 'CR1 4GH' ,'thomas@gmail.com', 98787787);


INSERT INTO specialty (specialty.specialty_name) VALUES ('Glaucoma'), ('Retina'), ('Cornea'), ('Cataract');

INSERT INTO Clinic (clinic_name) VALUES ('City Road'), ('Bedford'), ('Croydon');

INSERT INTO clinician (clinician_firstname, clinician_lastname, designation, specialty_id) VALUES
('Maya', 'Shah', 'Dr.', 1),
('Leo', 'Grant', 'Dr.', 2),
('Priya', 'Nair', 'Dr.', 3),
('Alan', 'Turing', 'Dr.', 4);

INSERT INTO Appointment (patient_id, clinician_id, clinic_id, app_date, app_time) VALUES
('OP001', 1, 1, '2026-10-05', '09:00:00'),
('OP002', 2, 1, '2026-10-05', '09:30:00'),
('OP001', 1, 2, '2026-11-16', '10:15:00'),
('OP003', 1, 1, '2026-10-06', '11:00:00'),
('OP004', 3, 3, '2026-10-07', '14:00:00');

INSERT INTO diagnosis (appointment_id, diagnosis) VALUES
(1, 'Ocular hypertension'),
(2, 'Diabetic macular oedema'),
(3, 'Ocular hypertension'),
(4, 'Glaucoma suspect'),
(5, 'Keratoconus');

INSERT INTO prescription (Appointment_ID) VALUES (1), (2), (3), (5);

INSERT INTO medicines (prescription_id, medicine_name, dose, route, frequency, duration) VALUES
(1, 'Latanoprost', '50 micrograms/ml', 'Eye Drop', 'Once daily', 'Continuous'),
(1, 'Timolol', '5 mg/ml', 'Eye Drop', 'Twice daily', 'Continuous'),
(2, 'Aflibercept', '2 mg', 'Intravitreal Injection', 'Once', 'Single Dose'),
(3, 'Latanoprost', '50 micrograms/ml', 'Eye Drop', 'Once daily', 'Continuous'),
(4, 'Sodium chloride drops', '5%', 'Eye Drop', 'Four times daily', '8 weeks');

INSERT INTO follow_Up (appointment_id, due_date, priority, Notes) VALUES
(1, '2026-11-16', 'High', 'Review IOP'),
(2, '2026-11-02', 'Urgent', 'OCT before review'),
(3, '2027-02-08', 'Routine', 'Visual field test'),
(4, '2027-04-06', 'Routine', 'Monitor'),
(5, '2026-12-02', 'Routine', 'Corneal topography');


