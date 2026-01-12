-----------------------Ranking Functions------------------------------------------------------------------------------------------

-------BY:Shourya Pokhriyal
-------Created Date: 12/10/2025
-------Table used: Ranks

----SQL topics covered: rank,dense_rank ,ROW_NUMBER(),unbounded preceding/Following, lead,lag ,NTILE

----------------------------------------------------------------------------------------------------------------------------------


select * , rank () over (order by student_marks desc) as rank_,
dense_rank () over (order by student_marks desc, student_name asc) as dense_rank_,
ROW_NUMBER() over (order by student_marks desc) row_number_
from ranks --ranks 

select *, rank() over (partition by dept order by student_marks desc) as Rank_by_dept
from Ranks --partition by 

select *, sum(student_marks) over (order by student_marks rows between 1 preceding and 1 following) summing 
from Ranks --rows between

select *,sum(student_marks) over (order by student_marks desc rows between unbounded preceding and current row) running_sum,
avg(student_marks) over (order by student_marks desc rows between 1 preceding and current row) running_sum
from ranks --- running sum 
--/ moving avg -> ( used in trading )

select *,first_value(student_marks) over (partition by dept order by student_marks desc) highest_marks,
last_value(student_marks) over (partition by dept order by student_marks rows between unbounded preceding and unbounded following) lowest_marks
from ranks --- first and last value

select *, lead(t.timing) over (partition by t.train_no order by timing) from Trains t 
select *, lag(t.timing) over (partition by t.train_no order by timing) from Trains t 

select *, NTILE(3) over (partition by dept order by student_marks desc ) as Ranking_dept_wise_into_3
from Ranks


--select * from ranks 






