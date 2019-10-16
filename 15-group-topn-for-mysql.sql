DROP TABLE IF EXISTS `strategy_table`;

CREATE TABLE `strategy_table`  (
  `table_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '攻略id',
  `title` varchar(100) NULL DEFAULT NULL COMMENT '攻略标题',
  `picture` varchar(255) NULL DEFAULT NULL COMMENT '攻略封面图片',
  `description` varchar(255) NULL DEFAULT NULL COMMENT '攻略描述',
  `content` varchar(15000) NULL DEFAULT NULL COMMENT '攻略内容',
  `author` varchar(20) NULL DEFAULT NULL COMMENT '攻略作者',
  `releaseTime` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  `releaseStatus` int(5) NULL DEFAULT 0 COMMENT '发布状态（\"0”未发布）',
  `browse` int(255) NULL DEFAULT NULL COMMENT '浏览数',
  `classifyId` int(11) NULL DEFAULT NULL COMMENT '攻略分类id',
  `tdkId` varchar(255) NULL DEFAULT NULL COMMENT 'tdkid',
  `labelId` int(11) NULL DEFAULT NULL COMMENT '标签内容id',
  `sortTime` datetime(0) NULL DEFAULT NULL COMMENT '置顶时间',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 ROW_FORMAT = Dynamic;

INSERT INTO `strategy_table` VALUES (1, 'sdad', 'static/img/strategyImg/2012031220134655.jpg', 'dasasdad', '<p>addddddddd</p>', 'asdasd', '2019-03-25 09:31:57', 0, NULL, 4003, '1e8f1c20-a335-449d-b27d-109815447e6d', 3, '2019-03-25 10:05:17');
INSERT INTO `strategy_table` VALUES (2, 'eeeeeeee', 'static/img/strategyImg/560dcfbdadc7e7ee8a37fe0ca3809e8.png', 'eeeeeeeeeeeee', '<p>eeeeeeeeeeeeeeee</p>', 'eeeeeeeeee', '2019-03-25 09:32:31', 0, NULL, 5004, 'e35c2759-41fa-4b22-9d3f-c1b17c1f48db', 2, '2019-03-25 09:32:31');
INSERT INTO `strategy_table` VALUES (3, 'yyyyyyyy', 'static/img/strategyImg/xunguang-9.jpg', 'yyyyyyyyyyyyyyy', '<p>yyyyyyyyyyyyyy</p>', 'yyyyyyyyyyy', '2019-03-25 09:33:10', 1, NULL, 5013, 'cce356ac-a3d1-4a69-9ffa-8b3f5929c6d0', 6, '2019-03-25 09:33:10');
INSERT INTO `strategy_table` VALUES (4, 'swwwwwwwwwww', 'static/img/strategyImg/timg (1).jpg', 'daddada', '<p>sdaaaaa<br/></p>', 'wwwwwwwwwwwwww', '2019-03-25 09:37:36', 0, NULL, 4001, '4f94a8f9-b8b3-4a70-8094-87711835c1de', 3, '2019-03-25 09:37:36');
INSERT INTO `strategy_table` VALUES (5, 'tttttt', 'static/img/strategyImg/timg (2).jpg', 'ttttttttt', '<p>ttttttttttt</p>', 'ttttttttttttt', '2019-03-25 10:05:05', 0, NULL, 4003, 'f07374b9-1fe4-4fb7-bfe5-a8e96a607dbf', 2, '2019-03-25 10:05:05');
INSERT INTO `strategy_table` VALUES (6, 'uuuuuuuuuu', 'static/img/strategyImg/timg (3).jpg', 'uuuuuuuuuu', '<p>uuuuuuuuuuuu</p>', 'uuuuuuuu', '2019-03-25 10:05:47', 0, NULL, 4001, '5eaa2c63-a060-4eaf-af25-7330280dfc28', 3, '2019-03-25 10:05:47');
INSERT INTO `strategy_table` VALUES (7, 'yyyyyyyy', 'static/img/strategyImg/xunguang-9.jpg', 'yyyyyyyyyyyyyyy', '<p>yyyyyyyyyyyyyy</p>', 'yyyyyyyyyyy', '2019-03-25 09:33:10', 1, NULL, 5013, 'cce356ac-a3d1-4a69-9ffa-8b3f5929c6d0', 6, '2019-03-25 09:33:10');
INSERT INTO `strategy_table` VALUES (8, 'yyyyyyyy', 'static/img/strategyImg/xunguang-9.jpg', 'yyyyyyyyyyyyyyy', '<p>yyyyyyyyyyyyyy</p>', 'yyyyyyyyyyy', '2019-03-25 09:33:10', 1, NULL, 5013, 'cce356ac-a3d1-4a69-9ffa-8b3f5929c6d0', 6, '2019-03-25 09:33:10');
INSERT INTO `strategy_table` VALUES (9, 'yyyyyyyy', 'static/img/strategyImg/xunguang-9.jpg', 'yyyyyyyyyyyyyyy', '<p>yyyyyyyyyyyyyy</p>', 'yyyyyyyyyyy', '2019-03-25 09:33:10', 1, NULL, 5013, 'cce356ac-a3d1-4a69-9ffa-8b3f5929c6d0', 6, '2019-03-25 09:33:10');
INSERT INTO `strategy_table` VALUES (10, 'eeeeeeee', 'static/img/strategyImg/560dcfbdadc7e7ee8a37fe0ca3809e8.png', 'eeeeeeeeeeeee', '<p>eeeeeeeeeeeeeeee</p>', 'eeeeeeeeee', '2019-03-25 09:32:31', 0, NULL, 5004, 'e35c2759-41fa-4b22-9d3f-c1b17c1f48db', 2, '2019-03-25 09:32:31');
INSERT INTO `strategy_table` VALUES (11, 'eeeeeeee', 'static/img/strategyImg/560dcfbdadc7e7ee8a37fe0ca3809e8.png', 'eeeeeeeeeeeee', '<p>eeeeeeeeeeeeeeee</p>', 'eeeeeeeeee', '2019-03-25 09:32:31', 0, NULL, 5004, 'e35c2759-41fa-4b22-9d3f-c1b17c1f48db', 2, '2019-03-25 09:32:31');
INSERT INTO `strategy_table` VALUES (12, 'eeeeeeee', 'static/img/strategyImg/560dcfbdadc7e7ee8a37fe0ca3809e8.png', 'eeeeeeeeeeeee', '<p>eeeeeeeeeeeeeeee</p>', 'eeeeeeeeee', '2019-03-25 09:32:31', 0, NULL, 5004, 'e35c2759-41fa-4b22-9d3f-c1b17c1f48db', 2, '2019-03-25 09:32:31');

DROP TABLE IF EXISTS `strategy_classify`;

CREATE TABLE strategy_classify ( 
  `classify_id` int(20) NOT NULL AUTO_INCREMENT COMMENT '分级id',
  `classify_1` varchar(100) NULL DEFAULT NULL COMMENT '一级分类',
  `classify_2` varchar(100) NULL DEFAULT NULL COMMENT '二级分类',
  PRIMARY KEY (`classify_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COMMENT = '攻略分类表' ROW_FORMAT = Dynamic;

INSERT INTO `strategy_classify` VALUES (2001, '装修攻略', '家具资讯');
INSERT INTO `strategy_classify` VALUES (2002, '装修攻略', '小白装修');
INSERT INTO `strategy_classify` VALUES (2003, '装修攻略', '装修施工');
INSERT INTO `strategy_classify` VALUES (2004, '装修攻略', '装修选材');
INSERT INTO `strategy_classify` VALUES (2005, '装修攻略', '家具搭配');
INSERT INTO `strategy_classify` VALUES (2006, '装修攻略', '家居风水');
INSERT INTO `strategy_classify` VALUES (2007, '装修攻略', '装修案例');
INSERT INTO `strategy_classify` VALUES (2008, '装修攻略', '装修设计');
INSERT INTO `strategy_classify` VALUES (3001, '家具选购', '卧室');
INSERT INTO `strategy_classify` VALUES (3002, '家具选购', '厨房');
INSERT INTO `strategy_classify` VALUES (3003, '家具选购', '客厅');
INSERT INTO `strategy_classify` VALUES (3004, '家具选购', '餐厅');
INSERT INTO `strategy_classify` VALUES (3005, '家具选购', '书房');
INSERT INTO `strategy_classify` VALUES (3006, '家具选购', '儿童房');
INSERT INTO `strategy_classify` VALUES (3007, '定制攻略', '橱柜');
INSERT INTO `strategy_classify` VALUES (4001, '定制攻略', '衣柜');
INSERT INTO `strategy_classify` VALUES (4002, '定制攻略', '鞋柜');
INSERT INTO `strategy_classify` VALUES (4003, '定制攻略', '书柜');
INSERT INTO `strategy_classify` VALUES (4004, '定制攻略', '书桌');
INSERT INTO `strategy_classify` VALUES (4005, '定制攻略', '床头柜');
INSERT INTO `strategy_classify` VALUES (4006, '定制攻略', '阳台柜');
INSERT INTO `strategy_classify` VALUES (4007, '定制攻略', '隔断柜');
INSERT INTO `strategy_classify` VALUES (4008, '定制攻略', '梳妆台');
INSERT INTO `strategy_classify` VALUES (4009, '定制攻略', '榻榻米');
INSERT INTO `strategy_classify` VALUES (4010, '定制攻略', '玄关柜');
INSERT INTO `strategy_classify` VALUES (4011, '定制攻略', '展示柜');
INSERT INTO `strategy_classify` VALUES (5001, '家具问答', '问题主题1');
INSERT INTO `strategy_classify` VALUES (5002, '家具问答', '问题主题2');
INSERT INTO `strategy_classify` VALUES (5003, '家具问答', '问题主题3');
INSERT INTO `strategy_classify` VALUES (5004, '空间家具选购', '我是谁');
INSERT INTO `strategy_classify` VALUES (5005, '定制攻略', 'sd');
INSERT INTO `strategy_classify` VALUES (5007, '空间家具选购', '555');
INSERT INTO `strategy_classify` VALUES (5011, '家居生活', '77777');
INSERT INTO `strategy_classify` VALUES (5012, '定制攻略', '2222');
INSERT INTO `strategy_classify` VALUES (5013, '全屋功能定制', '88888888');
INSERT INTO `strategy_classify` VALUES (5014, '家居生活', 'sheng');

select a.classifyId,b.classify_1,a.title,a.sortTime,a.content,a.picture from strategy_table as a,strategy_classify as b where a.classifyId=b.classify_id;

select c.classifyId,c.classify_1,c.title,c.sortTime,c.content,c.picture from
(select a.classifyId,b.classify_1,a.title,a.sortTime,a.content,a.picture from strategy_table as a,strategy_classify as b 
where a.classifyId=b.classify_id) as c order by c.classifyId,c.sortTime desc;

select c.classifyId,c.classify_1,c.title,c.sortTime,c.content,c.picture,
	if(@tmp=c.classify_1,@rank:=@rank+1,@rank:=1) as new_rank,@tmp:=c.classify_1 as tmp from
(select a.classifyId,b.classify_1,a.title,a.sortTime,a.content,a.picture from strategy_table as a,strategy_classify as b 
where a.classifyId=b.classify_id) as c order by c.classifyId,c.sortTime desc;

select * from (select c.classifyId,c.classify_1,c.title,c.sortTime,c.content,c.picture,
	if(@tmp=c.classify_1,@rank:=@rank+1,@rank:=1) as new_rank,@tmp:=c.classify_1 as tmp from
(select a.classifyId,b.classify_1,a.title,a.sortTime,a.content,a.picture from strategy_table as a,strategy_classify as b 
where a.classifyId=b.classify_id) as c order by c.classifyId,c.sortTime desc) as d where new_rank < 4;

