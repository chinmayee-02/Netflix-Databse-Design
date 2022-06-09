use z511s22cmundhe8;

drop table if exists watchlist;
drop table if exists haswatched;
drop table if exists streaming;
drop table if exists canaccess;
drop table if exists tvshow;
drop table if exists movie;
drop table if exists languages;
drop table if exists morelikethis;
drop table if exists content;
drop table if exists profiles;
drop table if exists transact;
drop table if exists payment;
drop table if exists subscription; 
drop table if exists plan; 
drop table if exists user; 


create table user  
(userid char(10) not null, 
password varchar(20) not null, 
username varchar(20) not null, 
emailid varchar(20) not null unique, 
gender enum('M', 'F'), 
phone char(10) not null unique, 
dateofbirth date not null, 
age int GENERATED ALWAYS AS ((YEAR (CURDATE()) - year(dateofbirth))), 
country varchar(20) not null, 
signupdate date not null, 
PRIMARY KEY (userid));


create table plan 
(planid char(2) not null unique, 
planduration int not null, 
plandesc varchar(100), 
plancost float,
PRIMARY KEY (planid)); 


create table subscription  
(subscriptionid char(10) not null unique, 
subscriptionstartdate date, 
userid char(10) not null, 
planid char(2) not null, 
subscriptionenddate date, 
PRIMARY KEY (subscriptionid), 
foreign key (userid) references user(userid) on delete cascade, 
foreign key (planid) references plan(planid) on delete cascade);



create table payment
( paymenttype varchar(10) not null,
accountno varchar(10) not null unique,
validthru date,
billingaddress varchar(25) not null,
billingstate varchar(25) not null,
billingcountry varchar(25) not null,
billingzipcode varchar(25) not null,
userid char(10) not null,
PRIMARY KEY(paymenttype,userid),
FOREIGN KEY(userid) references user(userid)
);


create table transact
( transactionid char(10) not null unique,
transactiondate date,
planid char(2) not null, 
userid char(10) not null,
PRIMARY KEY (transactionid), 
foreign key (userid) references user(userid) on delete cascade, 
foreign key (planid) references plan(planid) on delete cascade
);


create table profiles
( profileid char(10) not null unique,
userid char(10) not null,
PRIMARY KEY(profileid,userid),
FOREIGN KEY(userid) references user(userid)
);


-------------------------------------------------------------



create table content
(contentid char(10) not null,
contentname varchar(70) not null,
contentdesc varchar(200) not null,
genre varchar(25) not null,
rating float,
pgrating enum('G','PG','PG-13','R','NC-17'),
PRIMARY KEY(contentid)
);


create table morelikethis
( primarycontentid char(10) not null,
secondarycontentid char(10) not null,
PRIMARY KEY(primarycontentid,secondarycontentid),
FOREIGN KEY(primarycontentid) references content(contentid),
FOREIGN KEY(secondarycontentid) references content(contentid)
);


create table languages
( languages varchar(10) not null,
contentid char(10) not null,
PRIMARY KEY(languages,contentid),
FOREIGN KEY(contentid) references content(contentid)
);


create table movie
( contentid char(10) not null unique,
movietype varchar(20) not null,
PRIMARY KEY(contentid),
FOREIGN KEY(contentid) references content(contentid)
);


create table tvshow
( contentid char(10) not null,
episode varchar(10) not null,
seasons varchar(10) not null,
PRIMARY KEY(contentid,episode,seasons),
FOREIGN KEY(contentid) references content(contentid)
);


create table canaccess
( userid char(10) not null,
contentid char(10) not null,
loc varchar(30) not null,
PRIMARY KEY(userid,contentid),
FOREIGN KEY(userid) references user(userid),
FOREIGN KEY(contentid) references content(contentid)
);


create table streaming
( userid char(10) not null,
contentid char(10) not null,
streamdate date,
PRIMARY KEY(userid,contentid),
FOREIGN KEY(userid) references user(userid),
FOREIGN KEY(contentid) references content(contentid)
);


create table haswatched
( userid char(10) not null,
contentid char(10) not null,
watchdate date,
PRIMARY KEY(userid,contentid),
FOREIGN KEY(userid) references user(userid),
FOREIGN KEY(contentid) references content(contentid)
);

create table watchlist
( userid char(10) not null,
contentid char(10) not null,
PRIMARY KEY(userid,contentid),
FOREIGN KEY(userid) references user(userid),
FOREIGN KEY(contentid) references content(contentid)
);


insert into user(userid, password, username, emailid, gender, phone, dateofbirth, country, signupdate)
values
('A838990311', 'hbduihd#*JEI(!', 'Chinmayee Mundhe', 'chinmayee@gmail.com', 'F', '8782938918', str_to_date('02/01/1996', '%m/%d/%Y'), 'India', str_to_date('04/20/2022', '%m/%d/%Y')),
('B657123422', 'pd6u7@yahoo', 'Parth Deshpande','typhoon@gmail.com', 'M', '7632345635', str_to_date('03/02/1996', '%m/%d/%Y'), 'India', str_to_date('03/30/2022', '%m/%d/%Y')),
('B657893433', 'vh6u7@4tgth78', 'Kate Sharma', 'kate@gmail.com', 'F', '6789345635', str_to_date('08/02/2019', '%m/%d/%Y'), 'USA', str_to_date('03/30/2022', '%m/%d/%Y')),
('C127893444', 'claus@pk', 'Nitu Rawat', 'claus@gmail.com', 'M', '9834145635', str_to_date('04/20/1991', '%m/%d/%Y'), 'Germany', str_to_date('03/30/2021', '%m/%d/%Y')),
('Q997893455', 'viper@zulu', 'Vishal Gupta', 'viper@reddit.com', 'M', '7835234466', str_to_date('01/26/1995', '%m/%d/%Y'), 'South Korea', str_to_date('05/15/2021', '%m/%d/%Y'))
;


insert into plan (planid, planduration, plandesc, plancost)
values
('M2', 30, 'Monthly 2 screens', 6.99),
('M4', 30, 'Monthly 4 screens', 12.99),
('S2', 180, 'Semi-Annually 2 screens', 29.99),
('S4', 180, 'Semi-Annually 4 screens', 69.99),
('A2', 360, 'Annually 2 screens', 99.99),
('A4', 360, 'Annually 4 screens', 139.99);



insert into subscription 
(subscriptionid, subscriptionstartdate, userid, planid, subscriptionenddate)
values
('QWERTYUIOP', str_to_date('04/20/2022', '%m/%d/%Y'), 'A838990311','A4', str_to_date('04/13/2023', '%m/%d/%Y')),
('ASDFGHJKLA', str_to_date('03/30/2022', '%m/%d/%Y'), 'B657893433','M2', str_to_date('04/29/2022', '%m/%d/%Y')),
('ZXCVBNMZXC', str_to_date('03/30/2022', '%m/%d/%Y'), 'B657123422','S2', str_to_date('09/27/2022', '%m/%d/%Y')),
('QAZWSXEDCR', str_to_date('05/15/2021', '%m/%d/%Y'), 'Q997893455','M4', str_to_date('06/14/2021', '%m/%d/%Y')),
('FVTGBYHNUJ', str_to_date('10/20/2021', '%m/%d/%Y'), 'Q997893455','M4', str_to_date('11/19/2021', '%m/%d/%Y')),
('XCFSYRWENU', str_to_date('03/30/2019', '%m/%d/%Y'), 'C127893444','M2', str_to_date('04/30/2019', '%m/%d/%Y')),
('MIKOLPQAZW', str_to_date('12/15/2021', '%m/%d/%Y'), 'Q997893455','M4', str_to_date('01/14/2022', '%m/%d/%Y'));


insert into profiles (profileid, userid)
values
('Chinmayee','A838990311'),
('Varsha','A838990311'),
('Parth', 'B657123422'),
('Shailesh','B657123422'),
('Kate', 'B657893433'),
('Nitu', 'C127893444'),
('Rinky', 'C127893444'),
('Vishal', 'Q997893455'),
('Aayushi', 'Q997893455');


insert into payment (paymenttype, accountno, validthru, billingaddress, billingstate, billingcountry, billingzipcode, userid)
values
('CCARD', '1234567890', str_to_date('04/20/2024', '%m/%d/%Y'), '12 Clive Blvd', 'IN', 'USA', '47408', 'A838990311'),
('DCARD', '9087654321', str_to_date('05/20/2028', '%m/%d/%Y'), '12 Clive Blvd', 'IN', 'USA', '47408', 'A838990311'),
('DCARD', '6655443387', str_to_date('11/02/2023', '%m/%d/%Y'), 'A1 Clover Park', 'IL', 'USA', '65432', 'B657123422'),
('BNKACC', '9988776655', NULL, 'A1 Clover Park', 'IL', 'USA', '65432', 'B657123422'),
('DCARD', '2288554410', str_to_date('01/02/2025', '%m/%d/%Y'), 'CP Moon dr', 'SF', 'USA', '97231', 'C127893444'),
('CCARD', '9876548765', str_to_date('08/08/2022', '%m/%d/%Y'), '123 Vista Verde', 'AP', 'India', '675431', 'Q997893455'),
('BNKACC', '231456786', NULL, '123 Vista Verde', 'AP', 'India', '675431', 'Q997893455');


insert into transact (transactionid, transactiondate, planid, userid)
values
('ASDFG12345', str_to_date('04/20/2022', '%m/%d/%Y'), 'A4', 'A838990311'),
('HJKLP09876', str_to_date('03/30/2022', '%m/%d/%Y'), 'S2', 'B657123422'),
('QWERT87654', str_to_date('03/30/2022', '%m/%d/%Y'), 'M2', 'B657893433'),
('QWEDS07654', str_to_date('03/30/2019', '%m/%d/%Y'), 'M2', 'C127893444'),
('YUIOM87234', str_to_date('12/15/2021', '%m/%d/%Y'), 'M4', 'Q997893455');

insert into content  
(contentid, contentname, contentdesc, genre, rating, pgrating) 
values 
('CK10894492', 'Parasite', 'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.','Thriller', 8.5, 'R'), 
('NT84639013', 'Jab Tak Hai Jaan', 'A bomb disposal expert becomes bitter and lonely and is unable to fall in love until he is forced to deal with his past.','Romance', 6.7, 'PG-13'), 
('KN28403781', 'Titanic', 'RMS Titanic was a British passenger liner, operated by the White Star Line, which sank in the North Atlantic Ocean','Romance', 7.9, 'PG-13'), 
('YS53946291', '13 Going On 30', 'A girl who is sick of the social strictures of junior high is transformed into a grownup overnight.','Romantic-Comedy', 6.2, 'G'), 
('AM63045720', 'Spiderman: Homecoming', 'Thrilled by his experience with the Avengers, young Peter Parker returns home to live with his Aunt May.','Action', 7.4, 'PG'), 
('SP18354026', 'Ludo', 'Four wildly different stories overlap at the whims of fate, chance, and an eccentric criminal.','Dark Comedy', 7.6, 'PG-13'), 
('XI73045192', 'Frozen', 'Anna sets off on an epic journey - teaming up with mountain man Kristoff and his loyal reindeer Sven - to find her sister Elsa.','Musical', 9.2, 'PG'),
('OQ72164925', 'Conversations with a Killer: The Ted Bundy Tapes', 'Present-day interviews, archival footage and audio recordings made on death row form a searing portrait of notorious serial killer Ted Bundy','Crime Thriller', 7.7, 'R'), 

('BS65890364', 'How I Met Your Mother', 'A father recounts to his children - through a series of flashbacks - the journey he and his four best friends took leading up to him meeting their mother.','Comedy', 8.3, 'PG'), 
('PD93528406', 'Reply 1988', 'Follows the lives of 5 families living on the same street in a neighbourhood called Ssangmundong in Seoul.','Comedy', 9.2, 'G'), 
('WL47103591', 'Money Heist', 'Eight thieves take hostages and lock themselves in the Royal Mint of Spain as a criminal mastermind manipulates the police to carry out his plan.','Thriller', 8.2, 'PG-13'), 
('SU36502784', 'Aranyak', 'Amid a tense handover on the eve of a sabbatical, Inspector Kasturi Dogra is shaken by a teen disappearance and fears of a murderous creature in town.','Crime Thriller', 7.2, 'PG-13'), 
('AO38401648', 'Descendants of the Sun', 'A love story between Captain Yoo Shi Jin, Korean Special Forces, and Doctor Kang Mo Yeon, surgeon at Haesung Hospital.','Action', 8.3, 'PG'), 
('QV47204652', 'Inventing Anna', 'Audacious entrepreneur or con artist? A reporter digs into how Anna Delvey convinced New York elite she was a German heiress.','Drama', 6.8, 'PG-13');
 

insert into languages  
(contentid, languages) 
values 
('CK10894492','Korean'),
('CK10894492','English'),
('NT84639013','Hindi'),
('NT84639013','English'),
('NT84639013','Tamil'),
('KN28403781','English'),
('KN28403781','Spanish'),
('YS53946291','English'),
('AM63045720','English'),
('AM63045720','Hindi'),
('SP18354026','Hindi'),
('SP18354026','Telgu'),
('SP18354026','English'),
('XI73045192','Hindi'),
('XI73045192','English'),
('XI73045192','Korean'),
('OQ72164925','English'),
('BS65890364','English'),
('BS65890364','Spanish'),
('PD93528406','Korean'),
('PD93528406','English'),
('WL47103591','Spanish'),
('WL47103591','English'),
('SU36502784','Hindi'),
('AO38401648','Korean'),
('AO38401648','English'),
('AO38401648','Hindi'),
('QV47204652','English'),
('QV47204652','Spanish');


insert into movie  
(contentid, movietype)
VALUES
('Ck10894492','Fiction'),
('NT84639013','Fiction'),
('KN28403781','Historical'),
('YS53946291','Fiction'),
('AM63045720','Sci-Fi'),
('SP18354026','Fiction'),
('XI73045192','Animated'),
('OQ72164925','Documentary');


insert into tvshow  
(contentid, episode,seasons)
VALUES
('BS65890364','E22','S1'),
('BS65890364','E20','S2'),
('BS65890364','E12','S3'),
('BS65890364','E18','S4'),
('BS65890364','E22','S5'),
('BS65890364','E20','S6'),
('PD93528406','E20','S1'),
('WL47103591','E6','S1'),
('WL47103591','E8','S2'),
('WL47103591','E10','S3'),
('WL47103591','E5','S4'),
('SU36502784','E10','S1'),
('AO38401648','E16','S1'),
('QV47204652','E8','S1');


insert into morelikethis  
(primarycontentid, secondarycontentid)
VALUES
('CK10894492','OQ72164925'),
('NT84639013','KN28403781'),
('NT84639013','YS53946291'),
('KN28403781','NT84639013'),
('KN28403781','YS53946291'),
('YS53946291','NT84639013'),
('YS53946291','KN28403781'),
('OQ72164925','CK10894492'),
('WL47103591','QV47204652'),
('WL47103591','SU36502784'),
('SU36502784','WL47103591'),
('QV47204652','WL47103591');

insert into canaccess
(userid, contentid, loc)
VALUES
('A838990311','AM63045720','India'),
('B657893433','WL47103591','USA'),
('C127893444','WL47103591','Germany'),
('Q997893455','AO38401648','South Korea'),
('A838990311','AO38401648','India');


insert into streaming
(userid, contentid, streamdate)
VALUES
('A838990311','AM63045720',str_to_date('06/05/2022', '%m/%d/%Y')),
('B657123422','WL47103591',str_to_date('01/02/2022', '%m/%d/%Y')),
('C127893444','WL47103591',str_to_date('01/13/2022', '%m/%d/%Y')),
('Q997893455','AO38401648',str_to_date('12/25/2021', '%m/%d/%Y')),
('B657123422','SP18354026',str_to_date('04/22/2022', '%m/%d/%Y'));


insert into haswatched
(userid, contentid, watchdate)
VALUES
('A838990311','NT84639013',str_to_date('05/12/2022', '%m/%d/%Y')),
('A838990311','WL47103591',str_to_date('04/22/2022', '%m/%d/%Y')),
('A838990311','YS53946291',str_to_date('06/02/2022', '%m/%d/%Y')),
('B657123422','WL47103591',str_to_date('04/30/2022', '%m/%d/%Y')),
('B657123422','SU36502784',str_to_date('05/03/2022', '%m/%d/%Y')),
('C127893444','AM63045720',str_to_date('04/13/2019', '%m/%d/%Y')),
('Q997893455','OQ72164925',str_to_date('05/18/2021', '%m/%d/%Y')),
('Q997893455','AO38401648',str_to_date('12/20/2021', '%m/%d/%Y'));

insert into watchlist
(userid, contentid)
VALUES
('A838990311','KN28403781'),
('A838990311','SP18354026'),
('B657123422','BS65890364'),
('C127893444','CK10894492'),
('B657893433','XI73045192'),
('B657893433','PD93528406'),
('Q997893455','NT84639013');

-------------------------------------Queries:

--Subscription query:
select userid, emailid, phone,
case when monthdiff between 1 and 3 then 'Category 1'
when monthdiff between 4 and 6 then 'Category 2'
when monthdiff between 7 and 12 then 'Category 3' 
else 'Inactive' end as reminder_category
from
(select u.userid, u.emailid, u.phone, TIMESTAMPDIFF(month, subscriptionenddate, CURDATE()) as monthdiff,
row_number() over (partition by u.userid order by s.subscriptionenddate desc) as rownum
from user u
join subscription s
on u.userid = s.userid) x
where rownum = 1 and monthdiff >= 1;


--Recommendation query:
Select distinct h.userid as user, c1.contentname as watched, c2.contentname as recommended
from morelikethis m join haswatched h
on m.primarycontentid = h.contentid
join content c1
on c1.contentid = m.primarycontentid
join content c2
on c2.contentid = m.secondarycontentid
where c2.contentid not in (select h0.contentid from haswatched h0 where h0.userid=h.userid);


--Notification to watch - 
select distinct w.userid as user, c.contentname as NotifyToWatch
from watchlist w left join streaming s
on w.userid = s.userid
join content c on w.contentid = c.contentid
where s.userid is null;


--TVShow with seasons - 
Select c.contentname, count(t.seasons) as CountSeasons
from tvshow t join content c
on t.contentid = c.contentid
group by t.contentid
having count(t.seasons) > 2;


--Genre wise counts - 
Select genre, count(*) as count
from content
group by genre;


--Language count for each content
Select c.contentname, count(l.languages) as countofLanguages
from content c join languages l
on c.contentid = l.contentid
group by c.contentid;


--Movies above rating
Select c.contentname as MovieName, c.rating
from content c
where c.rating >= 7.5
and c.contentid in (Select contentid from movie);


--Contents that can be accessed from India and USA
select c.contentname, ca.loc
from content c join canaccess ca
on c.contentid = ca.contentid
where ca.loc='India'
union
select c.contentname, ca.loc
from content c join canaccess ca
on c.contentid = ca.contentid
where ca.loc='USA';


--New subscription in past 3 months
select s.userid, s.subscriptionstartdate, s.subscriptionenddate
from subscription s
where s.subscriptionstartdate < DATE_SUB(now(), INTERVAL 3 MONTH);


--Tv Show season wise episode counts
Select c.contentname, t.seasons, count(t.episode)
from tvshow t join content c
on t.contentid = c.contentid
group by t.contentid, t.seasons;