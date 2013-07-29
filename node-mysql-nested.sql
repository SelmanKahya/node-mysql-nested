-- phpMyAdmin SQL Dump
-- version 3.5.8.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 28, 2013 at 05:57 PM
-- Server version: 5.5.31-1~dotdeb.0
-- PHP Version: 5.4.9-4ubuntu2.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `node-mysql-nested`
--

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE IF NOT EXISTS `company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(40) NOT NULL,
  `company_type_id` int(11) NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`company_id`, `company_name`, `company_type_id`) VALUES
(1, 'Company the Gorgeous', 2),
(2, 'Foobar LLC', 3),
(3, 'Leak Security Co., Inc', 1),
(4, 'LA Water', 4);

-- --------------------------------------------------------

--
-- Table structure for table `company_type`
--

CREATE TABLE IF NOT EXISTS `company_type` (
  `company_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_type_name` varchar(40) NOT NULL,
  PRIMARY KEY (`company_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `company_type`
--

INSERT INTO `company_type` (`company_type_id`, `company_type_name`) VALUES
(1, 'Private Company'),
(2, 'Public Company'),
(3, 'Limited Liability Company'),
(4, 'State Owned Company');

-- --------------------------------------------------------

--
-- Table structure for table `goal`
--

CREATE TABLE IF NOT EXISTS `goal` (
  `goal_id` int(11) NOT NULL AUTO_INCREMENT,
  `improvement_plan_id` int(11) NOT NULL,
  `goal_name` varchar(40) NOT NULL,
  `goal_desc` varchar(160) NOT NULL,
  PRIMARY KEY (`goal_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `goal`
--

INSERT INTO `goal` (`goal_id`, `improvement_plan_id`, `goal_name`, `goal_desc`) VALUES
(1, 1, 'Lorem', 'Finish this by yesterday.'),
(2, 1, 'Ipsum', 'We have so much to do, sir.'),
(3, 1, 'Dolor', 'God may help us.'),
(4, 2, 'Sit Amet', 'Get something done before May 2053.'),
(5, 4, 'Neque', 'Have additional door security for front door.'),
(6, 4, 'Quisquam', 'Hire retired FBI agent, make him stand still all day in front of CEO''s office.');

-- --------------------------------------------------------

--
-- Table structure for table `improvement_plan`
--

CREATE TABLE IF NOT EXISTS `improvement_plan` (
  `improvement_plan_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `improvement_plan_name` varchar(40) NOT NULL,
  `improvement_plan_desc` varchar(80) NOT NULL,
  `improvement_plan_type_id` int(11) NOT NULL,
  PRIMARY KEY (`improvement_plan_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `improvement_plan`
--

INSERT INTO `improvement_plan` (`improvement_plan_id`, `company_id`, `improvement_plan_name`, `improvement_plan_desc`, `improvement_plan_type_id`) VALUES
(1, 1, '1st Performance Plan', 'We suck at this and that, need to fix these and those.', 1),
(2, 1, '2nd Performance Plan', 'After completing the 1st improvement plan, fix the broken entrance door.', 2),
(3, 2, 'Imp. Plan for Employee Satisfaction', 'Improve employee satisfaction by %150 at the end of 1st quarter of 2013.', 2),
(4, 3, 'Continuous Plan', 'Obtain minimum security standards to be a good security company.', 3);

-- --------------------------------------------------------

--
-- Table structure for table `improvement_plan_type`
--

CREATE TABLE IF NOT EXISTS `improvement_plan_type` (
  `improvement_plan_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `improvement_plan_type_name` varchar(40) NOT NULL,
  `improvement_plan_type_desc` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`improvement_plan_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `improvement_plan_type`
--

INSERT INTO `improvement_plan_type` (`improvement_plan_type_id`, `improvement_plan_type_name`, `improvement_plan_type_desc`) VALUES
(1, 'Performance Improvement Plan', NULL),
(2, 'Quality Improvement Plan ', NULL),
(3, 'Continuous Improvement Plan', NULL),
(4, 'Time Management Improvement Plan', NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
