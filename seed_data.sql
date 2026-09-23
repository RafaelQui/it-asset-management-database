USE it_asset_management;

INSERT INTO departments (department_name, location) VALUES
('Information Technology', 'Lancaster Office'),
('Finance', 'Lancaster Office'),
('Human Resources', 'Lancaster Office'),
('Sales', 'Harrisburg Office'),
('Operations', 'York Office');

INSERT INTO employees
(first_name, last_name, email, job_title, department_id, hire_date, employment_status)
VALUES
('Maya', 'Chen', 'maya.chen@northstar.com', 'IT Support Specialist', 1, '2024-02-12', 'Active'),
('Jordan', 'Lee', 'jordan.lee@northstar.com', 'Systems Administrator', 1, '2022-08-01', 'Active'),
('Olivia', 'Martin', 'olivia.martin@northstar.com', 'Financial Analyst', 2, '2025-01-15', 'Active'),
('Ethan', 'Brooks', 'ethan.brooks@northstar.com', 'Accountant', 2, '2023-06-05', 'Active'),
('Sophia', 'Rivera', 'sophia.rivera@northstar.com', 'HR Coordinator', 3, '2024-09-09', 'Active'),
('Noah', 'Patel', 'noah.patel@northstar.com', 'Sales Representative', 4, '2025-03-10', 'Active'),
('Ava', 'Wilson', 'ava.wilson@northstar.com', 'Sales Manager', 4, '2021-11-22', 'Active'),
('Liam', 'Carter', 'liam.carter@northstar.com', 'Operations Analyst', 5, '2023-04-17', 'Active'),
('Emma', 'Davis', 'emma.davis@northstar.com', 'Operations Coordinator', 5, '2024-07-08', 'Active'),
('Lucas', 'Nguyen', 'lucas.nguyen@northstar.com', 'Former Sales Associate', 4, '2022-05-16', 'Terminated');

INSERT INTO assets
(asset_tag, asset_type, manufacturer, model, serial_number, purchase_date, purchase_cost, asset_status)
VALUES
('LT-1001', 'Laptop', 'Dell', 'Latitude 5540', 'DL5540-001', '2025-02-01', 1299.00, 'In Use'),
('LT-1002', 'Laptop', 'Lenovo', 'ThinkPad T14', 'LNT14-002', '2024-11-10', 1399.00, 'In Use'),
('LT-1003', 'Laptop', 'HP', 'EliteBook 840', 'HP840-003', '2025-01-12', 1249.00, 'In Use'),
('DT-2001', 'Desktop', 'Dell', 'OptiPlex 7020', 'DOP7020-004', '2024-05-20', 999.00, 'In Use'),
('MN-3001', 'Monitor', 'Dell', 'P2422H', 'DLP24-005', '2024-05-20', 249.00, 'In Use'),
('MN-3002', 'Monitor', 'LG', '24MP60G', 'LG24-006', '2024-07-18', 179.00, 'Available'),
('PH-4001', 'Phone', 'Apple', 'iPhone 15', 'APL15-007', '2025-04-05', 799.00, 'In Use'),
('TB-5001', 'Tablet', 'Apple', 'iPad Air', 'IPAIR-008', '2024-12-14', 599.00, 'Available'),
('LT-1004', 'Laptop', 'Dell', 'Latitude 5420', 'DL5420-009', '2022-03-03', 1150.00, 'Repair'),
('PR-6001', 'Printer', 'HP', 'LaserJet Pro 4001', 'HPLJ-010', '2023-09-22', 429.00, 'In Use'),
('LT-1005', 'Laptop', 'Lenovo', 'ThinkPad E14', 'LNE14-011', '2023-01-05', 999.00, 'Retired'),
('MN-3003', 'Monitor', 'Dell', 'P2422H', 'DLP24-012', '2025-05-01', 249.00, 'Available');

INSERT INTO software
(software_name, vendor, license_type)
VALUES
('Microsoft 365', 'Microsoft', 'Subscription'),
('Tableau Desktop', 'Salesforce', 'Subscription'),
('Adobe Acrobat Pro', 'Adobe', 'Subscription'),
('CrowdStrike Falcon', 'CrowdStrike', 'Enterprise'),
('Google Chrome', 'Google', 'Free');

INSERT INTO asset_assignments
(asset_id, employee_id, assigned_date, returned_date, assignment_status)
VALUES
(1, 3, '2025-02-05', NULL, 'Assigned'),
(2, 7, '2024-11-15', NULL, 'Assigned'),
(3, 5, '2025-01-20', NULL, 'Assigned'),
(4, 8, '2024-05-22', NULL, 'Assigned'),
(5, 8, '2024-05-22', NULL, 'Assigned'),
(7, 7, '2025-04-08', NULL, 'Assigned'),
(9, 10, '2022-03-10', '2025-08-01', 'Returned'),
(11, 10, '2023-01-10', '2024-12-18', 'Returned');

INSERT INTO asset_software
(asset_id, software_id, installed_date)
VALUES
(1, 1, '2025-02-05'),
(1, 2, '2025-02-05'),
(1, 4, '2025-02-05'),
(1, 5, '2025-02-05'),
(2, 1, '2024-11-15'),
(2, 3, '2024-11-15'),
(2, 4, '2024-11-15'),
(2, 5, '2024-11-15'),
(3, 1, '2025-01-20'),
(3, 4, '2025-01-20'),
(3, 5, '2025-01-20'),
(4, 1, '2024-05-22'),
(4, 4, '2024-05-22'),
(4, 5, '2024-05-22');

INSERT INTO support_tickets
(employee_id, asset_id, category, priority, subject, opened_date, closed_date, ticket_status)
VALUES
(3, 1, 'Software', 'Medium', 'Tableau will not launch', '2026-08-28', '2026-08-29', 'Closed'),
(5, 3, 'Access', 'High', 'Cannot access HR shared drive', '2026-09-02', '2026-09-02', 'Resolved'),
(7, 2, 'Network', 'High', 'VPN disconnecting during client calls', '2026-09-05', NULL, 'In Progress'),
(8, 4, 'Hardware', 'Medium', 'Desktop running slowly', '2026-09-08', NULL, 'Open'),
(3, 1, 'Software', 'Low', 'Excel add-in missing', '2026-09-09', '2026-09-10', 'Closed'),
(9, NULL, 'Access', 'Medium', 'Password reset request', '2026-09-11', '2026-09-11', 'Closed'),
(6, NULL, 'Other', 'Low', 'New headset request', '2026-09-12', NULL, 'Open'),
(7, 7, 'Hardware', 'Critical', 'Company phone will not power on', '2026-09-14', '2026-09-14', 'Resolved'),
(8, 4, 'Software', 'Medium', 'Microsoft 365 update failure', '2026-09-16', NULL, 'In Progress'),
(5, 3, 'Network', 'High', 'Wi-Fi drops in conference room', '2026-09-18', NULL, 'Open');
