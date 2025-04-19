CREATE DATABASE  Examination ;
use  Examination ;
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    role ENUM('admin', 'teacher', 'student') NOT NULL
);
CREATE TABLE Subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) UNIQUE
);
CREATE TABLE Exams (
    exam_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150),
    subject_id INT,
    created_by INT,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);
CREATE TABLE Questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    exam_id INT,
    question_text TEXT,
    type ENUM('mcq', 'short_answer'),
    option_a VARCHAR(255),
    option_b VARCHAR(255),
    option_c VARCHAR(255),
    option_d VARCHAR(255),
    correct_answer CHAR(1),
    FOREIGN KEY (exam_id) REFERENCES Exams(exam_id)
);
CREATE TABLE Answers (
    answer_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    question_id INT,
    selected_option CHAR(1),
    FOREIGN KEY (student_id) REFERENCES Users(user_id),
    FOREIGN KEY (question_id) REFERENCES Questions(question_id)
);
CREATE TABLE Results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    exam_id INT,
    score INT,
    submitted_at DATETIME,
    FOREIGN KEY (student_id) REFERENCES Users(user_id),
    FOREIGN KEY (exam_id) REFERENCES Exams(exam_id)
);
INSERT INTO Users (name, email, password, role) VALUES
('Alice Admin', 'alice.admin@example.com', 'admin123', 'admin'),
('Bob Teacher', 'bob.teacher@example.com', 'teach123', 'teacher'),
('Eva Teacher', 'eva.teacher@example.com', 'teach234', 'teacher'),
('Charlie Student', 'charlie@example.com', 'charlie123', 'student'),
('Diana Student', 'diana@example.com', 'diana123', 'student'),
('Ethan Student', 'ethan@example.com', 'ethan123', 'student'),
('Fiona Student', 'fiona@example.com', 'fiona123', 'student'),
('George Student', 'george@example.com', 'george123', 'student'),
('Hannah Student', 'hannah@example.com', 'hannah123', 'student'),
('Ivy Student', 'ivy@example.com', 'ivy123', 'student');


INSERT INTO Subjects (subject_name) VALUES
('Mathematics'),
('Computer Science'),
('Physics'),
('Chemistry'),
('Biology'),
('English'),
('History'),
('Geography'),
('Economics'),
('General Knowledge');

INSERT INTO Exams (title, subject_id, created_by, start_time, end_time) VALUES
('Math Quiz 1', 1, 2, '2025-04-20 10:00:00', '2025-04-20 10:30:00'),
('CS Basics Test', 2, 2, '2025-04-21 14:00:00', '2025-04-21 14:45:00'),
('Physics Intro', 3, 3, '2025-04-22 09:00:00', '2025-04-22 09:45:00'),
('Chemistry Quiz', 4, 2, '2025-04-23 13:00:00', '2025-04-23 13:30:00'),
('Biology MCQ', 5, 2, '2025-04-24 11:00:00', '2025-04-24 11:30:00'),
('English Grammar Test', 6, 3, '2025-04-25 10:00:00', '2025-04-25 10:30:00'),
('History Challenge', 7, 3, '2025-04-26 12:00:00', '2025-04-26 12:30:00'),
('Geography Basics', 8, 2, '2025-04-27 14:00:00', '2025-04-27 14:30:00'),
('Economics Paper', 9, 3, '2025-04-28 15:00:00', '2025-04-28 15:45:00'),
('GK Test', 10, 2, '2025-04-29 16:00:00', '2025-04-29 16:30:00');

INSERT INTO Questions (exam_id, question_text, type, option_a, option_b, option_c, option_d, correct_answer) VALUES
(1, 'What is 2 + 2?', 'mcq', '3', '4', '5', '6', 'B'),
(1, 'Square root of 25?', 'mcq', '3', '4', '5', '6', 'C'),
(2, 'Full form of HTML?', 'mcq', 'High Text', 'Hyper Text Markup Language', 'Hyper Tool', 'None', 'B'),
(2, 'CSS used for?', 'mcq', 'Styling', 'Structure', 'Scripting', 'Server', 'A'),
(3, 'Unit of force?', 'mcq', 'Watt', 'Newton', 'Joule', 'Volt', 'B'),
(4, 'Atomic number of Oxygen?', 'mcq', '6', '7', '8', '9', 'C'),
(5, 'Human heart has how many chambers?', 'mcq', '2', '3', '4', '5', 'C'),
(6, 'Past tense of “go”?', 'mcq', 'goed', 'gone', 'goes', 'went', 'D'),
(7, 'Who was the first President of India?', 'mcq', 'Nehru', 'Gandhi', 'Rajendra Prasad', 'Ambedkar', 'C'),
(10, 'Capital of France?', 'mcq', 'London', 'Berlin', 'Madrid', 'Paris', 'D');

INSERT INTO Answers (student_id, question_id, selected_option) VALUES
(4, 1, 'B'),
(5, 2, 'C'),
(6, 3, 'B'),
(7, 4, 'A'),
(8, 5, 'B'),
(9, 6, 'C'),
(10, 7, 'C'),
(4, 8, 'D'),
(5, 9, 'C'),
(6, 10, 'D');

INSERT INTO Results (student_id, exam_id, score, submitted_at) VALUES
(4, 1, 2, '2025-04-20 10:31:00'),
(5, 1, 1, '2025-04-20 10:32:00'),
(6, 2, 2, '2025-04-21 14:46:00'),
(7, 2, 1, '2025-04-21 14:47:00'),
(8, 3, 1, '2025-04-22 09:46:00'),
(9, 4, 1, '2025-04-23 13:31:00'),
(10, 5, 1, '2025-04-24 11:31:00'),
(4, 6, 1, '2025-04-25 10:31:00'),
(5, 7, 1, '2025-04-26 12:31:00'),
(6, 10, 1, '2025-04-29 16:31:00');

SELECT e.title, COUNT(q.question_id) AS total_questions
FROM Exams e
LEFT JOIN Questions q ON e.exam_id = q.exam_id
GROUP BY e.exam_id;

SELECT u.name, r.score
FROM Results r
JOIN Users u ON r.student_id = u.user_id
JOIN Exams e ON r.exam_id = e.exam_id
WHERE e.title = 'Math Quiz 1';

SELECT u.name AS teacher_name, e.title AS exam_title
FROM Exams e
JOIN Users u ON e.created_by = u.user_id
WHERE u.role = 'teacher';

SELECT MAX(score) AS highest_score
FROM Results r
JOIN Exams e ON r.exam_id = e.exam_id
WHERE e.title = 'CS Basics Test';

SELECT u.name, q.question_text, a.selected_option
FROM Answers a
JOIN Users u ON a.student_id = u.user_id
JOIN Questions q ON a.question_id = q.question_id
JOIN Exams e ON q.exam_id = e.exam_id
WHERE e.title = 'Physics Intro';

SELECT e.title, e.start_time, e.end_time
FROM Exams e
JOIN Subjects s ON e.subject_id = s.subject_id
WHERE s.subject_name = 'Mathematics';
