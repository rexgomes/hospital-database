-- 1. Aggregate Query using GROUP BY and HAVING
-- Which clinicians have conducted 2 or more appointments?

SELECT
    c.designation, c.clinician_firstname, c.clinician_lastname,
    COUNT(a.appointment_id) AS Total_Appointments
FROM clinician c
JOIN appointment a ON c.clinician_id = a.clinician_id
GROUP BY c.clinician_id
HAVING COUNT(a.appointment_id) >= 2;

-- 2. INNER JOIN across at least three related tables
-- Appointment details
SELECT
    a.app_date,
    a.app_time,
    p.patient_firstname,
    p.patient_lastname,
    c.clinic_name
FROM appointment a
INNER JOIN Patient p ON a.patient_id = p.patient_id
INNER JOIN clinic c ON a.clinic_id = c.Clinic_id
ORDER BY a.app_date ASC;

-- 3. LEFT JOIN revealing missing or optional related data
-- Appointment with no prescription
SELECT
    a.appointment_id,
    a.app_date,
    p.patient_firstname,
    p.patient_lastname
FROM appointment a
INNER JOIN patient p ON a.patient_id = p.patient_id
LEFT JOIN prescription pr ON a.appointment_id = pr.appointment_id
WHERE pr.prescription_id IS NULL;

-- 4. Subquery or Common Table Expression
-- List names and postcode of patients who was prescribed Latanoprost
SELECT
    patient_firstname,
    patient_lastname,
    postcode
FROM patient
WHERE patient_id IN (
    SELECT a.patient_id
    FROM appointment a
    JOIN prescription pr ON a.appointment_id = pr.appointment_id
    JOIN medicines m ON pr.prescription_id = m.prescription_id
	WHERE m.medicine_name = 'Latanoprost')

