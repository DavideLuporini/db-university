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





