-----------------------Ranking Functions------------------------------------------------------------------------------------------

-------BY:Shourya Pokhriyal
-------Created Date: 12/10/2025
-------Table used: Ranks

----SQL topics covered: rank,dense_rank ,ROW_NUMBER(),unbounded preceding/Following, lead,lag ,NTILE

----------------------------------------------------------------------------------------------------------------------------------

--Q1: What is the difference between ROW_NUMBER(),RANK(),DENSE_RANK()

--ROW_NUMBER() assigns a unique, sequential number to each row, regardless of ties
--RANK() assigns the same rank to tied rows but skips subsequent rank values
--DENSE_RANK() assigns the same rank to tied rows and does not skip subsequent rank values

select * , rank () over (order by student_marks desc) as rank_,
dense_rank () over (order by student_marks desc, student_name asc) as dense_rank_,
ROW_NUMBER() over (order by student_marks desc) row_number_
from ranks 


--Q2: In each dept,rank the students based on the marks they achieved. 
select *, rank() over (partition by dept order by student_marks desc) as Rank_by_dept
from Ranks 



--Q3:Do a Neighbor Comparison for each student by 1 preceeding and 1 following. 
select *, sum(student_marks) over (order by student_marks rows between 1 preceding and 1 following) summing 
from Ranks


--Q4:Find the highest and lowest marks of students in each dept

--UNBOUNDED PRECEDING is a window frame clause used in window functions to specify that the window's starting point 
--is the very first row of the current partition

select *,first_value(student_marks) over (partition by dept order by student_marks desc) highest_marks,
last_value(student_marks) over (partition by dept order by student_marks desc rows between unbounded preceding and unbounded 
following) lowest_marks
,Avg(student_marks) over (order by student_marks desc rows between 1 preceding and current row) Avg_sum
from ranks 


--Q5: Rank the students only upto 3 in each dept, no matter what the count is. 
select *, NTILE(3) over (partition by dept order by student_marks desc ) as Ranking_dept_wise_into_3
from Ranks

select *, lead(t.timing) over (partition by t.train_no order by timing) from Trains t 
select *, lag(t.timing) over (partition by t.train_no order by timing) from Trains t 







