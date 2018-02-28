CREATE TABLE COURSE
(course_number int NOT NULL,
title varchar(20) NOT NULL,
credits SMALLINT NOT NULL WITH DEFAULT 3,
price decimal(6,2) NOT NULL,
cstart date NOT NULL,
cend date NOT NULL,
period business_time(cstart, cend),
PRIMARY key(course_number, bussiness_time WITHOUT overlaps));

-- insert values
insert into course(course_number, title, credits, price, cstart, cend, period)
insert into course(1, 'BD', 5, 300, '2017-01-01', '2017-06-01')
insert into course(2, 'BDA', 8, 800, '2017-06-01', '2017-12-01')
insert into course(3, 'C++', 6, 550, '2018-01-10', '2018-06-01')
insert into course(4, 'Meta-Programming', 4, 380, '2018-03-01', '2018-06-01')

--insert into table course

--Consultar datos temporales
-- for business_time as of ...
-- for business_time from ... to ...

---------------------
-- class == course --
---------------------

select * from class for business_time as of '2017-05-01'

select * from class for business_time from '2017-01-01' to '2017-12-31'

UPDATE class
FOR portion OF business_time FROM '2018-04-01' TO '2018-05-01'
WHERE course_number = 4

-- insertar un curso en medio
insert into course(2, 'BDA', 8, 800, '2017-08-01', '2017-09-01')
-- manda error
insert into course(5, 'AYMSS', 8, 800, '2017-08-01', '2017-09-01')
-- debe funcionar

DELETE FROM course
for portion of business_time from 'date' to 'date'
where course_number = 3


-- System_Time
SYSTEM TIME
create table course_sys(course_number int primary key not null,
TITLE VARCHAR(20) NOT NULL,
CREDITS SMALLINT NOT NULL WITH DEFAULT 3,
PRICE DECIMAL(7,2),
SYS_START TIMESTAMP(12) GENERATED ALWAYS AS ROW BEGIN NOT NULL,
SYS_END TIMESTAMP(12) GENERATED ALWAYS AS ROW END NOT NULL,
TRANS_START TIMESTAMP(12) GENERATED ALWAYS AS TRANSACTION START ID IMPLICITLY HIDDEN,
PERIOD SYSTEM_TIME(SYS_START, SYS_END));

