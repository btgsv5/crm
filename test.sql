/*
 Navicat Premium Data Transfer

 Source Server         : myTest
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 06/03/2022 00:11:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `startDate` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `optionA` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `optionB` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `optionC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `optionD` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `answer` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createTime` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `editTime` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `editBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES (2, 'zs', '单选题', '2021-12-30', '启动Controller的过程：VuGen → 工具 → 创建控制器（   ）', '脚本', '场景', '任务', '界面', 'B', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (3, 'zs', '单选题', '2021-12-30', '场景组查看与监控中，查看和监控每个脚本中Vuser的运行（   ），并能够实时进行Vuser的灵活控制', '控制', '状态', '结果', '时间', 'B', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (4, 'zs', '单选题', '2021-12-30', '为什么要查看和监控，同查看服务器性能有什么关系？虚拟用户Vuser即负载，用于对系统施加（   ）。换言之，Vuser的运行状态直接影响到对系统服务器施加压力的大小，同系统性能的衡量有密切关系。', '压力', '影响', '数据', '同步', 'A', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (5, 'zs', '单选题', '2021-12-30', 'Running Vusers图：显示整个场景内（   ）的Vuser数量', '正在运行', '正在操作', '正在计算', '正在显示', 'A', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (6, 'zs', '单选题', '2021-12-30', 'Trans Response Time图：显示整个场景内完成（   ）所需的时间值', '每个运行', '每个事务', '每个操作', '每个任务', 'B', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (7, 'zs', '单选题', '2021-12-30', 'Hits per Second图：显示（   ）内每秒向服务器发送的点击次数', '操作场景', '运行场景', '整个场景', '每个场景', 'C', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (8, 'zs', '单选题', '2021-12-30', 'Windows Resources图：显示（   ）内待监测的各项Windows资源指标值', '10秒', '30秒', '90秒', '60秒', 'D', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (9, 'zs', '单选题', '2021-12-30', '在场景运行过程中，可在（   ）的配置窗口中查看并控制集合点状态', '集合点', '汇聚点', '运行点', '操作点', 'A', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (10, 'zs', '单选题', '2021-12-30', '一般在运行场景时，运行 Vuser 的计算机将调用“用于控制负载生成器上 Vuser 执行的（   ）”', '集合点', '代理', '事务', '操作', 'B', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (11, 'zs', '单选题', '2021-12-30', '场景执行期间，该代理将显示“就绪”、“正在运行”和“（   ）”的 Vuser 的概要', '事务', '代理', '暂停', '操作', 'C', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (12, 'zs', '单选题', '2021-12-30', '系统资源监控是Controller监控中的重要组成部分之一。可进一步对系统的（    ）问题准确定位', '功能', '性能', '事务', '操作', 'B', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (13, 'zs', '单选题', '2021-12-30', 'LR可以监控场景运行期间的计算机各项系统资源（既包括服务器系统资源也包括Load Generator的系统资源）的使用情况，并定位系统性能（   ）', '效率', '信息', '瓶颈', '问题', 'C', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (14, 'zs', '多选题', '2021-12-30', 'Controller的作用？', '分析场景', '设计场景', '运行场景', '监控场景', 'BCD', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (15, 'zs', '多选题', '2021-12-30', '场景设计主要包括对什么进行设置？', '测试脚本', 'Generator', 'Schedule', '集合点', 'ABCD', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (16, 'zs', '多选题', '2021-12-30', '场景设计主要包括对什么进行设置？', '综合参数', 'IP  Spoofer', '集合点', 'VuGen', 'ABC', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (17, 'zs', '多选题', '2021-12-30', '运行场景时，可监视场景组及Vuser运行的状态，并可做什么？', '监视及控制每个Vuser', '查看由Vuser生成的错误', '警告和通知消息', '监控场景运行中收集到的各种数据', 'ABCD', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (18, 'zs', '多选题', '2021-12-30', 'Controller运行窗口，主要有哪几个操作区域应用功能？', '启动场景', '场景组，查看与监控', '操作按钮', '计算操作', 'ABC', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (19, 'zs', '多选题', '2021-12-30', 'Controller运行窗口，主要有哪几个操作区域应用功能？', '场景状态，查看与监控', '查看可用数据图', '控制集合点', '压力计算', 'ABC', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (20, 'zs', '多选题', '2021-12-30', '面向目标的测试场景，目标类型主要有哪些？', '每秒事务数', '每秒点击次数', '事务响应时间', '每秒逻辑数', 'ABC', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (21, 'zs', '多选题', '2021-12-30', '面向目标的测试场景，目标类型主要有哪些？', '每分页面数', '事务响应时间', '每秒点击次数', '每秒计算数', 'ABC', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (22, 'zs', '多选题', '2021-12-30', 'Manual Scenario场景：是通过设置哪几种信息，详细模拟用户的真实活动场景', '加压方式', '场景持续运行时间', '减压方式', '计算方式', 'ABC', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (23, 'zs', '多选题', '2021-12-30', '解决“怎么做？”的问题，主要有哪几种方法？', '设置Vuser初始化方式', '设置加压方式，模拟用户同时或逐渐进入测试场景', '设置Vuser持续执行时间', '设置网速', 'ABC', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (24, 'zs', '多选题', '2021-12-30', '解决“怎么做？”的问题，主要有哪几种方法？', '设置减压方式，模拟用户同时或逐渐退出测试场景', '设置Vuser持续执行时间', '设置Vuser初始化方式', '设置网络宽度', 'ABC', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (25, 'zs', '多选题', '2021-12-30', '查看联机图，有哪几幅默认图？', 'Running Vusers图', 'Trans Response Time图', 'Hits per Second图', 'Windows Resources图', 'ABCD', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (26, 'zs', '判断题', '2021-12-30', '场景类型之手动场景，在验证系统能否达到目标，验收测试常用', '对', '错', NULL, NULL, 'B', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (27, 'zs', '判断题', '2021-12-30', '场景类型之目标场景，是定位性能瓶颈并了解系统处理能力', '对', '错', NULL, NULL, 'B', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (28, 'zs', '判断题', '2021-12-30', 'Controller提供了一种直接读取系统计数器的功能，通过添加计数器来实现对系统资源的监控', '对', '错', NULL, NULL, 'A', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (29, 'zs', '判断题', '2021-12-30', '系统监视前期准备工作注意事项：要监控服务器计算机上的资源，可以不连接到该计算机', '对', '错', NULL, NULL, 'B', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (31, 'zs', '判断题', '2021-12-30', 'Linux操作系统最大缺点在于其作为服务器的强大功能', '对', '错', NULL, NULL, 'B', '2021-12-30 20:35:50', 'zs', NULL, NULL);
INSERT INTO `question` VALUES (32, 'zs', '判断题', '2021-12-30', '软件性能需求：通常是服务器的CPU使用率不超过75％ ，内存使用率分别不超过70％，处理列队中线程数不超过2', '对1', '错1', '', '', 'A', '2021-12-30 20:35:50', 'zs', '2021-12-30 22:14:44', 'zs');
INSERT INTO `question` VALUES (35, '23', '23', '2020-11-23', '23', '1', '1', '1', '1', '1', '1999-11-11 00:00:89', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score` int(255) NULL DEFAULT NULL,
  `uId` int(11) NULL DEFAULT NULL,
  `createTime` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES (4, 'wqe', NULL, 'qwe', 22, 1, NULL);
INSERT INTO `score` VALUES (5, 'zz', NULL, 'zz', 100, 3, NULL);
INSERT INTO `score` VALUES (6, 'sd', '智', 'sd', 99, 2, NULL);
INSERT INTO `score` VALUES (7, '123', '德', '23', 50, 4, NULL);
INSERT INTO `score` VALUES (8, '成功', NULL, '22', 22, 5, NULL);
INSERT INTO `score` VALUES (9, '失败', NULL, '11', 15, 6, NULL);
INSERT INTO `score` VALUES (10, '不知道', NULL, '12', 60, 7, NULL);
INSERT INTO `score` VALUES (16, 'ls', '男', 'l*', 100, 24, '2021-12-30 22:52:54');
INSERT INTO `score` VALUES (13, 'ls', '男', 'l*', 0, 24, '2021-12-30 22:33:56');
INSERT INTO `score` VALUES (14, 'ls', '男', 'l*', 50, 24, '2021-12-30 22:38:03');
INSERT INTO `score` VALUES (15, 'ls', '男', 'l*', 20, 24, '2021-12-30 22:42:19');
INSERT INTO `score` VALUES (17, 'ls', '男', 'l*', 0, 24, '2022-01-05 18:54:59');
INSERT INTO `score` VALUES (19, 'ls', NULL, 'l*', 2, 24, '2022-03-02 15:16:47');
INSERT INTO `score` VALUES (18, 'ls', NULL, 'l*', 5, 24, '2022-03-02 00:47:51');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, '张三', 21);
INSERT INTO `student` VALUES (2, '李四', 20);
INSERT INTO `student` VALUES (3, '\"张三\"', 20);
INSERT INTO `student` VALUES (4, '王五', 20);
INSERT INTO `student` VALUES (5, '无语', 100);
INSERT INTO `student` VALUES (6, '无', 100);

-- ----------------------------
-- Table structure for t_question_remark
-- ----------------------------
DROP TABLE IF EXISTS `t_question_remark`;
CREATE TABLE `t_question_remark`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `noteContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createTime` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `editTime` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `editBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `editFlag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
  `questionId` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_question_remark
-- ----------------------------
INSERT INTO `t_question_remark` VALUES ('1', '000013123123123213123', '2021-12-12 21:16:53', 'admin', '2021-12-13 23:05:47', 'admin', '0', '21');
INSERT INTO `t_question_remark` VALUES ('2', '111', '2021-12-12 21:17:04', 'admin', NULL, NULL, '0', '21');
INSERT INTO `t_question_remark` VALUES ('20220302002944', 'asdas', '2022-03-02 00:29:44', 'zs', NULL, NULL, '0', '26');
INSERT INTO `t_question_remark` VALUES ('20220302002947', '1', '2022-03-02 00:29:47', 'zs', NULL, NULL, '0', '26');
INSERT INTO `t_question_remark` VALUES ('4', '222132', '2021-12-12 21:26:43', 'admin', '2021-12-13 23:07:04', 'admin', '0', '21');
INSERT INTO `t_question_remark` VALUES ('5', '55512323', '2021-12-13 23:07:10', 'admin', '2021-12-13 23:19:39', 'admin', '0', '21');
INSERT INTO `t_question_remark` VALUES ('6', 'ss', '2021-12-13 23:19:21', 'admin', NULL, NULL, '0', '21');
INSERT INTO `t_question_remark` VALUES ('8', 'WERWER', '2021-12-25 16:20:29', 'zs', NULL, NULL, '0', '27');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isAdmin` int(3) NULL DEFAULT NULL,
  `createTime` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', 'admin', '男', '280155337@qq.com', NULL, NULL);
INSERT INTO `users` VALUES (2, 'zs', '123', '男', 'zs', 1, NULL);
INSERT INTO `users` VALUES (24, 'ls', '123', '男', 'ls', 0, NULL);
INSERT INTO `users` VALUES (22, 'admin', '123', '男', '1222@qq.com', 0, '2021-12-23 16:29:54');
INSERT INTO `users` VALUES (23, '张三', '123', '男', '118@qq.com', 0, '2021-12-23 16:35:17');

SET FOREIGN_KEY_CHECKS = 1;
