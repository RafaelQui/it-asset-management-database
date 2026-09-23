-- IT Asset Management Database
-- MySQL 8.0

DROP DATABASE IF EXISTS it_asset_management;
CREATE DATABASE it_asset_management;
USE it_asset_management;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    job_title VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,
    employment_status ENUM('Active', 'Leave', 'Terminated') DEFAULT 'Active',
    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE assets (
    asset_id INT AUTO_INCREMENT PRIMARY KEY,
    asset_tag VARCHAR(30) NOT NULL UNIQUE,
    asset_type ENUM('Laptop', 'Desktop', 'Monitor', 'Phone', 'Tablet', 'Printer') NOT NULL,
    manufacturer VARCHAR(60) NOT NULL,
    model VARCHAR(100) NOT NULL,
    serial_number VARCHAR(100) NOT NULL UNIQUE,
    purchase_date DATE NOT NULL,
    purchase_cost DECIMAL(10,2) NOT NULL,
    asset_status ENUM('In Use', 'Available', 'Repair', 'Retired') DEFAULT 'Available'
);

CREATE TABLE software (
    software_id INT AUTO_INCREMENT PRIMARY KEY,
    software_name VARCHAR(100) NOT NULL,
    vendor VARCHAR(100) NOT NULL,
    license_type ENUM('Subscription', 'Perpetual', 'Free', 'Enterprise') NOT NULL
);

CREATE TABLE asset_assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    asset_id INT NOT NULL,
    employee_id INT NOT NULL,
    assigned_date DATE NOT NULL,
    returned_date DATE NULL,
    assignment_status ENUM('Assigned', 'Returned') DEFAULT 'Assigned',
    CONSTRAINT fk_assignment_asset
        FOREIGN KEY (asset_id) REFERENCES assets(asset_id),
    CONSTRAINT fk_assignment_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE asset_software (
    asset_id INT NOT NULL,
    software_id INT NOT NULL,
    installed_date DATE NOT NULL,
    PRIMARY KEY (asset_id, software_id),
    CONSTRAINT fk_assetsoftware_asset
        FOREIGN KEY (asset_id) REFERENCES assets(asset_id),
    CONSTRAINT fk_assetsoftware_software
        FOREIGN KEY (software_id) REFERENCES software(software_id)
);

CREATE TABLE support_tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    asset_id INT NULL,
    category ENUM('Hardware', 'Software', 'Network', 'Access', 'Other') NOT NULL,
    priority ENUM('Low', 'Medium', 'High', 'Critical') NOT NULL,
    subject VARCHAR(150) NOT NULL,
    opened_date DATE NOT NULL,
    closed_date DATE NULL,
    ticket_status ENUM('Open', 'In Progress', 'Resolved', 'Closed') DEFAULT 'Open',
    CONSTRAINT fk_ticket_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT fk_ticket_asset
        FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
);
