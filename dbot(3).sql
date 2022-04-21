-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2022-04-14 19:26:31
-- 服务器版本： 5.6.50-log
-- PHP Version: 7.0.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbot`
--

-- --------------------------------------------------------

--
-- 表的结构 `config`
--

CREATE TABLE IF NOT EXISTS `config` (
  `id` int(11) NOT NULL,
  `type` longtext NOT NULL,
  `contents` longtext
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `config`
--

INSERT INTO `config` (`id`, `type`, `contents`) VALUES
(1, '当前版本', '2.3.3');

-- --------------------------------------------------------

--
-- 表的结构 `cookie`
--

CREATE TABLE IF NOT EXISTS `cookie` (
  `id` int(11) NOT NULL,
  `qq` bigint(20) DEFAULT NULL,
  `cookie_type` varchar(64) NOT NULL COMMENT 'CK类型',
  `cookie` longtext NOT NULL COMMENT 'cookie'
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `export`
--

CREATE TABLE IF NOT EXISTS `export` (
  `id` int(11) NOT NULL,
  `illustrate` varchar(128) NOT NULL COMMENT '说明',
  `export` varchar(128) NOT NULL COMMENT '类型变量',
  `up_down` enum('True','False') NOT NULL DEFAULT 'True' COMMENT '开关',
  `log` varchar(128) DEFAULT NULL COMMENT '日志文件夹名',
  `expired` varchar(64) DEFAULT NULL COMMENT '过期（关键字@数量）',
  `fen` varchar(12) NOT NULL DEFAULT '@' COMMENT '分割号',
  `up_key` varchar(1024) NOT NULL COMMENT '关键字上传（@）',
  `replay` varchar(1024) DEFAULT '默认用@隔开，已提交至 自选股 服务器\n结果：{msg}' COMMENT '回复',
  `max` bigint(20) NOT NULL DEFAULT '50' COMMENT '最大CK数量'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `export`
--

INSERT INTO `export` (`id`, `illustrate`, `export`, `up_down`, `log`, `expired`, `fen`, `up_key`, `replay`, `max`) VALUES
(1, '快手极速版', 'ksjsbCookie', 'True', 'ks_jsb', '6001@10', '@', 'kuaishou.api_st=@did=', '默认用@隔开，已提交至服务器\n结果：{msg}', 50),
(2, '普通快手', 'ksCookie', 'True', 'raw_main_ks', NULL, '@', 'kuaishou.api_st=@did=', '默认用@隔开，已提交至服务器\n结果：{msg}', 50),
(3, '自选股', 'TxStockCookie', 'True', 'raw_main_txstockV2', NULL, '@', 'openid@wzq_qlskey@wzq_qluin', '默认用@隔开，已提交至服务器\n结果：{msg}', 50),
(4, '酷狗大字版', 'kugouurl', 'True', 'raw_main_kgdzb', NULL, '@', 'gateway.kugou.com/v1/incentive/user_info', '默认用@隔开，已提交至服务器\n结果：{msg}', 50),
(5, '美团', 'mtTk', 'True', 'raw_MT_lb_meituan', NULL, '@', 'mt_c_token=', '默认用@隔开，已提交至服务器\n结果：{msg}', 50),
(6, '饿了么', 'elmck', 'True', 'xiecoll_radish-script_lb_elm', NULL, '@', 'ubt_ssid=', '默认用@隔开，已提交至服务器\n结果：{msg}', 50);

-- --------------------------------------------------------

--
-- 表的结构 `ql`
--

CREATE TABLE IF NOT EXISTS `ql` (
  `id` int(11) NOT NULL,
  `url` varchar(256) NOT NULL,
  `Client_ID` varchar(64) NOT NULL,
  `Client_Secret` varchar(128) NOT NULL,
  `token` varchar(128) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `ql`
--

INSERT INTO `ql` (`id`, `url`, `Client_ID`, `Client_Secret`, `token`) VALUES
(1, 'http://ip/', '1', '1', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `qq` bigint(20) NOT NULL,
  `admin` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`qq`, `admin`) VALUES
(2660867128, '1');

-- --------------------------------------------------------

--
-- 表的结构 `words`
--

CREATE TABLE IF NOT EXISTS `words` (
  `id` int(11) NOT NULL,
  `en_type` varchar(128) NOT NULL COMMENT '查询类型',
  `word` varchar(1024) NOT NULL COMMENT '问',
  `directions` varchar(1024) DEFAULT NULL,
  `reply` varchar(1024) DEFAULT NULL,
  `find_type` enum('精确','模糊') NOT NULL DEFAULT '精确' COMMENT '精确模糊查找',
  `word_type` enum('命令','问答','禁言','撤回','禁撤','定时') NOT NULL DEFAULT '问答' COMMENT '类型',
  `type_contents` varchar(128) DEFAULT NULL,
  `permission` enum('管理员','用户') NOT NULL DEFAULT '用户' COMMENT '使用权限'
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `words`
--

INSERT INTO `words` (`id`, `en_type`, `word`, `directions`, `reply`, `find_type`, `word_type`, `type_contents`, `permission`) VALUES
(1, 'add_export', '增加账号', '增加export xxx的命令，分割号指多账户分割的符号\n例子：增加账号 分割号 xxx 增加的ck', '{msg}', '精确', '命令', NULL, '管理员'),
(2, 'del_export', '删除其它账号', '删除export xxx的命令\n例子：删除其它账号 xxx 删除的ck/账户n', '{msg}', '精确', '命令', NULL, '管理员'),
(3, 'find_export', '其它查询', '查询export xxx的命令\n例子：其它查询 xxx', '{msg}', '精确', '命令', NULL, '管理员'),
(4, 'find_ks_log', '查询快手日志', '例子：查询快手日志 快手名', '{msg}', '精确', '命令', NULL, '管理员'),
(5, 'find_ks_info', '查询快手', '例子：查询快手 快手名\n查询快手余额', '账号【日志号{log_num}】：{jsb_name}\n余额：{jsb_rmb}\n金币：{jsb_jinbi}\n\n@账号【日志号{log_num}】：{ks_name}\n余额：{ks_rmb}\n金币：{ks_jinbi}', '精确', '命令', NULL, '用户'),
(6, 'find_ks_user', '查询快手过期账号', '查询快手过期账号', '根据运行日志进行查询，并不是实时查询，例如你删除一个快手账号，再次查询还是这些结果，需要再运行一下快手，等运行完毕日志生成后即可更新这个查询\n\n过期数量：{guoqi_num}\n@账号【日志号{log_num}】：{name}\n\n ', '精确', '命令', NULL, '管理员'),
(7, 'set_config', '设置配置', '例子：设置配置 config 内容', '{msg}', '精确', '命令', NULL, '管理员'),
(8, 'del_ks', '删除快手', '例子：删除快手 QQ 快手名', '{msg}', '精确', '命令', NULL, '管理员'),
(9, 'find_zixuangu', '查询自选股', '例子：查询自选股 账户名称', '账户：{zixuangu_name}\n金币：{zixuangu_jinbi}\n{zixuangu_1}\n{zixuangu_2}\n{zixuangu_3}\n{zixuangu_4}', '精确', '命令', NULL, '用户'),
(10, 'add_admin', '增加管理员', '例子：增加管理员 QQ', '{msg}', '精确', '命令', NULL, '管理员'),
(11, 'del_admin', '删除管理员', '例子：删除管理员 QQ', '{msg}', '精确', '命令', NULL, '管理员'),
(12, 'menu', '菜单', NULL, '#类型为config.sh里面的export xxx=””的xxx，只要你config.sh里面有什么类型，而且都是用@分割的多账号，都可以使用这条命令\n增加账号 [类型] [CK]\n\n其它查询 [类型]\n#输出账号数量，和每个账号N\n\n删除其它账号 [类型] [CK]/[账号n]\n#账号n对应查询的账号n\n\n查询快手日志 [快手账户名]\n查询快手 [快手账户名]\n查询快手过期账号', '精确', '命令', NULL, '用户'),
(13, 'find_mt_user', '查询美团', '例子：查询美团 账号名', '账号：{name}\n{mili}\n{jinbi}\n{juan}', '精确', '命令', NULL, '用户'),
(14, 'find_elm_user', '查询饿了么', '例子：查询饿了么 账号名', '账号：{name}\n{ci_dou}\n{juan}', '精确', '命令', NULL, '用户');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cookie`
--
ALTER TABLE `cookie`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `export`
--
ALTER TABLE `export`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `export_export_uindex` (`export`),
  ADD UNIQUE KEY `export_id_uindex` (`id`);

--
-- Indexes for table `ql`
--
ALTER TABLE `ql`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ql_id_uindex` (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`qq`),
  ADD UNIQUE KEY `user_qq_uindex` (`qq`);

--
-- Indexes for table `words`
--
ALTER TABLE `words`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `words_id_uindex` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `config`
--
ALTER TABLE `config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `cookie`
--
ALTER TABLE `cookie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=87;
--
-- AUTO_INCREMENT for table `export`
--
ALTER TABLE `export`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `ql`
--
ALTER TABLE `ql`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `words`
--
ALTER TABLE `words`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
