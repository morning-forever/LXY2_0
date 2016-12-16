/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50624
Source Host           : 127.0.0.1:3306
Source Database       : lxy2_0

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-12-16 16:51:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for lxy_add_svc
-- ----------------------------
DROP TABLE IF EXISTS `lxy_add_svc`;
CREATE TABLE `lxy_add_svc` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `is_valid` bit(1) NOT NULL DEFAULT b'1' COMMENT '标识当前记录对于当前的实际业务来说是否有效：1有效，0无效',
  `name` varchar(255) NOT NULL COMMENT '附加服务的名字',
  `km` int(11) NOT NULL COMMENT '折成的公里数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='附加服务表';

-- ----------------------------
-- Records of lxy_add_svc
-- ----------------------------
INSERT INTO `lxy_add_svc` VALUES ('7', '', '接贵阳龙洞堡机场-送贵阳北站', '60', '2016-11-21 14:05:53', '2016-11-21 14:05:53');
INSERT INTO `lxy_add_svc` VALUES ('8', '', '接送贵阳龙洞堡机场', '60', '2016-11-21 14:05:53', '2016-11-21 14:05:53');
INSERT INTO `lxy_add_svc` VALUES ('9', '', '接贵阳龙洞堡机场-送贵阳站（火车）', '40', '2016-11-21 14:05:53', '2016-11-21 14:05:53');
INSERT INTO `lxy_add_svc` VALUES ('11', '', '接送贵阳北站', '60', '2016-11-21 14:05:53', '2016-11-21 14:05:53');
INSERT INTO `lxy_add_svc` VALUES ('12', '', '接贵阳北站-送贵阳龙洞堡机场', '60', '2016-11-21 14:05:53', '2016-11-21 14:05:53');
INSERT INTO `lxy_add_svc` VALUES ('13', '', '接贵阳北站-送贵阳站（火车）', '40', '2016-11-21 14:05:53', '2016-11-22 17:07:41');
INSERT INTO `lxy_add_svc` VALUES ('15', '', '接送贵阳站（火车）', '20', '2016-11-21 14:05:53', '2016-11-21 14:05:53');

-- ----------------------------
-- Table structure for lxy_car_info
-- ----------------------------
DROP TABLE IF EXISTS `lxy_car_info`;
CREATE TABLE `lxy_car_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `is_valid` bit(1) NOT NULL DEFAULT b'1' COMMENT '标识当前记录对于当前的实际业务来说是否有效：1有效，0无效',
  `plate_number` varchar(45) NOT NULL COMMENT '车牌号',
  `car_type_id` int(11) NOT NULL COMMENT '车类型标识',
  `driver_id` bigint(20) DEFAULT NULL,
  `trip_times` int(11) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate_number_unique` (`plate_number`) USING BTREE,
  KEY `driver_id` (`driver_id`),
  KEY `car_type_id` (`car_type_id`),
  CONSTRAINT `car_type_id` FOREIGN KEY (`car_type_id`) REFERENCES `lxy_car_type` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `driver_id` FOREIGN KEY (`driver_id`) REFERENCES `lxy_driver` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8 COMMENT='车辆基本信息表';

-- ----------------------------
-- Records of lxy_car_info
-- ----------------------------
INSERT INTO `lxy_car_info` VALUES ('180', '', '贵AT1340', '1', '21', '1', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('181', '', '贵AT1410', '1', null, '1', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('182', '', '贵AT1672', '1', null, '1', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('183', '', '贵AT1679', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('184', '', '贵AT1684', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('185', '', '贵AT1686', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('186', '', '贵AT1687', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('187', '', '贵AT1689', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('188', '', '贵AT1690', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('189', '', '贵AT1691', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('190', '', '贵AT1692', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('191', '', '贵AT1693', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('192', '', '贵AT1694', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('193', '', '贵AT1695', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('194', '', '贵AT1697', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('195', '', '贵AT1698', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('196', '', '贵AT1702', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('197', '', '贵AT1703', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('198', '', '贵AT1704', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('199', '', '贵AT1705', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('200', '', '贵AT1706', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('201', '', '贵AT1707', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('202', '', '贵AT1708', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('203', '', '贵AT1709', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('204', '', '贵AT1712', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('205', '', '贵AT1715', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('206', '', '贵AT1717', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('207', '', '贵AT1719', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('208', '', '贵AT1722', '1', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('209', '', '贵AT1493', '2', null, '1', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('210', '', '贵AT1588', '2', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('211', '', '贵AT1590', '2', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('212', '', '贵AT1595', '2', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('213', '', '贵AT1596', '2', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('214', '', '贵AT1597', '2', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('215', '', '贵AT1598', '2', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('216', '', '贵AT1600', '2', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('217', '', '贵AT1602', '2', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('218', '', '贵AT1545', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('219', '', '贵AT1549', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('220', '', '贵AT1552', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('221', '', '贵AT1560', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('222', '', '贵AT1561', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('223', '', '贵AT1562', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('224', '', '贵AT1713', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('225', '', '贵AT1723', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('226', '', '贵AT1731', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('227', '', '贵AT1732', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('228', '', '贵AT1733', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('229', '', '贵AT1734', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('230', '', '贵AT1737', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('231', '', '贵AT1738', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('232', '', '贵AT1739', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('233', '', '贵AT1740', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('234', '', '贵AT1743', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('235', '', '贵AT1744', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('236', '', '贵AT1745', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('237', '', '贵AT1746', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('238', '', '贵AT1748', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('239', '', '贵AT1749', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('240', '', '贵AT1753', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('241', '', '贵AT1757', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('242', '', '贵AT1762', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('243', '', '贵AT1763', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('244', '', '贵AT1767', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('245', '', '贵AT1768', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('246', '', '贵AT1770', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('247', '', '贵AT1771', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('248', '', '贵AT1773', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('249', '', '贵AT1775', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('250', '', '贵AT1777', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('251', '', '贵AT1358', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:27:12');
INSERT INTO `lxy_car_info` VALUES ('252', '', '贵AT1558', '38', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:27:15');
INSERT INTO `lxy_car_info` VALUES ('253', '', '贵AT1724', '7', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('254', '', '贵AT1735', '7', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('255', '', '贵AT1750', '7', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('256', '', '贵AT1751', '7', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('257', '', '贵AT1756', '7', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('258', '', '贵AT1328', '8', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('259', '', '贵AT1512', '8', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('260', '', '贵AT1522', '8', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('261', '', '贵AT1526', '8', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('262', '', '贵AT1527', '8', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('263', '', '贵AT1529', '8', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('264', '', '贵AT1530', '8', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('265', '', '贵AT1533', '8', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('266', '', '贵AT1603', '8', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('267', '', '贵AT1536', '8', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('268', '', '贵AT1582', '8', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('269', '', '贵AT1049', '9', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('270', '', '贵AT1077', '9', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('271', '', '贵AT1080', '9', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('272', '', '贵AT1099', '9', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('274', '', '贵AT0529', '11', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('275', '', '贵AT0999', '11', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('276', '', '贵AT8000', '11', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('277', '', '贵AT1579', '12', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('278', '', '贵AT1581', '12', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('279', '', '贵AT1780', '12', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('280', '', '贵AT1791', '12', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('281', '', '贵AT1797', '12', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('282', '', '贵AT1799', '12', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');
INSERT INTO `lxy_car_info` VALUES ('283', '', '贵AT1091', '12', null, '0', '2016-11-17 11:08:20', '2016-11-17 11:08:20');

-- ----------------------------
-- Table structure for lxy_car_state
-- ----------------------------
DROP TABLE IF EXISTS `lxy_car_state`;
CREATE TABLE `lxy_car_state` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL,
  `is_valid` bit(1) NOT NULL DEFAULT b'1' COMMENT '标识当前记录对于当前的实际业务来说是否有效：1有效，0无效',
  `create_time` datetime NOT NULL,
  `car_id` bigint(20) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `form_id` bigint(20) DEFAULT NULL,
  `is_sms_dri` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否已通知司机',
  PRIMARY KEY (`id`),
  KEY `car_id` (`car_id`),
  KEY `form_id` (`form_id`),
  CONSTRAINT `car_id` FOREIGN KEY (`car_id`) REFERENCES `lxy_car_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `form_id` FOREIGN KEY (`form_id`) REFERENCES `lxy_order_form` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lxy_car_state
-- ----------------------------

-- ----------------------------
-- Table structure for lxy_car_type
-- ----------------------------
DROP TABLE IF EXISTS `lxy_car_type`;
CREATE TABLE `lxy_car_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(45) DEFAULT NULL COMMENT '车名',
  `seat_num` int(11) NOT NULL COMMENT '座位数',
  `price` double(11,2) NOT NULL COMMENT '每公里价格',
  `create_time` datetime NOT NULL COMMENT '记录创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后一次更新时间',
  `is_valid` bit(1) NOT NULL DEFAULT b'1' COMMENT '标识当前记录对于当前的实际业务来说是否有效：1有效，0无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='车的类型';

-- ----------------------------
-- Records of lxy_car_type
-- ----------------------------
INSERT INTO `lxy_car_type` VALUES ('1', '14座', '14', '2.90', '2016-11-17 11:41:00', '2016-11-17 11:41:00', '');
INSERT INTO `lxy_car_type` VALUES ('2', '19座', '19', '3.00', '2016-11-17 11:41:00', '2016-11-17 11:41:00', '');
INSERT INTO `lxy_car_type` VALUES ('7', '35座', '35', '3.50', '2016-11-17 11:41:00', '2016-11-17 11:41:00', '');
INSERT INTO `lxy_car_type` VALUES ('8', '39座', '39', '3.80', '2016-11-17 11:41:00', '2016-11-17 11:41:00', '');
INSERT INTO `lxy_car_type` VALUES ('9', '43座', '43', '4.80', '2016-11-17 11:41:00', '2016-11-17 11:41:00', '');
INSERT INTO `lxy_car_type` VALUES ('10', '49座', '49', '5.60', '2016-11-17 11:41:00', '2016-11-17 11:41:00', '');
INSERT INTO `lxy_car_type` VALUES ('11', '55座', '55', '5.60', '2016-11-17 11:41:00', '2016-11-17 11:41:00', '');
INSERT INTO `lxy_car_type` VALUES ('12', '57座', '57', '5.60', '2016-11-17 11:41:00', '2016-11-17 11:41:00', '');
INSERT INTO `lxy_car_type` VALUES ('38', '30座', '30', '3.50', '2016-11-17 11:41:00', '2016-11-17 11:41:00', '');

-- ----------------------------
-- Table structure for lxy_default_route
-- ----------------------------
DROP TABLE IF EXISTS `lxy_default_route`;
CREATE TABLE `lxy_default_route` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_valid` bit(1) NOT NULL DEFAULT b'1' COMMENT '标识当前记录对于当前的实际业务来说是否有效：1有效，0无效',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `content` varchar(600) NOT NULL COMMENT '路线名字',
  `day_num` int(20) NOT NULL DEFAULT '1' COMMENT '天数',
  `km` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='默认线路表';

-- ----------------------------
-- Records of lxy_default_route
-- ----------------------------
INSERT INTO `lxy_default_route` VALUES ('1', '', '2016-10-25 09:34:19', '2016-11-17 11:50:45', '水电费水电费', '2', '10');
INSERT INTO `lxy_default_route` VALUES ('2', '', '2016-10-25 10:04:59', '2016-11-17 11:50:45', '贵阳-遵义会址-贵阳', '1', '330');
INSERT INTO `lxy_default_route` VALUES ('3', '', '2016-10-25 10:15:58', '2016-11-17 11:50:45', '贵阳-息烽集中营-遵义机场-贵阳', '1', '470');
INSERT INTO `lxy_default_route` VALUES ('4', '', '2016-10-25 10:21:50', '2016-11-17 11:50:45', '贵阳-黄果树-龙宫-贵阳', '1', '330');
INSERT INTO `lxy_default_route` VALUES ('5', '', '2016-10-25 10:24:31', '2016-11-17 11:50:45', '贵阳-织金洞-贵阳', '1', '400');
INSERT INTO `lxy_default_route` VALUES ('6', '', '2016-10-25 10:26:03', '2016-11-17 11:50:45', '贵阳-黄果树-贵阳', '1', '300');
INSERT INTO `lxy_default_route` VALUES ('7', '', '2016-10-25 10:27:52', '2016-11-17 11:50:45', '贵阳-瓮安猴场-贵阳', '1', '350');
INSERT INTO `lxy_default_route` VALUES ('8', '', '2016-10-25 10:35:49', '2016-11-17 11:50:45', '贵阳-格凸河-贵阳', '1', '440');
INSERT INTO `lxy_default_route` VALUES ('9', '', '2016-10-25 10:39:58', '2016-11-17 11:50:45', '贵阳-荔波-贵阳', '1', '750');
INSERT INTO `lxy_default_route` VALUES ('10', '', '2016-10-25 10:41:36', '2016-11-17 11:50:45', '贵阳-扎佐-贵阳', '1', '220');
INSERT INTO `lxy_default_route` VALUES ('11', '', '2016-10-25 10:54:28', '2016-11-17 11:50:45', '贵阳-龙宫-黄果树-天星桥-陡坡塘-贵阳', '1', '330');
INSERT INTO `lxy_default_route` VALUES ('12', '', '2016-10-25 10:58:42', '2016-11-17 11:50:45', '贵阳-青岩古镇-贵阳', '1', '220');
INSERT INTO `lxy_default_route` VALUES ('13', '', '2016-10-25 11:00:02', '2016-11-17 11:50:45', '贵阳-黔灵山-甲秀楼-贵阳', '1', '220');
INSERT INTO `lxy_default_route` VALUES ('14', '', '2016-10-25 11:07:19', '2016-11-17 11:50:45', '贵阳-息烽集中营-遵义-贵阳', '1', '350');
INSERT INTO `lxy_default_route` VALUES ('15', '', '2016-10-25 11:13:10', '2016-11-17 11:50:45', '贵阳-青岩古镇-花溪湿地公园-小车河-天河潭-贵阳', '1', '220');
INSERT INTO `lxy_default_route` VALUES ('16', '', '2016-10-25 11:21:58', '2016-11-17 11:50:45', 'tests', '1', '10');
INSERT INTO `lxy_default_route` VALUES ('17', '', '2016-10-25 11:22:47', '2016-11-17 11:50:45', 'test1', '2', '10');
INSERT INTO `lxy_default_route` VALUES ('18', '', '2016-10-25 11:25:20', '2016-11-17 11:50:45', '贵阳-息烽温泉-遵义会址-湄潭-贵阳', '2', '650');
INSERT INTO `lxy_default_route` VALUES ('19', '', '2016-10-25 11:29:06', '2016-11-17 11:50:45', '贵阳-息烽温泉-遵义会址-仁怀茅台-贵阳', '2', '650');
INSERT INTO `lxy_default_route` VALUES ('20', '', '2016-10-25 11:34:03', '2016-11-17 11:50:45', '贵阳-西江苗寨-剑河-贵阳', '2', '600');
INSERT INTO `lxy_default_route` VALUES ('21', '', '2016-10-25 11:36:25', '2016-11-17 11:50:45', '贵阳-织金洞-贵阳', '2', '300');
INSERT INTO `lxy_default_route` VALUES ('22', '', '2016-10-25 11:38:06', '2016-11-17 11:50:45', '贵阳-大小七孔-贵阳', '2', '750');
INSERT INTO `lxy_default_route` VALUES ('23', '', '2016-10-25 11:42:04', '2016-11-17 11:50:45', '贵阳-青岩古镇-平塘-贵阳', '2', '480');
INSERT INTO `lxy_default_route` VALUES ('24', '', '2016-10-25 11:45:28', '2016-11-17 11:50:45', '贵阳-织金洞-安顺-黄果树-贵阳', '2', '550');
INSERT INTO `lxy_default_route` VALUES ('25', '', '2016-10-25 11:47:17', '2016-11-17 11:50:45', '贵阳-黄果树-天星桥-西江苗寨-贵阳', '2', '760');
INSERT INTO `lxy_default_route` VALUES ('26', '', '2016-10-25 11:49:04', '2016-11-17 11:50:45', '贵阳-荔波-大小七孔-西江苗寨-朗德-贵阳', '2', '1010');
INSERT INTO `lxy_default_route` VALUES ('27', '', '2016-10-25 11:50:20', '2016-11-17 11:50:45', '贵阳-西江苗寨-贵阳', '2', '460');
INSERT INTO `lxy_default_route` VALUES ('28', '', '2016-10-25 12:52:09', '2016-11-17 11:50:45', '贵阳-荔波-大小七孔-西江苗寨-朗德-贵阳', '2', '943');
INSERT INTO `lxy_default_route` VALUES ('29', '', '2016-10-25 12:56:09', '2016-11-17 11:50:45', '贵阳-西江苗寨-瓮安江界河-草塘-贵阳', '2', '602');
INSERT INTO `lxy_default_route` VALUES ('30', '', '2016-10-25 12:57:29', '2016-11-17 11:50:45', '贵阳-肇兴-芭莎苗寨-贵阳', '2', '1100');
INSERT INTO `lxy_default_route` VALUES ('31', '', '2016-10-25 12:59:00', '2016-11-17 11:50:45', '贵阳-西江苗寨-镇远古镇-朗德-贵阳', '2', '800');
INSERT INTO `lxy_default_route` VALUES ('32', '', '2016-10-25 13:00:21', '2016-11-17 11:50:45', '贵阳-盘县-贵阳', '3', '700');
INSERT INTO `lxy_default_route` VALUES ('33', '', '2016-10-25 13:01:14', '2016-11-17 11:50:45', '贵阳-黔西-大方-百里杜鹃-贵阳', '3', '400');
INSERT INTO `lxy_default_route` VALUES ('34', '', '2016-10-25 13:02:01', '2016-11-17 11:50:45', '贵阳-赤水-贵阳', '3', '1100');
INSERT INTO `lxy_default_route` VALUES ('35', '', '2016-10-25 13:02:57', '2016-11-17 11:50:45', '贵阳-小七孔-大七孔-西江苗寨-贵阳', '3', '950');
INSERT INTO `lxy_default_route` VALUES ('36', '', '2016-10-25 13:04:45', '2016-11-17 11:50:45', '贵阳-惠水-紫云-贞丰-兴义-贵阳', '3', '1110');
INSERT INTO `lxy_default_route` VALUES ('37', '', '2016-10-25 13:06:13', '2016-11-17 11:50:45', '贵阳-晴隆-兴义-贵阳（含黄果树、西峰林、马岭河）', '3', '860');
INSERT INTO `lxy_default_route` VALUES ('38', '', '2016-10-25 13:07:50', '2016-11-17 11:50:45', '贵阳--遵义（住）遵义会址-息烽-贵阳', '3', '350');
INSERT INTO `lxy_default_route` VALUES ('39', '', '2016-10-25 13:09:28', '2016-11-17 11:50:45', '贵阳-瓮安猴场-黄果树-龙宫-小七孔-贵阳', '3', '1480');
INSERT INTO `lxy_default_route` VALUES ('40', '', '2016-10-25 13:10:42', '2016-11-17 11:50:45', '贵阳-黄果树-兴义马岭河-万峰林-万峰湖-双乳峰-贵阳', '4', '910');
INSERT INTO `lxy_default_route` VALUES ('41', '', '2016-10-25 13:11:47', '2016-11-17 11:50:45', '贵阳-龙宫-黄果树、天星桥-小七孔-贵阳', '4', '1080');
INSERT INTO `lxy_default_route` VALUES ('42', '', '2016-10-25 13:12:35', '2016-11-17 11:50:45', '贵阳-荔波-黄果树-贵阳', '4', '1050');
INSERT INTO `lxy_default_route` VALUES ('43', '', '2016-10-25 13:13:46', '2016-11-17 11:50:45', '贵阳-小七孔-黄果树-天星桥-花溪湿地公园-贵阳', '4', '1100');
INSERT INTO `lxy_default_route` VALUES ('44', '', '2016-10-25 13:15:02', '2016-11-17 11:50:45', '贵阳-黄果树-小七孔-大七孔-西江苗寨-贵阳', '4', '1250');
INSERT INTO `lxy_default_route` VALUES ('45', '', '2016-10-25 13:17:29', '2016-11-17 11:50:45', '贵阳-小七孔-西江苗寨-下司-苗妹-多彩-黄果树-天星桥-陡坡塘-青岩古镇-湿地公园-贵阳', '4', '1330');
INSERT INTO `lxy_default_route` VALUES ('46', '', '2016-10-25 13:18:36', '2016-11-17 11:50:45', '贵阳-遵义-仁怀-娄山关-湄潭-茶场-贵阳', '4', '950');
INSERT INTO `lxy_default_route` VALUES ('47', '', '2016-10-25 13:19:38', '2016-11-17 11:50:45', '贵阳-青岩古镇-黄果树-西江苗寨-都匀东-贵阳', '4', '900');
INSERT INTO `lxy_default_route` VALUES ('48', '', '2016-10-25 13:21:24', '2016-11-17 11:50:45', '贵阳-息烽-遵义会址-仁怀茅台镇-习水-赤水大瀑布-遵义机场-贵阳', '5', '1260');
INSERT INTO `lxy_default_route` VALUES ('49', '', '2016-10-25 13:23:26', '2016-11-17 11:50:45', '贵阳-百里杜鹃-金沙-遵义会址-息烽-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('50', '', '2016-10-25 13:24:52', '2016-11-17 11:50:45', '贵阳-清镇红枫湖-织金洞-百里杜鹃-黄果树-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('51', '', '2016-10-25 13:26:57', '2016-11-17 11:50:45', '贵阳-百里杜鹃-织金洞-黄果树-龙宫-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('52', '', '2016-10-25 13:28:22', '2016-11-17 11:50:45', '贵阳-都匀东-榕江-从江-肇兴侗寨-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('53', '', '2016-10-25 13:29:26', '2016-11-17 11:50:45', '贵阳-小七孔-西江苗寨-黄果树-天星桥-贵阳', '5', '1210');
INSERT INTO `lxy_default_route` VALUES ('54', '', '2016-10-25 13:31:20', '2016-11-17 11:50:45', '贵阳-万峰林-马岭河-黄果树-小七孔-下司古镇、苗妹、黄平机场-贵阳', '5', '1880');
INSERT INTO `lxy_default_route` VALUES ('55', '', '2016-10-25 13:32:53', '2016-11-17 11:50:45', '贵阳-荔波-西江苗寨-黄果树-龙宫-甲秀楼-贵阳', '5', '1290');
INSERT INTO `lxy_default_route` VALUES ('56', '', '2016-10-25 13:35:17', '2016-11-17 11:50:45', '贵阳-孔学堂-小七孔-西江苗寨-黄果树-天星桥-贵阳', '5', '1300');
INSERT INTO `lxy_default_route` VALUES ('57', '', '2016-10-25 13:37:38', '2016-11-17 11:50:45', '贵阳-遵义会址-息烽集中营-西江苗寨-凯里-铜仁-梵净山-贵阳', '5', '1470');
INSERT INTO `lxy_default_route` VALUES ('58', '', '2016-10-25 13:42:06', '2016-11-17 11:50:45', '贵阳-黄果树-天龙-云峰-龙宫-威宁-草海-六盘水-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('59', '', '2016-10-25 13:45:21', '2016-11-17 11:50:45', '贵阳-花溪湿地公园-甲秀楼-黄果树-龙宫-小七孔-西江苗寨-朗德-贵阳', '5', '1340');
INSERT INTO `lxy_default_route` VALUES ('60', '', '2016-10-25 13:47:34', '2016-11-17 11:50:45', '贵阳-青岩古镇-花溪-黄果树-天星桥-兴义-马岭河-西峰林-龙宫-甲秀楼-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('61', '', '2016-10-25 13:49:01', '2016-11-17 11:50:45', '贵阳-黄果树-小七孔-大七孔-镇远-西江苗寨-贵阳', '5', '1530');
INSERT INTO `lxy_default_route` VALUES ('62', '', '2016-10-25 13:50:18', '2016-11-17 11:50:45', '贵阳-西江苗寨-镇远古镇-铜仁-梵净山-亚木沟-贵阳', '5', '1270');
INSERT INTO `lxy_default_route` VALUES ('63', '', '2016-10-25 13:52:52', '2016-11-17 11:50:45', '贵阳-凯里南站-凯里-西江苗寨-镇远-镇远古城-青龙洞-黄果树-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('64', '', '2016-10-25 13:54:49', '2016-11-17 11:50:45', '贵阳-凯里南站-凯里-西江苗寨-镇远-镇远古城-青龙洞-黄果树-贵阳', '5', '1290');
INSERT INTO `lxy_default_route` VALUES ('65', '', '2016-10-25 13:58:15', '2016-11-17 11:50:45', '贵阳-西江苗寨-朗德-小七孔-贵阳-黄果树-青岩古镇-贵阳', '5', '1420');
INSERT INTO `lxy_default_route` VALUES ('66', '', '2016-10-25 14:00:04', '2016-11-17 11:50:45', '贵阳-凯里南站-西江（住)-西江苗寨-荔波（住）大小七孔-金阳（住）-黄果树-金阳（住）-贵阳', '5', '1280');
INSERT INTO `lxy_default_route` VALUES ('67', '', '2016-10-25 14:02:42', '2016-11-17 11:50:45', '贵阳-西江苗寨-镇远-黄果树-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('68', '', '2016-10-25 14:05:35', '2016-11-17 11:50:45', '贵阳-西江苗寨-黄平-杉木河-云台山-镇远古镇-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('69', '', '2016-10-25 14:07:37', '2016-11-17 11:50:45', '贵阳-息烽-遵义-青岩古镇-黄果树-安顺（住）-天星桥-天龙-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('70', '', '2016-10-25 14:11:29', '2016-11-17 11:50:45', '贵阳-西江苗寨-黄平-杉木河-云台山-镇远古镇-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('71', '', '2016-10-25 14:13:01', '2016-11-17 11:50:45', '贵阳-都匀东-榕江-从江-肇兴侗寨-贵阳', '5', '1100');
INSERT INTO `lxy_default_route` VALUES ('72', '', '2016-10-25 14:14:07', '2016-11-17 11:50:45', '贵阳-大小七孔-西江苗寨-黄果树-多彩-贵阳', '5', '1250');
INSERT INTO `lxy_default_route` VALUES ('73', '', '2016-10-25 14:16:57', '2016-11-17 11:50:45', '贵阳-凯里南站-镇远古镇-西江苗寨-大小七孔-黄果树-黔灵山、甲秀楼-贵阳', '6', '1580');
INSERT INTO `lxy_default_route` VALUES ('74', '', '2016-10-25 14:18:39', '2016-11-17 11:50:45', '贵阳-小七孔-大小七孔-荔波-肇兴-西江苗寨-贵阳', '6', '1780');
INSERT INTO `lxy_default_route` VALUES ('75', '', '2016-10-25 14:51:07', '2016-11-17 11:50:45', '贵阳-肇兴-芭莎-黎平会址-西江苗寨-隆里古镇-小黄-加榜梯田-榕江-贵阳', '6', '1770');
INSERT INTO `lxy_default_route` VALUES ('76', '', '2016-10-25 14:51:08', '2016-11-17 11:50:45', '贵阳-肇兴-芭莎-黎平会址-西江苗寨-隆里古镇-小黄-加榜梯田-榕江-贵阳', '6', '1758');
INSERT INTO `lxy_default_route` VALUES ('77', '', '2016-10-25 15:07:51', '2016-11-17 11:50:45', '贵阳-黄果树-马岭河、24道拐-兴义（住）-西峰林、万峰湖-安顺（住）织金洞-贵阳', '6', '1320');
INSERT INTO `lxy_default_route` VALUES ('78', '', '2016-10-25 15:10:35', '2016-11-17 11:50:45', '贵阳-凯里南-镇远古镇-黎平肇兴侗寨-大小七孔-贵阳黔灵山公园-黄果树-花溪-青岩-贵阳', '6', '1733');
INSERT INTO `lxy_default_route` VALUES ('79', '', '2016-10-25 15:31:51', '2016-11-17 11:50:45', '贵阳-黔灵山-青岩古镇-黄果树-兴义马岭河-万峰林、万峰湖-织金洞-大小七孔-西江苗寨-镇远古镇-贵阳', '8', '2420');
INSERT INTO `lxy_default_route` VALUES ('80', '', '2016-10-25 15:38:47', '2016-11-17 11:50:45', '贵阳-黄果树-天星桥-马岭河、西峰林-双乳峰、龙宫-大小七孔-西江-镇远-梵净山-铜仁南站-贵阳', '8', '2660');
INSERT INTO `lxy_default_route` VALUES ('81', '', '2016-10-25 15:42:24', '2016-11-17 11:50:45', '贵阳-凯里南-镇远古镇-黎平肇兴侗寨-大小七孔-贵阳黔灵山公园-黄果树-花溪-青岩-贵阳', '7', '1890');

-- ----------------------------
-- Table structure for lxy_driver
-- ----------------------------
DROP TABLE IF EXISTS `lxy_driver`;
CREATE TABLE `lxy_driver` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(20) NOT NULL,
  `tel` varchar(20) NOT NULL,
  `is_valid` bit(1) NOT NULL DEFAULT b'1' COMMENT '标识当前记录对于当前的实际业务来说是否有效：1有效，0无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lxy_driver
-- ----------------------------
INSERT INTO `lxy_driver` VALUES ('21', '2016-11-04 11:00:19', '2016-11-17 11:52:50', '张和平', '13608594671', '');
INSERT INTO `lxy_driver` VALUES ('22', '2016-11-04 11:00:25', '2016-11-17 11:52:50', '周西桥', '13809446509', '');
INSERT INTO `lxy_driver` VALUES ('23', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '冷洪贵', '15585111528', '');
INSERT INTO `lxy_driver` VALUES ('24', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '俞勇', '13985479970', '');
INSERT INTO `lxy_driver` VALUES ('25', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '胡前明', '13195219008', '');
INSERT INTO `lxy_driver` VALUES ('26', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '彭政林', '13885010331', '');
INSERT INTO `lxy_driver` VALUES ('27', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '韦发兵', '18984845085', '');
INSERT INTO `lxy_driver` VALUES ('28', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '丁崇玉', '13885043662', '');
INSERT INTO `lxy_driver` VALUES ('29', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '张以建', '13511902693', '');
INSERT INTO `lxy_driver` VALUES ('30', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '杨华', '13985578810', '');
INSERT INTO `lxy_driver` VALUES ('31', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '欧文海', '13984870650', '');
INSERT INTO `lxy_driver` VALUES ('32', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '陈明', '13985117419', '');
INSERT INTO `lxy_driver` VALUES ('33', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '雷江', '15285996782', '');
INSERT INTO `lxy_driver` VALUES ('34', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '张京洪', '18985541703', '');
INSERT INTO `lxy_driver` VALUES ('35', '2016-11-03 16:29:26', '2016-11-17 11:52:50', '唐健', '15185009883', '');
INSERT INTO `lxy_driver` VALUES ('36', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '刘贵平', '17784958691', '');
INSERT INTO `lxy_driver` VALUES ('37', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '曹小峰', '13639116916', '');
INSERT INTO `lxy_driver` VALUES ('38', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '吴士强', '15185134660', '');
INSERT INTO `lxy_driver` VALUES ('39', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '阮金明', '18285177350', '');
INSERT INTO `lxy_driver` VALUES ('40', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '李建刚', '3765844581', '');
INSERT INTO `lxy_driver` VALUES ('41', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '章柏春', '13985524664', '');
INSERT INTO `lxy_driver` VALUES ('42', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '谢树贵', '13984075442', '');
INSERT INTO `lxy_driver` VALUES ('43', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '骆开江', '13658514091', '');
INSERT INTO `lxy_driver` VALUES ('44', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '朱荣', '18984148652', '');
INSERT INTO `lxy_driver` VALUES ('45', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '蒋伟', '15338504445', '');
INSERT INTO `lxy_driver` VALUES ('46', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '张兴成', '18084269546', '');
INSERT INTO `lxy_driver` VALUES ('47', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '杨德红', '18185158363', '');
INSERT INTO `lxy_driver` VALUES ('48', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '刘斌', '13985490372', '');
INSERT INTO `lxy_driver` VALUES ('49', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '杨秀洪', '13985561423', '');
INSERT INTO `lxy_driver` VALUES ('50', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '张玉龙', '13885078459', '');
INSERT INTO `lxy_driver` VALUES ('51', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '秦国强', '18984030168', '');
INSERT INTO `lxy_driver` VALUES ('52', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '吴景良', '18285314766', '');
INSERT INTO `lxy_driver` VALUES ('53', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '李辉', '18184118487', '');
INSERT INTO `lxy_driver` VALUES ('54', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '汪 骥', '13765837298', '');
INSERT INTO `lxy_driver` VALUES ('55', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '李进红', '13511958106', '');
INSERT INTO `lxy_driver` VALUES ('56', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '肖明星', '15985017309', '');
INSERT INTO `lxy_driver` VALUES ('57', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '周永祥', '13885132642', '');
INSERT INTO `lxy_driver` VALUES ('58', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '罗玉强', '13765018799', '');
INSERT INTO `lxy_driver` VALUES ('59', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '冷先政', '13984319890', '');
INSERT INTO `lxy_driver` VALUES ('60', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '庄师', '13577853838', '');
INSERT INTO `lxy_driver` VALUES ('61', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '陈忠华', '18164866929', '');
INSERT INTO `lxy_driver` VALUES ('62', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '贺 师', '13885482020', '');
INSERT INTO `lxy_driver` VALUES ('63', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '伍 师', '13639081937', '');
INSERT INTO `lxy_driver` VALUES ('64', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '王 玉', '13885080820', '');
INSERT INTO `lxy_driver` VALUES ('65', '2016-11-03 16:29:27', '2016-11-17 11:52:50', '张师', '18984070970', '');
INSERT INTO `lxy_driver` VALUES ('66', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '金德雨', '13885170787', '');
INSERT INTO `lxy_driver` VALUES ('67', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '段立伟', '13984007124', '');
INSERT INTO `lxy_driver` VALUES ('68', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '崔杰乾', '13985553692', '');
INSERT INTO `lxy_driver` VALUES ('69', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '张清平', '13639084207', '');
INSERT INTO `lxy_driver` VALUES ('70', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '孙筑祥', '18984193316', '');
INSERT INTO `lxy_driver` VALUES ('71', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '陈文光', '13985411327', '');
INSERT INTO `lxy_driver` VALUES ('72', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '张大勇', '13638018899', '');
INSERT INTO `lxy_driver` VALUES ('73', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '芩跃成', '13984080886', '');
INSERT INTO `lxy_driver` VALUES ('74', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '欧顺平', '15329306679', '');
INSERT INTO `lxy_driver` VALUES ('75', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '陈 军', '13885033971', '');
INSERT INTO `lxy_driver` VALUES ('76', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '邹秋平', '13885169730', '');
INSERT INTO `lxy_driver` VALUES ('77', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '雷忠声', '13984024788', '');
INSERT INTO `lxy_driver` VALUES ('78', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '史学勇', '15185005746', '');
INSERT INTO `lxy_driver` VALUES ('79', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '张 勇', '13885141343', '');
INSERT INTO `lxy_driver` VALUES ('80', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '谢怀黔', '13885012676', '');
INSERT INTO `lxy_driver` VALUES ('81', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '张 辉', '13511937799', '');
INSERT INTO `lxy_driver` VALUES ('82', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '杨通国', '15285504723', '');
INSERT INTO `lxy_driver` VALUES ('83', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '阳 稳', '13595150940', '');
INSERT INTO `lxy_driver` VALUES ('84', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '李书喜', '13984383566', '');
INSERT INTO `lxy_driver` VALUES ('85', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '钱 昆', '13618596688', '');
INSERT INTO `lxy_driver` VALUES ('86', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '陈继军', '18685005620', '');
INSERT INTO `lxy_driver` VALUES ('87', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '张 勇', '13628566208', '');
INSERT INTO `lxy_driver` VALUES ('88', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '张 麟', '13985513037', '');
INSERT INTO `lxy_driver` VALUES ('89', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '任洪斌', '18685119657', '');
INSERT INTO `lxy_driver` VALUES ('90', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '范 军', '13985516372', '');
INSERT INTO `lxy_driver` VALUES ('91', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '魏 云', '13608545463', '');
INSERT INTO `lxy_driver` VALUES ('92', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '何长兵', '13595185448', '');
INSERT INTO `lxy_driver` VALUES ('93', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '谢春林', '18985196460', '');
INSERT INTO `lxy_driver` VALUES ('94', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '张林生', '15902694830', '');
INSERT INTO `lxy_driver` VALUES ('95', '2016-11-03 16:29:28', '2016-11-17 11:52:50', '赖燕华', '13608511553', '');
INSERT INTO `lxy_driver` VALUES ('96', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '向运琪', '13608532587', '');
INSERT INTO `lxy_driver` VALUES ('97', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '罗福林', '15285576780', '');
INSERT INTO `lxy_driver` VALUES ('98', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '张文', '18984079927', '');
INSERT INTO `lxy_driver` VALUES ('99', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '张庆华', '13639063638', '');
INSERT INTO `lxy_driver` VALUES ('100', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '邱新国', '13985412584', '');
INSERT INTO `lxy_driver` VALUES ('101', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '刘昌荣', '13595128405', '');
INSERT INTO `lxy_driver` VALUES ('102', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '封真华', '13595006171', '');
INSERT INTO `lxy_driver` VALUES ('103', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '赖刚刚', '18984080005', '');
INSERT INTO `lxy_driver` VALUES ('104', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '顾怀胜', '13885150773', '');
INSERT INTO `lxy_driver` VALUES ('105', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '梅兴华', '13985434663', '');
INSERT INTO `lxy_driver` VALUES ('106', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '焦建民', '13885181198', '');
INSERT INTO `lxy_driver` VALUES ('107', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '王锦贵', '13658510909', '');
INSERT INTO `lxy_driver` VALUES ('108', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '胡开明', '15985000961', '');
INSERT INTO `lxy_driver` VALUES ('109', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '许红江', '18084363808', '');
INSERT INTO `lxy_driver` VALUES ('110', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '李 涛', '13595182002', '');
INSERT INTO `lxy_driver` VALUES ('111', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '蒋 平', '13885087456', '');
INSERT INTO `lxy_driver` VALUES ('112', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '陈东林', '13618599322', '');
INSERT INTO `lxy_driver` VALUES ('113', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '史贵兵', '13608552584', '');
INSERT INTO `lxy_driver` VALUES ('114', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '周仕禄', '13765166698', '');
INSERT INTO `lxy_driver` VALUES ('115', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '李兴军', '13985174686', '');
INSERT INTO `lxy_driver` VALUES ('116', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '贺俊毛', '13885482020', '');
INSERT INTO `lxy_driver` VALUES ('117', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '唐 师', '18585883711', '');
INSERT INTO `lxy_driver` VALUES ('118', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '李云胜', '13639123495', '');
INSERT INTO `lxy_driver` VALUES ('119', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '何 昆', '13885041989', '');
INSERT INTO `lxy_driver` VALUES ('120', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '陈 遗', '18985159650', '');
INSERT INTO `lxy_driver` VALUES ('121', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '胡志良', '13985185398', '');
INSERT INTO `lxy_driver` VALUES ('122', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '孙于江', '13985555485', '');
INSERT INTO `lxy_driver` VALUES ('123', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '刘 鸿', '18111895727', '');
INSERT INTO `lxy_driver` VALUES ('124', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '袁树亮', '13985569197', '');
INSERT INTO `lxy_driver` VALUES ('125', '2016-11-03 16:29:29', '2016-11-17 11:52:50', '伍发良', '13639081937', '');
INSERT INTO `lxy_driver` VALUES ('126', '2016-11-03 16:29:30', '2016-11-17 11:52:50', '王 强', '15329505581', '');
INSERT INTO `lxy_driver` VALUES ('127', '2016-11-03 17:07:12', '2016-11-17 11:52:50', '张云忠', '18798877536', '');
INSERT INTO `lxy_driver` VALUES ('128', '2016-11-03 17:07:12', '2016-11-17 11:52:50', '曾佩奎', '13595102187', '');
INSERT INTO `lxy_driver` VALUES ('129', '2016-11-03 17:07:12', '2016-11-17 11:52:50', '罗发刚', '18985134622', '');
INSERT INTO `lxy_driver` VALUES ('130', '2016-11-03 17:07:12', '2016-11-17 11:52:50', '陈文斌', '13368615282', '');
INSERT INTO `lxy_driver` VALUES ('131', '2016-11-03 17:07:12', '2016-11-17 11:52:50', '刘明江', '18984027729', '');
INSERT INTO `lxy_driver` VALUES ('132', '2016-11-03 17:07:12', '2016-11-17 11:52:50', '曾亚平', '13985445947', '');
INSERT INTO `lxy_driver` VALUES ('133', '2016-11-03 17:07:12', '2016-11-17 11:52:50', '钟仕祥', '13985004933', '');
INSERT INTO `lxy_driver` VALUES ('134', '2016-11-03 17:07:12', '2016-11-17 11:52:50', '李英强', '18302623383', '');
INSERT INTO `lxy_driver` VALUES ('135', '2016-11-03 17:07:12', '2016-11-17 11:52:50', '李长江', '13885117549', '');

-- ----------------------------
-- Table structure for lxy_feedback
-- ----------------------------
DROP TABLE IF EXISTS `lxy_feedback`;
CREATE TABLE `lxy_feedback` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_valid` bit(1) NOT NULL DEFAULT b'1',
  `create_time` datetime NOT NULL,
  `type` varchar(24) DEFAULT NULL COMMENT '反馈类型',
  `email` varchar(128) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(24) DEFAULT NULL COMMENT '电话',
  `username` varchar(128) DEFAULT NULL COMMENT '姓名',
  `message` varchar(255) NOT NULL COMMENT '消息',
  `user_id` varchar(100) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `user_id_feedback` (`user_id`),
  CONSTRAINT `user_id_feedback` FOREIGN KEY (`user_id`) REFERENCES `sys_app_user` (`USER_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='意见反馈';

-- ----------------------------
-- Records of lxy_feedback
-- ----------------------------
INSERT INTO `lxy_feedback` VALUES ('1', '', '2016-09-29 17:03:26', '1', '810957426@qq.com', '18286410266', '黎国庆', 'slfdjlaskflasjdlfjasldf', null);
INSERT INTO `lxy_feedback` VALUES ('2', '', '2016-09-29 17:05:36', '1', '56556565@qq.com', '18286541022', 'sdfsdf', '大事发生地方', null);
INSERT INTO `lxy_feedback` VALUES ('4', '', '2016-09-29 17:11:19', '3', '5464569@qq.com', '15885641022', '54646', 'ldklaglajgoerksadlgajlfa', null);

-- ----------------------------
-- Table structure for lxy_order_form
-- ----------------------------
DROP TABLE IF EXISTS `lxy_order_form`;
CREATE TABLE `lxy_order_form` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_valid` bit(1) NOT NULL DEFAULT b'1' COMMENT '标识当前记录对于当前的实际业务来说是否有效：1有效，0无效',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `order_code` varchar(32) NOT NULL COMMENT '订单编号(yyyyMMddHHmmss+userId+随机3)',
  `default_route_id` bigint(20) DEFAULT NULL COMMENT '订单类型',
  `user_defined_route` varchar(500) DEFAULT NULL,
  `start_time` datetime NOT NULL COMMENT '订单出发日期',
  `end_time` datetime NOT NULL COMMENT '订单结束日期',
  `add_svc_id` int(11) DEFAULT NULL COMMENT '所选附加服务',
  `add_svc_other` varchar(255) DEFAULT NULL COMMENT '附加服务如果选了其他，此列值不为空，否则为空',
  `km` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL COMMENT '用户id',
  `contact_person` varchar(255) DEFAULT NULL COMMENT '联系人',
  `contact_number` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `group_number` varchar(15) DEFAULT NULL,
  `order_state` enum('PAY_OK','CHECKSUCCESS','CHECKFAIL','CHECKING','CONSUMED','REFUNDING','REFUNDED','REFUND_FAIL','CLOSED','FINISH','WAITPAY') NOT NULL COMMENT '订单状态（参照XConst.java中的ORDER_STATE)',
  `pay_type` varchar(16) DEFAULT NULL COMMENT '支付类型（alipay：支付宝   unionpay:银联）',
  `pay_order_id` varchar(128) DEFAULT '0' COMMENT '支付单号',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `assessor` varchar(50) DEFAULT NULL COMMENT '审核人',
  `is_sms_dri` bit(1) DEFAULT b'0' COMMENT '是否已通知司机',
  PRIMARY KEY (`id`),
  KEY `default_route_id` (`default_route_id`),
  KEY `add_svc_id` (`add_svc_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `add_svc_id` FOREIGN KEY (`add_svc_id`) REFERENCES `lxy_add_svc` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `default_route_id` FOREIGN KEY (`default_route_id`) REFERENCES `lxy_default_route` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_app_user` (`USER_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单表';

-- ----------------------------
-- Records of lxy_order_form
-- ----------------------------

-- ----------------------------
-- Table structure for lxy_order_refund
-- ----------------------------
DROP TABLE IF EXISTS `lxy_order_refund`;
CREATE TABLE `lxy_order_refund` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `state` varchar(20) DEFAULT 'ADD',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `person_name` varchar(20) DEFAULT NULL COMMENT '退款人真实姓名',
  `person_phone` varchar(20) DEFAULT NULL COMMENT '退款人联系方式',
  `bank_name` varchar(20) DEFAULT '""' COMMENT '退款银行名称',
  `bank_no` varchar(32) DEFAULT NULL COMMENT '退款银行卡号',
  `reason` varchar(64) DEFAULT NULL COMMENT '退款原因',
  `finish_time` datetime DEFAULT NULL COMMENT '退款完成时间',
  `form_id` bigint(20) DEFAULT NULL COMMENT 'web_order_form表的id',
  `is_check` bigint(20) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单退款表';

-- ----------------------------
-- Records of lxy_order_refund
-- ----------------------------
INSERT INTO `lxy_order_refund` VALUES ('1', 'ADD', '2016-10-21 16:31:35', '2016-10-21 16:31:35', '', '', '', '', '行程有变', null, '13', '1');
INSERT INTO `lxy_order_refund` VALUES ('2', 'ADD', '2016-10-25 17:55:39', '2016-10-25 17:56:07', '', '', '', '', '行程有变', null, '15', '0');

-- ----------------------------
-- Table structure for lxy_refund
-- ----------------------------
DROP TABLE IF EXISTS `lxy_refund`;
CREATE TABLE `lxy_refund` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `form_id` bigint(20) DEFAULT NULL COMMENT '对应order_formID',
  `reason` varchar(2048) DEFAULT NULL COMMENT '审核理由',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='订单退款审核表';

-- ----------------------------
-- Records of lxy_refund
-- ----------------------------
INSERT INTO `lxy_refund` VALUES ('1', '2016-10-25 17:56:34', '15', null);

-- ----------------------------
-- Table structure for sys_app_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_app_user`;
CREATE TABLE `sys_app_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `PHONE` varchar(100) DEFAULT NULL,
  `SFID` varchar(100) DEFAULT NULL,
  `START_TIME` varchar(100) DEFAULT NULL,
  `END_TIME` varchar(100) DEFAULT NULL,
  `YEARS` int(10) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_app_user
-- ----------------------------
INSERT INTO `sys_app_user` VALUES ('140bc34b09294d08b1a94e9a75b80681', 'zcf', '9be40cee5b0eee1462c82c6964087ff9', '张', '', '55896f5ce3c0494fa6850775a4e29ff6', '', '', '1', 'hello', '17785925359', '521564146', '2016-10-20', '2017-02-28', '1', '020', '350816828@qq.com');
INSERT INTO `sys_app_user` VALUES ('2383a825adff47e19321ae6db6eb942b', 'htt26', 'e10adc3949ba59abbe56e057f20f883e', '贵阳龙行神洲国际旅行社-黄廷廷', '', 'b8f775e69a1148c7be4476dac12557a8', '', '', '1', '', '18985176036', '546132164656566', '2016-10-28', '2019-04-26', '4', '52222', '446285092@qq.com');
INSERT INTO `sys_app_user` VALUES ('3d338b02b71c431589040b4fee5d4cf1', 'bfx', 'b0baee9d279d34fa1dfd71aadb908c3f', '包福勋', '', '55896f5ce3c0494fa6850775a4e29ff6', '', '', '1', 'hello、', '12342134', '12342142314213', '2016-09-28', '2017-01-31', '2', '006', '654@qq.com');
INSERT INTO `sys_app_user` VALUES ('4234159c09434c54a6e7a760166f70ef', 'xiahuiqin', 'e10adc3949ba59abbe56e057f20f883e', '贵阳龙行神洲国际旅行社-夏慧琴', '', 'b8f775e69a1148c7be4476dac12557a8', '', '', '1', '', '18985176038', '4156321315665', '2016-10-28', '2019-05-22', '4', '50002', '3322624865@qq.com');
INSERT INTO `sys_app_user` VALUES ('5798d8e6df884ceb9aed086136a101f1', 'luoting', 'e10adc3949ba59abbe56e057f20f883e', '自然之旅-罗婷', '', '76c1ab74271442efb0b625b5e8cf4884', '', '', '1', 'sdf', '18585629618', '', '2016-11-16', '2016-11-18', '5', '0900990', '423424@qq.com');
INSERT INTO `sys_app_user` VALUES ('77908ff64bff4cb4b1987f5dd4a4b96c', 'gounana', 'e10adc3949ba59abbe56e057f20f883e', '贵阳龙行神洲国际旅行社-勾娜娜', '', 'b8f775e69a1148c7be4476dac12557a8', '', '', '1', '', '18985176037', '2165132613136', '2016-10-28', '2018-06-15', '4', '50001', '1289045757@qq.com');
INSERT INTO `sys_app_user` VALUES ('ba11934ade2b43808356ed6a75549c8c', 'fuqin', 'e10adc3949ba59abbe56e057f20f883e', '贵阳龙行神洲国际旅行社-付琴', '', 'b8f775e69a1148c7be4476dac12557a8', '', '', '1', '', '18985176061', '14165464561', '2016-10-28', '2017-11-29', '4', '40001', '2718196587@qq.com');
INSERT INTO `sys_app_user` VALUES ('d3775a7302914a249d6f13fed7b662aa', 'zhangcheng', 'bb10a8408150565df76c39fcb0cd6a62', '张诚', '', 'f944a9df72634249bbcb8cb73b0c9b86', '', '', '1', 'xxxx', '182000000', '52222', '2016-10-13', '2016-10-31', '3', '10000', 'zhang@qq.com');
INSERT INTO `sys_app_user` VALUES ('d499ac0b56d74062ac85780f171825bb', 'luoxiao', 'e10adc3949ba59abbe56e057f20f883e', '贵阳龙行神洲国际旅行社-骆骁', '', 'b8f775e69a1148c7be4476dac12557a8', '', '', '1', '', '18985176064', '41216546546546', '2016-10-28', '2019-02-22', '0', '50009', '302653841@qq.com');
INSERT INTO `sys_app_user` VALUES ('efed8ea355a84762880da089f00247af', 'gcy', 'b0b56a22da74a4578084ed8043f3faca', '郭朝永', '', 'f944a9df72634249bbcb8cb73b0c9b86', '', '', '1', 'hello', '18286101861', '522501199112207072', '2016-08-15', '2016-08-24', '1', '002', '1042456230@qq.com');
INSERT INTO `sys_app_user` VALUES ('fbd5daff70f34622956607c96d51867d', 'linli', '3517d8b291fed38708899cf152b6913d', '贵阳龙行神洲国际旅行社-林莉', '', 'b8f775e69a1148c7be4476dac12557a8', '', '', '1', '', '18985176065', '522654484566544', '2016-10-28', '2017-03-30', '4', '20001', '3376888428@qq.com');
INSERT INTO `sys_app_user` VALUES ('fed584e8d5284aefb56ba721bcf038fe', 'lgq', 'e10adc3949ba59abbe56e057f20f883e', 'gsdgsdg', '', '55896f5ce3c0494fa6850775a4e29ff6', '', '', '1', 'sdf ', '18286410266', '52252655645656', '2016-08-15', '2016-08-31', '3', '00000', '979314805@qq.com');

-- ----------------------------
-- Table structure for sys_dictionaries
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionaries`;
CREATE TABLE `sys_dictionaries` (
  `ZD_ID` varchar(100) NOT NULL,
  `NAME` varchar(100) DEFAULT NULL,
  `BIANMA` varchar(100) DEFAULT NULL,
  `ORDY_BY` int(10) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `JB` int(10) DEFAULT NULL,
  `P_BM` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`ZD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_dictionaries
-- ----------------------------
INSERT INTO `sys_dictionaries` VALUES ('212a6765fddc4430941469e1ec8c8e6c', '人事部', '001', '1', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_001');
INSERT INTO `sys_dictionaries` VALUES ('3cec73a7cc8a4cb79e3f6ccc7fc8858c', '行政部', '002', '2', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_002');
INSERT INTO `sys_dictionaries` VALUES ('48724375640341deb5ef01ac51a89c34', '北京', 'dq001', '1', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_dq001');
INSERT INTO `sys_dictionaries` VALUES ('5a1547632cca449db378fbb9a042b336', '研发部', '004', '4', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_004');
INSERT INTO `sys_dictionaries` VALUES ('7f9cd74e60a140b0aea5095faa95cda3', '财务部', '003', '3', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_003');
INSERT INTO `sys_dictionaries` VALUES ('b861bd1c3aba4934acdb5054dd0d0c6e', '科技不', 'kj', '7', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_kj');
INSERT INTO `sys_dictionaries` VALUES ('c067fdaf51a141aeaa56ed26b70de863', '部门', 'BM', '1', '0', '1', 'BM');
INSERT INTO `sys_dictionaries` VALUES ('cdba0b5ef20e4fc0a5231fa3e9ae246a', '地区', 'DQ', '2', '0', '1', 'DQ');
INSERT INTO `sys_dictionaries` VALUES ('f184bff5081d452489271a1bd57599ed', '上海', 'SH', '2', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_SH');
INSERT INTO `sys_dictionaries` VALUES ('f30bf95e216d4ebb8169ff0c86330b8f', '客服部', '006', '6', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_006');

-- ----------------------------
-- Table structure for sys_gl_qx
-- ----------------------------
DROP TABLE IF EXISTS `sys_gl_qx`;
CREATE TABLE `sys_gl_qx` (
  `GL_ID` varchar(100) NOT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `FX_QX` int(10) DEFAULT NULL,
  `FW_QX` int(10) DEFAULT NULL,
  `QX1` int(10) DEFAULT NULL,
  `QX2` int(10) DEFAULT NULL,
  `QX3` int(10) DEFAULT NULL,
  `QX4` int(10) DEFAULT NULL,
  PRIMARY KEY (`GL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_gl_qx
-- ----------------------------
INSERT INTO `sys_gl_qx` VALUES ('1', '2', '1', '1', '1', '1', '1', '1');
INSERT INTO `sys_gl_qx` VALUES ('2', '1', '0', '0', '1', '1', '1', '1');
INSERT INTO `sys_gl_qx` VALUES ('55896f5ce3c0494fa6850775a4e29ff6', '7', '0', '0', '1', '0', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('63abc2a26b1b4e14ad75acfdc0a7fd46', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('68f23fc0caee475bae8d52244dea8444', '7', '0', '0', '1', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('76c1ab74271442efb0b625b5e8cf4884', '7', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('ac66961adaa2426da4470c72ffeec117', '1', '1', '0', '1', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('b0c77c29dfa140dc9b14a29c056f824f', '7', '1', '0', '1', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('b8f775e69a1148c7be4476dac12557a8', '7', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('e74f713314154c35bd7fc98897859fe3', '6', '1', '1', '1', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('f944a9df72634249bbcb8cb73b0c9b86', '7', '1', '1', '1', '1', '0', '0');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `MENU_ID` int(11) NOT NULL,
  `MENU_NAME` varchar(255) DEFAULT NULL,
  `MENU_URL` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `MENU_ORDER` varchar(100) DEFAULT NULL,
  `MENU_ICON` varchar(30) DEFAULT NULL,
  `MENU_TYPE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '#', '0', '1', 'icon-desktop', '1');
INSERT INTO `sys_menu` VALUES ('2', '组织管理', 'admin/role.do', '1', '2', null, '1');
INSERT INTO `sys_menu` VALUES ('4', '会员管理', 'admin/happuser/listUsers.do', '1', '4', null, '1');
INSERT INTO `sys_menu` VALUES ('5', '系统用户', 'admin/user/listUsers.do', '1', '3', null, '1');
INSERT INTO `sys_menu` VALUES ('6', '信息管理', '#', '0', '2', 'icon-list-alt', '1');
INSERT INTO `sys_menu` VALUES ('7', '图片管理', 'admin/pictures/list.do', '6', '1', null, '1');
INSERT INTO `sys_menu` VALUES ('8', '性能监控', 'druid/index.html', '9', '1', null, '1');
INSERT INTO `sys_menu` VALUES ('9', '系统工具', '#', '0', '3', 'icon-th', '1');
INSERT INTO `sys_menu` VALUES ('10', '接口测试', 'admin/tool/interfaceTest.do', '9', '2', null, '1');
INSERT INTO `sys_menu` VALUES ('11', '发送邮件', 'admin/tool/goSendEmail.do', '9', '3', null, '1');
INSERT INTO `sys_menu` VALUES ('12', '置二维码', 'admin/tool/goTwoDimensionCode.do', '9', '4', null, '1');
INSERT INTO `sys_menu` VALUES ('13', '多级别树', 'admin/tool/ztree.do', '9', '5', null, '1');
INSERT INTO `sys_menu` VALUES ('14', '地图工具', 'admin/tool/map.do', '9', '6', null, '1');
INSERT INTO `sys_menu` VALUES ('15', '微信管理', '#', '0', '2', 'icon-comments', '1');
INSERT INTO `sys_menu` VALUES ('16', '文本回复', 'textmsg/list.do', '15', '2', null, '1');
INSERT INTO `sys_menu` VALUES ('17', '应用命令', 'command/list.do', '15', '4', null, '1');
INSERT INTO `sys_menu` VALUES ('18', '图文回复', 'imgmsg/list.do', '15', '3', null, '1');
INSERT INTO `sys_menu` VALUES ('19', '关注回复', 'textmsg/goSubscribe.do', '15', '1', null, '1');
INSERT INTO `sys_menu` VALUES ('20', '在线管理', 'admin/onlinemanager/list.do', '1', '5', null, '1');
INSERT INTO `sys_menu` VALUES ('21', '龙行云-订单管理', '#', '0', '5', null, '2');
INSERT INTO `sys_menu` VALUES ('22', '龙行云-车辆管理', '#', '0', '6', null, '2');
INSERT INTO `sys_menu` VALUES ('23', '龙行云-路线管理', '#', '0', '7', null, '2');
INSERT INTO `sys_menu` VALUES ('24', '订单列表', 'admin/order/list.do', '21', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('25', '退款管理', 'admin/lxy/refund/list.do', '21', '2', null, '2');
INSERT INTO `sys_menu` VALUES ('26', '默认线路', 'admin/lxy/default_route/list.do', '23', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('27', '车辆使用', 'admin/lxy/car/use_list.do', '22', '2', null, '2');
INSERT INTO `sys_menu` VALUES ('29', '龙行云-用户反馈', '#', '0', '8', null, '2');
INSERT INTO `sys_menu` VALUES ('30', '用户反馈', 'admin/lxy/feedback/main', '29', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('31', '车辆基本信息', 'admin/lxy/car/base_info/list', '22', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('32', '车辆类型管理', 'admin/lxy/car_type/main', '22', '3', null, '2');
INSERT INTO `sys_menu` VALUES ('34', '附加项目', 'admin/lxy/add_svc/list', '23', '4', null, '2');
INSERT INTO `sys_menu` VALUES ('35', '专属订单', 'admin/order/applist.do', '21', '3', null, '2');
INSERT INTO `sys_menu` VALUES ('36', '司机管理', 'admin/lxy/driver/main', '22', '4', null, '2');
INSERT INTO `sys_menu` VALUES ('37', '接送地点管理', '#', '0', '4', null, '');
INSERT INTO `sys_menu` VALUES ('38', '接团地点管理', 'admin/lxy/jt/main', '37', '1', null, '');
INSERT INTO `sys_menu` VALUES ('39', '送团地点管理', 'admin/lxy/st/main', '37', '2', null, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `ROLE_ID` varchar(100) NOT NULL,
  `ROLE_NAME` varchar(100) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `ADD_QX` varchar(255) DEFAULT NULL,
  `DEL_QX` varchar(255) DEFAULT NULL,
  `EDIT_QX` varchar(255) DEFAULT NULL,
  `CHA_QX` varchar(255) DEFAULT NULL,
  `QX_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '系统管理员', '1090653257718', '0', '1', '1', '1', '1', '1');
INSERT INTO `sys_role` VALUES ('2', '超级管理员', '1090653257718', '1', '230', '50', '34', '54', '2');
INSERT INTO `sys_role` VALUES ('4', '用户组', '118', '0', '0', '0', '0', '0', null);
INSERT INTO `sys_role` VALUES ('55896f5ce3c0494fa6850775a4e29ff6', '特级会员', '498', '7', '0', '0', '0', '0', '55896f5ce3c0494fa6850775a4e29ff6');
INSERT INTO `sys_role` VALUES ('6', '客户组', '18', '0', '1', '1', '1', '1', null);
INSERT INTO `sys_role` VALUES ('63abc2a26b1b4e14ad75acfdc0a7fd46', '旅行社老大', '1090653257718', '1', '0', '0', '0', '0', '63abc2a26b1b4e14ad75acfdc0a7fd46');
INSERT INTO `sys_role` VALUES ('68f23fc0caee475bae8d52244dea8444', '中级会员', '498', '7', '0', '0', '0', '0', '68f23fc0caee475bae8d52244dea8444');
INSERT INTO `sys_role` VALUES ('7', '会员组', '498', '0', '0', '0', '0', '1', null);
INSERT INTO `sys_role` VALUES ('76c1ab74271442efb0b625b5e8cf4884', '自然之旅', '498', '7', '0', '0', '0', '0', '76c1ab74271442efb0b625b5e8cf4884');
INSERT INTO `sys_role` VALUES ('ac66961adaa2426da4470c72ffeec117', '客运公司管理员', '1090653257718', '1', '34357641270', '34357641216', '34357641216', '34357641216', 'ac66961adaa2426da4470c72ffeec117');
INSERT INTO `sys_role` VALUES ('b0c77c29dfa140dc9b14a29c056f824f', '高级会员', '498', '7', '0', '0', '0', '0', 'b0c77c29dfa140dc9b14a29c056f824f');
INSERT INTO `sys_role` VALUES ('b8f775e69a1148c7be4476dac12557a8', '贵阳龙行神洲国际旅行社', '498', '7', '0', '0', '0', '0', 'b8f775e69a1148c7be4476dac12557a8');
INSERT INTO `sys_role` VALUES ('e74f713314154c35bd7fc98897859fe3', '黄金客户', '18', '6', '1', '1', '1', '1', 'e74f713314154c35bd7fc98897859fe3');
INSERT INTO `sys_role` VALUES ('f944a9df72634249bbcb8cb73b0c9b86', '初级会员', '498', '7', '1', '1', '1', '1', 'f944a9df72634249bbcb8cb73b0c9b86');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `SKIN` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('012166278881425a9f6477069491f920', 'zhy', '550b7b6c404e2f5ada0dc12c73e1e95f57a0ebfe', '贵阳龙行神洲国际旅行社', '', '63abc2a26b1b4e14ad75acfdc0a7fd46', '2016-10-31 18:11:04', '220.197.186.42', '0', '', 'default', 'sdfs@qq.com', '56222', '18286410266');
INSERT INTO `sys_user` VALUES ('1', 'admin', 'de41b7fb99201d8334c23c014db35ecd92df81bc', '系统管理员', '1133671055321055258374707980945218933803269864762743594642571294', '1', '2016-11-23 10:10:12', '127.0.0.1', '0', '最高统治者', 'default', 'admin@main.com', '001', '18788888888');
INSERT INTO `sys_user` VALUES ('292449d148944bd7aa694c3ed770c690', 'zhuyou', '398c2ee460748dd6d38c0245ec48c753ac53e639', '朱优', '', 'ac66961adaa2426da4470c72ffeec117', '2016-11-10 10:14:38', '58.16.139.182', '0', '客运公司操作员', 'default', '1796925383@qq.com', 'zhuyou', '18708502172');
INSERT INTO `sys_user` VALUES ('524f52bfb5624d1ea807128d23f65ed1', 'chenzong', 'cffa7d0af34ab2234e2dea02c4df424bd0d18717', '贵阳龙行神洲国际旅行社', '', '63abc2a26b1b4e14ad75acfdc0a7fd46', '2016-10-31 10:26:13', '1.204.49.18', '0', '陈东霞', 'default', '1592466767@qq.com', 'chendongxia', '18985176039');
INSERT INTO `sys_user` VALUES ('b4a3fb8c2ec542dd9ba42bebdb6eadad', 'zhangcheng', '56e6f59652d96b7c8ebb3cf3b4395b316f03e7f2', '张经理', '', 'ac66961adaa2426da4470c72ffeec117', '2016-10-13 09:47:26', '121.34.33.177', '0', 'xxxxxxxxxx', 'default', 'zhang@qq.com', '10003', '18200000000');

-- ----------------------------
-- Table structure for sys_user_qx
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_qx`;
CREATE TABLE `sys_user_qx` (
  `U_ID` varchar(100) NOT NULL,
  `C1` int(10) DEFAULT NULL,
  `C2` int(10) DEFAULT NULL,
  `C3` int(10) DEFAULT NULL,
  `C4` int(10) DEFAULT NULL,
  `Q1` int(10) DEFAULT NULL,
  `Q2` int(10) DEFAULT NULL,
  `Q3` int(10) DEFAULT NULL,
  `Q4` int(10) DEFAULT NULL,
  PRIMARY KEY (`U_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_qx
-- ----------------------------
INSERT INTO `sys_user_qx` VALUES ('1', '1', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('2', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `sys_user_qx` VALUES ('55896f5ce3c0494fa6850775a4e29ff6', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('63abc2a26b1b4e14ad75acfdc0a7fd46', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('68f23fc0caee475bae8d52244dea8444', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('76c1ab74271442efb0b625b5e8cf4884', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('ac66961adaa2426da4470c72ffeec117', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('b0c77c29dfa140dc9b14a29c056f824f', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('b8f775e69a1148c7be4476dac12557a8', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('e74f713314154c35bd7fc98897859fe3', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('f944a9df72634249bbcb8cb73b0c9b86', '0', '0', '0', '0', '0', '0', '0', '0');
