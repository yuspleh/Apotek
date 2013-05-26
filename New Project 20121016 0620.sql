-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.14


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema apotek
--

CREATE DATABASE IF NOT EXISTS apotek;
USE apotek;

--
-- Definition of table `faktur_bebas`
--

DROP TABLE IF EXISTS `faktur_bebas`;
CREATE TABLE `faktur_bebas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(45) DEFAULT NULL,
  `alamat` varchar(70) DEFAULT NULL,
  `tgl` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `oleh` int(10) unsigned NOT NULL DEFAULT '0',
  `simpan` bit(1) NOT NULL DEFAULT b'0',
  `dokter` varchar(45) DEFAULT NULL,
  `tglresep` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `faktur_bebas`
--

/*!40000 ALTER TABLE `faktur_bebas` DISABLE KEYS */;
INSERT INTO `faktur_bebas` (`id`,`nama`,`alamat`,`tgl`,`oleh`,`simpan`,`dokter`,`tglresep`) VALUES 
 (1,'john','surabaya','2012-10-22 22:08:22',0,0x01,'dr. jill','2012-10-11'),
 (2,'max','malang','2012-10-23 04:32:45',0,0x01,'dr. jack','2012-10-09');
/*!40000 ALTER TABLE `faktur_bebas` ENABLE KEYS */;


--
-- Definition of table `faktur_terima`
--

DROP TABLE IF EXISTS `faktur_terima`;
CREATE TABLE `faktur_terima` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `no` varchar(45) DEFAULT NULL,
  `supplier` int(10) unsigned NOT NULL DEFAULT '0',
  `tempo` date DEFAULT NULL,
  `tgl` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `oleh` int(10) unsigned NOT NULL DEFAULT '0',
  `simpan` bit(1) NOT NULL DEFAULT b'0',
  `lunas` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `faktur_terima`
--

/*!40000 ALTER TABLE `faktur_terima` DISABLE KEYS */;
INSERT INTO `faktur_terima` (`id`,`no`,`supplier`,`tempo`,`tgl`,`oleh`,`simpan`,`lunas`) VALUES 
 (3,NULL,0,NULL,'2012-10-22 21:27:13',0,0x00,0x00),
 (4,NULL,0,NULL,'2012-10-23 04:45:57',0,0x00,0x00),
 (5,NULL,0,NULL,'2012-10-23 04:48:42',0,0x00,0x00);
/*!40000 ALTER TABLE `faktur_terima` ENABLE KEYS */;


--
-- Definition of table `obat`
--

DROP TABLE IF EXISTS `obat`;
CREATE TABLE `obat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obat` varchar(45) NOT NULL,
  `harga` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tgl` datetime NOT NULL,
  `oleh` int(10) unsigned NOT NULL,
  `aktif` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `KEMBAR` (`obat`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `obat`
--

/*!40000 ALTER TABLE `obat` DISABLE KEYS */;
INSERT INTO `obat` (`id`,`obat`,`harga`,`tgl`,`oleh`,`aktif`) VALUES 
 (1,'paramex','78000.00','2012-10-22 08:08:03',0,0x01),
 (2,'inzana','39000.00','2012-10-22 08:08:07',0,0x01),
 (3,'Panadol','0.00','2012-10-23 04:46:07',0,0x01);
/*!40000 ALTER TABLE `obat` ENABLE KEYS */;


--
-- Definition of table `obat_bebas`
--

DROP TABLE IF EXISTS `obat_bebas`;
CREATE TABLE `obat_bebas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obat` int(10) unsigned NOT NULL,
  `qty` int(10) unsigned NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `tgl` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `oleh` int(10) unsigned NOT NULL DEFAULT '0',
  `faktur` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `obat_bebas`
--

/*!40000 ALTER TABLE `obat_bebas` DISABLE KEYS */;
INSERT INTO `obat_bebas` (`id`,`obat`,`qty`,`harga`,`tgl`,`oleh`,`faktur`) VALUES 
 (1,2,2,'39000.00','2012-10-23 04:36:35',0,2),
 (2,1,3,'78000.00','2012-10-23 04:36:40',0,2),
 (3,1,2,'78000.00','2012-10-23 04:53:17',0,1),
 (4,2,3,'39000.00','2012-10-23 04:53:21',0,1);
/*!40000 ALTER TABLE `obat_bebas` ENABLE KEYS */;


--
-- Definition of table `obat_stok`
--

DROP TABLE IF EXISTS `obat_stok`;
CREATE TABLE `obat_stok` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obat` int(10) unsigned NOT NULL,
  `qty` int(10) unsigned NOT NULL,
  `harga` decimal(10,2) NOT NULL DEFAULT '0.00',
  `faktur` int(10) unsigned NOT NULL,
  `tgl` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `oleh` int(10) unsigned NOT NULL DEFAULT '0',
  `netto` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `obat_stok`
--

/*!40000 ALTER TABLE `obat_stok` DISABLE KEYS */;
INSERT INTO `obat_stok` (`id`,`obat`,`qty`,`harga`,`faktur`,`tgl`,`oleh`,`netto`) VALUES 
 (1,2,2,'150000.00',2,'2012-10-22 08:21:04',0,'90000.00'),
 (2,2,2,'80000.00',1,'2012-10-22 08:22:31',0,'60000.00'),
 (3,1,2,'120000.00',1,'2012-10-22 08:22:49',0,'90000.00'),
 (4,2,2,'60000.00',4,'2012-10-22 21:35:35',0,'50000.00'),
 (6,1,4,'240000.00',4,'2012-10-22 21:37:21',0,'180000.00');
/*!40000 ALTER TABLE `obat_stok` ENABLE KEYS */;


--
-- Definition of table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `supplier` varchar(45) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `tgl` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `oleh` int(10) unsigned NOT NULL DEFAULT '0',
  `aktif` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplier`
--

/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` (`id`,`supplier`,`alamat`,`tgl`,`oleh`,`aktif`) VALUES 
 (1,'PT. ANC Corp.','Malang','2012-10-22 08:08:37',0,0x01),
 (2,'Kalbe Inc.','Surabaya','2012-10-22 08:15:42',0,0x01),
 (3,'PT. Medic Plus Corp','Sumatera','2012-10-23 04:49:08',0,0x01);
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;


--
-- Definition of table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(32) NOT NULL,
  `nama` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `KEMBAR` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`,`username`,`password`,`nama`) VALUES 
 (1,'admin','21232F297A57A5A743894A0E4A801FC3','Admin');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
