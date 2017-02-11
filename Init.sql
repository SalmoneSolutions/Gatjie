drop database if exists `getmethere`;
create database `getmethere`;
use `getmethere`;

drop table if exists `rank`;
CREATE TABLE IF NOT EXISTS `rank` (
  `rank_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(100) DEFAULT NULL,
  `type` char(100) DEFAULT NULL,
  `latitude` decimal(42,10) DEFAULT NULL,
  `longitude` decimal(42,10) DEFAULT NULL,
  `opening_time` varchar(100) NOT NULL,
  `closing_time` varchar(100) NOT NULL,
  PRIMARY KEY (`rank_id`)
);



INSERT INTO `rank` (`rank_id`, `name`, `type`, `latitude`, `longitude`, `opening_time`, `closing_time`) VALUES
(1, 'Cape Town', 'official', -33.9222350000, 18.4264440000, '04 AM', '23 PM'),
(2, 'Bellville', 'official', -33.9058290000, 18.6302960000, '04 AM', '21 PM'),
(3, 'Khayelitsha', 'official', -34.0161550000, 18.6493420000, '04 AM', '21 PM'),
(4, 'Gugulethu', 'official', -33.9818910000, 18.5661780000, '04 AM', '22 PM'),
(5, 'Maitland', 'official', -33.9249840000, 18.4790910000, '06 AM', '21 PM'),
(6, 'Obsevatory', 'official', -33.9400520000, 18.4639100000, '06 AM', '21 PM'),
(7, 'V&A Waterfront', 'un-official', -33.9050730000, 18.4178760000, '05 AM', '20 PM'),
(8, 'Brackenfell', 'Unofficial', -33.8813010000, 18.7088460000, '08 AM', '22 PM'),
(9, 'Nyanga', 'Official', -33.9923680000, 18.5833170000, '04 AM', '23 PM'),
(10, 'Langa', 'Official', -33.9456470000, 18.5366780000, '04 AM', '23 PM'),
(11, 'Delft South', 'official', -33.9917910000, 18.6306800000, '06 AM', '21 PM'),
(12, 'Port Elizabeth Njoli St Uncedo Taxi Association', 'official', -33.8694449,25.7094693, '06 AM', '21 PM'),
(13, 'Port Elizabeth Durban Rd', 'official', -33.9346968,25.5833402, '07 AM', '6 PM'),
(14, 'Port Elizabeth Govan Mbeki', 'official', -33.9570393,25.6189179, '08:30 AM', '3 PM'),
(15, 'Port Elizabeth Norwhich Long Distance Taxis', 'official', -33.9599971,25.6232024, '06 AM', '21 PM'),
(16, 'Uitenhage Terminus', 'official', -33.8042361,25.4468998, '06 AM', '21 PM'),
(18, 'Grahamstown Somerset East', 'official', -33.3099299,26.5302576, '06 AM', '21 PM'),
(19, 'Grahamstown Raglan Road Uncedo Taxi Association', 'official', -33.3064509,26.5419949, '06 AM', '21 PM'),
(20, 'Grahamstown Grata Taxi Association', 'official', -33.3082084,26.5304721, '06 AM', '21 PM'),
(21, 'King Williams Town KFC ', 'official', -32.8388732,27.6422155, '06 AM', '21 PM'),
(22, 'King Williams Town Uncedo ', 'official', -32.8641098,27.4343336, '06 AM', '21 PM'),
(23, 'East London Shoprite ', 'official', -33.018623,27.904428, '06 AM', '21 PM'),
(25, 'East London Bonza Bay Rank', 'official', -32.9787795,27.9261754, '06 AM', '21 PM'),
(26, 'Durban Umhlanga ', 'official', -29.7518882,31.0584878, '06 AM', '21 PM'),
(27, 'Durban Greyville ', 'official', -29.8683645,31.0444116, '06 AM', '21 PM'),
(28, 'Durban Pavillion ', 'official', 29.8838448,30.9153222, '06 AM', '21 PM'),
(29, 'Johannesburg Westgate ', 'official', -26.2042184,28.050223, '06 AM', '21 PM'),
(30, 'Johannesburg Art Gallery', 'official', -26.1964522,28.0494747, '06 AM', '21 PM'),
(31, 'Johannesburg Department of Labour ', 'official', -26.208076,28.0443195, '06 AM', '21 PM'),
(32, 'Johannesburg Bree', 'official', -26.1938289,28.0500701, '06 AM', '21 PM'),
(33, 'Johannesburg Parktown', 'official', -26.1812745,28.0426887, '06 AM', '21 PM'),
(34, 'Johannesburg Germiston', 'official', -26.2148418,28.1661553, '06 AM', '21 PM'),
(35, 'Johannesburg Daveyton Cntral Benoni', 'official', -26.1529538,28.373136, '06 AM', '21 PM'),
(36, 'Johannesburg JetPark Germiston', 'official', -26.126203,28.3137406, '06 AM', '21 PM');




drop table if exists `route`;
CREATE TABLE IF NOT EXISTS `route` (
  `route_id` int(11) NOT NULL AUTO_INCREMENT,
  `rank_id` int(42) DEFAULT NULL,
  `route_name` char(100) DEFAULT NULL,
  `price` decimal(42,2) DEFAULT NULL,
  `destination_id` int(11) NOT NULL,
  PRIMARY KEY (`route_id`),
  KEY `rank_id` (`rank_id`)
);


INSERT INTO `route` (`route_id`, `rank_id`, `route_name`, `price`, `destination_id`) VALUES
(1, 2, 'Bellville N2 Cape Town CBD', 16.50, 1),
(3, 2, 'Bellville - Khayelitsha', 13.00, 3),
(4, 7, 'Waterfront - Cape Town CBD', 5.00, 1),
(5, 1, 'Cape Town - Observatory', 7.00, 6),
(6, 1, 'Cape Town - Khayelitsha (all sites)', 16.50, 3),
(7, 1, 'Cape Town - Gugulethu', 12.00, 4),
(8, 1, 'Cape Town - Maitland', 8.50, 5),
(9, 5, 'Maitland -Observatory', 5.00, 6),
(10, 6, 'Observatory - Maitland', 5.00, 5),
(11, 3, 'Khayelitsha - Gugulethu', 13.00, 4),
(12, 4, 'Gugulethu - Khayelitsha', 13.00, 3);


ALTER TABLE `route`
  ADD CONSTRAINT `route_ibfk_1` FOREIGN KEY (`rank_id`) REFERENCES `rank` (`rank_id`);

CREATE USER freakils@localhost IDENTIFIED BY 'fish04';
GRANT ALL PRIVILEGES ON getmethere.* TO freakils@localhost;
FLUSH PRIVILEGES;
