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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-23 20:16:41
