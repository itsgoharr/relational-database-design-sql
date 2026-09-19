-- Monthly schedule
SELECT co.class_id,c.course_name,co.starts_at,co.room,t.first_name||' '||t.last_name AS trainer
FROM class_offering co JOIN course c USING(course_code) JOIN trainer t USING(trainer_id)
WHERE co.starts_at >= date_trunc('month',CURRENT_DATE) AND co.starts_at < date_trunc('month',CURRENT_DATE)+interval '1 month'
ORDER BY co.starts_at;
-- Class roster
SELECT co.class_id,c.course_name,cl.first_name,cl.last_name,cl.city,cl.state
FROM enrollment e JOIN class_offering co USING(class_id) JOIN course c USING(course_code) JOIN client cl USING(client_id)
ORDER BY co.class_id,cl.last_name,cl.first_name;
-- Qualified trainers by course
SELECT c.course_code,c.course_name,t.first_name,t.last_name,q.qualified_on
FROM trainer_qualification q JOIN course c USING(course_code) JOIN trainer t USING(trainer_id)
ORDER BY c.course_code,t.last_name;
