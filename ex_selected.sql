-- Selezionare tutti gli studenti nati nel 1990
SELECT * FROM `students`
WHERE YEAR(`date_of_birth`) = 1990  
ORDER BY `students`.`date_of_birth`  DESC


-- Selezionare tutti i corsi che valgono più di 10 crediti

SELECT * FROM `courses`
WHERE `cfu` >= 10  
ORDER BY `courses`.`cfu`  DESC

-- Selezionare tutti gli studenti che hanno più di 30 anni

SELECT * FROM `students` 

WHERE YEAR(`date_of_birth`) =  1992 
ORDER BY `students`.`date_of_birth`  DESC

-- Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea

SELECT * FROM `courses` 
WHERE `period` = "I semestre"  
ORDER BY `courses`.`period`  DESC

-- Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020
SELECT * FROM `exams`

WHERE `hour` >= "14:00"   AND `date`  = "2020/06/20"
ORDER BY `exams`.`date` DESC

-- Selezionare tutti i corsi di laurea magistrale
SELECT * FROM `degrees`
WHERE `name` LIKE '%magistrale%';

-- Da quanti dipartimenti è composta l'università?
SELECT COUNT(*) AS 'number of departments' FROM `departments` LIMIT 25

-- Quanti sono gli insegnanti che non hanno un numero di telefono?
SELECT COUNT(*) 
FROM `teachers`
WHERE `phone` IS NULL




-- GROUP BY EXS


-- 1# Contare quanti iscritti ci sono stati ogni anno


SELECT COUNT(*) AS 'num_iscritti', YEAR(`enrolment_date`) AS `anno_iscrizione`
FROM `students`
GROUP BY `anno_iscrizione`

-- 2# Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT COUNT(*) AS 'teachers', `office_address` AS `address`
FROM `teachers`
GROUP BY `address`

-- 3# Calcolare la media dei voti di ogni appello d'esame

SELECT COUNT(*) AS `exam_student`, AVG(`vote`) AS `vote`
FROM `exam_student`
GROUP BY `vote`

--#QUERI CON JOIN 
-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT D.`name`, S.`name`, S.`surname`, S.`registration_number` AS 'number'
FROM `degrees` D
JOIN `students` S
ON D.`id` = S.`degree_id`
WHERE D.`name` = 'Corso di Laurea in Economia'

-- 2 Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze

SELECT DE.`name`, DG.`name`
FROM `departments` DE
JOIN `degrees` DG
ON DE.`id` = DG.`department_id`
WHERE DE.`name` = 'Dipartimento di Neuroscienze'
ORDER BY DG.`name` ASC

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT T.`name`, T.`surname`, C.`name`
FROM `teachers` T
JOIN `course_teacher` CT
ON T.`id` = CT.`teacher_id`
JOIN `courses` C
ON C.`id` = CT.`course_id`
WHERE T.`id` = 44

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT * 
    FROM `students` 
    JOIN `degrees` 
    ON `students`.`degree_id`= `degrees`.`id` 
    JOIN `departments` 
    ON `degrees`.`department_id`=`departments`.`id` 
    ORDER BY `students`.`surname`

-- 5 Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT `degrees`. * , `courses`.`name`  
    FROM `degrees` 
    JOIN `courses` 
    ON `degrees`.`id`=`courses`.`degree_id` 
    JOIN `course_teacher` 
    ON `courses`.`id`= `course_teacher`.`course_id` 
    JOIN `teachers` 
    ON `course_teacher`.`teacher_id`= `teachers`.`id` 
    ORDER BY `courses`.`id`

-- 6 Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT DISTINCT `teachers`.`name`, `teachers`.`surname` , `departments` . `name`
    FROM `teachers` 
    JOIN `course_teacher` 
    ON `teachers`.`id`=`course_teacher`.`teacher_id`
    JOIN `courses` 
    ON `course_teacher`.`course_id`=`courses`.`id`
    JOIN `degrees` 
    ON `courses`.`degree_id`= `degrees`.`id`
    JOIN `departments` 
    ON `degrees`.`department_id`=`departments`.`id`
    WHERE `departments`.`name`='Dipartimento di Matematica'

    -- 7 BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT S.`name`, S.`surname`, IF(COUNT(C.`name`)>1, 'more then one attemp', 'first attempt') AS 'how many attemps', C.`name` AS 'Course name', COUNT(C.`name`) AS 'Attemps'
FROM `students` S
JOIN `exam_student` ES
ON S.`id` = ES.`student_id`
JOIN `exams` E
ON E.`id` = ES.`exam_id`
JOIN `courses` C
ON C.`id` = E.`course_id`
GROUP BY S.`name`, S.`surname`, C.`name`


