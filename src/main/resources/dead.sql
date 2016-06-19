/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : dead

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2016-06-19 09:00:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(64) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `source` int(1) unsigned DEFAULT '0',
  `writer` varchar(64) DEFAULT NULL,
  `content` text,
  `publishDate` datetime DEFAULT NULL,
  `catalogId` int(11) unsigned DEFAULT NULL,
  `pageView` int(11) unsigned DEFAULT NULL,
  `environment` varchar(255) DEFAULT NULL,
  `download` int(11) unsigned DEFAULT NULL,
  `status` int(1) unsigned DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', null, '九度-题目1465：最简真分数', '', '', '0', 'admin', '来源地址：[http://ac.jobdu.com/problem.php?pid=1465](http://ac.jobdu.com/problem.php?pid=1465)\r\n\r\n题目描述：\r\n给出n个正整数，任取两个数分别作为分子和分母组成最简真分数，编程求共有几个这样的组合。\r\n输入：\r\n输入有多组，每组包含n（n&lt;=600）和n个不同的整数，整数大于1且小于等于1000。\r\n当n=0时，程序结束，不需要处理这组数据。\r\n输出：\r\n每行输出最简真分数组合的个数。\r\n样例输入：\r\n7\r\n3 5 7 9 11 13 15\r\n3 \r\n2 4 5\r\n0\r\n样例输出：\r\n17 \r\n2\r\n来源：\r\n2012年北京大学计算机研究生机试真题\r\n\r\n```\r\n#include&lt;iostream&gt;\r\n#include&lt;algorithm&gt;\r\nusing namespace std;\r\n \r\nint a[601];\r\n \r\n// 求最大公约数\r\nint gcd(int x, int y) {\r\n    if (y == 0)\r\n        return x;\r\n    else\r\n        return gcd(y, x % y);\r\n}\r\n \r\nint main() {\r\n    freopen(\"gcd.txt\", \"r\", stdin);\r\n    int n;\r\n    while (scanf(\"%d\", &n), n) {\r\n        for (int i = 0; i &lt; n; ++i)\r\n            scanf(\"%d\", &a[i]);\r\n        // 优化\r\n        sort(a, a + n);\r\n        int count = 0;\r\n        for (int i = 0; i &lt; n; ++i)\r\n            for (int j = i + 1; j &lt; n; ++j)\r\n                if (gcd(a[i], a[j]) == 1)\r\n                    count++;\r\n        printf(\"%d\\n\", count);\r\n    }\r\n}\r\n```', '2016-06-18 22:39:14', '1', '18', 'markdown', '0', '3', '0', '2016-06-18 20:16:27', null, '2016-06-18 22:39:13', null, null);

-- ----------------------------
-- Table structure for attachment
-- ----------------------------
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(255) DEFAULT NULL,
  `size` varchar(64) DEFAULT NULL,
  `downloads` int(11) unsigned DEFAULT '0',
  `url` char(255) DEFAULT NULL,
  `articleId` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of attachment
-- ----------------------------

-- ----------------------------
-- Table structure for catalog
-- ----------------------------
DROP TABLE IF EXISTS `catalog`;
CREATE TABLE `catalog` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `folder` varchar(64) DEFAULT NULL,
  `deep` int(1) unsigned DEFAULT '0',
  `pid` int(11) DEFAULT NULL,
  `pidPath` varchar(255) DEFAULT NULL,
  `sum` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of catalog
-- ----------------------------
INSERT INTO `catalog` VALUES ('1', '算法', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:33:07', null, null, null, null);
INSERT INTO `catalog` VALUES ('2', '基础算法', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:33:20', null, '2016-06-18 19:35:55', null, null);
INSERT INTO `catalog` VALUES ('3', '字符串', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:36:44', null, null, null, null);
INSERT INTO `catalog` VALUES ('4', '数据结构', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:36:59', null, null, null, null);
INSERT INTO `catalog` VALUES ('5', '动态规划', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:37:19', null, null, null, null);
INSERT INTO `catalog` VALUES ('6', '搜索', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:37:37', null, null, null, null);
INSERT INTO `catalog` VALUES ('7', '树论', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:39:19', null, null, null, null);
INSERT INTO `catalog` VALUES ('8', '图论', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:39:25', null, null, null, null);
INSERT INTO `catalog` VALUES ('9', '计算几何', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:39:47', null, null, null, null);
INSERT INTO `catalog` VALUES ('10', '数学', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:39:54', null, null, null, null);
INSERT INTO `catalog` VALUES ('11', '其他', '', '2', '1', '0', '0', '0', '0', '2016-06-18 19:40:31', null, null, null, null);
INSERT INTO `catalog` VALUES ('12', '搜索引擎', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:40:55', null, null, null, null);
INSERT INTO `catalog` VALUES ('13', '爬虫', '', '2', '12', '0', '0', '0', '0', '2016-06-18 19:41:06', null, null, null, null);
INSERT INTO `catalog` VALUES ('14', 'hadoop', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:41:29', null, null, null, null);
INSERT INTO `catalog` VALUES ('15', 'spark', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:41:35', null, null, null, null);
INSERT INTO `catalog` VALUES ('16', '数据挖掘', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:41:47', null, null, null, null);
INSERT INTO `catalog` VALUES ('17', '开源项目', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:41:55', null, null, null, null);
INSERT INTO `catalog` VALUES ('18', 'linux', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:42:09', null, null, null, null);
INSERT INTO `catalog` VALUES ('19', '前端', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:42:15', null, null, null, null);
INSERT INTO `catalog` VALUES ('20', '其他', '', '1', '0', '0', '0', '0', '0', '2016-06-18 19:42:35', null, '2016-06-18 19:43:21', null, null);
INSERT INTO `catalog` VALUES ('21', '水', '', '3', '2', '0', '0', '0', '0', '2016-06-18 19:44:05', null, '2016-06-19 09:00:05', null, null);
INSERT INTO `catalog` VALUES ('22', '模拟', '', '3', '2', '0', '0', '0', '0', '2016-06-18 23:49:21', null, null, null, null);
INSERT INTO `catalog` VALUES ('23', '查找', '', '3', '2', '0', '0', '0', '0', '2016-06-18 23:49:29', null, null, null, null);
INSERT INTO `catalog` VALUES ('24', '排序', '', '3', '2', '0', '0', '0', '0', '2016-06-18 23:49:44', null, null, null, null);

-- ----------------------------
-- Table structure for plan
-- ----------------------------
DROP TABLE IF EXISTS `plan`;
CREATE TABLE `plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `cancelReason` varchar(255) DEFAULT NULL,
  `level` int(1) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of plan
-- ----------------------------

-- ----------------------------
-- Table structure for search_log
-- ----------------------------
DROP TABLE IF EXISTS `search_log`;
CREATE TABLE `search_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keywords` varchar(255) DEFAULT NULL,
  `times` int(11) unsigned DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=752 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of search_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `value` varchar(64) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('13', '', 'article:publish', '0', '0', '2016-06-05 12:56:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('19', '', 'permission:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('20', '', 'permission:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('21', '', 'role:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('22', '', 'role:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('23', '', 'user:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('24', '', 'user:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('42', '', 'plan:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('43', '', 'plan:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('44', '', 'article:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('45', '', 'article:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('46', '', 'article:upload', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('47', '', 'attachment:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('48', '', 'attachment:delete', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('49', '', 'system:rebuild', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('50', '', 'catalog:save', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('51', '', 'system:staticAll', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);
INSERT INTO `sys_permission` VALUES ('52', '', 'system:staticOne', '0', '0', '2016-06-05 12:57:09', null, '2016-06-05 12:57:09', null, null);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `value` varchar(64) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', null, 'admin', '0', '0', '2016-06-05 12:56:03', null, '2016-06-05 12:56:03', null, null);
INSERT INTO `sys_role` VALUES ('10', null, 'publisher', '0', '0', '2016-06-05 12:56:03', null, '2016-06-05 12:56:03', null, null);
INSERT INTO `sys_role` VALUES ('11', null, 'user', '0', '0', '2016-06-05 12:56:03', null, '2016-06-05 12:56:03', null, null);
INSERT INTO `sys_role` VALUES ('12', null, 'developer', '0', '0', '2016-06-05 12:56:03', null, '2016-06-05 12:56:03', null, null);

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) DEFAULT NULL,
  `permissionId` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('1', '1', '13', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('2', '1', '19', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('3', '1', '20', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('4', '1', '21', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('5', '1', '22', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('6', '1', '23', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('7', '1', '24', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('8', '1', '42', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('9', '1', '43', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('10', '1', '44', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('11', '1', '45', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('12', '1', '46', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('13', '1', '47', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('14', '1', '48', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('15', '1', '49', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('16', '1', '50', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('17', '1', '51', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('18', '1', '52', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('19', '10', '13', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('20', '10', '44', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('21', '10', '45', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('22', '10', '46', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('23', '10', '47', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);
INSERT INTO `sys_role_permission` VALUES ('24', '10', '48', '1', null, '2016-06-05 12:56:40', null, '2016-06-05 12:56:40', null, null);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `uid` varchar(64) DEFAULT NULL,
  `source` int(1) DEFAULT NULL COMMENT '用户来源:0为站内注册,1为新浪微博,2为qq登陆',
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '1SOxD7X3fSr0Hs0Wz/KBRhAGZGzel3flrQtuwexsPXc=', 'admin', '', '0', '0', '0', '0', '2016-06-05 12:56:40', null, '2016-06-09 15:28:00', null, null);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `createBy` varchar(64) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateBy` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1', '1', '1', null, '2016-06-05 12:55:43', null, '2016-06-05 12:55:43', null, null);

-- ----------------------------
-- Function structure for queryChildrenInfo
-- ----------------------------
DROP FUNCTION IF EXISTS `queryChildrenInfo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `queryChildrenInfo`(folderIdPara INT) RETURNS varchar(4000) CHARSET utf8
BEGIN
DECLARE sTemp VARCHAR(4000);
DECLARE sTempChd VARCHAR(4000);

SET sTemp = '$';
SET sTempChd = cast(folderIdPara as char);

WHILE sTempChd is not NULL DO
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT group_concat(id) INTO sTempChd FROM sys_catalog where FIND_IN_SET(folder,sTempChd)>0;
END WHILE;
return sTemp;
END
;;
DELIMITER ;
