-- Selezionare tutti gli studenti nati nel 1990
SELECT * FROM `students`
WHERE YEAR(`date_of_birth`) = 1990  
ORDER BY `students`.`date_of_birth`  DESC