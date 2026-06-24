-- Developer: Jai Verma
-- Project: Lantern Library - Event Booking System Architecture
-- Description: A fully normalized (3NF) relational database script for managing library events and patron registrations.

-- 1. Initialize Database
CREATE DATABASE IF NOT EXISTS lantern_library_events;
USE lantern_library_events;

-- 2. Create 'patrons' Table (Library Members)
CREATE TABLE patrons (
    patron_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    contact_email VARCHAR(120) UNIQUE NOT NULL,
    membership_tier ENUM('Standard', 'Premium', 'Scholar') DEFAULT 'Standard',
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create 'spatial_assets' Table (Rooms and Event Spaces)
CREATE TABLE spatial_assets (
    space_id INT AUTO_INCREMENT PRIMARY KEY,
    space_designation VARCHAR(100) NOT NULL,
    maximum_occupancy INT NOT NULL,
    is_multimedia_equipped BOOLEAN DEFAULT FALSE
);

-- 4. Create 'event_categories' Table (Lookup table for event types)
CREATE TABLE event_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(60) UNIQUE NOT NULL
);

-- 5. Create 'scheduled_events' Table (The core event entity)
CREATE TABLE scheduled_events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_title VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    space_id INT NOT NULL,
    hosting_date DATE NOT NULL,
    time_commencement TIME NOT NULL,
    time_conclusion TIME NOT NULL,
    -- Foreign Key Constraints
    FOREIGN KEY (category_id) REFERENCES event_categories(category_id) ON DELETE RESTRICT,
    FOREIGN KEY (space_id) REFERENCES spatial_assets(space_id) ON DELETE CASCADE
);

-- 6. Create 'event_bookings' Table (Junction table linking patrons to events)
CREATE TABLE event_bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    patron_id INT NOT NULL,
    booking_status ENUM('Confirmed', 'Waitlisted', 'Cancelled') DEFAULT 'Confirmed',
    booked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- Foreign Key Constraints
    FOREIGN KEY (event_id) REFERENCES scheduled_events(event_id) ON DELETE CASCADE,
    FOREIGN KEY (patron_id) REFERENCES patrons(patron_id) ON DELETE CASCADE,
    -- Ensure a patron cannot book the same event twice
    UNIQUE (event_id, patron_id) 
);

-- ==========================================
-- INSERTING UNIQUE MOCK DATA 
-- ==========================================

-- Insert distinct Patrons
INSERT INTO patrons (first_name, last_name, contact_email, membership_tier) VALUES 
('Elias', 'Vance', 'elias.vance@example.com', 'Scholar'),
('Nadia', 'Kovac', 'n.kovac88@example.com', 'Premium'),
('Julian', 'Harper', 'j.harper.reads@example.com', 'Standard'),
('Maya', 'Lin', 'maya.lin.tech@example.com', 'Premium');

-- Insert distinct Spatial Assets (Rooms)
INSERT INTO spatial_assets (space_designation, maximum_occupancy, is_multimedia_equipped) VALUES 
('The Glass Atrium', 150, TRUE),
('Whisper Room B', 15, FALSE),
('The Grand Archive', 50, TRUE),
('Innovation Lab', 30, TRUE);

-- Insert Event Categories
INSERT INTO event_categories (category_name) VALUES 
('Author Q&A'),
('Tech Workshop'),
('Silent Reading Session'),
('Historical Archive Tour');

-- Insert Scheduled Events
INSERT INTO scheduled_events (event_title, category_id, space_id, hosting_date, time_commencement, time_conclusion) VALUES 
('Introduction to Cloud Computing in Literature', 2, 4, '2026-07-15', '14:00:00', '16:00:00'),
('An Evening with Sci-Fi Author R.A. Montgomery', 1, 1, '2026-07-20', '18:30:00', '20:30:00'),
('Sunday Morning Silent Reading', 3, 2, '2026-07-22', '09:00:00', '11:00:00');

-- Insert Event Bookings
-- Elias and Maya attending the Cloud Computing Workshop
INSERT INTO event_bookings (event_id, patron_id, booking_status) VALUES 
(1, 1, 'Confirmed'),
(1, 4, 'Confirmed');

-- Nadia attending the Author Q&A
INSERT INTO event_bookings (event_id, patron_id, booking_status) VALUES 
(2, 2, 'Confirmed');

-- Julian waitlisted for the Silent Reading
INSERT INTO event_bookings (event_id, patron_id, booking_status) VALUES 
(3, 3, 'Waitlisted');