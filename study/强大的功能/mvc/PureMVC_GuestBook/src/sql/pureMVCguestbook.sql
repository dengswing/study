-- phpMyAdmin SQL Dump
-- version 2.10.1
-- http://www.phpmyadmin.net
-- 
-- 主机: localhost
-- 生成日期: 2008 年 07 月 14 日 06:42
-- 服务器版本: 5.0.41
-- PHP 版本: 5.2.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- 数据库: `guestbook`
-- 

-- --------------------------------------------------------

-- 
-- 表的结构 `topic`
-- 

CREATE TABLE `topic` (
  `id` int(11) NOT NULL auto_increment,
  `addTime` datetime NOT NULL,
  `username` varchar(100) character set utf8 collate utf8_unicode_ci NOT NULL,
  `content` text character set utf8 collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='PureMVC的留言簿' AUTO_INCREMENT=1 ;

-- 
-- 导出表中的数据 `topic`
-- 

