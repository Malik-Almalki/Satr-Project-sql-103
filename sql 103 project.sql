USE school_al_tamayoz;

-- 1. إنشاء جدول وسيط لعلاقة many-to-many بين المعلمين والطلاب
CREATE TABLE teacher_student (
    teacher_id INT,
    student_id INT,
    PRIMARY KEY (teacher_id, student_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- تعبئة جدول teacher_student تلقائيًا لكل 10 معلمين و30 طالب
INSERT INTO teacher_student (teacher_id, student_id) VALUES
(1,1),(2,1),
(2,2),(3,2),
(3,3),(4,3),
(4,4),(5,4),
(5,5),(6,5),
(6,6),(7,6),
(7,7),(8,7),
(8,8),(9,8),
(9,9),(10,9),
(10,10),(1,10),
(1,11),(2,11),
(2,12),(3,12),
(3,13),(4,13),
(4,14),(5,14),
(5,15),(6,15),
(6,16),(7,16),
(7,17),(8,17),
(8,18),(9,18),
(9,19),(10,19),
(10,20),(1,20),
(1,21),(2,21),
(2,22),(3,22),
(3,23),(4,23),
(4,24),(5,24),
(5,25),(6,25),
(6,26),(7,26),
(7,27),(8,27),
(8,28),(9,28),
(9,29),(10,29),
(10,30),(1,30);

-- 2. إنشاء علاقة one-to-many بين المواد والمعلمين
ALTER TABLE teachers
ADD subject_id INT,
ADD FOREIGN KEY (subject_id) REFERENCES courses(subject_id);

-- ربط المعلمين بالمواد الستة
UPDATE teachers SET subject_id = 1 WHERE teacher_id = 1;
UPDATE teachers SET subject_id = 2 WHERE teacher_id = 2;
UPDATE teachers SET subject_id = 3 WHERE teacher_id = 3;
UPDATE teachers SET subject_id = 4 WHERE teacher_id = 4;
UPDATE teachers SET subject_id = 5 WHERE teacher_id = 5;
UPDATE teachers SET subject_id = 6 WHERE teacher_id = 6;
UPDATE teachers SET subject_id = 1 WHERE teacher_id = 7;
UPDATE teachers SET subject_id = 2 WHERE teacher_id = 8;
UPDATE teachers SET subject_id = 3 WHERE teacher_id = 9;
UPDATE teachers SET subject_id = 4 WHERE teacher_id = 10;

-- 3. إنشاء جدول وسيط لعلاقة many-to-many بين الطلاب والمواد
CREATE TABLE student_course (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(subject_id)
);

-- تعبئة جدول student_course تلقائيًا لكل 30 طالب والـ 6 مواد
INSERT INTO student_course (student_id, course_id) VALUES
(1,1),(1,2),(1,3),
(2,2),(2,4),(2,5),
(3,1),(3,3),(3,6),
(4,2),(4,5),(4,6),
(5,1),(5,4),(5,6),
(6,3),(6,4),(6,5),
(7,1),(7,2),(7,3),
(8,2),(8,5),(8,6),
(9,1),(9,4),(9,6),
(10,3),(10,4),(10,5),
(11,1),(11,2),(11,5),
(12,2),(12,3),(12,6),
(13,1),(13,4),(13,5),
(14,2),(14,3),(14,6),
(15,1),(15,5),(15,6),
(16,2),(16,4),(16,5),
(17,1),(17,2),(17,3),
(18,3),(18,4),(18,6),
(19,1),(19,5),(19,6),
(20,2),(20,3),(20,5),
(21,1),(21,4),(21,6),
(22,2),(22,3),(22,5),
(23,1),(23,2),(23,4),
(24,3),(24,4),(24,6),
(25,1),(25,5),(25,6),
(26,2),(26,3),(26,4),
(27,1),(27,4),(27,5),
(28,2),(28,3),(28,6),
(29,1),(29,5),(29,6),
(30,2),(30,4),(30,5);

-- 4. إنشاء Procedure باسم student_info لعرض بيانات الطلاب والمواد
DELIMITER //

CREATE PROCEDURE student_info()
BEGIN
    SELECT s.student_name, s.level, s.track, c.subject_name
    FROM students s
    JOIN student_course sc ON s.student_id = sc.student_id
    JOIN courses c ON sc.course_id = c.subject_id
    ORDER BY s.student_id, c.subject_name;
END //

DELIMITER ;

-- استدعاء الـ Procedure
CALL student_info();

-- 5. إنشاء View باسم teacher_info لعرض اسم المعلم، رقم المكتب، واسم المادة
CREATE VIEW teacher_info AS
SELECT t.teacher_name, t.office_number, c.subject_name
FROM teachers t
JOIN courses c ON t.subject_id = c.subject_id;

-- عرض الـ View
SELECT * FROM teacher_info;

-- حذف الـ View
DROP VIEW teacher_info;

-- 6. إنشاء Index للبحث باستخدام أسماء الطلاب أبجدياً
CREATE INDEX idx_student_name ON students(student_name);

-- عرض الـ Index
SHOW INDEX FROM students;
SELECT * FROM students ORDER BY student_name;


-- حذف الـ Index
DROP INDEX idx_student_name ON students;
