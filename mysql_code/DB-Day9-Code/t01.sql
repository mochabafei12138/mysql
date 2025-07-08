-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb1
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `mydb1`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mydb1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `mydb1`;

--
-- Table structure for table `a`
--

DROP TABLE IF EXISTS `a`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a` (
  `sname` varchar(20) DEFAULT NULL,
  `num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `a`
--

LOCK TABLES `a` WRITE;
/*!40000 ALTER TABLE `a` DISABLE KEYS */;
INSERT INTO `a` VALUES ('a',10),('b',20),('c',30);
/*!40000 ALTER TABLE `a` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b`
--

DROP TABLE IF EXISTS `b`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `b` (
  `sname` varchar(20) DEFAULT NULL,
  `num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b`
--

LOCK TABLES `b` WRITE;
/*!40000 ALTER TABLE `b` DISABLE KEYS */;
INSERT INTO `b` VALUES ('a',10),('b',40),('c',30);
/*!40000 ALTER TABLE `b` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bike`
--

DROP TABLE IF EXISTS `bike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bike` (
  `bid` int NOT NULL COMMENT '单车编号',
  `in_use` tinyint(1) DEFAULT NULL COMMENT '使用状态',
  `kind` int DEFAULT NULL COMMENT '单车类型',
  PRIMARY KEY (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bike`
--

LOCK TABLES `bike` WRITE;
/*!40000 ALTER TABLE `bike` DISABLE KEYS */;
/*!40000 ALTER TABLE `bike` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c`
--

DROP TABLE IF EXISTS `c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c` (
  `sname` varchar(20) DEFAULT NULL,
  `num` int DEFAULT NULL,
  `score` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c`
--

LOCK TABLES `c` WRITE;
/*!40000 ALTER TABLE `c` DISABLE KEYS */;
INSERT INTO `c` VALUES ('a',10,34),('b',20,54),('c',30,56);
/*!40000 ALTER TABLE `c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cou53`
--

DROP TABLE IF EXISTS `cou53`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cou53` (
  `cno` int NOT NULL COMMENT '课程号',
  `cname` varchar(30) DEFAULT NULL COMMENT '课程名称',
  PRIMARY KEY (`cno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='课程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cou53`
--

LOCK TABLES `cou53` WRITE;
/*!40000 ALTER TABLE `cou53` DISABLE KEYS */;
/*!40000 ALTER TABLE `cou53` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cou54`
--

DROP TABLE IF EXISTS `cou54`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cou54` (
  `cno` int NOT NULL,
  `cname` varchar(30) DEFAULT NULL COMMENT '课程名称',
  PRIMARY KEY (`cno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='课程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cou54`
--

LOCK TABLES `cou54` WRITE;
/*!40000 ALTER TABLE `cou54` DISABLE KEYS */;
/*!40000 ALTER TABLE `cou54` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept`
--

DROP TABLE IF EXISTS `dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dept` (
  `deptno` int NOT NULL COMMENT '部门编号',
  `deptname` varchar(20) DEFAULT NULL COMMENT '部门名称',
  `address` varchar(10) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept`
--

LOCK TABLES `dept` WRITE;
/*!40000 ALTER TABLE `dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp`
--

DROP TABLE IF EXISTS `emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp` (
  `empno` int DEFAULT NULL COMMENT '工号',
  `ename` varchar(20) DEFAULT NULL COMMENT '姓名',
  `gender` varchar(10) DEFAULT NULL COMMENT '性别',
  `job` varchar(20) DEFAULT NULL COMMENT '岗位',
  `leaderno` int DEFAULT NULL COMMENT '领导工号',
  `birth` date DEFAULT NULL COMMENT '生日',
  `salary` int DEFAULT NULL COMMENT '底薪',
  `extra` int DEFAULT NULL COMMENT '绩效',
  `deptno` int DEFAULT NULL COMMENT '部门编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='员工表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp`
--

LOCK TABLES `emp` WRITE;
/*!40000 ALTER TABLE `emp` DISABLE KEYS */;
INSERT INTO `emp` VALUES (7369,'smith','male','clark',7902,'1980-12-17',800,NULL,20),(7499,'allen','female','salesman',7698,'1981-02-20',1600,300,30),(7521,'ward','male','salesman',7698,'1981-02-22',1250,500,30),(7566,'jones','female','managen',7839,'1981-04-02',2975,NULL,30),(7654,'martin','male','salesman',7698,'1981-09-28',1250,1400,30),(7698,'blake','female','manager',7839,'1981-05-01',2850,NULL,30),(7782,'clark','female','manageer',7839,'1980-06-17',2450,NULL,10),(7788,'scott','male','analyst',7566,'1987-02-20',3000,NULL,20),(7839,'king','male','president',NULL,'1987-02-20',5000,NULL,10),(7219,'aaa','female','salesman',7698,'1981-02-20',2975,300,10),(7230,'aaa','female','managen',7839,'1981-04-02',1200,NULL,30),(7561,'bbb','female','managen',7839,'1981-04-02',1250,NULL,30),(7710,'ccc','female','managen',7839,'1981-04-02',1000,NULL,30);
/*!40000 ALTER TABLE `emp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emplyee`
--

DROP TABLE IF EXISTS `emplyee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emplyee` (
  `eno` int DEFAULT NULL COMMENT '工号',
  `ename` varchar(20) DEFAULT NULL COMMENT '员工姓名',
  `deptno` int DEFAULT NULL COMMENT '部门编号',
  KEY `fk_emp_dept` (`deptno`),
  CONSTRAINT `fk_emp_dept` FOREIGN KEY (`deptno`) REFERENCES `dept` (`deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emplyee`
--

LOCK TABLES `emplyee` WRITE;
/*!40000 ALTER TABLE `emplyee` DISABLE KEYS */;
/*!40000 ALTER TABLE `emplyee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `new_emp`
--

DROP TABLE IF EXISTS `new_emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `new_emp` (
  `deptno` int DEFAULT NULL COMMENT '部门编号',
  `max_sal` int DEFAULT NULL COMMENT '底薪'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `new_emp`
--

LOCK TABLES `new_emp` WRITE;
/*!40000 ALTER TABLE `new_emp` DISABLE KEYS */;
INSERT INTO `new_emp` VALUES (20,3000),(30,2975),(10,5000);
/*!40000 ALTER TABLE `new_emp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `record`
--

DROP TABLE IF EXISTS `record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `record` (
  `rid` int NOT NULL COMMENT '流水号',
  `uid` int DEFAULT NULL COMMENT '用户编号',
  `bid` int DEFAULT NULL COMMENT '单车编号',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `payway` varchar(10) DEFAULT NULL COMMENT '支付方式',
  `payment` int DEFAULT NULL COMMENT '支付金额',
  PRIMARY KEY (`rid`),
  KEY `fk_rec_user` (`uid`),
  KEY `fk_rec_bike` (`bid`),
  CONSTRAINT `fk_rec_bike` FOREIGN KEY (`bid`) REFERENCES `bike` (`bid`),
  CONSTRAINT `fk_rec_user` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `record`
--

LOCK TABLES `record` WRITE;
/*!40000 ALTER TABLE `record` DISABLE KEYS */;
/*!40000 ALTER TABLE `record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sco51`
--

DROP TABLE IF EXISTS `sco51`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sco51` (
  `sid` int DEFAULT NULL COMMENT '学号',
  `cno` int DEFAULT NULL COMMENT '课程号',
  `score` int DEFAULT NULL COMMENT '成绩',
  KEY `stu_sco_51_sid` (`sid`),
  CONSTRAINT `stu_sco_51_sid` FOREIGN KEY (`sid`) REFERENCES `stu51` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sco51`
--

LOCK TABLES `sco51` WRITE;
/*!40000 ALTER TABLE `sco51` DISABLE KEYS */;
/*!40000 ALTER TABLE `sco51` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sco52`
--

DROP TABLE IF EXISTS `sco52`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sco52` (
  `sid` int DEFAULT NULL COMMENT '学号',
  `cno` int DEFAULT NULL COMMENT '课程号',
  `score` int DEFAULT NULL COMMENT '成绩',
  KEY `stu_sco_52_sid` (`sid`),
  CONSTRAINT `stu_sco_52_sid` FOREIGN KEY (`sid`) REFERENCES `stu52` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='成绩表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sco52`
--

LOCK TABLES `sco52` WRITE;
/*!40000 ALTER TABLE `sco52` DISABLE KEYS */;
/*!40000 ALTER TABLE `sco52` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sco53`
--

DROP TABLE IF EXISTS `sco53`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sco53` (
  `sid` int DEFAULT NULL COMMENT '学号',
  `cno` int DEFAULT NULL COMMENT '课程号',
  `score` int DEFAULT NULL COMMENT '成绩',
  KEY `stu_sco_53_sid` (`sid`),
  KEY `cou_sco_53_cno` (`cno`),
  CONSTRAINT `cou_sco_53_cno` FOREIGN KEY (`cno`) REFERENCES `cou53` (`cno`),
  CONSTRAINT `stu_sco_53_sid` FOREIGN KEY (`sid`) REFERENCES `stu53` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='成绩表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sco53`
--

LOCK TABLES `sco53` WRITE;
/*!40000 ALTER TABLE `sco53` DISABLE KEYS */;
/*!40000 ALTER TABLE `sco53` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sco54`
--

DROP TABLE IF EXISTS `sco54`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sco54` (
  `sid` int DEFAULT NULL COMMENT '学号',
  `cno` int DEFAULT NULL COMMENT '课程号',
  `score` int DEFAULT NULL COMMENT '成绩',
  KEY `stu_sco_54_sid` (`sid`),
  KEY `cou_sco_54_cno` (`cno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='成绩表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sco54`
--

LOCK TABLES `sco54` WRITE;
/*!40000 ALTER TABLE `sco54` DISABLE KEYS */;
/*!40000 ALTER TABLE `sco54` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `score`
--

DROP TABLE IF EXISTS `score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `score` (
  `sno` varchar(5) DEFAULT NULL COMMENT '学号',
  `cno` varchar(5) DEFAULT NULL COMMENT '课程号',
  `degree` varchar(3) DEFAULT NULL COMMENT '成绩',
  KEY `stu_sco_sno` (`sno`),
  CONSTRAINT `stu_sco_sno` FOREIGN KEY (`sno`) REFERENCES `student` (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `score`
--

LOCK TABLES `score` WRITE;
/*!40000 ALTER TABLE `score` DISABLE KEYS */;
INSERT INTO `score` VALUES ('103','3-245','86'),('105','3-245','75'),('109','3-245','68'),('103','3-105','92'),('105','3-105','88'),('109','3-105','76'),('103','3-105','64'),('105','3-105','91'),('109','3-105','78'),('103','6-166','85'),('105','6-166','79'),('109','6-166','81');
/*!40000 ALTER TABLE `score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu`
--

DROP TABLE IF EXISTS `stu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu` (
  `score` int DEFAULT NULL,
  `uid` int DEFAULT NULL,
  `hobby` varchar(20) DEFAULT NULL,
  `username` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu`
--

LOCK TABLES `stu` WRITE;
/*!40000 ALTER TABLE `stu` DISABLE KEYS */;
/*!40000 ALTER TABLE `stu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu11`
--

DROP TABLE IF EXISTS `stu11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu11` (
  `sid` int NOT NULL COMMENT '学号',
  `sname` varchar(20) NOT NULL COMMENT '姓名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu11`
--

LOCK TABLES `stu11` WRITE;
/*!40000 ALTER TABLE `stu11` DISABLE KEYS */;
/*!40000 ALTER TABLE `stu11` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu12`
--

DROP TABLE IF EXISTS `stu12`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu12` (
  `sid` int DEFAULT NULL,
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu12`
--

LOCK TABLES `stu12` WRITE;
/*!40000 ALTER TABLE `stu12` DISABLE KEYS */;
INSERT INTO `stu12` VALUES (1001,NULL),(1002,NULL);
/*!40000 ALTER TABLE `stu12` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu21`
--

DROP TABLE IF EXISTS `stu21`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu21` (
  `sid` int NOT NULL COMMENT '学号',
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  `address` varchar(50) DEFAULT '北京' COMMENT '家庭住址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu21`
--

LOCK TABLES `stu21` WRITE;
/*!40000 ALTER TABLE `stu21` DISABLE KEYS */;
INSERT INTO `stu21` VALUES (1001,NULL,'北京'),(1002,'aaa','上海');
/*!40000 ALTER TABLE `stu21` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu22`
--

DROP TABLE IF EXISTS `stu22`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu22` (
  `sid` int NOT NULL COMMENT '学号',
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  `address` varchar(50) NOT NULL DEFAULT '北京' COMMENT '家庭住址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu22`
--

LOCK TABLES `stu22` WRITE;
/*!40000 ALTER TABLE `stu22` DISABLE KEYS */;
/*!40000 ALTER TABLE `stu22` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu31`
--

DROP TABLE IF EXISTS `stu31`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu31` (
  `sid` int NOT NULL COMMENT '学号',
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  `card_id` varchar(18) DEFAULT NULL COMMENT '身份证号',
  UNIQUE KEY `card_id` (`card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu31`
--

LOCK TABLES `stu31` WRITE;
/*!40000 ALTER TABLE `stu31` DISABLE KEYS */;
INSERT INTO `stu31` VALUES (1001,'aaa','23456789'),(1001,'aaa',NULL),(1001,'aaa',NULL);
/*!40000 ALTER TABLE `stu31` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu32`
--

DROP TABLE IF EXISTS `stu32`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu32` (
  `sid` int NOT NULL COMMENT '学号',
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  `card_id` varchar(18) DEFAULT NULL,
  UNIQUE KEY `card_id` (`card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu32`
--

LOCK TABLES `stu32` WRITE;
/*!40000 ALTER TABLE `stu32` DISABLE KEYS */;
INSERT INTO `stu32` VALUES (1001,'aaa','23456789');
/*!40000 ALTER TABLE `stu32` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu41`
--

DROP TABLE IF EXISTS `stu41`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu41` (
  `sid` int NOT NULL COMMENT '学号',
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu41`
--

LOCK TABLES `stu41` WRITE;
/*!40000 ALTER TABLE `stu41` DISABLE KEYS */;
INSERT INTO `stu41` VALUES (1,'aff');
/*!40000 ALTER TABLE `stu41` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu42`
--

DROP TABLE IF EXISTS `stu42`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu42` (
  `sid` int DEFAULT NULL,
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu42`
--

LOCK TABLES `stu42` WRITE;
/*!40000 ALTER TABLE `stu42` DISABLE KEYS */;
/*!40000 ALTER TABLE `stu42` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu43`
--

DROP TABLE IF EXISTS `stu43`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu43` (
  `sid` int NOT NULL AUTO_INCREMENT COMMENT '学号',
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu43`
--

LOCK TABLES `stu43` WRITE;
/*!40000 ALTER TABLE `stu43` DISABLE KEYS */;
INSERT INTO `stu43` VALUES (3,'aaaa'),(4,'bbb'),(5,'ccc'),(6,'eee'),(8,'uuu');
/*!40000 ALTER TABLE `stu43` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu44`
--

DROP TABLE IF EXISTS `stu44`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu44` (
  `sid` int NOT NULL AUTO_INCREMENT,
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu44`
--

LOCK TABLES `stu44` WRITE;
/*!40000 ALTER TABLE `stu44` DISABLE KEYS */;
/*!40000 ALTER TABLE `stu44` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu45`
--

DROP TABLE IF EXISTS `stu45`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu45` (
  `sid` int NOT NULL AUTO_INCREMENT COMMENT '学号',
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu45`
--

LOCK TABLES `stu45` WRITE;
/*!40000 ALTER TABLE `stu45` DISABLE KEYS */;
INSERT INTO `stu45` VALUES (6,'aaaa'),(7,'ddd'),(8,'bbb');
/*!40000 ALTER TABLE `stu45` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu51`
--

DROP TABLE IF EXISTS `stu51`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu51` (
  `sid` int NOT NULL AUTO_INCREMENT COMMENT '学号',
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  `age` int DEFAULT NULL COMMENT '年龄',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu51`
--

LOCK TABLES `stu51` WRITE;
/*!40000 ALTER TABLE `stu51` DISABLE KEYS */;
/*!40000 ALTER TABLE `stu51` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu52`
--

DROP TABLE IF EXISTS `stu52`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu52` (
  `sid` int NOT NULL,
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  `age` int DEFAULT NULL COMMENT '年龄',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu52`
--

LOCK TABLES `stu52` WRITE;
/*!40000 ALTER TABLE `stu52` DISABLE KEYS */;
/*!40000 ALTER TABLE `stu52` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu53`
--

DROP TABLE IF EXISTS `stu53`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu53` (
  `sid` int NOT NULL COMMENT '学号',
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  `age` int DEFAULT NULL COMMENT '年龄',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu53`
--

LOCK TABLES `stu53` WRITE;
/*!40000 ALTER TABLE `stu53` DISABLE KEYS */;
/*!40000 ALTER TABLE `stu53` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu54`
--

DROP TABLE IF EXISTS `stu54`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu54` (
  `sid` int NOT NULL,
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  `age` int DEFAULT NULL COMMENT '年龄'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu54`
--

LOCK TABLES `stu54` WRITE;
/*!40000 ALTER TABLE `stu54` DISABLE KEYS */;
/*!40000 ALTER TABLE `stu54` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `sno` varchar(5) NOT NULL,
  `sname` varchar(20) DEFAULT NULL COMMENT '姓名',
  `ssex` varchar(1) DEFAULT NULL COMMENT '性别',
  `sbirth` date DEFAULT NULL COMMENT '生日',
  `class` varchar(5) DEFAULT NULL COMMENT '班级号',
  PRIMARY KEY (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('101','李军','男','1976-02-20','95033'),('103','陆君','男','1974-06-03','95031'),('105','匡明','男','1975-10-02','95031'),('107','王丽','女','1976-01-23','95033'),('108','曾华','男','1977-09-01','95033'),('109','王芳','女','1975-02-10','95031');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_person`
--

DROP TABLE IF EXISTS `tb_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_person` (
  `pno` int NOT NULL COMMENT '用户编号',
  `pname` varchar(20) NOT NULL COMMENT '用户名',
  `birth` date NOT NULL COMMENT '生日',
  PRIMARY KEY (`pno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_person`
--

LOCK TABLES `tb_person` WRITE;
/*!40000 ALTER TABLE `tb_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_shopcar`
--

DROP TABLE IF EXISTS `tb_shopcar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_shopcar` (
  `pno` int DEFAULT NULL COMMENT '用户编号',
  `car_id` int DEFAULT NULL COMMENT '购物车编号',
  KEY `fk_per_car` (`pno`),
  CONSTRAINT `fk_per_car` FOREIGN KEY (`pno`) REFERENCES `tb_person` (`pno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_shopcar`
--

LOCK TABLES `tb_shopcar` WRITE;
/*!40000 ALTER TABLE `tb_shopcar` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_shopcar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_ym_sales`
--

DROP TABLE IF EXISTS `tb_ym_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_ym_sales` (
  `yearly` int NOT NULL COMMENT '年份',
  `monthly` int NOT NULL COMMENT '月份',
  `sales` int DEFAULT NULL COMMENT '销量',
  PRIMARY KEY (`yearly`,`monthly`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_ym_sales`
--

LOCK TABLES `tb_ym_sales` WRITE;
/*!40000 ALTER TABLE `tb_ym_sales` DISABLE KEYS */;
INSERT INTO `tb_ym_sales` VALUES (2021,1,84),(2021,2,24),(2021,3,50),(2021,4,73),(2021,6,91),(2021,7,52),(2021,8,85),(2021,9,57),(2021,10,32),(2021,11,64),(2021,12,69),(2022,1,82),(2022,2,13),(2022,3,52),(2022,4,55),(2022,5,87),(2022,6,32),(2022,7,46),(2022,8,81),(2022,9,14),(2022,10,68),(2022,11,51),(2022,12,56);
/*!40000 ALTER TABLE `tb_ym_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_table`
--

DROP TABLE IF EXISTS `temp_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp_table` (
  `empno` int DEFAULT NULL COMMENT '工号',
  `ename` varchar(20) DEFAULT NULL COMMENT '姓名',
  `gender` varchar(10) DEFAULT NULL COMMENT '性别',
  `job` varchar(20) DEFAULT NULL COMMENT '岗位',
  `leaderno` int DEFAULT NULL COMMENT '领导工号',
  `birth` date DEFAULT NULL COMMENT '生日',
  `salary` int DEFAULT NULL COMMENT '底薪',
  `extra` int DEFAULT NULL COMMENT '绩效',
  `deptno` int DEFAULT NULL COMMENT '部门编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_table`
--

LOCK TABLES `temp_table` WRITE;
/*!40000 ALTER TABLE `temp_table` DISABLE KEYS */;
INSERT INTO `temp_table` VALUES (7499,'allen','female','salesman',7698,'1981-02-20',1600,300,30),(7521,'ward','male','salesman',7698,'1981-02-22',1250,500,30),(7566,'jones','female','managen',7839,'1981-04-02',2975,NULL,30),(7654,'martin','male','salesman',7698,'1981-09-28',1250,1400,30),(7698,'blake','female','manager',7839,'1981-05-01',2850,NULL,30),(7230,'aaa','female','managen',7839,'1981-04-02',1200,NULL,30),(7561,'bbb','female','managen',7839,'1981-04-02',1250,NULL,30),(7710,'ccc','female','managen',7839,'1981-04-02',1000,NULL,30);
/*!40000 ALTER TABLE `temp_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `uid` int NOT NULL COMMENT '用户编号',
  `uname` varchar(20) DEFAULT NULL COMMENT '用户名称',
  `ulevel` int DEFAULT NULL COMMENT '用户等级',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `worker`
--

DROP TABLE IF EXISTS `worker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `worker` (
  `uid` int DEFAULT NULL,
  `uname` varchar(10) DEFAULT NULL,
  `salary` float DEFAULT NULL,
  `hobby` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worker`
--

LOCK TABLES `worker` WRITE;
/*!40000 ALTER TABLE `worker` DISABLE KEYS */;
/*!40000 ALTER TABLE `worker` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-23 20:10:27
