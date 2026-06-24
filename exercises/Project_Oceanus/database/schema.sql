-- Database creation for Project Oceanus
CREATE DATABASE IF NOT EXISTS oceanus_db;
USE oceanus_db;

-- Fleet management table
CREATE TABLE IF NOT EXISTS ships (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ship_name VARCHAR(100) NOT NULL,
    ship_class VARCHAR(50) NOT NULL,
    operational_status VARCHAR(20) DEFAULT 'Docked',
    developer VARCHAR(100) DEFAULT 'Jai Verma',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert demo data
INSERT INTO ships (ship_name, ship_class, operational_status) VALUES 
('Nautilus', 'Explorer', 'Active'),
('Leviathan', 'Cargo', 'Docked');