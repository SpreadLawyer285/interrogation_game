CREATE DATABASE IF NOT EXISTS traitor_investigation;
USE traitor_investigation;

CREATE TABLE group_members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    height VARCHAR(10),
    hair_color VARCHAR(20),
    eye_color VARCHAR(20),
    age INT,
    alibi TEXT,
    location_during_incident VARCHAR(100)
);

CREATE TABLE detectives (
    detective_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    years_of_experience INT,
    year_of_birth INT,
    success_rate DECIMAL(5, 2),
    specialty VARCHAR(100)
);

CREATE TABLE interview_statements (
    statement_id INT AUTO_INCREMENT PRIMARY KEY,
    detective_id INT,
    member_id INT,
    statement TEXT,
    date_time DATETIME,
    FOREIGN KEY (detective_id) REFERENCES detectives(detective_id),
    FOREIGN KEY (member_id) REFERENCES group_members(member_id)
);

INSERT INTO group_members (name, height, hair_color, eye_color, age, alibi, location_during_incident) VALUES
('John Doe', '180cm', 'black', 'brown', 30, 'At home', 'Home'),
('Bob Brown', '175cm', 'black', 'brown', 35, 'At a friend''s house', 'Friend''s House'),
('Charlie Davis', '185cm', 'brown', 'blue', 40, 'At a restaurant', 'Restaurant'),
('David Lee', '178cm', 'black', 'brown', 32, 'At a concert', 'Concert Hall'),
('James Anderson', '182cm', 'blonde', 'blue', 31, 'At a sports event', 'Stadium'),
('Jane Smith', '165cm', 'brown', 'blue', 25, 'At work', 'Office'),
('Alice Johnson', '170cm', 'blonde', 'green', 28, 'At the gym', 'Gym'),
('Emily Wilson', '168cm', 'red', 'green', 27, 'At a café', 'Café'),
('Sophia Martinez', '163cm', 'brown', 'hazel', 24, 'At the library', 'Library'),
('Olivia Taylor', '170cm', 'black', 'brown', 29, 'At a family gathering', 'Family Home');

INSERT INTO detectives (name, years_of_experience, year_of_birth, success_rate, specialty) VALUES
('Detective Smith', 10, 1980, 95.5, 'Homicide'),
('Detective Johnson', 8, 1985, 92.3, 'Fraud'),
('Detective Williams', 12, 1978, 97.1, 'Cybercrime');


INSERT INTO interview_statements (detective_id, member_id, statement, date_time) VALUES
(1, 1, 'I was at home all evening.', '2023-10-01 18:30:00'),
(2, 2, 'I was working late at the office.', '2023-10-01 19:00:00'),
(3, 3, 'I was at the gym from 6 PM to 8 PM.', '2023-10-01 19:30:00'),
(2, 4, 'I was at a friend''s house watching a movie.', '2023-10-01 20:00:00'),
(3, 5, 'I was having dinner at a restaurant.', '2023-10-01 20:30:00'),
(1, 6, 'I was at a café reading a book.', '2023-10-01 21:00:00'),
(2, 7, 'I was at a concert with friends.', '2023-10-01 21:30:00'),
(3, 8, 'I was studying at the library.', '2023-10-01 22:00:00'),
(1, 9, 'I was at a sports event with my family.', '2023-10-01 22:30:00'),
(2, 10, 'I was at a family gathering.', '2023-10-01 23:00:00');


SELECT name, height, hair_color, eye_color
FROM group_members
WHERE hair_color = 'black' AND eye_color = 'brown';

SELECT detectives.name, COUNT(interview_statements.statement_id) as interview_count
FROM detectives
JOIN interview_statements interview_statements ON detectives.detective_id = interview_statements.detective_id
GROUP BY detectives.name
ORDER BY interview_count DESC
LIMIT 1;

SELECT interview_statements.statement
FROM interview_statements interview_statements
JOIN group_members group_members ON interview_statements.member_id = group_members.member_id
WHERE group_members.name = 'John Doe';


SELECT name, alibi
FROM group_members
WHERE alibi IS NOT NULL;

SELECT name, location_during_incident
FROM group_members
WHERE location_during_incident = 'Home';

SELECT group_members.name, interview_statements.statement
FROM group_members group_members
JOIN interview_statements interview_statements ON group_members.member_id = interview_statements.member_id
JOIN detectives ON interview_statements.detective_id = detectives.detective_id
WHERE detectives.name = 'Detective Smith';
