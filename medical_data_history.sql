-- =====================================================
-- Project: Medical Data History Analysis
-- Program: Certified Data Analyst (DataMites)
-- Tool: MySQL Workbench
-- Description: SQL queries to analyze patient,
-- admission, doctor, and province data.
-- =====================================================

-- Database used for practice:
-- project_medical_data_history
-- Note: Database connection credentials are not included.

-- Tables used:
-- 1. patients
-- 2. admissions
-- 3. doctors
-- 4. province_names

-- SQL concepts covered:
-- SELECT, WHERE, ORDER BY, DISTINCT,
-- GROUP BY, HAVING, aggregate functions,
-- string functions, date functions,
-- CASE expressions, UNION ALL, and JOINs.
-- =====================================================
-- Task 1: View patient records
-- =====================================================
SELECT *
FROM patients;


-- =====================================================
-- Task 2: View patients with a specific condition
-- Example: Patients diagnosed with Dementia
-- =====================================================
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    a.diagnosis
FROM patients p
JOIN admissions a
    ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';


-- =====================================================
-- Task 3: Find patients based on height and weight
-- =====================================================
SELECT
    patient_id,
    first_name,
    last_name,
    height,
    weight
FROM patients
WHERE height > 160
  AND weight > 70;


-- =====================================================
-- Task 24: Count patients in each city
-- =====================================================
SELECT
    city,
    COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;


-- =====================================================
-- Task 25: Combine patient and doctor names
-- =====================================================
SELECT
    first_name,
    last_name,
    'Patient' AS role
FROM patients

UNION ALL

SELECT
    first_name,
    last_name,
    'Doctor' AS role
FROM doctors;


-- =====================================================
-- Task 26: Count patients by allergy
-- =====================================================
SELECT
    allergies,
    COUNT(*) AS total_patients
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_patients DESC;


-- =====================================================
-- Task 27: Patients born in the 1970s
-- =====================================================
SELECT
    first_name,
    last_name,
    birth_date
FROM patients
WHERE birth_date >= '1970-01-01'
  AND birth_date < '1980-01-01'
ORDER BY birth_date ASC;


-- =====================================================
-- Task 28: Format names
-- =====================================================
SELECT
    CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;


-- =====================================================
-- Task 29: Total patient height by province
-- =====================================================
SELECT
    province_id,
    SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;


-- =====================================================
-- Task 30: Weight difference for patients named Maroni
-- =====================================================
SELECT
    MAX(weight) - MIN(weight) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';


-- =====================================================
-- Task 31: Admissions by day of the month
-- =====================================================
SELECT
    DAY(admission_date) AS day_of_month,
    COUNT(*) AS total_admissions
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY total_admissions DESC;


-- =====================================================
-- Task 32: Group patients by weight ranges
-- =====================================================
SELECT
    FLOOR(weight / 10) * 10 AS weight_group,
    COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;


-- =====================================================
-- Task 33: Identify patients with BMI >= 30
-- =====================================================
SELECT
    patient_id,
    weight,
    height,
    CASE
        WHEN weight / POW(height / 100.0, 2) >= 30 THEN 1
        ELSE 0
    END AS isObese
FROM patients;


-- =====================================================
-- Task 34: Find patients diagnosed with Epilepsy
-- attended by doctor Lisa
-- =====================================================
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
FROM patients p
JOIN admissions a
    ON p.patient_id = a.patient_id
JOIN doctors d
    ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
  AND d.first_name = 'Lisa';