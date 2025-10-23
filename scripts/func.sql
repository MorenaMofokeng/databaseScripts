SQL> CREATE OR REPLACE FUNCTION year_info(
  2      p_employee_id IN b_employees.employee_id%TYPE
  3  ) RETURN VARCHAR2 IS
  4      v_birth_date DATE;
  5      v_employment_date DATE;
  6      v_current_date DATE := SYSDATE;
  7      v_age NUMBER;
  8      v_years_of_service NUMBER;
  9  BEGIN
 10      -- Get employee's birth date and employment date
 11      SELECT birth_date, employment_date
 12      INTO v_birth_date, v_employment_date
 13      FROM b_employees
 14      WHERE employee_id = p_employee_id;
 15
 16      -- Calculate age in years (truncated to whole number)
 17      v_age := TRUNC(MONTHS_BETWEEN(v_current_date, v_birth_date) / 12);
 18
 19      -- Calculate years of service (truncated to whole number)
 20      v_years_of_service := TRUNC(MONTHS_BETWEEN(v_current_date, v_employment_date) / 12);
 21
 22      -- Return formatted string with line breaks
 23      RETURN 'Employee age: ' || v_age || CHR(10) ||
 24             'No. of years in service: ' || v_years_of_service;
 25  EXCEPTION
 26      WHEN NO_DATA_FOUND THEN
 27          RETURN 'Employee not found';
 28      WHEN OTHERS THEN
 29          RETURN 'Error calculating age and service years';
 30  END year_info;
 31  /