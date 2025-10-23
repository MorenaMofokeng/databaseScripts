SQL> CREATE OR REPLACE PROCEDURE staff_info(
  2      p_employee_id IN b_employees.employee_id%TYPE
  3  ) AS
  4      v_employee_name VARCHAR2(50);
  5      v_job_description VARCHAR2(20);
  6      v_department_name VARCHAR2(30);
  7      v_manager_name VARCHAR2(50);
  8      v_manager_id b_employees.employee_id%TYPE;
  9  BEGIN
 10      -- Get employee information
 11      SELECT INITCAP(e.first_name) || ' ' || SUBSTR(INITCAP(e.last_name), 1, 1) || '.',
 12             e.classification,
 13             d.department_name,
 14             d.department_mgr
 15      INTO v_employee_name,
 16           v_job_description,
 17           v_department_name,
 18           v_manager_id
 19      FROM b_employees e
 20      JOIN b_departments d ON e.department_id = d.department_id
 21      WHERE e.employee_id = p_employee_id;
 22
 23      -- Get manager's name
 24      SELECT INITCAP(first_name)
 25      INTO v_manager_name
 26      FROM b_employees
 27      WHERE employee_id = v_manager_id;
 28
 29      -- Display the report
 30      DBMS_OUTPUT.PUT_LINE(v_employee_name || ' (' || v_job_description || ') works in ' ||
 31                           v_department_name || ' under ' || v_manager_name);
 32  EXCEPTION
 33      WHEN NO_DATA_FOUND THEN
 34          DBMS_OUTPUT.PUT_LINE('Employee with ID ' || p_employee_id || ' not found.');
 35      WHEN OTHERS THEN
 36          DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
 37  END staff_info;
 38  /


SQL> declare
  2  v_employee_id b_employees.employee_id%TYPE:= &employee_id;
  3  begin
  4  staff_info(v_employee_id);
  5  exception
  6  when others then
  7  dbms_output.put_line('Error: '||SQLERRM);
  8  end;
  9  /