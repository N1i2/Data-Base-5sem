--create database UNIVER;
use UNIVER;

drop table AUDITORIUM;
drop table AUDITORIUM_TYPE;
drop table PROGRESS;
drop table STUDENT;
drop table GROUPS;
drop table PROFESSION;
drop table TEACHER;
drop table SUBJECT;
drop table PULPIT;
drop table FACULTY;

create table FACULTY
(
    FACULTY char(10) constraint FACULTY_PK primary key,
    FACULTY_NAME varchar(50) default '???'
);

insert into FACULTY
values
    (N'XTiT', N'Chemical technology and engineering'),
    (N'LXF', N'Faculty of Forestry'),
    (N'EAF', N'Faculty of Engineering and Economics'),
    (N'TTLP', N'Technology and technology of the forest industry'),
    (N'TOB', N'Organic technology'),
    (N'IT', N'Faculty of Information Technology'),
    (N'EDeP', N'Faculty of Publishing and Printing');

create table PROFESSION
(
    PROFESSION char(20) constraint PROFESSION_PK  primary key,
    FACULTY char(10) constraint PROFESSION_FACULTY_FK foreign key references FACULTY(FACULTY),
    PROFESSION_NAME varchar(100),
    QUALIFICATION varchar(50)
);

insert into PROFESSION
    (FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)
values
    ('EDeP', '1-40 01 02', 'Information systems and technologies', 'software engineer-systems engineer' ),
    ('EDeP', '1-47 01 01', 'Publishing', 'editor-technologist' ),
    ('EDeP', '1-36 06 01', 'Printing equipment and information processing systems', 'electrical engineerê' ),
    ('XTiT', '1-36 01 08', 'Design and production of products from composite materials', 'mechanical engineer'),
    ('XTiT', '1-36 07 01', 'Machines and apparatus for chemical production and building materials enterprises', 'mechanical engineer'),
    ('LXF', '1-75 01 01', 'Forestry', 'forestry engineer'),
    ('LXF', '1-75 02 01', 'Landscape construction', 'landscape construction engineer'),
    ('LXF', '1-89 02 02', 'Tourism and environmental management', 'tourism specialist'),
    ('EAF', '1-25 01 07', 'Economics and enterprise management', 'economist manager'),
    ('EAF', '1-25 01 08', 'Accounting, analysis and audit', 'economist'),
    ('TTLP', '1-36 05 01', 'Machinery and equipment of the forestry complex', 'mechanical engineer'),
    ('TTLP', '1-46 01 01', 'Forestry Engineering', 'process engineer'),
    ('TOB', '1-48 01 02', 'Chemical technology of organic substances, materials and products', 'chemical engineer-technologist'),
    ('TOB', '1-48 01 05', 'Chemical technology of wood processing', 'chemical engineer-technologist' ),
    ('TOB', '1-54 01 03', 'Physical and chemical methods and instruments for product quality control', 'certification engineer');

create table PULPIT
(
    PULPIT char(20) constraint PULPIT_PK  primary key,
    PULPIT_NAME varchar(100),
    FACULTY char(10) constraint PULPIT_FACULTY_FK foreign key references FACULTY(FACULTY)
);

insert into PULPIT
    (PULPIT, PULPIT_NAME, FACULTY )
values
    ('ECeT', 'Information systems and technologies', 'IT'),
    ('POeCOE', 'Printing equipment and information processing systems', 'EDeP' ),
    ('BF', 'Belarusian philology', 'EDeP' ),
    ('RET', 'Editorial and publishing tenologies', 'EDeP'),
    ('PP', 'Printing production', 'EDeP' ),
    ('LB', 'Forestry', 'LXF'),
    ('LU', 'Forest Management', 'LXF'),
    ('LZeDV', 'Forest protection and wood science', 'LXF'),
    ('LKeP', 'Forest crops and soil science', 'LXF'),
    ('TeP', 'Tourism and Environmental Management', 'LXF'),
    ('LPeCPC', 'Landscape design and garden construction', 'LXF'),
    ('TL', 'Forest Transport', 'TTLP'),
    ('LMeLZ', 'Forest machines and logging technologies', 'TTLP'),
    ('TDP', 'Woodworking Technologies', 'TTLP'),
    ('TeDED', 'Technology and design of wood products', 'TTLP'),
    ('OX', 'Organic Chemistry', 'TOB'),
    ('XPD', 'Chemical wood processing', 'TOB'),
    ('TNBeOXT', 'Technology of Inorganic Substances and General Chemical Technology', 'XTiT')
,
    ('ATeM', 'Economic Theory and Marketing', 'EAF'),
    ('MeAP', 'Environmental Management and Economics', 'EAF'),
    ('CBUAeA', 'Statistics, accounting, analysis and auditing', 'EAF')

create table TEACHER
(
    TEACHER char(10) constraint TEACHER_PK  primary key,
    TEACHER_NAME varchar(100),
    GENDER char(1) CHECK (GENDER in ('m', 'w')),
    PULPIT char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT)
);
insert into  TEACHER
    (TEACHER, TEACHER_NAME, GENDER, PULPIT )
values
    ('CMLB', 'Smelov Vladimir Vladislavovich', 'm', 'ECeT'),
    ('AKHBC', 'Akunovich Stanislav Ivanovich', 'm', 'ECeT'),
    ('KLCHB', 'Kolesnikov Vitaly Leonidovich', 'm', 'ECeT'),
    ('BRKBC', 'Andrey Igorevich Brakovich', 'm', 'ECeT'),
    ('DTK', 'Dyatko Alexander Arkadievich', 'm', 'ECeT'),
    ('URB', 'Urbanovich Pavel Pavlovich', 'm', 'ECeT'),
    ('GPH', 'Gurin Nikolai Ivanovich', 'm', 'ECeT'),
    ('GLK', 'Zhilyak Nadezhda Aleksandrovna', 'w', 'ECeT'),
    ('MPZ', 'Moroz Elena Stanislavovna', 'w', 'ECeT'),
    ('BRTSHVCH', 'Bartashevich Svyatoslav Aleksandrovich', 'm', 'POeCOE'),
    ('ARS', 'Arsentiev Vitaly Arsentievich', 'm', 'POeCOE'),
    ('BRNVSK', 'Baranovsky Stanislav Ivanovich', 'm', 'ATeM'),
    ('NVRV', 'Neverov Alexander Vasilievich', 'm', 'MeAP'),
    ('RVKCH', 'Rovkach Andrey Ivanovich', 'm', 'LB'),
    ('DMDK', 'Demidko Marina Nikolaevna', 'w', 'LPeCPC'),
    ('BRG', 'Burganskaya Tatyana Minaevna', 'w', 'LPeCPC'),
    ('RZhK', 'Leonid Nikolaevich Rozhkov', 'm', 'LB'),
    ('ZVGTSV', 'Zvyagintsev Vyacheslav Borisovich', 'm', 'LZeDV'),
    ('BZBRDV', 'Bezborodov Vladimir Stepanovich', 'm', 'OX'),
    ('NSKVTs', 'Mikhail Trofimovich Naskovets', 'm', 'TL');

create table SUBJECT
(
    SUBJECT char(10) constraint SUBJECT_PK  primary key,
    SUBJECT_NAME varchar(100) unique,
    PULPIT char(20) constraint SUBJECT_PULPIT_FK foreign key 
                         references PULPIT(PULPIT)
);

insert into SUBJECT
    (SUBJECT, SUBJECT_NAME, PULPIT )
values
    ('CUBD', 'Database Management Systems', 'ECeT'),
    ('BD', 'Databases', 'ECeT'),
    ('ENF', 'Information Technology', 'ECeT'),
    ('OAeP', 'Fundamentals of Algorithmization and Programming', 'ECeT'),
    ('PZ', 'Knowledge representation in computer systems', 'ECeT'),
    ('PCP', 'Network Application Programming', 'ECeT'),
    ('MCOC', 'Modeling of Information Processing Systems', 'ECeT'),
    ('PEC', 'Information Systems Design', 'ECeT'),
    ('KG', 'Computer Geometry', 'ECeT'),
    ('PMAPL', 'Printing machines, automatic machines and production lines', 'POeCOE'),
    ('KMC', 'Computer Multimedia Systems', 'ECeT'),
    ('OPP', 'Organization of printing production', 'POeCOE'),
    ('DM', 'Discrete Mathematics', 'ECeT'),
    ('MP', 'Mathematical Programming', 'ECeT'),
    ('LAVM', 'Logical Fundamentals of Computers', 'ECeT'),
    ('OOP', 'Object-Oriented Programming', 'ECeT'),
    ('AP', 'Environmental Economics', 'MeAP'),
    ('AT', 'Economic Theory', 'ATeM'),
    ('EG', 'Engineering Geodesy', 'LU'),
    ('LB', 'Forestry', 'LZeDV'),
    ('OX', 'Organic Chemistry', 'OX'),
    ('VTL', 'Forest water transport', 'TL'),
    ('TeOL', 'Technology and equipment of logging', 'LMeLZ')

create table GROUPS
(
    IDGROUP integer identity(1,1) constraint GROUP_PK  primary key,
    FACULTY char(10) constraint  GROUPS_FACULTY_FK foreign key references FACULTY(FACULTY),
    PROFESSION char(20) constraint  GROUPS_PROFESSION_FK foreign key references PROFESSION(PROFESSION),
    YEAR_FIRST smallint check (YEAR_FIRST<=YEAR(GETDATE())),
);
insert into GROUPS
    (FACULTY, PROFESSION, YEAR_FIRST )
values
    ('EDeP', '1-40 01 02', 2013),
    --1
    ('EDeP', '1-40 01 02', 2012),
    ('EDeP', '1-40 01 02', 2011),
    ('EDeP', '1-40 01 02', 2010),
    ('EDeP', '1-47 01 01', 2013),---5 ãð
    ('EDeP', '1-47 01 01', 2012),
    ('EDeP', '1-47 01 01', 2011),
    ('EDeP', '1-36 06 01', 2010),-----8 ãð
    ('EDeP', '1-36 06 01', 2013),
    ('EDeP', '1-36 06 01', 2012),
    ('EDeP', '1-36 06 01', 2011),
    ('XTiT', '1-36 01 08', 2013),---12 ãð                                                  
    ('XTiT', '1-36 01 08', 2012),
    ('XTiT', '1-36 07 01', 2011),
    ('XTiT', '1-36 07 01', 2010),
    ('TOB', '1-48 01 02', 2012),
    ---16 ãð 
    ('TOB', '1-48 01 02', 2011),
    ('TOB', '1-48 01 05', 2013),
    ('TOB', '1-54 01 03', 2012),
    ('LXF', '1-75 01 01', 2013),--20 ãð      
    ('LXF', '1-75 02 01', 2012),
    ('LXF', '1-75 02 01', 2011),
    ('LXF', '1-89 02 02', 2012),
    ('LXF', '1-89 02 02', 2011),
    ('TTLP', '1-36 05 01', 2013),
    ('TTLP', '1-36 05 01', 2012),
    ('TTLP', '1-46 01 01', 2012),--27 ãð
    ('EAF', '1-25 01 07', 2013),
    ('EAF', '1-25 01 07', 2012),
    ('EAF', '1-25 01 07', 2010),
    ('EAF', '1-25 01 08', 2013),
    ('EAF', '1-25 01 08', 2012)
---32 ãð       

------Ñîçäàíèå è çàïîëíåíèå òàáëèöû STUDENT
create table STUDENT
(
    IDSTUDENT integer identity(1000,1) constraint STUDENT_PK primary key,
    IDGROUP integer constraint STUDENT_GROUP_FK foreign key references GROUPS(IDGROUP),
    NAME nvarchar(100),
    BDAY date,
    STAMP timestamp,
    INFO xml,
    FOTO varbinary
)

insert into STUDENT
    (IDGROUP, NAME, BDAY)
values
    (1, 'Khartanovich Ekaterina Alexandrovna', '11.03.1995'),
    (1, 'Gorbach Elizaveta Yuryevna', '07.12.1995'),
    (1, 'Zykova Kristina Dmitrievna', '10/12/1995'),
    (1, 'Shenets Ekaterina Sergeevna', '01/08/1995'),
    (1, 'Shitik Alina Igorevna', '02.08.1995'),
    (2, 'Silyuk Valeria Ivanovna', '12.07.1994'),
    (2, 'Sergel Violetta Nikolaevna', '06.03.1994'),
    (2, 'Dobrodey Olga Anatolyevna', '09.11.1994'),
    (2, 'Podolyak Maria Sergeevna', '04.10.1994'),
    (2, 'Nikitenko Ekaterina Dmitrievna', '01/08/1994'),
    (3, 'Yatskevich Galina Iosifovna', '02.08.1993'),
    (3, 'Osadchaya Ela Vasilievna', '07.12.1993'),
    (3, 'Akulova Elena Gennadievna', '02.12.1993'),
    (4, 'Pleshkun Milana Anatolyevna', '03/08/1992'),
    (4, 'Buyanova Maria Alexandrovna', '06/02/1992'),
    (4, 'Kharchenko Elena Gennadievna', '12/11/1992'),
    (4, 'Kruchenok Evgeniy Aleksandrovich', '11.05.1992'),
    (4, 'Borokhovsky Vitaly Petrovich', '09.11.1992'),
    (4, 'Matskevich Nadezhda Valerievna', '01.11.1992'),
    (5, 'Loginova Maria Vyacheslavovna', '07/08/1995'),
    (5, 'Belko Natalya Nikolaevna', '02.11.1995'),
    (5, 'Selilo Ekaterina Gennadievna', '05/07/1995'),
    (5, 'Drozd Anastasia Andreevna', '04.08.1995'),
    (6, 'Kozlovskaya Elena Evgenievna', '08.11.1994'),
    (6, 'Potapnin Kirill Olegovich', '02.03.1994'),
    (6, 'Ravkovskaya Olga Nikolaevna', '04.06.1994'),
    (6, 'Alexandra Vadimovna Khodoronok', '09.11.1994'),
    (6, 'Ramuk Vladislav Yuryevich', '04.07.1994'),
    (7, 'Neruganenok Maria Vladimirovna', '01/03/1993'),
    (7, 'Gypsy Anna Petrovna', '12.09.1993'),
    (7, 'Masilevich Oksana Igorevna', '12.06.1993'),
    (7, 'Aleksievich Elizaveta Viktorovna', '02/09/1993'),
    (7, 'Vatolin Maxim Andreevich', '04.07.1993'),
    (8, 'Sinitsa Valeria Andreevna', '01/08/1992'),
    (8, 'Kudryashova Alina Nikolaevna', '12.05.1992'),
    (8, 'Migulina Elena Leonidovna', '08.11.1992'),
    (8, 'Shpilenya Alexey Sergeevich', '12.03.1992'),
    (9, 'Astafiev Igor Alexandrovich', '10.08.1995'),
    (9, 'Gaityukevich Andrey Igorevich', '02.05.1995'),
    (9, 'Ruchenya Natalya Alexandrovna', '01/08/1995'),
    (9, 'Tarasevich Anastasia Ivanovna', '11.09.1995'),
    (10, 'Zhoglin Nikolay Vladimirovich', '01/08/1994'),
    (10, 'Sanko Andrey Dmitrievich', '11.09.1994'),
    (10, 'Peshchur Anna Alexandrovna', '04/06/1994'),
    (10, 'Buchalis Nikita Leonidovich', '12.08.1994'),
    (11, 'Lavrenchuk Vladislav Nikolaevich', '07.11.1993'),
    (11, 'Vlasik Evgenia Viktorovna', '04.06.1993'),
    (11, 'Abramov Denis Dmitrievich', '12/10/1993'),
    (11, 'Olenchik Sergey Nikolaevich', '04.07.1993'),
    (11, 'Pavel Andreevich Savinko', '01/08/1993'),
    (11, 'Bakun Alexey Viktorovich', '02.09.1993'),
    (12, 'Ban Sergey Anatolyevich', '12/11/1995'),
    (12, 'Secheiko Ilya Aleksandrovich', '10.06.1995'),
    (12, 'Kuzmicheva Anna Andreevna', '09.08.1995'),
    (12, 'Burko Diana Frantsevna', '04.07.1995'),
    (12, 'Danilenko Maxim Vasilievich', '03/08/1995'),
    (12, 'Zizyuk Olga Olegovna', '12.09.1995'),
    (13, 'Sharapo Maria Vladimirovna', '08.10.1994'),
    (13, 'Kasperovich Vadim Viktorovich', '10.02.1994'),
    (13, 'Chuprygin Arseniy Aleksandrovich', '11.11.1994'),
    (13, 'Voevodskaya Olga Leonidovna', '10.02.1994'),
    (13, 'Metushevsky Denis Igorevich', '12.01.1994'),
    (14, 'Lovetskaya Valeria Aleksandrovna', '11.09.1993'),
    (14, 'Dvorak Antonina Nikolaevna', '01.12.1993'),
    (14, 'Pike Tatyana Nikolaevna', '06/09/1993'),
    (14, 'Koblinets Alexandra Evgenievna', '01/05/1993'),
    (14, 'Fomichevskaya Elena ErnesTOBna', '01.07.1993'),
    (15, 'Besarab Margarita Vadimovna', '04/07/1992'),
    (15, 'Baduro Victoria Sergeevna', '12/10/1992'),
    (15, 'Tarasenko Olga Viktorovna', '05.05.1992'),
    (15, 'Afanasenko Olga Vladimirovna', '11.01.1992'),
    (15, 'Chuykevich Irina Dmitrievna', '04.06.1992'),
    (16, 'Brel Alesya Alekseevna', '01/08/1994'),
    (16, 'Kuznetsova Anastasia Andreevna', '02/07/1994'),
    (16, 'Tomina Karina Gennadievna', '12.06.1994'),
    (16, 'Dubrova Pavel Igorevich', '03.07.1994'),
    (16, 'Shpakov Viktor Andreevich', '04.07.1994'),
    (17, 'Schneider Anastasia Dmitrievna', '08.11.1993'),
    (17, 'Shygina Elena Viktorovna', '04/02/1993'),
    (17, 'Klyueva Anna Ivanovna', '03.06.1993'),
    (17, 'Domorad Marina Andreevna', '05.11.1993'),
    (17, 'Mikhail Aleksandrovich Linchuk', '07/03/1993'),
    (18, 'Daria Olegovna Vasilyeva', '01/08/1995'),
    (18, 'Schigelskaya Ekaterina Andreevna', '06.09.1995'),
    (18, 'Sazonova Ekaterina Dmitrievna', '03/08/1995'),
    (18, 'Bakunovich Alina Olegovna', '08/07/1995')

create table PROGRESS
(
    SUBJECT char(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),
    IDSTUDENT integer constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),
    PDATE date,
    NOTE integer check (NOTE between 1 and 10)
)

insert into PROGRESS
    (SUBJECT, IDSTUDENT, PDATE, NOTE)
values
    ('OAeP', 1000, '01.10.2013', 6),
    ('OAeP', 1001, '01.10.2013', 8),
    ('OAeP', 1002, '01.10.2013', 7),
    ('OAeP', 1003, '01.10.2013', 5),
    ('OAeP', 1005, '01.10.2013', 4),
    ('CUBD', 1014, '01.12.2013', 5),
    ('CUBD', 1015, '01.12.2013', 9),
    ('CUBD', 1016, '01.12.2013', 5),
    ('CUBD', 1017, '01.12.2013', 4),
    ('KG', 1018, '06.5.2013', 4),
    ('KG', 1019, '06.05.2013', 7),
    ('KG', 1020, '06.05.2013', 7),
    ('KG', 1021, '06.05.2013', 9),
    ('KG', 1022, '06.05.2013', 5),
    ('KG', 1023, '06.05.2013', 10),
    ('KG', 1024, '06.05.2013', 10),
    ('KG', 1025, '06.05.2013', 3)

insert into PROGRESS
    (SUBJECT,IDSTUDENT,PDATE, NOTE)
values
    ('OAeP', 1074, '01.10.2013', 6),
    ('OAeP', 1075, '01.10.2013', 8),
    ('OAeP', 1076, '01.10.2013', 7),
    ('OAeP', 1077, '01.10.2013', 5),
    ('OAeP', 1078, '01.10.2013', 4),
    ('BD', 1079, '01.10.2013', 6),
    ('BD', 1080, '01.10.2013', 8),
    ('BD', 1081, '01.10.2013', 7),
    ('BD', 1082, '01.10.2013', 5),
    ('BD', 1083, '01.10.2013', 6)

insert into PROGRESS
    (SUBJECT,IDSTUDENT,PDATE, NOTE)
values
    ('OAeP', 1051, '01.10.2013', 6),
    ('OAeP', 1052, '01.10.2013', 8),
    ('OAeP', 1053, '01.10.2013', 7),
    ('OAeP', 1054, '01.10.2013', 5),
    ('OAeP', 1055, '01.10.2013', 4),
    ('BD', 1056, '01.10.2013', 6),
    ('BD', 1057, '01.10.2013', 8),
    ('BD', 1058, '01.10.2013', 7),
    ('BD', 1059, '01.10.2013', 5),
    ('BD', 1060, '01.10.2013', 6)

create table AUDITORIUM_TYPE
(
    AUDITORIUM_TYPE char(10) constraint AUDITORIUM_TYPE_PK  primary key,
    AUDITORIUM_TYPENAME varchar(40)
);

insert into AUDITORIUM_TYPE
    (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )
values('LK', 'Lecture'),
    ('LB-K', 'Computer class'),
    ('LK-K', 'Lecture room with installed projector'),
    ('LB-X', 'Chemical Laboratory'),
    ('LB-CK', 'Special computer class');

create table AUDITORIUM
(
    AUDITORIUM char(20) constraint AUDITORIUM_PK  primary key,
    AUDITORIUM_TYPE char(10) constraint  AUDITORIUM_AUDITORIUM_TYPE_FK foreign key         
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE),
    AUDITORIUM_CAPACITY integer constraint  AUDITORIUM_CAPACITY_CHECK default 1 check (AUDITORIUM_CAPACITY between 1 and 300),
    AUDITORIUM_NAME varchar(50)
);

insert into  AUDITORIUM
    (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)
values
    ('206-1', '206-1', 'LB-K', 15),
    ('301-1', '301-1', 'LB-K', 15),
    ('236-1', '236-1', 'LK', 60),
    ('313-1', '313-1', 'LK-K', 60),
    ('324-1', '324-1', 'LK-K', 50),
    ('413-1', '413-1', 'LB-K', 15),
    ('423-1', '423-1', 'LB-K', 90),
    ('408-2', '408-2', 'LK', 90);


    select f.FACULTY from FACULTY f;
