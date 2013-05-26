/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50514
Source Host           : localhost:3306
Source Database       : apotek

Target Server Type    : MYSQL
Target Server Version : 50514
File Encoding         : 65001

Date: 2012-10-19 07:17:31
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `faktur_bebas`
-- ----------------------------
DROP TABLE IF EXISTS `faktur_bebas`;
CREATE TABLE `faktur_bebas` (
`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
`nama`  varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL ,
`alamat`  varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL ,
`tgl`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
`oleh`  int(10) UNSIGNED NOT NULL DEFAULT 0 ,
`simpan`  bit(1) NOT NULL DEFAULT b'0' ,
`dokter`  varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL ,
`tglresep`  date NULL DEFAULT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci
AUTO_INCREMENT=31

;

-- ----------------------------
-- Table structure for `faktur_terima`
-- ----------------------------
DROP TABLE IF EXISTS `faktur_terima`;
CREATE TABLE `faktur_terima` (
`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
`no`  varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL ,
`supplier`  int(10) UNSIGNED NOT NULL DEFAULT 0 ,
`tempo`  date NULL DEFAULT NULL ,
`tgl`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
`oleh`  int(10) UNSIGNED NOT NULL DEFAULT 0 ,
`simpan`  bit(1) NOT NULL DEFAULT b'0' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci
AUTO_INCREMENT=12

;

-- ----------------------------
-- Table structure for `obat`
-- ----------------------------
DROP TABLE IF EXISTS `obat`;
CREATE TABLE `obat` (
`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
`obat`  varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ,
`harga`  decimal(10,2) NOT NULL DEFAULT 0.00 ,
`tgl`  datetime NOT NULL ,
`oleh`  int(10) UNSIGNED NOT NULL ,
`aktif`  bit(1) NOT NULL DEFAULT b'1' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci
AUTO_INCREMENT=5

;

-- ----------------------------
-- Table structure for `obat_bebas`
-- ----------------------------
DROP TABLE IF EXISTS `obat_bebas`;
CREATE TABLE `obat_bebas` (
`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
`obat`  int(10) UNSIGNED NOT NULL ,
`qty`  int(10) UNSIGNED NOT NULL ,
`harga`  decimal(10,2) NOT NULL ,
`tgl`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
`oleh`  int(10) UNSIGNED NOT NULL DEFAULT 0 ,
`faktur`  int(10) UNSIGNED NOT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci
AUTO_INCREMENT=45

;

-- ----------------------------
-- Table structure for `obat_stok`
-- ----------------------------
DROP TABLE IF EXISTS `obat_stok`;
CREATE TABLE `obat_stok` (
`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
`obat`  int(10) UNSIGNED NOT NULL ,
`qty`  int(10) UNSIGNED NOT NULL ,
`harga`  decimal(10,2) NOT NULL DEFAULT 0.00 ,
`faktur`  int(10) UNSIGNED NOT NULL ,
`tgl`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
`oleh`  int(10) UNSIGNED NOT NULL DEFAULT 0 ,
`netto`  decimal(10,2) NOT NULL DEFAULT 0.00 ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci
AUTO_INCREMENT=17

;

-- ----------------------------
-- Table structure for `supplier`
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
`supplier`  varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ,
`alamat`  varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ,
`tgl`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
`oleh`  int(10) UNSIGNED NOT NULL DEFAULT 0 ,
`aktif`  bit(1) NOT NULL DEFAULT b'1' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci
AUTO_INCREMENT=4

;

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
`username`  varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ,
`password`  varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ,
`nama`  varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci
AUTO_INCREMENT=2

;

-- ----------------------------
-- Auto increment value for `faktur_bebas`
-- ----------------------------
ALTER TABLE `faktur_bebas` AUTO_INCREMENT=31;

-- ----------------------------
-- Auto increment value for `faktur_terima`
-- ----------------------------
ALTER TABLE `faktur_terima` AUTO_INCREMENT=12;

-- ----------------------------
-- Indexes structure for table `obat`
-- ----------------------------
CREATE UNIQUE INDEX `KEMBAR` ON `obat`(`obat`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `obat`
-- ----------------------------
ALTER TABLE `obat` AUTO_INCREMENT=5;

-- ----------------------------
-- Auto increment value for `obat_bebas`
-- ----------------------------
ALTER TABLE `obat_bebas` AUTO_INCREMENT=45;

-- ----------------------------
-- Auto increment value for `obat_stok`
-- ----------------------------
ALTER TABLE `obat_stok` AUTO_INCREMENT=17;

-- ----------------------------
-- Auto increment value for `supplier`
-- ----------------------------
ALTER TABLE `supplier` AUTO_INCREMENT=4;

-- ----------------------------
-- Indexes structure for table `user`
-- ----------------------------
CREATE UNIQUE INDEX `KEMBAR` ON `user`(`username`) USING BTREE ;

-- ----------------------------
-- Auto increment value for `user`
-- ----------------------------
ALTER TABLE `user` AUTO_INCREMENT=2;
