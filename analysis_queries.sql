USE it_asset_management;

-- 1. Current asset assignments with employee and department
SELECT
    a.asset_tag,
    a.asset_type,
    a.manufacturer,
    a.model,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    aa.assigned_date
FROM asset_assignments aa
JOIN assets a
    ON aa.asset_id = a.asset_id
JOIN employees e
    ON aa.employee_id = e.employee_id
JOIN departments d
    ON e.department_id = d.department_id
WHERE aa.assignment_status = 'Assigned'
ORDER BY d.department_name, employee_name;

-- 2. Number of active employees by department
SELECT
    d.department_name,
    COUNT(e.employee_id) AS active_employee_count
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
    AND e.employment_status = 'Active'
GROUP BY d.department_id, d.department_name
ORDER BY active_employee_count DESC;

-- 3. Asset inventory by status
SELECT
    asset_status,
    COUNT(*) AS asset_count,
    ROUND(SUM(purchase_cost), 2) AS total_purchase_value
FROM assets
GROUP BY asset_status
ORDER BY asset_count DESC;

-- 4. Open and in-progress support tickets
SELECT
    st.ticket_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    st.category,
    st.priority,
    st.subject,
    st.opened_date,
    st.ticket_status
FROM support_tickets st
JOIN employees e
    ON st.employee_id = e.employee_id
WHERE st.ticket_status IN ('Open', 'In Progress')
ORDER BY
    FIELD(st.priority, 'Critical', 'High', 'Medium', 'Low'),
    st.opened_date;

-- 5. Ticket count by category
SELECT
    category,
    COUNT(*) AS ticket_count
FROM support_tickets
GROUP BY category
ORDER BY ticket_count DESC;

-- 6. Support ticket volume by department
SELECT
    d.department_name,
    COUNT(st.ticket_id) AS ticket_count
FROM support_tickets st
JOIN employees e
    ON st.employee_id = e.employee_id
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY ticket_count DESC;

-- 7. Average resolution time in days for completed tickets
SELECT
    ROUND(AVG(DATEDIFF(closed_date, opened_date)), 2) AS avg_resolution_days
FROM support_tickets
WHERE closed_date IS NOT NULL;

-- 8. Software installed on each asset
SELECT
    a.asset_tag,
    a.asset_type,
    s.software_name,
    s.vendor,
    aws.installed_date
FROM asset_software aws
JOIN assets a
    ON aws.asset_id = a.asset_id
JOIN software s
    ON aws.software_id = s.software_id
ORDER BY a.asset_tag, s.software_name;

-- 9. Employees with multiple assigned assets
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    COUNT(aa.asset_id) AS assigned_asset_count
FROM asset_assignments aa
JOIN employees e
    ON aa.employee_id = e.employee_id
WHERE aa.assignment_status = 'Assigned'
GROUP BY e.employee_id, e.first_name, e.last_name
HAVING COUNT(aa.asset_id) > 1
ORDER BY assigned_asset_count DESC;

-- 10. Assets that are not currently assigned
SELECT
    a.asset_tag,
    a.asset_type,
    a.manufacturer,
    a.model,
    a.asset_status
FROM assets a
LEFT JOIN asset_assignments aa
    ON a.asset_id = aa.asset_id
    AND aa.assignment_status = 'Assigned'
WHERE aa.assignment_id IS NULL
ORDER BY a.asset_status, a.asset_type;

-- 11. Asset age and lifecycle review
SELECT
    asset_tag,
    asset_type,
    manufacturer,
    model,
    purchase_date,
    TIMESTAMPDIFF(YEAR, purchase_date, CURDATE()) AS asset_age_years,
    asset_status,
    CASE
        WHEN asset_status = 'Retired' THEN 'Already Retired'
        WHEN TIMESTAMPDIFF(YEAR, purchase_date, CURDATE()) >= 4 THEN 'Review for Replacement'
        ELSE 'Within Lifecycle'
    END AS lifecycle_recommendation
FROM assets
ORDER BY asset_age_years DESC;

-- 12. High-priority unresolved tickets
SELECT
    st.ticket_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    st.category,
    st.priority,
    st.subject,
    st.opened_date,
    DATEDIFF(CURDATE(), st.opened_date) AS days_open
FROM support_tickets st
JOIN employees e
    ON st.employee_id = e.employee_id
JOIN departments d
    ON e.department_id = d.department_id
WHERE st.priority IN ('High', 'Critical')
  AND st.ticket_status IN ('Open', 'In Progress')
ORDER BY days_open DESC;
