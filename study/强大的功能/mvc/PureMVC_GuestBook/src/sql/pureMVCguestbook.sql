-- phpMyAdmin SQL Dump
-- version 2.10.1
-- http://www.phpmyadmin.net
-- 
-- ����: localhost
-- ��������: 2008 �� 07 �� 14 �� 06:42
-- �������汾: 5.0.41
-- PHP �汾: 5.2.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- ���ݿ�: `guestbook`
-- 

-- --------------------------------------------------------

-- 
-- ��Ľṹ `topic`
-- 

CREATE TABLE `topic` (
  `id` int(11) NOT NULL auto_increment,
  `addTime` datetime NOT NULL,
  `username` varchar(100) character set utf8 collate utf8_unicode_ci NOT NULL,
  `content` text character set utf8 collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='PureMVC�����Բ�' AUTO_INCREMENT=1 ;

-- 
-- �������е����� `topic`
-- 

