/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.5.28 : Database - smbms
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`smbms` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `smbms`;

/*Table structure for table `smbms_bill` */

DROP TABLE IF EXISTS `smbms_bill`;

CREATE TABLE `smbms_bill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `billCode` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '账单编码',
  `productName` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `productDesc` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品描述',
  `productUnit` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品单位',
  `productCount` decimal(20,2) DEFAULT NULL COMMENT '商品数量',
  `totalPrice` decimal(20,2) DEFAULT NULL COMMENT '商品总额',
  `isPayment` int(10) DEFAULT NULL COMMENT '是否支付（0：未支付 1：已支付）',
  `createdBy` bigint(20) DEFAULT NULL COMMENT '创建者（userId）',
  `creationDate` datetime DEFAULT NULL COMMENT '创建时间',
  `modifyBy` bigint(20) DEFAULT NULL COMMENT '更新者（userId）',
  `modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
  `providerId` bigint(20) DEFAULT NULL COMMENT '供应商ID',
  `status` int(10) DEFAULT NULL COMMENT '0不可用，1可用',
  PRIMARY KEY (`id`),
  KEY `providerId` (`providerId`),
  CONSTRAINT `smbms_bill_ibfk_1` FOREIGN KEY (`providerId`) REFERENCES `smbms_provider` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `smbms_bill` */

insert  into `smbms_bill`(`id`,`billCode`,`productName`,`productDesc`,`productUnit`,`productCount`,`totalPrice`,`isPayment`,`createdBy`,`creationDate`,`modifyBy`,`modifyDate`,`providerId`,`status`) values (1,'001','可乐','无','罐','100.00','100.00',1,1,'2019-10-28 15:52:47',14,'2019-12-06 18:07:42',3,1),(2,'002','玉米','无','斤','500.00','40000.00',1,1,'2019-10-28 15:58:11',NULL,NULL,2,1),(3,'003','大米','无','斤','500.00','40000.00',0,1,'2019-10-28 15:58:44',NULL,NULL,3,1),(4,'004','绿豆','无','斤','500.00','50000.00',1,1,'2019-10-28 15:58:51',NULL,NULL,2,1),(5,'005','红豆','无','斤','500.00','45000.00',0,1,'2019-10-28 15:58:53',NULL,NULL,3,1),(6,'006','猪肉','无','斤','600.00','23000.00',0,1,'2019-10-28 15:58:56',1,'2019-10-29 09:29:02',3,1),(9,'007','苹果',NULL,'斤','600.00','23000.00',1,1,'2019-10-29 19:23:55',1,'2019-10-30 11:58:05',2,1),(10,'0010','可乐0',NULL,'冠','123.00','123.00',0,14,'2019-12-06 18:38:19',NULL,NULL,2,1),(11,'0011','尚方宝剑',NULL,'把','1000000.00','10000000000.00',0,14,'2019-12-08 18:58:33',14,'2019-12-08 18:58:44',7,1),(12,'0001','开天辟地剑',NULL,'把','1.00','222222221000.00',0,14,'2019-12-08 18:59:18',NULL,NULL,8,1),(13,'00001','如来神掌秘籍',NULL,'本','1.00','99999998000.00',0,14,'2019-12-08 18:59:44',NULL,NULL,8,1),(14,'2','2',NULL,'2','2.00','2.00',0,14,'2019-12-11 14:04:37',14,'2019-12-11 14:05:43',2,0);

/*Table structure for table `smbms_perm_role` */

DROP TABLE IF EXISTS `smbms_perm_role`;

CREATE TABLE `smbms_perm_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(50) DEFAULT NULL,
  `perm_id` int(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `smbms_perm_role_ibfk_2` (`perm_id`),
  CONSTRAINT `smbms_perm_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `smbms_role` (`id`),
  CONSTRAINT `smbms_perm_role_ibfk_2` FOREIGN KEY (`perm_id`) REFERENCES `smbms_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

/*Data for the table `smbms_perm_role` */

insert  into `smbms_perm_role`(`id`,`role_id`,`perm_id`) values (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,17),(17,2,1),(18,2,2),(19,2,4),(20,2,5),(21,2,6),(22,2,7),(24,2,9),(27,2,17),(28,3,1),(29,3,2),(30,3,5),(31,3,9),(32,3,17),(33,1,19),(34,2,19),(35,3,19),(36,2,3),(37,2,13);

/*Table structure for table `smbms_permission` */

DROP TABLE IF EXISTS `smbms_permission`;

CREATE TABLE `smbms_permission` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `perm_code` int(50) DEFAULT NULL COMMENT '权限编号',
  `perm_name` varchar(50) DEFAULT NULL COMMENT '权限名称',
  `perm_url` varchar(200) DEFAULT NULL COMMENT '权限地址',
  `parent_code` int(50) DEFAULT NULL COMMENT '父权限编号(以codeId做链接)',
  `isMenu` int(11) DEFAULT NULL COMMENT '0不是菜单。1是菜单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `smbms_permission` */

insert  into `smbms_permission`(`id`,`perm_code`,`perm_name`,`perm_url`,`parent_code`,`isMenu`) values (1,1000,'订单管理',NULL,0,0),(2,2000,'供应商管理',NULL,0,0),(3,3000,'用户管理',NULL,0,0),(4,1001,'修改','/bill/update',1000,1),(5,1002,'订单查询','/bill/getAll.do',1000,0),(6,1003,'增加订单','/billAdd.jsp',1000,0),(7,1004,'删除','/bill/del',1000,1),(8,2001,'修改','/provider/update',2000,1),(9,2002,'供应商查询','/provider/getAll.do',2000,0),(10,2003,'增加供应商','/providerAdd.jsp',2000,0),(11,2004,'删除','/provider/del',2000,1),(12,3001,'修改','/user/update',3000,1),(13,3002,'用户查询','/user/getAll.do',3000,0),(14,3003,'增加用户','/userAdd.jsp',3000,0),(15,3004,'删除','/user/del',3000,1),(17,5000,'修改密码','/password.jsp',0,0),(19,4000,'退出系统','javascript:logout()',0,0);

/*Table structure for table `smbms_provider` */

DROP TABLE IF EXISTS `smbms_provider`;

CREATE TABLE `smbms_provider` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `proCode` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '供应商编码',
  `proName` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '供应商名称',
  `proDesc` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '供应商详细描述',
  `proContact` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '供应商联系人',
  `proPhone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `proAddress` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '地址',
  `proFax` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '传真',
  `createdBy` bigint(20) DEFAULT NULL COMMENT '创建者（userId）',
  `creationDate` datetime DEFAULT NULL COMMENT '创建时间',
  `modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
  `modifyBy` bigint(20) DEFAULT NULL COMMENT '更新者（userId）',
  `status` int(10) DEFAULT NULL COMMENT '0不可用，1可用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `smbms_provider` */

insert  into `smbms_provider`(`id`,`proCode`,`proName`,`proDesc`,`proContact`,`proPhone`,`proAddress`,`proFax`,`createdBy`,`creationDate`,`modifyDate`,`modifyBy`,`status`) values (2,'PRO-CODE—002','测试供应商002','有','张三','15918230468','安庆','15918230488',1,'2019-10-27 23:13:29','2019-12-08 19:04:35',14,1),(3,'PRO-CODE—003','测试供应商003','111110000','李八','15918234444','zzz11','111100000',1,'2019-10-27 23:14:02','2019-12-05 16:59:21',14,1),(4,'PRO-CODE—004','测试供应商004','无','陈光辉','13845674444','安庆','15928233488',1,'2019-10-27 23:14:04','2019-10-30 10:03:54',1,1),(5,'PRO-CODE—005','测试供应商005','无','王二','19918234498','安庆','15928333488',1,'2019-10-27 23:15:24',NULL,NULL,1),(6,'PRO-CODE—006','测试供应商006','无','王二二','19918235498','合肥','15928433488',1,'2019-10-27 23:16:00',NULL,NULL,1),(7,'PRO-CODE—009','测试供应商009','无','陈光辉','13845674444','安庆','13415672341',1,'2019-10-30 10:33:19','2019-10-30 10:34:56',1,1),(8,'PRO-CODE—001','zzzr','zzzz','zzzr','18856502339','1111zzzz','zzzz',NULL,'2019-12-05 17:43:27',NULL,NULL,1),(9,'disabled','disabled','disabled','disabled','18888888888','18888888888','disabled',14,'2019-12-08 19:12:25',NULL,NULL,1),(10,'test','test','test','test','18888888888','test','test',14,'2019-12-08 19:13:14',NULL,NULL,1),(11,'test1','test1','test','test','15555555555','test','test',14,'2019-12-08 19:13:36',NULL,NULL,1),(12,'1','1','1','1','13112312312','1','1',14,'2019-12-11 14:07:02','2019-12-11 14:07:30',14,1);

/*Table structure for table `smbms_role` */

DROP TABLE IF EXISTS `smbms_role`;

CREATE TABLE `smbms_role` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_name` varchar(50) DEFAULT NULL COMMENT '角色名',
  `createBy` int(20) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modifyBy` int(20) DEFAULT NULL COMMENT '修改者',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(20) DEFAULT NULL COMMENT '0不能用.1能用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `smbms_role` */

insert  into `smbms_role`(`id`,`role_name`,`createBy`,`create_time`,`modifyBy`,`modify_time`,`status`) values (1,'admin',1,'2019-12-03 17:36:51',NULL,NULL,1),(2,'leader',1,'2019-12-03 17:37:06',NULL,NULL,1),(3,'emplyer',1,'2019-12-03 17:37:31',NULL,NULL,1);

/*Table structure for table `smbms_user` */

DROP TABLE IF EXISTS `smbms_user`;

CREATE TABLE `smbms_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `userCode` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户编码',
  `userName` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户名称',
  `userPassword` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户密码',
  `gender` int(10) DEFAULT NULL COMMENT '性别（1:女、 2:男）',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '手机',
  `address` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '地址',
  `userType` int(10) DEFAULT NULL COMMENT '用户类型（1：系统管理员、2：经理、3：普通员工）',
  `createdBy` bigint(20) DEFAULT NULL COMMENT '创建者（userId）',
  `creationDate` datetime DEFAULT NULL COMMENT '创建时间',
  `modifyBy` bigint(20) DEFAULT NULL COMMENT '更新者（userId）',
  `modifyDate` datetime DEFAULT NULL COMMENT '更新时间',
  `status` int(11) DEFAULT NULL COMMENT '0不能用，1能用',
  `salt` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '盐值',
  PRIMARY KEY (`id`),
  KEY `userType` (`userType`),
  CONSTRAINT `smbms_user_ibfk_1` FOREIGN KEY (`userType`) REFERENCES `smbms_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `smbms_user` */

insert  into `smbms_user`(`id`,`userCode`,`userName`,`userPassword`,`gender`,`birthday`,`phone`,`address`,`userType`,`createdBy`,`creationDate`,`modifyBy`,`modifyDate`,`status`,`salt`) values (3,'0002','郑宗明1号','ebed7d8bfe0abd33db8ca4fe5248644e',2,'1999-06-01','13645675875','芜湖',1,1,'2019-10-26 14:22:22',NULL,NULL,1,'aaae371bdd197487787cb17ce7669e8b'),(5,'0004','郑宗明3号','ebed7d8bfe0abd33db8ca4fe5248644e',2,'1996-11-23','13949675111','安庆',2,1,'2019-10-26 14:24:08',14,'2019-12-05 16:59:03',1,'aaae371bdd197487787cb17ce7669e8b'),(6,'0005','郑宗明4号','ebed7d8bfe0abd33db8ca4fe5248644e',2,'1999-04-06','13949670875','芜湖',1,1,'2019-10-26 14:25:28',NULL,NULL,1,'aaae371bdd197487787cb17ce7669e8b'),(7,'0006','郑宗明5号','ebed7d8bfe0abd33db8ca4fe5248644e',1,'1999-04-08','13948670875','合肥',3,1,'2019-10-26 14:26:33',NULL,NULL,1,'aaae371bdd197487787cb17ce7669e8b'),(8,'0007','郑宗明6号','ebed7d8bfe0abd33db8ca4fe5248644e',2,'1994-07-01','13948670876','合肥',3,1,'2019-10-26 14:27:41',NULL,NULL,1,'aaae371bdd197487787cb17ce7669e8b'),(9,'0008','郑宗明7号','ebed7d8bfe0abd33db8ca4fe5248644e',1,'1994-07-06','13940670875','芜湖',2,1,'2019-10-26 14:28:19',NULL,NULL,1,'aaae371bdd197487787cb17ce7669e8b'),(10,'0009','郑宗明8号','ebed7d8bfe0abd33db8ca4fe5248644e',2,'1994-11-06','13940677875','安庆',3,1,'2019-10-26 14:29:03',NULL,NULL,1,'aaae371bdd197487787cb17ce7669e8b'),(12,'0001','郑宗明9号','ebed7d8bfe0abd33db8ca4fe5248644e',1,'1994-11-06','13940677875','安庆',1,1,'2019-10-30 14:44:56',NULL,NULL,1,'aaae371bdd197487787cb17ce7669e8b'),(13,'00012','郑宗明10号','ebed7d8bfe0abd33db8ca4fe5248644e',2,'2019-12-04','12249293395','安徽',1,1,'2019-12-04 17:48:54',NULL,NULL,1,'aaae371bdd197487787cb17ce7669e8b'),(14,'zzm123','郑宗明','ebed7d8bfe0abd33db8ca4fe5248644e',2,'2016-12-04','18888888888','日本',1,1,'2019-12-11 14:10:30',14,'2019-12-11 14:10:30',1,'aaae371bdd197487787cb17ce7669e8b'),(15,'000100','郑宗明11号','ebed7d8bfe0abd33db8ca4fe5248644e',2,'2019-12-10','18888888888','zzz',3,1,'2019-12-05 10:59:42',NULL,NULL,1,'aaae371bdd197487787cb17ce7669e8b'),(16,'zzzzzrrr','郑宗明12号','ebed7d8bfe0abd33db8ca4fe5248644e',2,'2019-12-02','18888888888','zzzz',2,14,'2019-12-05 11:21:12',NULL,NULL,1,'aaae371bdd197487787cb17ce7669e8b'),(17,'zzzzzz','郑宗明13号','ebed7d8bfe0abd33db8ca4fe5248644e',2,'2019-12-17','18365095737','zzzzzzz',1,14,'2019-12-05 17:29:30',NULL,NULL,1,'aaae371bdd197487787cb17ce7669e8b'),(18,'zzm1234','郑宗明2号','d0a94ba5380e65aa1e4f5093e94c97d7',2,'2019-12-10','18856502336','zzr',2,14,'2019-12-06 14:46:50',NULL,NULL,1,'c5ebf2b5ad50494ca446429bbde2c52a'),(19,'zzm1235','郑宗明','36c63a96fd0fd92eb498acba0117666a',2,'2019-12-10','18888888888','安徽',3,14,'2019-12-08 19:03:18',NULL,NULL,1,'9588f5ddbb11af0a529cd58d542f95f6'),(20,'1','郑宗明14号','0522fc6702323c98adeca00efe5371fe',2,'2019-12-11','13112312312','1',3,14,'2019-12-11 14:09:11',NULL,NULL,1,'72de3e2313a5b8215dc07584b37d1175');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
