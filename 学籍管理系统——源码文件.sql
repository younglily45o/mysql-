drop database if exists student_db;
create database student_db;
use student_db;
/*1. 用户权限表
/*该表用于存储用户信息以及其所拥有的权限级别。*/
CREATE TABLE `user_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `auth_level` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*2. 学生信息表
/*该表用于存储学生的基本信息。*/
CREATE TABLE `student_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `birthday` date NOT NULL,
  `enroll_year` int(11) NOT NULL,
  `major` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*3. 学生成绩表
/*该表用于存储学生的成绩信息。*/
CREATE TABLE `student_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `course_name` varchar(50) NOT NULL,
  `score` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_id` (`student_id`),
  CONSTRAINT `fk_student_id` FOREIGN KEY (`student_id`) REFERENCES `student_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*4. 用户权限级别表
/*该表用于存储不同权限级别的信息。*/
CREATE TABLE `auth_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `auth_level` (`name`) VALUES
('系统管理员'),
('部门管理员'),
('部门操作员'),
('部门员工');

/* 1. 插入用户权限表随机数据 */
INSERT INTO user_auth (username, password, auth_level)
VALUES
('admin', 'admin123', 1),
('dept_admin', 'deptadmin123', 2),
('dept_operator', 'deptoperator123', 3),
('dept_employee', 'deptemployee123', 3),
('user1', 'user1123', 4),
('user2', 'user2123', 4);

/* 2. 插入学生信息表随机数据 */
INSERT INTO student_info (name, gender, birthday, enroll_year, major)
VALUES
('张三', 'male', '2000-01-01', 2019, '计算机科学与技术'),
('李四', 'male', '1999-05-01', 2018, '物联网工程'),
('王五', 'male', '2001-08-01', 2020, '电子信息工程'),
('赵六', 'female', '2002-04-01', 2021, '通信工程'),
('钱七', 'female', '1998-11-01', 2017, '软件工程');

/* 3. 插入学生成绩表随机数据 */
INSERT INTO student_score (student_id, course_name, score)
VALUES
(1, '数据结构', 88.5),
(1, '算法设计', 91),
(1, '操作系统', 86.5),
(2, '数据结构', 75),
(2, '算法设计', 81.5),
(2, '操作系统', 78),
(3, '数据结构', 92),
(3, '算法设计', 90),
(3, '操作系统', 94),
(4, '数据结构', 85.5),
(4, '算法设计', 83),
(4, '操作系统', 87),
(5, '数据结构', 78),
(5, '算法设计', 85.5),
(5, '操作系统', 79),
(1, '高等数学', 89),
(2, '高等数学', 77),
(3, '高等数学', 95),
(4, '高等数学', 86),
(5, '高等数学', 80);

drop user if exists 
	`admin`@localhost,dept_admin@localhost,
    dept_operator@localhost,dept_employee@localhost,
    user1@localhost,user2@localhost;
create user 
    'admin'@'localhost' identified by 'admin123',
    'dept_admin'@'localhost' identified by 'deptadmin123',
    'dept_operator'@'localhost' identified by 'deptoperator123',
    'dept_employee'@'localhost' identified by 'deptemployee123',
    'user1'@'localhost' identified by 'user1123',
    'user2'@'localhost' identified by 'user2123';
    
grant all on * to `admin`@localhost;
grant all on student_db.* to dept_admin@localhost;
grant create,alter,drop,select on student_db.* to dept_operator@localhost;
grant create,alter,drop,select on student_db.* to dept_employee@localhost;
grant select on student_db.* to user1@localhost;
grant select on student_db.* to user2@localhost;


/*查询所有学生的姓名和所在专业：*/
SELECT name, major FROM student_info;

/*查询某个学生的姓名、所在专业和成绩：*/
SELECT si.name, si.major, ss.score
FROM student_info si
LEFT JOIN student_score ss ON si.id = ss.student_id
WHERE si.id = 1;


