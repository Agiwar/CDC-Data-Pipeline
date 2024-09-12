CREATE DATABASE IF NOT EXISTS onlinepay;

USE onlinepay;

CREATE TABLE IF NOT EXISTS auth_pay_setting_history_tab (
  `id`                        bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `auth_pay_id`               bigint(20) NOT NULL,
  `history_type`              int(11) NOT NULL,
  `update_time`               datetime(6) NOT NULL,
  `channel_type`              int(11) NOT NULL,
  `channel`                   varchar(4) DEFAULT NULL,
  `channel_paytool_code`      varchar(255) DEFAULT NULL,
  `channel_display_meta`      varchar(255) DEFAULT NULL,
  `channel_display_detail`    varchar(255) DEFAULT NULL,
  `use_jko_coin`              tinyint(1) NOT NULL,
  `single_payment_max_amount` decimal(20,2) DEFAULT NULL,
  `currency`                  varchar(3) DEFAULT 'TWD',
  `create_time`               datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `modify_time`               datetime(6) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY                 (`id`),
  KEY                         `auth_pay_history_auth_pay_id_idx` (`auth_pay_id`),
  KEY                         `auth_pay_history_update_time_idx` (`update_time`)
) ENGINE=InnoDB AUTO_INCREMENT=10062 DEFAULT CHARSET=utf8mb4;

LOAD DATA INFILE '/var/lib/mysql-files/auth_pay_setting_history_tab.csv'
INTO TABLE auth_pay_setting_history_tab
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;