CREATE DATABASE IF NOT EXISTS smart_traffic_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smart_traffic_db;

CREATE TABLE IF NOT EXISTS drivers (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    license_no VARCHAR(40) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    registration_no VARCHAR(20) NOT NULL UNIQUE,
    vehicle_type VARCHAR(40) NOT NULL,
    driver_id INT NULL,
    CONSTRAINT fk_vehicle_driver FOREIGN KEY (driver_id)
        REFERENCES drivers(driver_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS violation_types (
    violation_type_id INT AUTO_INCREMENT PRIMARY KEY,
    violation_type VARCHAR(80) NOT NULL UNIQUE,
    default_fine DECIMAL(10,2) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS violation_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    violation_type_id INT NOT NULL,
    violation_date DATE NOT NULL,
    location VARCHAR(150),
    fine_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    status ENUM('Unpaid', 'Paid') NOT NULL DEFAULT 'Unpaid',
    CONSTRAINT fk_record_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_record_type FOREIGN KEY (violation_type_id)
        REFERENCES violation_types(violation_type_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT IGNORE INTO violation_types (violation_type, default_fine) VALUES
('Overspeeding', 1000.00),
('Signal Jumping', 1000.00),
('Illegal Parking', 500.00),
('No Helmet', 500.00),
('No Seat Belt', 1000.00);

-- Optional sample data for testing. Remove these inserts if you want an empty database.
INSERT IGNORE INTO drivers (name, license_no, phone) VALUES
('Rahul Das', 'WB-TEST-1001', '9000000001'),
('Priya Sen', 'WB-TEST-1002', '9000000002');

INSERT IGNORE INTO vehicles (registration_no, vehicle_type, driver_id) VALUES
('WB-01-AB-1234', 'Car', (SELECT driver_id FROM drivers WHERE license_no='WB-TEST-1001')),
('WB-02-CD-5678', 'Motorcycle', (SELECT driver_id FROM drivers WHERE license_no='WB-TEST-1002'));
