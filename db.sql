/*
 Navicat Premium Data Transfer

 Source Server         : myserver
 Source Server Type    : MariaDB
 Source Server Version : 110402 (11.4.2-MariaDB)
 Source Host           : 127.0.0.1:3306
 Source Schema         : winbot

 Target Server Type    : MariaDB
 Target Server Version : 110402 (11.4.2-MariaDB)
 File Encoding         : 65001

 Date: 28/09/2026 19:48:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_member
-- ----------------------------
DROP TABLE IF EXISTS `admin_member`;
CREATE TABLE `admin_member`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mem_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `mem_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `mem_mobile` char(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `alarmST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'Y',
  `grade` int(11) NOT NULL DEFAULT 0,
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `price` double(30, 3) NULL DEFAULT 10000.000,
  `live_price` double(30, 3) NULL DEFAULT 0.000,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `allExactST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `allStopST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `allExact` int(11) NULL DEFAULT NULL,
  `allStop` int(11) NULL DEFAULT NULL,
  `allStartST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `recom` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `metaId` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `appKey` char(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `appSecret` char(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `mem_id`(`mem_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 183 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alert_log
-- ----------------------------
DROP TABLE IF EXISTS `alert_log`;
CREATE TABLE `alert_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `db_type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `symbol` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `close` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `signal_time` datetime NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1758 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alert_log2
-- ----------------------------
DROP TABLE IF EXISTS `alert_log2`;
CREATE TABLE `alert_log2`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `pid` int(11) NULL DEFAULT NULL,
  `log_id` int(11) NULL DEFAULT NULL,
  `uuid` char(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `db_type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `st` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `signal_price` double(15, 3) NULL DEFAULT NULL,
  `result_price` double(15, 3) NULL DEFAULT NULL,
  `bunbong` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `second1` int(11) NULL DEFAULT NULL,
  `second2` int(11) NULL DEFAULT NULL,
  `second3` int(11) NULL DEFAULT NULL,
  `second4` int(11) NULL DEFAULT NULL,
  `signal_time` datetime NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alert_log3
-- ----------------------------
DROP TABLE IF EXISTS `alert_log3`;
CREATE TABLE `alert_log3`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `db_type` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `type` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bunbong` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `signal_time` datetime NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for candle_best
-- ----------------------------
DROP TABLE IF EXISTS `candle_best`;
CREATE TABLE `candle_best`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` int(11) UNSIGNED NOT NULL,
  `candle` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `side` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `tp` double NULL DEFAULT NULL,
  `lhr` double NULL DEFAULT NULL,
  `shr` double NULL DEFAULT NULL,
  `pnl` double NULL DEFAULT NULL,
  `cagr` double NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `c_s`(`cid`) USING BTREE,
  CONSTRAINT `c_s` FOREIGN KEY (`cid`) REFERENCES `candle_stats` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1843906 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for candle_cool
-- ----------------------------
DROP TABLE IF EXISTS `candle_cool`;
CREATE TABLE `candle_cool`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` char(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `side` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cooltime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uuid`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1033 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for candle_list
-- ----------------------------
DROP TABLE IF EXISTS `candle_list`;
CREATE TABLE `candle_list`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bunbong` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CLOSE_NOW` double(15, 3) NULL DEFAULT NULL,
  `CLOSE_PREV` double(15, 3) NULL DEFAULT NULL COMMENT '이전종가',
  `BBW_NOW` double(15, 3) NULL DEFAULT NULL COMMENT '선택된 심벌과 선택된 캔들의 볼린저밴드의 폭을 계산 , 볼린저밴드의 표준편차 멀티플은 2배수로 하고, 캔들의 가짓수는 20개로 한다. BB(20)의 높이 ',
  `BBW_PREV` double(15, 3) NULL DEFAULT NULL,
  `Vol_Z_score` double(15, 3) NULL DEFAULT NULL COMMENT '거래량의 z –score 계산 , 캔들의 기준은 20개로 한다. Z score = (마지막 캔들의 거래량 – 20개 구간 거래량 평균)/20개 구간 거래량의 표준편차',
  `RSI` double(15, 3) NULL DEFAULT NULL COMMENT '직전 캔들 종가 기준 , RSI(20)의 값을 표시',
  `RSI_Slope` double(15, 3) NULL DEFAULT NULL COMMENT '캔들은 20개를 사용한다. RSI Slope = 1번째 캔들의 RSI(20)-마지막 캔들의 RSI(20)/20 ',
  `ATR` double(15, 3) NULL DEFAULT NULL COMMENT '직전 20개 캔들의 ATR 표시 ',
  `STD_DEV` double(15, 3) NULL DEFAULT NULL COMMENT '직전 20개 캔들의 표준편차 표시 ',
  `F_UP_LV1` double(15, 3) NULL DEFAULT NULL COMMENT '직전 20개 캔들 기준 피보나치 되돌림의 첫번째 상단의 가격 계산  ',
  `F_UP_LV2` double(15, 3) NULL DEFAULT NULL COMMENT '직전 20개 캔들 기준 피보나치 되돌림의 두번째 상단의 가격 계산',
  `F_DN_LV1` double(15, 3) NULL DEFAULT NULL COMMENT '직전 20개 캔들 기준 피보나치 되돌림의 첫번째 하단의 가격 계산  ',
  `F_DN_LV2` double(15, 3) NULL DEFAULT NULL COMMENT '직전 20개 캔들 기준 피보나치 되돌림의 두번째 하단의 가격 계산',
  `CC_BTC` double(15, 3) NULL DEFAULT NULL,
  `CC_ETH` double(15, 3) NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11056 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for candle_rows
-- ----------------------------
DROP TABLE IF EXISTS `candle_rows`;
CREATE TABLE `candle_rows`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` int(11) UNSIGNED NOT NULL,
  `tp` double NULL DEFAULT NULL,
  `side` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `hr` double NULL DEFAULT NULL,
  `cagr` double NULL DEFAULT NULL,
  `pnl` double NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `c_s`(`cid`) USING BTREE,
  CONSTRAINT `candle_rows_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `candle_stats` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6638059 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for candle_stats
-- ----------------------------
DROP TABLE IF EXISTS `candle_stats`;
CREATE TABLE `candle_stats`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `signal` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `candle_min` int(11) NULL DEFAULT NULL,
  `first_signal_date` date NULL DEFAULT NULL,
  `lookahead_min` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `buy_count` int(11) NULL DEFAULT NULL,
  `sell_count` int(11) NULL DEFAULT NULL,
  `best_metric` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122928 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for candle_up_down
-- ----------------------------
DROP TABLE IF EXISTS `candle_up_down`;
CREATE TABLE `candle_up_down`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `candle` int(11) NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  `per` double NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for etc_candle_list
-- ----------------------------
DROP TABLE IF EXISTS `etc_candle_list`;
CREATE TABLE `etc_candle_list`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bunbong` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for etc_strategy_list
-- ----------------------------
DROP TABLE IF EXISTS `etc_strategy_list`;
CREATE TABLE `etc_strategy_list`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `val` char(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` char(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `second1` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `second2` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `second3` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `second4` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for etc_symbol_list
-- ----------------------------
DROP TABLE IF EXISTS `etc_symbol_list`;
CREATE TABLE `etc_symbol_list`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for event_log
-- ----------------------------
DROP TABLE IF EXISTS `event_log`;
CREATE TABLE `event_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) UNSIGNED NULL DEFAULT NULL,
  `pid` int(11) UNSIGNED NULL DEFAULT NULL,
  `tid` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `oid` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `event_type` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `old_st` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `new_st` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `old_status` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `new_status` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `signalType` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `signalPrice` double(15, 2) NULL DEFAULT NULL,
  `signalTime` datetime NULL DEFAULT NULL,
  `localTime` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `item_uid`(`uid`) USING BTREE,
  INDEX `play_list_id`(`pid`) USING BTREE,
  CONSTRAINT `event_log_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `admin_member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2020 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for line_list
-- ----------------------------
DROP TABLE IF EXISTS `line_list`;
CREATE TABLE `line_list`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `subLine` double(15, 3) NULL DEFAULT NULL COMMENT '지지선',
  `resLine` double(15, 3) NULL DEFAULT NULL COMMENT '저항선',
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uuid`(`symbol`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for live_play_list
-- ----------------------------
DROP TABLE IF EXISTS `live_play_list`;
CREATE TABLE `live_play_list`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) UNSIGNED NOT NULL,
  `del_ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'N',
  `live_ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'Y',
  `a_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bunbong` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '1~ 990',
  `type` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'stoch, RSI, UT, mid, abs',
  `second1` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `second2` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1',
  `second3` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1',
  `second4` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1',
  `repeatConfig` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'repeat' COMMENT 'repeat: 자동반복, stopLoss: 손절 시 반복 멈춤, once: 1회만 진입',
  `profitTradeType` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'per' COMMENT 'per, abs, fix',
  `profitFixValue` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '지지선 : sub, 저항선: res',
  `profitAbsValue` double NULL DEFAULT 0 COMMENT '절대값',
  `lossTradeType` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'per',
  `lossFixValue` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `lossAbsValue` double NULL DEFAULT 0,
  `absValue` double NULL DEFAULT NULL COMMENT '진입시 절대값',
  `enter` double NULL DEFAULT 1 COMMENT '진입',
  `cancel` double NULL DEFAULT 1 COMMENT '진입취소',
  `profit` double NULL DEFAULT 1 COMMENT '1차익절',
  `stopLoss` double NULL DEFAULT 1 COMMENT '손절',
  `stopTime` int(11) NULL DEFAULT NULL,
  `stopTimeType` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `stopRevST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `profitRevST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `leverage` double NULL DEFAULT 0,
  `margin` double NULL DEFAULT 0,
  `minimumOrderST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `m_cancelStopLoss` double NULL DEFAULT NULL COMMENT '손절취소',
  `m_profit` double NULL DEFAULT NULL COMMENT '2차익절',
  `trendOrderST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `t_cancelStopLoss` double NULL DEFAULT NULL COMMENT '추세:손절취소',
  `t_profit` double NULL DEFAULT NULL COMMENT '추세:2차익절',
  `t_chase` double NULL DEFAULT NULL COMMENT '추세:추세추격',
  `t_ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `t_autoST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N' COMMENT '자동청산 on off',
  `t_direct` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `signalType` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `alarmSignalST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `alarmResultST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `orderSize` int(11) NULL DEFAULT NULL,
  `st` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'STOP' COMMENT 'STOP, START',
  `status` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'READY',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `autoST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `stoch_id` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `direct1ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `direct2ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `detailTap` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'B',
  `selectST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'Y',
  `r_tid` char(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `r_oid` char(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `r_id` char(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `r_m_st` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `r_t_st` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `r_t_tick` double NULL DEFAULT 0,
  `r_t_cnt` int(11) NULL DEFAULT 0,
  `r_tempPrice` double NULL DEFAULT NULL,
  `r_signalType` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `r_signalPrice` double NULL DEFAULT NULL,
  `r_signalTime` datetime NULL DEFAULT NULL,
  `r_exactPrice` double NULL DEFAULT NULL,
  `r_exactTime` datetime NULL DEFAULT NULL,
  `r_profitPrice` double NULL DEFAULT 0,
  `r_profitTime` datetime NULL DEFAULT NULL,
  `r_stopPrice` double NULL DEFAULT 0,
  `r_stopTime` datetime NULL DEFAULT NULL,
  `r_endPrice` double NULL DEFAULT 0,
  `r_endTime` datetime NULL DEFAULT NULL,
  `r_exact_cnt` int(11) NULL DEFAULT 0,
  `r_profit_cnt` int(11) NULL DEFAULT 0,
  `r_profit_tick` double NULL DEFAULT 0,
  `r_stop_cnt` int(11) NULL DEFAULT 0,
  `r_stop_tick` double NULL DEFAULT 0,
  `r_forcing_cnt` int(11) NULL DEFAULT 0,
  `r_forcing_tick` int(11) NULL DEFAULT 0,
  `r_real_tick` double NULL DEFAULT 0,
  `r_pol_tick` double NULL DEFAULT 0,
  `r_charge` double NULL DEFAULT 0,
  `r_t_charge` double NULL DEFAULT 0,
  `r_pol_sum` double NULL DEFAULT 0,
  `r_minQty` double NULL DEFAULT NULL,
  `r_qty` double NULL DEFAULT NULL,
  `r_margin` double NULL DEFAULT NULL,
  `r_avgPrice` double NULL DEFAULT NULL,
  `r_win` int(11) NULL DEFAULT 0,
  `r_loss` int(11) NULL DEFAULT 0,
  `algoId` char(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `item_uid`(`uid`) USING BTREE,
  CONSTRAINT `live_play_list_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `admin_member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for live_play_log
-- ----------------------------
DROP TABLE IF EXISTS `live_play_log`;
CREATE TABLE `live_play_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) UNSIGNED NOT NULL,
  `pid` int(11) UNSIGNED NOT NULL,
  `tid` char(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `oid` char(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `st` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `type` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bunbong` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `win_loss` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `leverage` double NULL DEFAULT NULL,
  `margin` double NULL DEFAULT NULL,
  `positionSize` double NULL DEFAULT NULL,
  `signalType` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `signalPrice` double NULL DEFAULT NULL,
  `signalTime` datetime NULL DEFAULT NULL,
  `openPrice` double NULL DEFAULT NULL COMMENT '체결된가격 진입가격',
  `closePrice` double NULL DEFAULT NULL COMMENT '익절 가격',
  `closeTick` double NULL DEFAULT NULL,
  `pol_tick` double NULL DEFAULT NULL COMMENT '손익 틱',
  `pol_sum` double NULL DEFAULT NULL COMMENT '손익 돈',
  `charge` double NULL DEFAULT 0 COMMENT 'ls증권 수수료',
  `openTime` datetime NULL DEFAULT NULL,
  `closeTime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `item_uid`(`uid`) USING BTREE,
  INDEX `play_list_id`(`pid`) USING BTREE,
  CONSTRAINT `live_play_log_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `admin_member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ls_log_bunbong
-- ----------------------------
DROP TABLE IF EXISTS `ls_log_bunbong`;
CREATE TABLE `ls_log_bunbong`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '종목코드',
  `open` double(15, 2) NULL DEFAULT NULL COMMENT '시가',
  `high` double(15, 2) NULL DEFAULT NULL COMMENT '고가',
  `low` double(15, 2) NULL DEFAULT NULL COMMENT '저가',
  `close` double(15, 2) NULL DEFAULT NULL COMMENT '종가',
  `ovsdate` datetime NULL DEFAULT NULL COMMENT '체결일자(현지)',
  `kordate` datetime NULL DEFAULT NULL COMMENT '체결일자(한국)	',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ls_log_ovc
-- ----------------------------
DROP TABLE IF EXISTS `ls_log_ovc`;
CREATE TABLE `ls_log_ovc`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '종목코드',
  `ovsdate` datetime NULL DEFAULT NULL COMMENT '체결일자(현지)',
  `kordate` datetime NULL DEFAULT NULL COMMENT '체결일자(한국)	',
  `curpr` double(15, 3) NULL DEFAULT NULL COMMENT '체결가격',
  `ydiffpr` double(15, 3) NULL DEFAULT NULL COMMENT '전일대비',
  `ydiffSign` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '전일대비기호',
  `open` double(15, 3) NULL DEFAULT NULL COMMENT '시가',
  `high` double(15, 3) NULL DEFAULT NULL COMMENT '고가',
  `low` double(15, 3) NULL DEFAULT NULL COMMENT '저가',
  `chgrate` double(15, 3) NULL DEFAULT NULL COMMENT '등락율',
  `trdq` int(11) NULL DEFAULT NULL COMMENT '건별체결수량',
  `totq` int(11) NULL DEFAULT NULL COMMENT '누적체결수량',
  `cgubun` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '체결구분',
  `mdvolume` int(11) NULL DEFAULT NULL COMMENT '매도누적체결수량',
  `msvolume` int(11) NULL DEFAULT NULL COMMENT '매수누적체결수량',
  `ovsmkend` date NULL DEFAULT NULL COMMENT '장마감일',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ls_log_ovh
-- ----------------------------
DROP TABLE IF EXISTS `ls_log_ovh`;
CREATE TABLE `ls_log_ovh`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `hotime` char(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerho1` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidho1` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerrem1` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerno1` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidno1` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerho2` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidho2` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerrem2` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidrem2` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerno2` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidno2` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerho3` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidho3` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerrem3` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidrem3` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerno3` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidno3` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerho4` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidho4` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerrem4` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidrem4` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerno4` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidno4` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerho5` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidho5` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidrem1` char(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerrem5` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidrem5` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `offerno5` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bidno5` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `totoffercnt` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `totbidcnt` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `totofferrem` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `totbidrem` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ls_tick
-- ----------------------------
DROP TABLE IF EXISTS `ls_tick`;
CREATE TABLE `ls_tick`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '종목코드',
  `curpr` double(15, 2) NULL DEFAULT NULL COMMENT '시가',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for msg_list
-- ----------------------------
DROP TABLE IF EXISTS `msg_list`;
CREATE TABLE `msg_list`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fun` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `code` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `msg` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `pid` int(11) NULL DEFAULT NULL,
  `tid` char(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `side` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `st` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'N',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for order_list
-- ----------------------------
DROP TABLE IF EXISTS `order_list`;
CREATE TABLE `order_list`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) UNSIGNED NOT NULL,
  `pid` int(11) UNSIGNED NOT NULL,
  `retry` int(11) NULL DEFAULT 0,
  `st` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `symbol` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `side` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `qty` double NULL DEFAULT NULL,
  `leverage` double NULL DEFAULT NULL,
  `margin` double NULL DEFAULT NULL,
  `endType` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `new_oid` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL CHECK (json_valid(`new_oid`)),
  `close_oid` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL CHECK (json_valid(`close_oid`)),
  `algoId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `coolTime` datetime NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `_uid`(`uid`) USING BTREE,
  INDEX `_pid`(`pid`) USING BTREE,
  CONSTRAINT `_pid` FOREIGN KEY (`pid`) REFERENCES `live_play_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `_uid` FOREIGN KEY (`uid`) REFERENCES `admin_member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for play_list
-- ----------------------------
DROP TABLE IF EXISTS `play_list`;
CREATE TABLE `play_list`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) UNSIGNED NOT NULL,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bunbong` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '1~ 990',
  `type` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'bunbong, tick',
  `second1` int(11) NULL DEFAULT NULL,
  `second2` int(11) NULL DEFAULT 1,
  `second3` int(11) NULL DEFAULT 1,
  `second4` int(11) NULL DEFAULT 1,
  `enter` double(15, 2) NULL DEFAULT 1.00 COMMENT '진입',
  `cancel` double(15, 2) NULL DEFAULT 1.00 COMMENT '진입취소',
  `profit` double(15, 2) NULL DEFAULT 1.00 COMMENT '1차익절',
  `stopLoss` double(15, 2) NULL DEFAULT 1.00 COMMENT '손절',
  `leverage` double(15, 2) NULL DEFAULT 0.00,
  `margin` double(15, 2) NULL DEFAULT 0.00,
  `minimumOrderST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `m_cancelStopLoss` double(15, 2) NULL DEFAULT NULL COMMENT '손절취소',
  `m_profit` double(15, 2) NULL DEFAULT NULL COMMENT '2차익절',
  `trendOrderST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `t_cancelStopLoss` double(15, 2) NULL DEFAULT NULL COMMENT '추세:손절취소',
  `t_profit` double(15, 2) NULL DEFAULT NULL COMMENT '추세:2차익절',
  `t_chase` double(15, 2) NULL DEFAULT NULL COMMENT '추세:추세추격',
  `t_ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `t_autoST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N' COMMENT '자동청산 on off',
  `t_direct` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `signalType` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `alarmSignalST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `alarmResultST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `orderSize` int(11) NULL DEFAULT NULL,
  `st` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'STOP' COMMENT 'STOP, START',
  `status` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'READY',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `autoST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `stoch_id` char(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `direct1ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `direct2ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `detailTap` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'B',
  `selectST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'Y',
  `r_tid` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `r_oid` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `r_m_st` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `r_t_st` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `r_t_tick` double(15, 2) NULL DEFAULT 0.00,
  `r_t_cnt` int(11) NULL DEFAULT 0,
  `r_tempPrice` double(10, 2) NULL DEFAULT NULL,
  `r_signalType` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `r_signalPrice` double(15, 2) NULL DEFAULT NULL,
  `r_signalTime` datetime NULL DEFAULT NULL,
  `r_exactPrice` double(15, 2) NULL DEFAULT NULL,
  `r_exactTime` datetime NULL DEFAULT NULL,
  `r_profitPrice` double(15, 2) NULL DEFAULT 0.00,
  `r_profitTime` datetime NULL DEFAULT NULL,
  `r_stopPrice` double(15, 2) NULL DEFAULT 0.00,
  `r_stopTime` datetime NULL DEFAULT NULL,
  `r_endPrice` double(15, 2) NULL DEFAULT 0.00,
  `r_endTime` datetime NULL DEFAULT NULL,
  `r_exact_cnt` int(11) NULL DEFAULT 0,
  `r_profit_cnt` int(11) NULL DEFAULT 0,
  `r_profit_tick` int(11) NULL DEFAULT 0,
  `r_stop_cnt` int(11) NULL DEFAULT 0,
  `r_stop_tick` int(11) NULL DEFAULT 0,
  `r_forcing_cnt` int(11) NULL DEFAULT 0,
  `r_forcing_tick` int(11) NULL DEFAULT 0,
  `r_real_tick` double(15, 2) NULL DEFAULT NULL,
  `r_pol_tick` double(15, 2) NULL DEFAULT 0.00,
  `r_charge` double(15, 2) NULL DEFAULT 0.00,
  `r_pol_sum` double(15, 3) NULL DEFAULT 0.000,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `item_uid`(`uid`) USING BTREE,
  CONSTRAINT `play_list_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `admin_member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 181 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for play_log
-- ----------------------------
DROP TABLE IF EXISTS `play_log`;
CREATE TABLE `play_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) UNSIGNED NOT NULL,
  `pid` int(11) UNSIGNED NOT NULL,
  `tid` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `oid` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `st` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `signalType` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `signalPrice` double(15, 2) NULL DEFAULT NULL,
  `signalTime` datetime NULL DEFAULT NULL,
  `openPrice` double(15, 2) NULL DEFAULT NULL COMMENT '체결된가격 진입가격',
  `closePrice` double(15, 2) NULL DEFAULT NULL COMMENT '익절 가격',
  `closeTick` double(15, 2) NULL DEFAULT NULL,
  `pol_tick` double(15, 2) NULL DEFAULT NULL COMMENT '손익 틱',
  `pol_sum` double(15, 2) NULL DEFAULT NULL COMMENT '손익 돈',
  `charge` double(15, 2) NULL DEFAULT 0.00 COMMENT 'ls증권 수수료',
  `openTime` datetime NULL DEFAULT NULL,
  `closeTime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `item_uid`(`uid`) USING BTREE,
  INDEX `play_list_id`(`pid`) USING BTREE,
  CONSTRAINT `play_log_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `admin_member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for real_price
-- ----------------------------
DROP TABLE IF EXISTS `real_price`;
CREATE TABLE `real_price`  (
  `cur_price` double(15, 2) NOT NULL DEFAULT 0.00
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stoch_list
-- ----------------------------
DROP TABLE IF EXISTS `stoch_list`;
CREATE TABLE `stoch_list`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `uuid` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `type` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'stoch, rsi, sma',
  `type2` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `bunbong` int(11) NULL DEFAULT NULL,
  `second1` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'rsi 분봉?',
  `second2` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1',
  `second3` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1',
  `second4` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1',
  `rsi_period` int(11) NULL DEFAULT NULL,
  `rsi_up` double(15, 3) NULL DEFAULT NULL,
  `rsi_down` double(15, 3) NULL DEFAULT NULL,
  `st1` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'INIT' COMMENT 'INIT: 추가해야함, READY:준비, DEL: 삭제해야함',
  `st2` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'INIT',
  `created_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `uuid`) USING BTREE,
  INDEX `item_uid`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stoch_list_copy1
-- ----------------------------
DROP TABLE IF EXISTS `stoch_list_copy1`;
CREATE TABLE `stoch_list_copy1`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `uuid` char(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `type` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'stoch, rsi, sma',
  `bunbong` int(11) NULL DEFAULT NULL,
  `second1` int(11) NULL DEFAULT NULL COMMENT 'rsi 분봉?',
  `second2` int(11) NULL DEFAULT 1,
  `second3` int(11) NULL DEFAULT 1,
  `second4` int(11) NULL DEFAULT 1,
  `rsi_period` int(11) NULL DEFAULT NULL,
  `rsi_up` double(15, 3) NULL DEFAULT NULL,
  `rsi_down` double(15, 3) NULL DEFAULT NULL,
  `st1` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'INIT' COMMENT 'INIT: 추가해야함, READY:준비, DEL: 삭제해야함',
  `st2` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'INIT',
  `created_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `uuid`) USING BTREE,
  INDEX `item_uid`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stoch_list_copy2
-- ----------------------------
DROP TABLE IF EXISTS `stoch_list_copy2`;
CREATE TABLE `stoch_list_copy2`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `uuid` char(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `type` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'stoch, rsi, sma',
  `bunbong` int(11) NULL DEFAULT NULL,
  `second1` int(11) NULL DEFAULT NULL COMMENT 'rsi 분봉?',
  `second2` int(11) NULL DEFAULT 1,
  `second3` int(11) NULL DEFAULT 1,
  `second4` int(11) NULL DEFAULT 1,
  `rsi_period` int(11) NULL DEFAULT NULL,
  `rsi_up` double(15, 3) NULL DEFAULT NULL,
  `rsi_down` double(15, 3) NULL DEFAULT NULL,
  `st1` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'INIT' COMMENT 'INIT: 추가해야함, READY:준비, DEL: 삭제해야함',
  `st2` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'INIT',
  `created_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `uuid`) USING BTREE,
  INDEX `item_uid`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 365 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for test_play_list
-- ----------------------------
DROP TABLE IF EXISTS `test_play_list`;
CREATE TABLE `test_play_list`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) UNSIGNED NOT NULL,
  `del_ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'N',
  `live_ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'N',
  `a_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'BTCUSDT',
  `bunbong` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '1~ 990',
  `type` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'stoch, RSI, UT, mid, abs',
  `second1` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `second2` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1',
  `second3` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1',
  `second4` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1',
  `repeatConfig` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'repeat' COMMENT 'repeat: 자동반복, stopLoss: 손절 시 반복 멈춤, once: 1회만 진입',
  `profitTradeType` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'per' COMMENT 'per, abs, fix',
  `profitFixValue` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '지지선 : res, 저항선: sub',
  `profitAbsValue` double(30, 10) NULL DEFAULT 0.0000000000 COMMENT '절대값',
  `lossTradeType` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'per',
  `lossFixValue` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `lossAbsValue` double(30, 10) NULL DEFAULT 0.0000000000,
  `absValue` double(30, 10) NULL DEFAULT NULL COMMENT '진입시 절대값',
  `enter` double(30, 10) NULL DEFAULT 1.0000000000 COMMENT '진입',
  `cancel` double(30, 10) NULL DEFAULT 1.0000000000 COMMENT '진입취소',
  `profit` double(30, 10) NULL DEFAULT 1.0000000000 COMMENT '1차익절',
  `stopLoss` double(30, 10) NULL DEFAULT 1.0000000000 COMMENT '손절',
  `stopTime` int(11) NULL DEFAULT NULL,
  `stopTimeType` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `stopRevST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `profitRevST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `leverage` double(30, 10) NULL DEFAULT 0.0000000000,
  `margin` double(30, 10) NULL DEFAULT 0.0000000000,
  `minimumOrderST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `m_cancelStopLoss` double(30, 10) NULL DEFAULT NULL COMMENT '손절취소',
  `m_profit` double(30, 10) NULL DEFAULT NULL COMMENT '2차익절',
  `trendOrderST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `t_cancelStopLoss` double(30, 10) NULL DEFAULT NULL COMMENT '추세:손절취소',
  `t_profit` double(30, 10) NULL DEFAULT NULL COMMENT '추세:2차익절',
  `t_chase` double(30, 10) NULL DEFAULT NULL COMMENT '추세:추세추격',
  `t_ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `t_autoST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N' COMMENT '자동청산 on off',
  `t_direct` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `signalType` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `alarmSignalST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `alarmResultST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `orderSize` int(11) NULL DEFAULT NULL,
  `st` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'STOP' COMMENT 'STOP, START',
  `status` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'READY',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `autoST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `stoch_id` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `direct1ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `direct2ST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `detailTap` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'B',
  `selectST` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'Y',
  `r_tid` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `r_oid` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `r_m_st` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `r_t_st` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N',
  `r_t_tick` double(30, 10) NULL DEFAULT 0.0000000000,
  `r_t_cnt` int(11) NULL DEFAULT 0,
  `r_tempPrice` double(30, 10) NULL DEFAULT NULL,
  `r_signalType` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `r_signalPrice` double(30, 10) NULL DEFAULT NULL,
  `r_signalTime` datetime NULL DEFAULT NULL,
  `r_exactPrice` double(30, 10) NULL DEFAULT NULL,
  `r_exactTime` datetime NULL DEFAULT NULL,
  `r_profitPrice` double(30, 10) NULL DEFAULT 0.0000000000,
  `r_profitTime` datetime NULL DEFAULT NULL,
  `r_stopPrice` double(30, 10) NULL DEFAULT 0.0000000000,
  `r_stopTime` datetime NULL DEFAULT NULL,
  `r_endPrice` double(30, 10) NULL DEFAULT 0.0000000000,
  `r_endTime` datetime NULL DEFAULT NULL,
  `r_exact_cnt` int(11) NULL DEFAULT 0,
  `r_profit_cnt` int(11) NULL DEFAULT 0,
  `r_profit_tick` double(30, 10) NULL DEFAULT 0.0000000000,
  `r_stop_cnt` int(11) NULL DEFAULT 0,
  `r_stop_tick` double(30, 10) NULL DEFAULT 0.0000000000,
  `r_forcing_cnt` int(11) NULL DEFAULT 0,
  `r_forcing_tick` int(11) NULL DEFAULT 0,
  `r_real_tick` double(30, 10) NULL DEFAULT NULL,
  `r_pol_tick` double(30, 10) NULL DEFAULT 0.0000000000,
  `r_charge` double(30, 10) NULL DEFAULT 0.0000000000,
  `r_t_charge` double(30, 10) NULL DEFAULT NULL,
  `r_pol_sum` double(30, 10) NULL DEFAULT 0.0000000000,
  `r_minQty` double(30, 10) NULL DEFAULT NULL,
  `r_qty` double(30, 10) NULL DEFAULT NULL,
  `r_margin` double(30, 10) NULL DEFAULT NULL,
  `r_win` int(11) NULL DEFAULT 0,
  `r_loss` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `item_uid`(`uid`) USING BTREE,
  CONSTRAINT `test_play_list_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `admin_member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for test_play_log
-- ----------------------------
DROP TABLE IF EXISTS `test_play_log`;
CREATE TABLE `test_play_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) UNSIGNED NOT NULL,
  `pid` int(11) UNSIGNED NOT NULL,
  `tid` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `oid` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `st` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `symbol` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `type` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '전략',
  `bunbong` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `win_loss` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `leverage` double(30, 10) NULL DEFAULT NULL,
  `margin` double(30, 10) NULL DEFAULT NULL,
  `positionSize` double(30, 10) NULL DEFAULT NULL,
  `signalType` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `signalPrice` double(30, 10) NULL DEFAULT NULL,
  `signalTime` datetime NULL DEFAULT NULL,
  `openPrice` double(30, 10) NULL DEFAULT NULL COMMENT '체결된가격 진입가격',
  `closePrice` double(30, 10) NULL DEFAULT NULL COMMENT '익절 가격',
  `closeTick` double(30, 10) NULL DEFAULT NULL,
  `pol_tick` double(30, 10) NULL DEFAULT NULL COMMENT '손익 틱',
  `pol_sum` double(30, 10) NULL DEFAULT NULL COMMENT '손익 돈',
  `charge` double(30, 10) NULL DEFAULT 0.0000000000 COMMENT 'ls증권 수수료',
  `openTime` datetime NULL DEFAULT NULL,
  `closeTime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `item_uid`(`uid`) USING BTREE,
  INDEX `play_list_id`(`pid`) USING BTREE,
  CONSTRAINT `test_play_log_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `admin_member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for update_st
-- ----------------------------
DROP TABLE IF EXISTS `update_st`;
CREATE TABLE `update_st`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `st` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Procedure structure for SP_API_ALL_TICK_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_ALL_TICK_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_ALL_TICK_GET`()
BEGIN	
-- 	SELECT 
-- 		p.uid, 
-- 		m.allExactST,
-- 		m.allStopST,
-- 		m.allExact,
-- 		m.allStop,
-- 		m.allStartST,
-- 		SUM(l.real_tick) AS sum_tick
-- 
-- 	FROM play_list p
-- 	INNER JOIN play_log l ON p.id = l.pid
-- 	INNER JOIN admin_member m ON p.uid = m.id
-- 	WHERE p.idx = l.idx AND l.st = 'EXACT' AND (m.allExactST = 'Y' OR m.allStopST = 'Y') AND (0 < allExact OR 0 < allStop)
-- 	GROUP BY p.uid;
-- 	
	
	SELECT 
		p.uid, 
		m.allExactST,
		m.allStopST,
		m.allExact,
		m.allStop,
		m.allStartST,
-- 		SUM(l.real_tick) AS real_tick,
-- 		ll.pol_tick,
-- 		SUM(l.real_tick) + ll.pol_tick AS sum_tick,
		
		SUM(l.real_tick) AS sum_tick

	FROM play_list p
	INNER JOIN play_log l ON p.id = l.pid
	INNER JOIN admin_member m ON p.uid = m.id
	LEFT JOIN (
		SELECT pid, SUM(pol_tick) AS pol_tick
		FROM play_log
		GROUP BY pid
	) ll ON p.id = ll.pid
	WHERE p.idx = l.idx AND l.st = 'EXACT' AND (m.allExactST = 'Y' OR m.allStopST = 'Y') AND (0 < allExact OR 0 < allStop)
	GROUP BY p.uid;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_COOL_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_COOL_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_API_COOL_ADD`(IN `p_uuid` char(15))
BEGIN	
	INSERT INTO candle_cool SET
		uuid = p_uuid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_COOL_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_COOL_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_COOL_EDIT`(IN `p_uuid` char(15),
	IN `p_c_cooltime` DATETIME,
	IN `p_c_side` char(5))
BEGIN	
	UPDATE candle_cool SET
		cooltime = p_c_cooltime,
		side = p_c_side
	WHERE uuid = p_uuid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_COOL_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_COOL_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_COOL_GET`(IN `p_uuid` char(15))
BEGIN	
	SELECT *
	FROM candle_cool
	WHERE uuid = p_uuid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ITEM_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ITEM_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ITEM_GET`(IN `p_id` int(11),
	IN `p_uid` int(11),
	IN `p_mode` int(11))
BEGIN	
	SELECT p.*, c.id AS cid, c.side AS side, c.cooltime
	FROM play_list p
	INNER JOIN candle_cool c ON p.stoch_id = c.uuid
	
	WHERE p.id = p_id AND p.uid = p_uid AND p.`mode` = p_mode;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_LOG_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_LOG_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_LOG_GET`()
BEGIN	
	SELECT *
	FROM play_log;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_LOG_ITEM2_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_LOG_ITEM2_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_LOG_ITEM2_GET`(IN `p_pid` int(11),
	IN `p_uid` int(11),
	IN `p_idx` int(11))
BEGIN	
	SELECT *
	FROM play_log
	WHERE uid = p_uid AND pid = p_pid AND idx = p_idx;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_LOG_ITEM_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_LOG_ITEM_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_LOG_ITEM_GET`(IN `p_pid` int(11),
	IN `p_uid` int(11),
	IN `p_idx` int(11),
	IN `p_signalType` char(20))
BEGIN	
	SELECT *
	FROM play_log
	WHERE uid = p_uid AND pid = p_pid AND idx = p_idx AND signalType = p_signalType;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_M_ST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_M_ST`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_M_ST`(IN `p_id` int(11),
	IN `p_st` char(1))
BEGIN	
	UPDATE play_log SET 
			m_st = p_st
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_RSI_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_RSI_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_RSI_EDIT`(IN `p_id` int(11),
	IN `p_uuid` char(15))
BEGIN	
	UPDATE play_list SET
		rsi_id = p_uuid
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST`(IN `p_pid` int(11),
	IN `p_uid` int(11),
	IN `p_st` char(20),
	IN `p_signalPrice` double(15,10),
	IN `p_idx` int(11),
	IN `p_signalType` char(20))
BEGIN	
	IF p_st = 'ENTER_WAIT' THEN
		UPDATE play_list SET 
			st = 'START',
			idx = p_idx
		WHERE id = p_pid AND uid = p_uid;
	
		INSERT INTO play_log SET
			uid = p_uid,
			pid = p_pid,
			idx = p_idx,
			st = 'ENTER_WAIT',
			signalType = p_signalType,
			signalPrice = p_signalPrice,
			signalTime = NOW();
		
	ELSEIF p_st = 'CANCEL_WAIT' THEN
		UPDATE play_list SET 
			st = 'READY',
			idx = p_idx
		WHERE id = p_pid AND uid = p_uid;
		
		DELETE FROM play_log WHERE uid = p_uid AND pid = p_pid AND idx = p_idx+1 AND signalType = p_signalType;
		
	END IF;


-- 	IF p_st = 'START' THEN
-- 		UPDATE play_list SET 
-- 			st = 'START',
-- 			idx = p_idx
-- 		WHERE id = p_pid AND uid = p_uid;
-- 	
-- 		INSERT INTO play_log SET
-- 			uid = p_uid,
-- 			pid = p_pid,
-- 			idx = p_idx,
-- 			signalType = p_signalType,
-- 			signalPrice = p_signalPrice,
-- 			signalTime = NOW();
-- 		
-- 	ELSEIF p_st = 'CANCEL' THEN
-- 		UPDATE play_list SET 
-- 			st = 'READY',
-- 			idx = p_idx
-- 		WHERE id = p_pid AND uid = p_uid;
-- 		
-- 		DELETE FROM play_log WHERE uid = p_uid AND pid = p_pid AND idx = p_idx+1 AND signalType = p_signalType;
-- 		
-- 	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_STOCH_ALL_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_STOCH_ALL_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_STOCH_ALL_EDIT`(IN `p_uuid` char(15),
	IN `p_bunbong` char(10),
	IN `p_second2` int(11),
	IN `p_second3` int(11),
	IN `p_second4` int(11))
BEGIN	
	UPDATE test_play_list SET
		stoch_id = p_uuid
	WHERE bunbong = p_bunbong
		AND second2 = p_second2
		AND second3 = p_second3
		AND second4 = p_second4;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_STOCH_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_STOCH_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_STOCH_EDIT`(IN `p_id` int(11),
	IN `p_uuid` char(15))
BEGIN	
	UPDATE play_list SET
		stoch_id = p_uuid
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_STOCH_ONE_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_STOCH_ONE_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_STOCH_ONE_EDIT`(IN `p_uid` int(11),
	IN `p_uuid` char(15),
	IN `p_bunbong` char(10),
	IN `p_second2` int(11),
	IN `p_second3` int(11),
	IN `p_second4` int(11))
BEGIN	
	UPDATE play_list SET
		stoch_id = p_uuid
	WHERE bunbong = p_bunbong
		AND second2 = p_second2
		AND second3 = p_second3
		AND second4 = p_second4
		AND uid = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_ATUO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_ATUO`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_ATUO`(IN `p_id` int(11))
BEGIN	
	UPDATE play_list SET 
			st = 'READY'
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_CANCEL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_CANCEL`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_CANCEL`(IN `p_id` int(11),
	IN `p_pid` int(11),
	IN `p_idx` int(11))
BEGIN	
	UPDATE play_list SET 
			st = 'READY',
			idx = p_idx
	WHERE id = p_pid;
	
	DELETE FROM play_log WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_CANCEL_WAIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_CANCEL_WAIT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_CANCEL_WAIT`(IN `p_id` int(11))
BEGIN	
	UPDATE play_log SET 
		st = 'CANCEL_WAIT'
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_CANCEL_WAIT_RE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_CANCEL_WAIT_RE`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_CANCEL_WAIT_RE`(IN `p_id` int(11))
BEGIN	
	UPDATE play_log SET 
		st = 'EXACT_WAIT'
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_DEL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_DEL`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_DEL`(IN `p_id` int(11))
BEGIN	
	DELETE FROM play_list WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_EDIT`(IN `p_id` int(11))
BEGIN	
	UPDATE play_list SET st = 'IDLE' WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_EXACT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_EXACT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_EXACT`(IN `p_id` int(11),
	IN `p_tid` char(10),
	IN `p_exactPrice` DOUBLE(15,10),
	IN `p_exact_cnt` int(11),
	IN `p_rsi` DOUBLE(15,10),
	IN `p_charge` int(11))
BEGIN	
	UPDATE play_log SET 
			tid = p_tid,
			st = 'EXACT',
			exactPrice = p_exactPrice,
			exact_cnt = p_exact_cnt,
			exactTime = NOW(),
			charge = charge + p_charge,
			rsi = p_rsi
	WHERE id = p_id;
	
	
-- 	UPDATE admin_member SET
-- 		price = price - (
-- 			SELECT charge FROM play_log WHERE id = p_id
-- 		)
-- 	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_EXACT_WAIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_EXACT_WAIT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_EXACT_WAIT`(IN `p_pid` int(11),
	IN `p_uid` int(11),
	IN `p_signalPrice` double(15,10),
	IN `p_idx` int(11),
	IN `p_signalType` char(5))
BEGIN	
	UPDATE play_list SET 
		st = 'START',
		idx = p_idx
	WHERE id = p_pid AND uid = p_uid;

	INSERT INTO play_log SET
		uid = p_uid,
		pid = p_pid,
		idx = p_idx,
		st = 'EXACT_WAIT',
		signalType = p_signalType,
		signalPrice = p_signalPrice,
		signalTime = NOW();
		
		
	SELECT LAST_INSERT_ID() AS id;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_EXACT_WAIT_UPDATE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_EXACT_WAIT_UPDATE`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_EXACT_WAIT_UPDATE`(IN `p_id` int(11),
	IN `p_signalPrice` double(15,10),
	IN `p_signalType` char(20))
BEGIN	
	UPDATE play_log SET
		signalType = p_signalType,
		signalPrice = p_signalPrice,
		signalTime = NOW()
	WHERE id = p_id;	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_FORCING
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_FORCING`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_FORCING`(IN `p_id` int(11),
	IN `p_pid` int(11),
	IN `p_endPrice` DOUBLE(15,10),
	IN `p_forcing_cnt` int(11),
	
	IN `p_pol_tick` int(11),
	IN `p_pol_sum` double(15,10),
	
	IN `p_charge` int(11))
BEGIN	
	UPDATE play_log SET 
			st = 'FORCING',
			endPrice = p_endPrice,
			forcing_cnt = p_forcing_cnt,
			
			forcing_tick = p_pol_tick,
			
			endTime = NOW(),
			charge = charge + p_charge,
			
			pol_tick = p_pol_tick,
			pol_sum = p_pol_sum
	WHERE id = p_id;
	
-- 	UPDATE admin_member SET
-- 		price = price - (
-- 			SELECT charge FROM play_log WHERE id = p_id
-- 		)
-- 	WHERE id = p_id;
-- 	
	UPDATE play_list SET st = 'READY' WHERE id = p_pid;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_INIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_INIT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_INIT`(IN `p_pid` int(11),
	IN `p_uid` int(11),
	IN `p_signalPrice` double(15,10),
	IN `p_idx` int(11),
	IN `p_signalType` char(20))
BEGIN	
	INSERT INTO play_log SET
		uid = p_uid,
		pid = p_pid,
		idx = p_idx,
		st = 'EXACT_WAIT',
		signalType = p_signalType,
		signalPrice = p_signalPrice,
		signalTime = NOW();
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_PROFIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_PROFIT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_PROFIT`(IN `p_id` int(11),
	IN `p_profitPrice` DOUBLE(15,10),
	IN `p_profit_cnt` int(11),
	
	IN `p_pol_tick` int(11),
	IN `p_pol_sum` double(15,10),
	
	IN `p_charge` int(11))
BEGIN	
	UPDATE play_log SET 
			st = 'PROFIT',
			profitPrice = p_profitPrice,
			profit_cnt = p_profit_cnt,
			profitTime = NOW(),
			charge = charge + p_charge,
			
			profit_tick = p_pol_tick,
			
			pol_tick = p_pol_tick,
			pol_sum = p_pol_sum
	WHERE id = p_id;
	
-- 	UPDATE admin_member SET
-- 		price = price - (
-- 			SELECT charge FROM play_log WHERE id = p_id
-- 		)
-- 	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_STOP
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_STOP`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_STOP`(IN `p_id` int(11),
	IN `p_stopPrice` DOUBLE(15,10),
	IN `p_stop_cnt` int(11),
	
	IN `p_pol_tick` int(11),
	IN `p_pol_sum` double(15,10),
	
	IN `p_charge` int(11))
BEGIN	
	UPDATE play_log SET 
			st = 'STOP',
			stopPrice = p_stopPrice,
			stop_cnt = p_stop_cnt,
			stopTime = NOW(),
			charge = charge + p_charge,
			
			stop_tick = p_pol_tick,
			
			pol_tick = p_pol_tick,
			pol_sum = p_pol_sum
	WHERE id = p_id;
	
-- 	UPDATE admin_member SET
-- 		price = price - (
-- 			SELECT charge FROM play_log WHERE id = p_id
-- 		)
-- 	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_TICK
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_TICK`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_TICK`(IN `p_id` int(11),
	IN `p_real_tick` int(11))
BEGIN	
	UPDATE play_log SET 
			real_tick = p_real_tick
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_ST_USER_PRICE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_ST_USER_PRICE`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_ST_USER_PRICE`(IN `p_id` int(11),
	IN `p_pol_sum` double(15,10))
BEGIN	
	UPDATE admin_member SET
		price = price + (p_pol_sum)
	WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_T_CNT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_T_CNT`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_T_CNT`(IN `p_id` int(11),
	IN `p_t_cnt` int(11))
BEGIN	
	UPDATE play_log SET 
			t_cnt = p_t_cnt
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_T_ST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_T_ST`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_T_ST`(IN `p_id` int(11),
	IN `p_st` char(1))
BEGIN	
	UPDATE play_log SET 
			t_st = p_st
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_T_TICK
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_T_TICK`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_T_TICK`(IN `p_id` int(11),
	IN `p_tick` int(11))
BEGIN	
	UPDATE play_log SET 
			t_tick = p_tick
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_UUID_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_UUID_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_UUID_GET`(IN `p_uuid` char(15))
BEGIN	
	SELECT *
	FROM play_list p
	WHERE stoch_id = p_uuid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_UUID_GET2
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_UUID_GET2`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_UUID_GET2`()
BEGIN	
	SELECT p.*, c.id AS cid, c.side AS side, c.cooltime
	FROM play_list p
	INNER JOIN candle_cool c ON p.stoch_id = c.uuid 
-- 	LEFT JOIN play_log l ON p.id = l.pid 
	
	WHERE (p.type = 'A' OR p.type = 'B' OR p.type = 'A1') 
		AND p.autoST = 'Y' 
		AND p.st = 'READY'
		AND NOW() < c.cooltime
		AND (c.side = p.signalType OR p.signalType = 'TWO');
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PLAY_Y_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PLAY_Y_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_PLAY_Y_GET`(IN `p_bun` int(11))
BEGIN	
	SELECT *
	FROM play_list p
	WHERE autoST = 'Y' AND bunbong LIKE CONCAT('%_',p_bun);
	
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PRICE_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PRICE_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_PRICE_GET`()
BEGIN	
	SELECT *
	FROM real_price;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_PRICE_SET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_PRICE_SET`;
delimiter ;;
CREATE PROCEDURE `SP_API_PRICE_SET`(IN `p_cur_price` double(15,2))
BEGIN	
	UPDATE real_price SET cur_price = p_cur_price;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_RSI_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_RSI_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_API_RSI_ADD`(IN `p_uuid` char(15),
	IN `p_second1` int(11),
	IN `p_rsi_period` int(11),
	IN `p_rsi_up` double(15,10),
	IN `p_rsi_down` double(15,10))
BEGIN	
	INSERT INTO stoch_list SET  
		uuid = p_uuid,
		type = 'rsi',
		second1 = p_second1,
		rsi_period = p_rsi_period,
		rsi_up = p_rsi_up,
		rsi_down = p_rsi_down;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_RSI_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_RSI_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_RSI_GET`(IN `p_second1` int(11),
	IN `p_rsi_period` int(11),
	IN `p_rsi_up` double(15,3),
	IN `p_rsi_down` double(15,3))
BEGIN	
	SELECT *
	FROM stoch_list
	WHERE 
				type = 'rsi'
		AND second1 = p_second1
		AND	rsi_period = p_rsi_period
		AND rsi_up = p_rsi_up
		AND	rsi_down = p_rsi_down;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_STOCH_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_STOCH_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_API_STOCH_ADD`(IN `p_symbol` char(20),
	IN `p_uuid` char(15),
	IN `p_bunbong` int(11),
	IN `p_second2` int(11),
	IN `p_second3` int(11),
	IN `p_second4` int(11))
BEGIN	
	INSERT INTO stoch_list SET  
		symbol = p_symbol,
		uuid = p_uuid,
		type = 'stoch',
		bunbong = p_bunbong,
		second2 = p_second2,
		second3 = p_second3,
		second4 = p_second4;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_STOCH_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_STOCH_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_STOCH_GET`(IN `p_symbol` char(20),
	IN `p_type` char(20),
	IN `p_bunbong` char(10),
	IN `p_second2` char(10),
	IN `p_second3` char(10),
	IN `p_second4` char(10))
BEGIN	
-- 	SELECT *
-- 	FROM stoch_list
-- 	WHERE 
-- 				type = p_type
-- 		AND symbol = p_symbol
-- 		AND bunbong = p_bunbong
-- 		AND second2 = p_second2
-- 		AND second3 = p_second3
-- 		AND second4 = p_second4;
-- 		
	
	SELECT *
	FROM stoch_list
	WHERE 
				type2 = p_type
		AND symbol = p_symbol
		AND bunbong = p_bunbong
		AND CASE WHEN p_second2 IS NOT NULL THEN (second2 = p_second2) ELSE (second2 IS NULL) END
		AND CASE WHEN p_second3 IS NOT NULL THEN (second3 = p_second3) ELSE (second3 IS NULL) END
		AND CASE WHEN p_second4 IS NOT NULL THEN (second4 = p_second4) ELSE (second4 IS NULL) END;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_STOCH_ID_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_STOCH_ID_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_STOCH_ID_GET`(IN `p_uuid` char(15))
BEGIN	
	SELECT *
	FROM stoch_list
	WHERE uuid = p_uuid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_TARGET_LIST_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_TARGET_LIST_GET`;
delimiter ;;
CREATE PROCEDURE `SP_API_TARGET_LIST_GET`()
BEGIN	
	SELECT *
	FROM stoch_list
	WHERE st = 'INIT';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_API_TARGET_ST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_API_TARGET_ST`;
delimiter ;;
CREATE PROCEDURE `SP_API_TARGET_ST`(IN `p_id` int(11))
BEGIN	
	UPDATE stoch_list SET
		st = 'READY'
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_LOAD_LOG
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_LOAD_LOG`;
delimiter ;;
CREATE PROCEDURE `SP_A_LOAD_LOG`(IN `p_symbol` char(20),
	IN `p_id` int(11))
BEGIN	
	SELECT *
	FROM alert_log3
	WHERE db_type = 'ATF' AND bunbong = p_id AND symbol = p_symbol
	ORDER BY created_at DESC
	LIMIT 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_LOAD_LOG2
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_LOAD_LOG2`;
delimiter ;;
CREATE PROCEDURE `SP_A_LOAD_LOG2`(IN `p_symbol` char(20),
	IN `p_id` int(11))
BEGIN	
	SELECT *
	FROM alert_log3
	WHERE db_type = 'UT' AND bunbong = p_id AND symbol = p_symbol
	ORDER BY created_at DESC
	LIMIT 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_LOGIN
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_LOGIN`;
delimiter ;;
CREATE PROCEDURE `SP_A_LOGIN`(IN `userId` VARCHAR(50),
	IN `userPW` VARCHAR(100))
BEGIN
	SELECT *
	FROM admin_member
	WHERE mem_id = userId AND password = PASSWORD(userPW)
	LIMIT 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_MEMBER_ALL_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_MEMBER_ALL_GET`;
delimiter ;;
CREATE PROCEDURE `SP_A_MEMBER_ALL_GET`()
BEGIN	
	SELECT *
	FROM admin_member;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_MEMBER_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_MEMBER_GET`;
delimiter ;;
CREATE PROCEDURE `SP_A_MEMBER_GET`(IN `p_uid` int(11))
BEGIN	
	SELECT *
	FROM admin_member
	WHERE id = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_MEMBER_KEY_ALL_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_MEMBER_KEY_ALL_GET`;
delimiter ;;
CREATE PROCEDURE `SP_A_MEMBER_KEY_ALL_GET`()
BEGIN	
	SELECT id, appKey, appSecret
	FROM admin_member
	WHERE appKey IS NOT NULL AND appSecret IS NOT NULL;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PER_MY_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PER_MY_GET`;
delimiter ;;
CREATE PROCEDURE `SP_A_PER_MY_GET`(IN `p_id` INT)
BEGIN	
	SELECT 
		*
	FROM admin_member
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_ADD`(IN `p_uid` int(11),
	IN `p_mode` int(11),
	IN `p_bunbong` char(10),
	IN `p_second1` int(11),
	IN `p_second2` int(11),
	IN `p_second3` int(11),
	IN `p_second4` int(11),
	IN `p_enter` int(11),
	IN `p_cancel` int(11),
	IN `p_profit` int(11),
	IN `p_stopLoss` int(11),
	IN `p_minimumOrderST` char(1),
	IN `p_m_cancelStopLoss` int(11),
	IN `p_m_profit` int(11),
	IN `p_trendOrderST` char(1),
	IN `p_t_cancelStopLoss` int(11),
	IN `p_t_profit` int(11),
	IN `p_t_chase` int(11),
	IN `p_signalType` char(5),
	IN `p_alarmSignalST` char(1),
	IN `p_alarmResultST` char(1),
	IN `p_orderSize` int(11),
	
	IN `p_t_autoST` char(1),
	IN `p_t_ST` char(1),
	IN `p_t_direct` char(1),
	IN `p_type` char(10),
	
	IN `p_direct1ST` char(1),
	IN `p_direct2ST` char(1))
BEGIN	
	INSERT INTO play_list SET
		uid = p_uid,
		`mode` = p_mode,
		bunbong = p_bunbong,
		second1 = p_second1,
		second2 = p_second2,
		second3 = p_second3,
		second4 = p_second4,
		enter = p_enter,
		cancel = p_cancel,
		profit = p_profit,
		stopLoss = p_stopLoss,
		minimumOrderST = p_minimumOrderST,
		m_cancelStopLoss = p_m_cancelStopLoss,
		m_profit = p_m_profit,
		trendOrderST = p_trendOrderST,
		t_cancelStopLoss = p_t_cancelStopLoss,
		t_profit = p_t_profit,
		t_chase = p_t_chase,
		signalType = p_signalType,
		alarmSignalST = p_alarmSignalST,
		alarmResultST = p_alarmResultST,
		orderSize = p_orderSize,
		
		t_autoST = p_t_autoST,
		t_ST = p_t_ST,
		t_direct = p_t_direct,
		type = p_type,
		
		direct1ST = p_direct1ST,
		direct2ST = p_direct2ST;
		
-- 		t_long = p_t_long,
-- 		t_short = p_t_short,
-- 		t_same = p_t_same,
-- 		t_sameST = p_t_sameST;
		
	SELECT LAST_INSERT_ID() AS id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_ALL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_ALL`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_ALL`(IN `p_uid` int(11),
	IN `p_pid` int(11))
BEGIN	

	SELECT *
	FROM play_list
	WHERE uid = p_uid AND id <> p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_AUTO_ALL_SET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_AUTO_ALL_SET`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_AUTO_ALL_SET`(IN `p_uid` int(11),
	IN `p_autoST` char(1))
BEGIN	
	UPDATE play_list SET
		autoST = p_autoST
	WHERE uid = p_uid;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_AUTO_SET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_AUTO_SET`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_AUTO_SET`(IN `p_id` int(11),
	IN `p_autoST` char(1))
BEGIN	
	UPDATE play_list SET
		autoST = p_autoST
	WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_DEL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_DEL`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_DEL`(IN `p_id` int(11))
BEGIN	
	DELETE FROM play_list WHERE id = p_id;
	
-- 	UPDATE play_list SET st = 'DEL' WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_DETAIL_ITEM
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_DETAIL_ITEM`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_DETAIL_ITEM`(IN `p_id` int(11))
BEGIN	
	SELECT *
	FROM play_list
	WHERE id = p_id;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_DETAIL_LOG
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_DETAIL_LOG`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_DETAIL_LOG`(IN `p_pid` int(11))
BEGIN	
	SELECT a.*, b.enter, b.profit
	FROM play_log a
	INNER JOIN play_list b ON a.pid = b.id
	WHERE pid = p_pid AND a.st <> 'EXACT_WAIT'
	ORDER BY a.id DESC;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_DETAIL_LOG_GROUP
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_DETAIL_LOG_GROUP`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_DETAIL_LOG_GROUP`(IN `p_pid` int(11),
	IN `p_idx` int(11))
BEGIN	
-- 	SELECT 
-- 			SUM(exact_cnt) AS exact_cnt,
-- 			SUM(profit_cnt) AS profit_cnt,
-- 			SUM(stop_cnt) AS stop_cnt,
-- 			SUM(forcing_cnt) AS forcing_cnt,
-- 			SUM(forcing_tick) AS forcing_tick,
-- 			SUM(charge) AS charge, 
-- 			SUM(pol_tick) AS pol_tick,
-- 			SUM(pol_sum) AS pol_sum
-- 	FROM play_log
-- 	WHERE pid = p_pid;
	
	SELECT log.*, list.enter, list.profit, list.stopLoss, list.cancel
	FROM play_log log
	INNER JOIN play_list list ON log.pid = list.id
	WHERE log.pid = p_pid AND log.idx = p_idx 
	LIMIT 1;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_DETAIL_TAP
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_DETAIL_TAP`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_DETAIL_TAP`(IN `p_id` int(11),
	IN `p_detailTap` char(1))
BEGIN	
	UPDATE play_list SET
		detailTap = p_detailTap
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_EDIT`(IN `p_id` int(11),
	IN `p_bunbong` char(10),
	IN `p_second1` int(11),
	IN `p_second2` int(11),
	IN `p_second3` int(11),
	IN `p_second4` int(11),
	IN `p_enter` int(11),
	IN `p_cancel` int(11),
	IN `p_profit` int(11),
	IN `p_stopLoss` int(11),
	IN `p_minimumOrderST` char(1),
	IN `p_m_cancelStopLoss` int(11),
	IN `p_m_profit` int(11),
	IN `p_trendOrderST` char(1),
	IN `p_t_cancelStopLoss` int(11),
	IN `p_t_profit` int(11),
	IN `p_t_chase` int(11),
	IN `p_signalType` char(5),
	IN `p_alarmSignalST` char(1),
	IN `p_alarmResultST` char(1),
	IN `p_orderSize` int(11),
	
	IN `p_t_autoST` char(1),
	IN `p_t_ST` char(1),
	IN `p_t_direct` char(1),
	IN `p_type` char(10),
	
	
	IN `p_direct1ST` char(1),
	IN `p_direct2ST` char(1))
BEGIN	
	UPDATE play_list SET 
		bunbong = p_bunbong,
		second1 = p_second1,
		second2 = p_second2,
		second3 = p_second3,
		second4 = p_second4,
		enter = p_enter,
		cancel = p_cancel,
		profit = p_profit,
		stopLoss = p_stopLoss,
		minimumOrderST = p_minimumOrderST,
		m_cancelStopLoss = p_m_cancelStopLoss,
		m_profit = p_m_profit,
		trendOrderST = p_trendOrderST,
		t_cancelStopLoss = p_t_cancelStopLoss,
		t_profit = p_t_profit,
		t_chase = p_t_chase,
		signalType = p_signalType,
		alarmSignalST = p_alarmSignalST,
		alarmResultST = p_alarmResultST,
		orderSize = p_orderSize,
		
		
		t_autoST = p_t_autoST,
		t_ST = p_t_ST,
		t_direct = p_t_direct,
		type = p_type,
		
		direct1ST = p_direct1ST,
		direct2ST = p_direct2ST
-- 		t_long = p_t_long,
-- 		t_short = p_t_short,
-- 		t_same = p_t_same,
-- 		t_sameST = p_t_sameST
		
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_EDIT_ST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_EDIT_ST`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_EDIT_ST`(IN `p_id` int(11))
BEGIN	
-- 	DELETE FROM play_list WHERE id = p_id;
	
	UPDATE play_list SET st = 'EDIT' WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_GET`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_GET`(IN `p_uid` int(11),
	IN `pg` INT,
	IN `block` INT)
BEGIN	

	SELECT SQL_CALC_FOUND_ROWS *
	FROM play_list
	WHERE uid = p_uid
	LIMIT pg, block;
	
	SELECT FOUND_ROWS() AS totalCount;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_LEN
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_LEN`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_LEN`(IN `p_uid` int(11))
BEGIN	
	SELECT COUNT(*) AS cnt
	FROM play_list
	WHERE uid = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_LOG_ALL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_LOG_ALL`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_LOG_ALL`()
BEGIN	
	SELECT *
	FROM play_log;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_LOG_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_LOG_GET`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_LOG_GET`(IN `p_uid` int(11),
	IN `p_pid` int(11))
BEGIN	
	SELECT *
	FROM play_log
	WHERE uid = p_uid AND pid = p_pid ;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_LOG_GET2
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_LOG_GET2`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_LOG_GET2`(IN `p_uid` int(11),
	IN `p_pid` int(11),
	IN `p_idx` int(11))
BEGIN	
	SELECT *
	FROM play_log
	WHERE uid = p_uid AND pid = p_pid AND idx = p_idx;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_LOG_GET3
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_LOG_GET3`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_LOG_GET3`(IN `p_bunbon` int(11))
BEGIN	
	SELECT 
			p.id AS pid, 
			p.uid AS uid, 
			l.id AS lid, 
			l.signalType AS signalType,
			l.exactPrice AS exactPrice,
			p.orderSize AS orderSize
	FROM play_list p
	INNER JOIN play_log l ON p.id = l.pid
	WHERE p.autoST = 'Y' 
		AND p.bunbong = p_bunbon
		AND l.st = 'EXACT'
		AND ((p.t_ST = 'Y' AND p.t_autoST = 'Y' AND l.t_cnt = 2) OR (p.t_ST = 'N' AND p.t_autoST = 'Y' AND l.t_cnt = 1));
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_LOG_LIST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_LOG_LIST`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_LOG_LIST`(IN `p_uid` int(11))
BEGIN	
-- 
-- 	select b.*, a.st, a.real_tick, (select autost from play_list where id = a.pid) as autost, (select bunbong from play_list where id = a.pid) as bunbong
-- 	from play_log a
-- 	inner join (
-- 		select 
-- 			max(id) as id,
-- 			pid,
-- 			signaltype,
-- 			sum(exact_cnt) as exact_cnt,
-- 			sum(profit_cnt) as profit_cnt,
-- 			sum(stop_cnt) as stop_cnt,
-- 			sum(forcing_cnt) as forcing_cnt,
-- 			sum(forcing_tick) as forcing_tick,
-- 			sum(charge) as charge, 
-- 			sum(pol_tick) as pol_tick,
-- 			sum(pol_sum) as pol_sum
-- 		from play_log
-- 		group by pid
-- 	) as b on a.id = b.id
-- 	where a.uid = uid;
-- 	
	
	
	
	select 
		play.id as iid, 
		a.*, 
		play.bunbong, 
		play.autoST, 
		play.enter, 
		a.signalPrice, 
		play.signalType as p_signalType, 
		play.type, 
		a.exactPrice, 
		play.orderSize, 
		play.trendOrderST, 
		play.minimumOrderST,
		play.detailTap,
		play.selectST
	from play_list play
	left join (
		select b.*, a.st, a.real_tick, signalPrice, a.exactPrice, a.signalType
		from play_log a
		inner join (
			select 
				max(id) as id,
				pid,
				sum(profit_tick) as profit_tick,
				sum(stop_tick) as stop_tick,
				
				sum(exact_cnt) as exact_cnt,
				sum(profit_cnt) as profit_cnt,
				sum(stop_cnt) as stop_cnt,
				sum(forcing_cnt) as forcing_cnt,
				sum(forcing_tick) as forcing_tick,
				sum(charge) as charge, 
				sum(pol_tick) as pol_tick,
				sum(pol_sum) as pol_sum
			from play_log
			group by pid
		) as b on a.id = b.id
		where a.uid = p_uid
	) a on a.pid = play.id
	WHERE play.st <> 'DEL' AND play.uid = p_uid;
-- 
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_LOG_U_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_LOG_U_GET`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_LOG_U_GET`(IN `p_uid` int(11))
BEGIN	
	SELECT *
	FROM play_log
	WHERE uid = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_SELECT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_SELECT`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_SELECT`(IN `p_id` int(11),
	IN `p_selectST` char(1))
BEGIN	
	UPDATE play_list SET
		selectST = p_selectST
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_SET_DEL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_SET_DEL`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_SET_DEL`(IN `p_id` int(11))
BEGIN	
	DELETE FROM play_log WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_SET_READY
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_SET_READY`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_SET_READY`(IN `p_id` int(11))
BEGIN	
	UPDATE play_list SET st = 'READY' WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_PLAY_SET_ST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_PLAY_SET_ST`;
delimiter ;;
CREATE PROCEDURE `SP_A_PLAY_SET_ST`(IN `p_id` int(11),
	IN `p_st` char(20))
BEGIN	
-- 	DELETE FROM play_list WHERE id = p_id;
	
	UPDATE play_log SET st = p_st WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_RESULT_DETAIL_PAGE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_RESULT_DETAIL_PAGE`;
delimiter ;;
CREATE PROCEDURE `SP_A_RESULT_DETAIL_PAGE`(IN `p_uid` int(11),
	IN `p_date` CHAR(10),
	IN `pg` INT,
	IN `block` INT)
BEGIN	
	SELECT SQL_CALC_FOUND_ROWS *
	FROM play_log
	WHERE 
		uid = p_uid 
		AND DATE_FORMAT(signalTime,'%Y/%m/%d') = p_date 
		AND (profitTime IS NOT NULL OR stopTime IS NOT NULL OR endTime IS NOT NULL)
	ORDER BY id DESC
	LIMIT pg, block;
	
	SELECT FOUND_ROWS() AS totalCount;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_RESULT_EXPORT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_RESULT_EXPORT`;
delimiter ;;
CREATE PROCEDURE `SP_A_RESULT_EXPORT`(IN `p_uid` int(11),
	IN `sDate` DATE,
	IN `eDate` DATE)
BEGIN		
	SELECT 
		DATE_FORMAT(exactTime,'%Y/%m/%d') AS '날짜',
		IFNULL(SUM(exact_cnt), 0) AS '진입',
		IFNULL(SUM(profit_tick), 0) AS '익절',
		IFNULL(SUM(stop_tick), 0) AS '손절',
		IFNULL(SUM(forcing_cnt), 0) AS '강제청산',
-- 		IFNULL(SUM(forcing_tick), 0) AS forcing_tick,
		IFNULL(SUM(pol_tick), 0) AS '손익',
		IFNULL(SUM(charge), 0) AS '수수료',
		IFNULL(SUM(pol_sum), 0) - IFNULL(SUM(charge), 0) AS '손입합계'
	FROM play_log
	WHERE 
				uid = p_uid 
		AND exactTime IS NOT NULL 
		AND (sDate <= exactTime AND eDate <= exactTime)
	GROUP BY DATE_FORMAT(exactTime,'%Y-%m-%d');

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_A_RESULT_PAGE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_A_RESULT_PAGE`;
delimiter ;;
CREATE PROCEDURE `SP_A_RESULT_PAGE`(IN `p_uid` int(11),
	IN `pg` INT,
	IN `block` INT,
	IN `sDate` DATE,
	IN `eDate` DATE)
BEGIN	
	
	SELECT 
		SQL_CALC_FOUND_ROWS DATE_FORMAT(exactTime,'%Y/%m/%d') AS logDate,
		IFNULL(SUM(exact_cnt), 0) AS exact_cnt,
		IFNULL(SUM(profit_tick), 0) AS profit_tick,
		IFNULL(SUM(stop_tick), 0) AS stop_tick,
		IFNULL(SUM(forcing_cnt), 0) AS forcing_cnt,
		IFNULL(SUM(forcing_tick), 0) AS forcing_tick,
		IFNULL(SUM(pol_tick), 0) AS pol_tick,
		IFNULL(SUM(charge), 0) AS charge,
		IFNULL(SUM(pol_sum), 0) - IFNULL(SUM(charge), 0) AS pol_sum
	FROM play_log
	WHERE 
				uid = p_uid 
		AND exactTime IS NOT NULL 
		AND (sDate <= exactTime AND eDate <= exactTime)
	GROUP BY DATE_FORMAT(exactTime,'%Y-%m-%d')
	LIMIT pg, block;


	
	SELECT FOUND_ROWS() AS totalCount;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_CAGR_BEST_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_CAGR_BEST_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_CAGR_BEST_ADD`(IN `p_cid` int(11),
  IN `p_candle` char(20),
	IN `p_side` char(20),
  IN `p_tp` double,
  IN `p_lhr` double,
  IN `p_shr` double,
  IN `p_pnl` double,
  IN `p_cagr` double)
BEGIN	
	INSERT INTO candle_best SET
		cid = p_cid,
		candle = p_candle,
		side = p_side,
		tp = p_tp,
		lhr = p_lhr,
		shr = p_shr,
		pnl = p_pnl,
		cagr = p_cagr;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_CAGR_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_CAGR_GET`;
delimiter ;;
CREATE PROCEDURE `SP_CAGR_GET`(IN `p_symbol` char(20),
	IN `p_candle_min` int(11),
	IN `p_signal` char(10),
	IN `p_side` char(10))
BEGIN	
	SELECT 
		CASE 
				WHEN r.side = 'BUY' THEN buy_count
				WHEN r.side = 'SELL' THEN sell_count
		END AS count,
		s.first_signal_date,
		s.lookahead_min,
		r.tp,
		r.hr,
		r.pnl
	FROM candle_stats AS s
	INNER JOIN candle_rows AS r ON s.id = r.cid
	WHERE 
				s.candle_min = p_candle_min
		AND s.symbol = p_symbol
		AND s.`signal` = p_signal
		AND r.side = p_side
	ORDER BY r.tp;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_CAGR_ROWS_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_CAGR_ROWS_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_CAGR_ROWS_ADD`(IN `p_cid` int(11),
  IN `p_tp` double,
	IN `p_side` char(20),
  IN `p_hr` double,
  IN `p_cagr` double,
  IN `p_pnl` double)
BEGIN	
	INSERT INTO candle_rows SET
		cid = p_cid,
		tp = p_tp,
		side = p_side,
		hr = p_hr,
		cagr = p_cagr,
		pnl = p_pnl;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_CAGR_STATS_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_CAGR_STATS_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_CAGR_STATS_ADD`(IN `p_symbol`	char(20),
	IN `p_signal`	char(20),
	IN `p_candle_min`	int(11),
	IN `p_first_signal_date`	date,
	IN `p_lookahead_min`	char(20),
	IN `p_buy_count`	int(11),
	IN `p_sell_count`	int(11),
	IN `p_best_metric`	char(20))
BEGIN	
	DELETE FROM candle_stats 
	WHERE	symbol = p_symbol AND `signal` = p_signal AND candle_min = p_candle_min;

	INSERT INTO candle_stats SET
		symbol = p_symbol,
		`signal` = p_signal,
    candle_min = p_candle_min,
    first_signal_date = p_first_signal_date,
    lookahead_min = p_lookahead_min,
    buy_count = p_buy_count,
    sell_count = p_sell_count,
    best_metric = p_best_metric;
		
		
	SELECT LAST_INSERT_ID() AS id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_CAGR_STATS_DEL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_CAGR_STATS_DEL`;
delimiter ;;
CREATE PROCEDURE `SP_CAGR_STATS_DEL`(IN `p_symbol`	char(20),
	IN `p_signal`	char(20),
	IN `p_candle_min`	int(11))
BEGIN	
	DELETE FROM candle_stats 
	WHERE	symbol = p_symbol AND `signal` = p_signal AND candle_min = p_candle_min;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_CAGR_STRATEGY_A_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_CAGR_STRATEGY_A_GET`;
delimiter ;;
CREATE PROCEDURE `SP_CAGR_STRATEGY_A_GET`()
BEGIN	
	SELECT 
		s.symbol,
		s.`signal`,
		s.candle_min AS bunbong,
		s.first_signal_date,
		r.side,
		r.tp,
		r.hr,
		r.pnl
	FROM candle_rows AS r
	INNER JOIN candle_stats AS s ON r.cid = s.id
	WHERE r.hr >= 0.5
	ORDER BY r.cagr DESC
	LIMIT 10;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_CAGR_STRATEGY_B_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_CAGR_STRATEGY_B_GET`;
delimiter ;;
CREATE PROCEDURE `SP_CAGR_STRATEGY_B_GET`()
BEGIN	
	SELECT 
		s.symbol,
		s.`signal`,
		s.candle_min,
		s.first_signal_date,
		r.side,
		r.tp,
		r.hr,
		r.pnl
	FROM candle_rows AS r
	INNER JOIN candle_stats AS s ON r.cid = s.id
	WHERE r.hr >= 0.8
	ORDER BY r.cagr DESC
	LIMIT 10;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_CAGR_UP_DOWN_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_CAGR_UP_DOWN_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_CAGR_UP_DOWN_ADD`(IN `p_symbol` char(20),
  IN `p_candle` int(11),
	IN `p_price` double)
BEGIN	

	DELETE FROM candle_up_down
	WHERE symbol = p_symbol AND candle = p_candle;

	INSERT INTO candle_up_down SET
		symbol = p_symbol,
		candle = p_candle,
		price = p_price;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_CAGR_UP_DOWN_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_CAGR_UP_DOWN_GET`;
delimiter ;;
CREATE PROCEDURE `SP_CAGR_UP_DOWN_GET`()
BEGIN	
	SELECT *
	FROM candle_up_down;
-- 	WHERE candle = p_candle;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_CAGR_UP_DOWN_PER_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_CAGR_UP_DOWN_PER_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_CAGR_UP_DOWN_PER_EDIT`(IN `p_symbol` char(20),
  IN `p_candle` int(11),
	IN `p_per` double)
BEGIN	
	UPDATE candle_up_down
	SET per = p_per
	WHERE symbol = p_symbol AND candle = p_candle;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_CAGR_UP_DOWN_ST_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_CAGR_UP_DOWN_ST_GET`;
delimiter ;;
CREATE PROCEDURE `SP_CAGR_UP_DOWN_ST_GET`(IN `p_side` char(5),
	IN `p_candle` int(11))
BEGIN	
	SELECT 
		b.*,
		ud.candle,
		ud.price,
		ud.per
	FROM candle_up_down AS ud
	INNER JOIN (
		SELECT 
				symbol,
				`signal`, 
				candle_min AS bunbong, 
				lookahead_min, 
				side, 
				tp, 
				pnl,
				first_signal_date
		FROM (
			SELECT
				st.symbol,
				st.signal,
				st.candle_min,
				st.lookahead_min,
				be.side,
				be.tp,
				be.pnl,
				st.first_signal_date,
				ROW_NUMBER() OVER (PARTITION BY st.symbol ORDER BY be.pnl DESC) as rnk
			FROM candle_stats AS st
			INNER JOIN candle_best AS be ON st.id = be.cid
			WHERE be.candle = 'ALL' AND be.side = p_side
		) AS ranked_stats
		WHERE rnk = 1
	) AS b ON ud.symbol = b.symbol
	WHERE ud.candle = p_candle
	ORDER BY 
    CASE WHEN p_side = 'long' THEN ud.per END DESC,
    CASE WHEN p_side = 'short' THEN ud.per END ASC
	LIMIT 10;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_C_CANDLE_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_C_CANDLE_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_C_CANDLE_ADD`(IN `p_symbol` char(20),
	IN `p_bunbong` char(10),
	
	IN `p_CLOSE_NOW` double(15, 3),
	IN `p_CLOSE_PREV` double(15, 3),
	
	IN `p_BBW_NOW` double(15, 3),
	IN `p_BBW_PREV` double(15, 3),
	
	IN `p_Vol_Z_score` double(15, 3),
	IN `p_RSI` double(15, 3),
	IN `p_RSI_Slope` double(15, 3),
	IN `p_ATR` double(15, 3),
	IN `p_STD_DEV` double(15, 3),
	IN `p_F_UP_LV1` double(15, 3),
	IN `p_F_UP_LV2` double(15, 3),
	IN `p_F_DN_LV1` double(15, 3),
	IN `p_F_DN_LV2` double(15, 3),
	
	IN `p_CC_BTC` double(15, 3),
	IN `p_CC_ETH` double(15, 3))
BEGIN	
-- 	INSERT INTO candle_list SET
-- 		symbol = p_symbol,
-- 		bunbong = p_bunbong,
-- -- 		`date` = p_date,
-- 		
-- 		
-- 		prevClose = p_prevClose,
-- 		BBW = p_BBW,
-- 		Vol_Z_score = p_Vol_Z_score,
-- 		RSI = p_RSI,
-- 		RSI_Slope = p_RSI_Slope,
-- 		ATR = p_ATR,
-- 		SD = p_SD,
-- 		F_UP_LV1 = p_F_UP_LV1,
-- 		F_UP_LV2 = p_F_UP_LV2,
-- 		F_DN_LV1 = p_F_DN_LV1,
-- 		F_DN_LV2 = p_F_DN_LV2;
-- 		
		
		
	INSERT INTO candle_list SET 
		symbol = p_symbol,
		bunbong = p_bunbong,
		CLOSE_NOW = p_CLOSE_NOW,
		CLOSE_PREV = p_CLOSE_PREV,
		
		BBW_NOW = p_BBW_NOW,
		BBW_PREV = p_BBW_PREV,
		
		Vol_Z_score = p_Vol_Z_score,
		RSI = p_RSI,
		RSI_Slope = p_RSI_Slope,
		ATR = p_ATR,
		STD_DEV = p_STD_DEV,
		F_UP_LV1 = p_F_UP_LV1,
		F_UP_LV2 = p_F_UP_LV2,
		F_DN_LV1 = p_F_DN_LV1,
		F_DN_LV2 = p_F_DN_LV2,
		
		CC_BTC = p_CC_BTC,
		CC_ETH = p_CC_ETH;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_C_CANDLE_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_C_CANDLE_GET`;
delimiter ;;
CREATE PROCEDURE `SP_C_CANDLE_GET`(IN `p_bunbong` char(10),
	IN `p_symbol` char(20))
BEGIN	
		SELECT * 
		FROM candle_list 
		WHERE bunbong = p_bunbong AND symbol = p_symbol
		ORDER BY created_at DESC
		LIMIT 2;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_C_CANDLE_UPDATE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_C_CANDLE_UPDATE`;
delimiter ;;
CREATE PROCEDURE `SP_C_CANDLE_UPDATE`(IN `p_symbol` char(20),
	IN `p_bunbong` char(10),
	
	IN `p_CLOSE_NOW` double(15, 3),
	IN `p_CLOSE_PREV` double(15, 3),
	
	IN `p_BBW_NOW` double(15, 3),
	IN `p_BBW_PREV` double(15, 3),
	
	IN `p_Vol_Z_score` double(15, 3),
	IN `p_RSI` double(15, 3),
	IN `p_RSI_Slope` double(15, 3),
	IN `p_ATR` double(15, 3),
	IN `p_STD_DEV` double(15, 3),
	IN `p_F_UP_LV1` double(15, 3),
	IN `p_F_UP_LV2` double(15, 3),
	IN `p_F_DN_LV1` double(15, 3),
	IN `p_F_DN_LV2` double(15, 3),
	
	IN `p_CC_BTC` double(15, 3),
	IN `p_CC_ETH` double(15, 3))
BEGIN	
	UPDATE candle_list SET 
		CLOSE_NOW = p_CLOSE_NOW,
		CLOSE_PREV = p_CLOSE_PREV,
		
		BBW_NOW = p_BBW_NOW,
		BBW_PREV = p_BBW_PREV,
		
		Vol_Z_score = p_Vol_Z_score,
		RSI = p_RSI,
		RSI_Slope = p_RSI_Slope,
		ATR = p_ATR,
		STD_DEV = p_STD_DEV,
		F_UP_LV1 = p_F_UP_LV1,
		F_UP_LV2 = p_F_UP_LV2,
		F_DN_LV1 = p_F_DN_LV1,
		F_DN_LV2 = p_F_DN_LV2,
		
		CC_BTC = p_CC_BTC,
		CC_ETH = p_CC_ETH
	WHERE symbol = p_symbol AND bunbong = p_bunbong;

-- 	INSERT INTO candle_list SET

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ETC_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ETC_GET`;
delimiter ;;
CREATE PROCEDURE `SP_ETC_GET`()
BEGIN	
	SELECT *
	FROM etc_candle_list;

	SELECT *
	FROM etc_strategy_list;

	SELECT *
	FROM etc_symbol_list;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ETC_STOCH_DEAD_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ETC_STOCH_DEAD_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_ETC_STOCH_DEAD_EDIT`(IN `p_id` int(11),
	IN `p_st` char(20))
BEGIN	
	UPDATE stoch_list SET
		st2 = p_st
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ETC_STOCH_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ETC_STOCH_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_ETC_STOCH_EDIT`(IN `p_id` int(11),
	IN `p_st` char(20))
BEGIN	
	UPDATE stoch_list SET
		st = p_st
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ETC_STOCH_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ETC_STOCH_GET`;
delimiter ;;
CREATE PROCEDURE `SP_ETC_STOCH_GET`(IN `p_type` char(10))
BEGIN	
	SELECT *
	FROM stoch_list
	WHERE 
				`type` = p_type AND (st1 != 'READY' OR st2 != 'READY');
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ETC_STOCH_LONG_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ETC_STOCH_LONG_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_ETC_STOCH_LONG_EDIT`(IN `p_id` int(11),
	IN `p_st` char(20))
BEGIN	
	UPDATE stoch_list SET
		st1 = p_st
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_EVENT_LOG_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_EVENT_LOG_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_EVENT_LOG_ADD`(IN `p_uid` int(11),
	IN `p_pid` int(11),
	IN `p_tid` char(10),
	IN `p_oid` char(10),
	IN `p_event_type`  char(20),
	IN `p_old_st`  char(20),
	IN `p_new_st`  char(20),
	IN `p_old_status`  char(20),
	IN `p_new_status`  char(20),
	IN `p_signalType`  char(5),
	IN `p_signalPrice` double(15,10),
	IN `p_signalTime` datetime)
BEGIN	
	INSERT INTO event_log SET
		uid = p_uid,
		pid = p_pid,
		tid = p_tid,
		oid = p_oid,
		event_type = p_event_type,
		old_st = p_old_st,
		new_st = p_new_st,
		old_status = p_old_status,
		new_status = p_new_status,
		signalType = p_signalType,
		signalPrice = p_signalPrice,
		signalTime = p_signalTime;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ADD`(IN `p_uid` int(11),
	IN `p_bunbong` char(10),
	IN `p_second1` char(10),
	IN `p_second2` char(10),
	IN `p_second3` char(10),
	IN `p_second4` char(10),
	IN `p_enter` int(11),
	IN `p_cancel` int(11),
	IN `p_profit` int(11),
	IN `p_stopLoss` int(11),
	IN `p_minimumOrderST` char(1),
	IN `p_m_cancelStopLoss` int(11),
	IN `p_m_profit` int(11),
	IN `p_trendOrderST` char(1),
	IN `p_t_cancelStopLoss` int(11),
	IN `p_t_profit` int(11),
	IN `p_t_chase` int(11),
	IN `p_signalType` char(5),
	IN `p_alarmSignalST` char(1),
	IN `p_alarmResultST` char(1),
	IN `p_orderSize` int(11),
	IN `p_t_autoST` char(1),
	IN `p_t_ST` char(1),
	IN `p_t_direct` char(1),
	IN `p_type` char(10),
	IN `p_direct1ST` char(1),
	IN `p_direct2ST` char(1))
BEGIN	
	INSERT INTO test_play_list SET
		uid = p_uid,
		bunbong = p_bunbong,
		second1 = p_second1,
		second2 = p_second2,
		second3 = p_second3,
		second4 = p_second4,
		enter = p_enter,
		cancel = p_cancel,
		profit = p_profit,
		stopLoss = p_stopLoss,
		minimumOrderST = p_minimumOrderST,
		m_cancelStopLoss = p_m_cancelStopLoss,
		m_profit = p_m_profit,
		trendOrderST = p_trendOrderST,
		t_cancelStopLoss = p_t_cancelStopLoss,
		t_profit = p_t_profit,
		t_chase = p_t_chase,
		signalType = p_signalType,
		alarmSignalST = p_alarmSignalST,
		alarmResultST = p_alarmResultST,
		orderSize = p_orderSize,
		
		t_autoST = p_t_autoST,
		t_ST = p_t_ST,
		t_direct = p_t_direct,
		type = p_type,
		
		direct1ST = p_direct1ST,
		direct2ST = p_direct2ST;
		
-- 		t_long = p_t_long,
-- 		t_short = p_t_short,
-- 		t_same = p_t_same,
-- 		t_sameST = p_t_sameST;
		
	SELECT LAST_INSERT_ID() AS id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ALL_INIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ALL_INIT`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ALL_INIT`()
BEGIN	
	UPDATE live_play_list SET 
		r_tid = null,
		r_oid = null,
	
		r_m_st = 'N',
		r_t_st = 'N',
		r_t_tick = 0,
		r_t_cnt = 0,
		r_tempPrice = null,
		r_signalType = null,
		r_signalPrice = null,
		r_signalTime = null,
		r_exactPrice = null,
		r_exactTime = null,
		
		r_exact_cnt = 0,
		r_profit_cnt = 0,
		r_profit_tick = 0,
		r_stop_cnt = 0,
		r_stop_tick = 0,
		r_forcing_cnt = 0,
		r_forcing_tick = 0,
		r_real_tick = null,
		r_pol_tick = 0,
		r_charge = 0,
		r_pol_sum = 0,
		
		r_profitPrice = 0,
		r_profitTime = null,
		r_stopPrice = 0,
		r_stopTime = null,
		r_endPrice = 0,
		r_endTime = null;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_AUTO_SET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_AUTO_SET`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_AUTO_SET`(IN `p_id` int(11),
	IN `p_autoST` char(1))
BEGIN	
	UPDATE live_play_list SET
		autoST = p_autoST
	WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_DETAIL_ITEM
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_DETAIL_ITEM`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_DETAIL_ITEM`(IN `p_id` int(11))
BEGIN	
	SELECT *
	FROM live_play_list
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_DETAIL_LOG
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_DETAIL_LOG`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_DETAIL_LOG`(IN `p_pid` int(11),
	IN `pg` INT,
	IN `block` INT)
BEGIN	
	SELECT SQL_CALC_FOUND_ROWS *
	FROM live_play_log
	WHERE 
		pid = p_pid
-- 		AND (
-- 			CASE
-- 				WHEN (TIME(NOW()) BETWEEN '09:00:00' AND '23:59:59')
--         THEN (closeTime >= DATE_ADD(CURRENT_DATE(), INTERVAL 9 HOUR) AND closeTime < DATE_ADD(CURRENT_DATE(), INTERVAL 30 HOUR))
--         ELSE (closeTime >= DATE_ADD(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY), INTERVAL 9 HOUR) AND closeTime < DATE_ADD(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY), INTERVAL 30 HOUR))
-- 			END
-- 		)
	ORDER BY id DESC
	LIMIT pg, block;
	
	SELECT FOUND_ROWS() AS totalCount;
	
	
	SELECT 
		COUNT(*) AS exact_cnt,
		COUNT(CASE WHEN st = 'PROFIT' THEN 1 END) AS profit_cnt,
		COUNT(CASE WHEN st = 'STOP' THEN 1 END) AS stop_cnt,
		COUNT(CASE WHEN st = 'FORCING' THEN 1 END) AS forcing_cnt,
		SUM(pol_tick) AS pol_tick,
		SUM(charge) AS charge,
		SUM(pol_sum) AS pol_sum
	FROM live_play_log
	WHERE 
		pid = p_pid
-- 		AND (
-- 			CASE
-- 				WHEN (TIME(NOW()) BETWEEN '09:00:00' AND '23:59:59')
--         THEN (closeTime >= DATE_ADD(CURRENT_DATE(), INTERVAL 9 HOUR) AND closeTime < DATE_ADD(CURRENT_DATE(), INTERVAL 30 HOUR))
--         ELSE (closeTime >= DATE_ADD(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY), INTERVAL 9 HOUR) AND closeTime < DATE_ADD(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY), INTERVAL 30 HOUR))
-- 			END
-- 		)
		;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_DETAIL_TAP
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_DETAIL_TAP`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_DETAIL_TAP`(IN `p_id` int(11),
	IN `p_detailTap` char(1))
BEGIN	
	UPDATE live_play_list SET
		detailTap = p_detailTap
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_EDIT`(IN `p_id` int(11),
	IN `p_symbol` char(20),
	IN `p_bunbong` char(10),
	IN `p_second1` char(10),
	IN `p_second2` char(10),
	IN `p_second3` char(10),
	IN `p_second4` char(10),
	IN `p_enter` DOUBLE(15,10),
	IN `p_cancel` DOUBLE(15,10),
	IN `p_profit` DOUBLE(15,10),
	IN `p_stopLoss` DOUBLE(15,10),
	
	IN `p_leverage` DOUBLE(15,2),
	IN `p_margin` DOUBLE(15,2),
	
	IN `p_minimumOrderST` char(1),
	IN `p_m_cancelStopLoss` DOUBLE(15,10),
	IN `p_m_profit` DOUBLE(15,10),
	IN `p_trendOrderST` char(1),
	IN `p_t_cancelStopLoss` DOUBLE(15,10),
	IN `p_t_profit` DOUBLE(15,10),
	IN `p_t_chase` DOUBLE(15,10),
	IN `p_signalType` char(5),
	IN `p_alarmSignalST` char(1),
	IN `p_alarmResultST` char(1),
	IN `p_orderSize` int(11),
	
	IN `p_t_autoST` char(1),
	IN `p_t_ST` char(1),
	IN `p_t_direct` char(1),
	IN `p_type` char(10),
	
	
	IN `p_direct1ST` char(1),
	IN `p_direct2ST` char(1))
BEGIN	
	UPDATE live_play_list SET 
		symbol = p_symbol,
		bunbong = p_bunbong,
		second1 = p_second1,
		second2 = p_second2,
		second3 = p_second3,
		second4 = p_second4,
		enter = p_enter,
		cancel = p_cancel,
		profit = p_profit,
		stopLoss = p_stopLoss,
		
		leverage = p_leverage,
		margin = p_margin,
		
		minimumOrderST = p_minimumOrderST,
		m_cancelStopLoss = p_m_cancelStopLoss,
		m_profit = p_m_profit,
		trendOrderST = p_trendOrderST,
		t_cancelStopLoss = p_t_cancelStopLoss,
		t_profit = p_t_profit,
		t_chase = p_t_chase,
		signalType = p_signalType,
		alarmSignalST = p_alarmSignalST,
		alarmResultST = p_alarmResultST,
		orderSize = p_orderSize,
		
		
		t_autoST = p_t_autoST,
		t_ST = p_t_ST,
		t_direct = p_t_direct,
		type = p_type,
		
		direct1ST = p_direct1ST,
		direct2ST = p_direct2ST
-- 		t_long = p_t_long,
-- 		t_short = p_t_short,
-- 		t_same = p_t_same,
-- 		t_sameST = p_t_sameST
		
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_INIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_INIT`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_INIT`(IN `p_id` int(11))
BEGIN	
-- 	DELETE FROM play_list WHERE id = p_id;
	UPDATE live_play_list SET 
		`status` = 'READY',
		r_tid = null,
		r_oid = null,
		
		
		r_m_st = 'N',
		r_t_st = 'N',
		r_t_tick = 0,
		r_t_cnt = 0,
		r_tempPrice = null,
		r_signalType = null,
		r_signalPrice = null,
		r_signalTime = null,
		r_exactPrice = null,
		r_exactTime = null,
		r_profitPrice = null,
-- 		r_profitTime = null,
		r_stopPrice = null,
		
		
		
-- 		r_stopTime = null,
-- 		r_endPrice = null,
-- 		r_endTime = null,
-- 		r_profit_tick = null,
-- 		r_stop_tick = 0,
-- 		r_forcing_tick = 0,

		r_real_tick = 0,
		
		r_minQty = 0,
		r_qty = 0,
		r_margin = 0,
		r_t_charge = 0
	WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_INIT2
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_INIT2`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_INIT2`()
BEGIN	
	UPDATE live_play_list SET 
		r_tid = null,
		r_oid = null,
	
		r_m_st = 'N',
		r_t_st = 'N',
		r_t_tick = 0,
		r_t_cnt = 0,
		r_tempPrice = null,
		r_signalType = null,
		r_signalPrice = null,
		r_signalTime = null,
		r_exactPrice = null,
		r_exactTime = null,
		
		r_exact_cnt = 0,
		r_profit_cnt = 0,
		r_profit_tick = 0,
		r_stop_cnt = 0,
		r_stop_tick = 0,
		r_forcing_cnt = 0,
		r_forcing_tick = 0,
		r_real_tick = null,
		r_pol_tick = 0,
		r_charge = 0,
		r_pol_sum = 0,
		
		r_profitPrice = 0,
		r_profitTime = null,
		r_stopPrice = 0,
		r_stopTime = null,
		r_endPrice = 0,
		r_endTime = null,
		
		r_qty = 0,
		r_minQty = 0,
		r_margin = 0,
		r_t_charge = 0,
		
		algoId = null;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_INIT3
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_INIT3`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_INIT3`(IN `p_id` int(11))
BEGIN	
-- 	DELETE FROM play_list WHERE id = p_id;
	UPDATE live_play_list SET 
		r_tid = null,
		r_oid = null,
		
		
		r_m_st = 'N',
		r_t_st = 'N',
		r_t_tick = 0,
		r_t_cnt = 0,
		r_tempPrice = null,
		r_exactPrice = null,
		r_exactTime = null,
		r_profitPrice = null,
		r_stopPrice = null,
		

		r_real_tick = 0,
		
		r_minQty = 0,
		r_qty = 0,
		r_margin = 0,
-- 		r_t_pnl = 0,
		r_t_charge = 0,
		
		algoId = null
		
	WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_LOG_LIST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_LOG_LIST`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_LOG_LIST`(IN `p_uid` int(11))
BEGIN	
-- 	select 
-- 		play.id as iid, 
-- 		a.*, 
-- 		play.bunbong, 
-- 		play.autoST, 
-- 		play.enter, 
-- 		a.signalPrice, 
-- 		play.signalType as p_signalType, 
-- 		play.type, 
-- 		a.exactPrice, 
-- 		play.orderSize, 
-- 		play.trendOrderST, 
-- 		play.minimumOrderST,
-- 		play.detailTap,
-- 		play.selectST
-- 	from play_list play
-- 	left join (
-- 		select b.*, a.st, a.real_tick, signalPrice, a.exactPrice, a.signalType
-- 		from play_log a
-- 		inner join (
-- 			select 
-- 				max(id) as id,
-- 				pid,
-- 				sum(profit_tick) as profit_tick,
-- 				sum(stop_tick) as stop_tick,
-- 				
-- 				sum(exact_cnt) as exact_cnt,
-- 				sum(profit_cnt) as profit_cnt,
-- 				sum(stop_cnt) as stop_cnt,
-- 				sum(forcing_cnt) as forcing_cnt,
-- 				sum(forcing_tick) as forcing_tick,
-- 				sum(charge) as charge, 
-- 				sum(pol_tick) as pol_tick,
-- 				sum(pol_sum) as pol_sum
-- 			from play_log
-- 			group by pid
-- 		) as b on a.id = b.id
-- 		where a.uid = p_uid
-- 	) a on a.pid = play.id
-- 	WHERE play.st <> 'DEL' AND play.uid = p_uid;
-- 	
-- 	
	
	SELECT
		*
	FROM live_play_list play
	WHERE play.uid = p_uid AND del_st = 'N';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_POL_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_POL_GET`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_POL_GET`(IN `p_uid` int(11))
BEGIN	
	SELECT SUM(r_pol_sum) AS pol_sum
	FROM live_play_list
	WHERE uid = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_PRICE_SET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_PRICE_SET`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_PRICE_SET`(IN `p_id` int(11),
	IN `p_price` DOUBLE(30, 10))
BEGIN	
	UPDATE admin_member SET
		live_price = p_price
	WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_SELECT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_SELECT`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_SELECT`(IN `p_id` int(11),
	IN `p_selectST` char(1))
BEGIN	
	UPDATE live_play_list SET
		selectST = p_selectST
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_SET_ST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_SET_ST`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_SET_ST`(IN `p_id` int(11),
	IN `p_st` char(20),
	IN `p_status` char(20))
BEGIN	
-- 	DELETE FROM play_list WHERE id = p_id;
	UPDATE live_play_list SET 
		st = p_st,
		`status` = p_status
	WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_SET_ST2
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_SET_ST2`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_SET_ST2`(IN `p_id` int(11),
	IN `p_st` char(20),
	IN `p_status` char(20),
	IN `p_autoST` char(1))
BEGIN	
-- 	DELETE FROM play_list WHERE id = p_id;
	UPDATE live_play_list SET 
		st = p_st,
		`status` = p_status,
		autoST = p_autoST
	WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_START_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_START_GET`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_START_GET`()
BEGIN	
	SELECT p.*, l.resLine, l.subLine
	FROM live_play_list p
	LEFT JOIN line_list l ON p.symbol = l.symbol AND p.uid = l.uid
	WHERE st = 'START' 
		AND `status` IN ('EXACT_WAIT', 'CANCEL_WAIT', 'EXACT', 'READY')
		OR `status` IN ('FORCING_WAIT', 'FORCING');
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_STOCH_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_STOCH_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_STOCH_EDIT`(IN `p_id` int(11),
	IN `p_uuid` char(20))
BEGIN	
	UPDATE live_play_list SET
		stoch_id = p_uuid
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_STOCH_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_STOCH_GET`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_STOCH_GET`()
BEGIN	
	SELECT id, bunbong, `type`, second2, second3, second4 
	FROM live_play_list;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_STOP
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_STOP`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_STOP`(IN `p_id` int(11))
BEGIN	
-- 	DELETE FROM play_list WHERE id = p_id;
	UPDATE live_play_list SET 
		`st` = 'STOP',
		`status` = 'READY',
		autoST = 'N'
	WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_ALGO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_ALGO`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_ALGO`(IN `p_id` int(11),
	IN `p_algoId` CHAR(36))
BEGIN	
	UPDATE live_play_list SET
		algoId = p_algoId
	WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_CLOSE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_CLOSE`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_CLOSE`(IN `p_uid` int(11),
	IN `p_pid` int(11),
	IN `p_tid` char(20),
	IN `p_oid` char(20),
	IN `p_st` char(20),
	IN `p_signalType` char(5),
	IN `p_signalPrice` double(15,10),
	IN `p_signalTime` datetime,
	IN `p_openPrice` double(15,10),
	IN `p_closePrice` double(15,10),
	
	IN `p_pol_tick` DOUBLE(15,10),
	IN `p_pol_sum` double(15,10),
	
	IN `p_charge` DOUBLE(15,10),
	IN `p_openTime` datetime,
	IN `p_closeTime` datetime)
BEGIN	
	INSERT INTO live_play_log SET
			uid = p_uid,
			pid = p_pid,
			tid = p_tid,
			oid = p_oid,
			st = p_st,
			signalType = p_signalType,
			signalPrice = p_signalPrice,
			signalTime = p_signalTime,
			openPrice = p_openPrice,
			closePrice = p_closePrice,
			pol_tick = p_pol_tick,
			pol_sum = p_pol_sum,
			charge = p_charge*2,
			openTime = p_openTime,
			closeTime = p_closeTime;
			
	UPDATE live_play_list SET
			r_pol_tick = r_pol_tick + p_pol_tick,
			r_charge = r_charge + p_charge,
			r_pol_sum = r_pol_sum + p_pol_sum,
			
			r_profit_cnt = CASE WHEN p_st = 'PROFIT' THEN r_profit_cnt + 1 ELSE r_profit_cnt END,
			r_profit_tick = CASE WHEN p_st = 'PROFIT' THEN r_profit_tick + p_pol_tick ELSE r_profit_tick END,

			r_stop_cnt = CASE WHEN p_st = 'LOSS' THEN r_stop_cnt + 1 ELSE r_stop_cnt END,
			r_stop_tick = CASE WHEN p_st = 'LOSS' THEN r_stop_tick + p_pol_tick ELSE r_stop_tick END,

			r_forcing_cnt = CASE WHEN p_st = 'FORCING' THEN r_forcing_cnt + 1 ELSE r_forcing_cnt END,
			r_forcing_tick = CASE WHEN p_st = 'FORCING' THEN r_forcing_tick + p_pol_tick ELSE r_forcing_tick END
			
	WHERE id = p_pid;
	
	UPDATE admin_member SET
		price = price + (p_pol_sum - p_charge)
	WHERE id = p_uid;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_EDIT`(IN `p_id` int(11),
	IN `p_st` char(20))
BEGIN	
	UPDATE live_play_list SET 
			`status` = p_st
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_EXACT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_EXACT`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_EXACT`(IN `p_id` int(11),
	IN `p_uid` int(11),
	IN `p_exactPrice` DOUBLE(15,10),
	IN `p_tid` char(12),
	IN `p_charge` DOUBLE(15,10))
BEGIN	
	UPDATE live_play_list SET 
			`status` = 'EXACT',
			r_tid = p_tid,
			r_exactPrice = p_exactPrice,
			r_exact_cnt = r_exact_cnt + 1,
			r_exactTime = NOW(),
			r_charge = r_charge + p_charge
	WHERE id = p_id;
	
	UPDATE admin_member SET
		price = price - p_charge
	WHERE id = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_EXACT_WAIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_EXACT_WAIT`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_EXACT_WAIT`(IN `p_pid` int(11),
	IN `p_tid` char(12),
-- 	IN `p_tempPrice` double(15,3),
	IN `p_signalPrice` double(30,10),
	IN `p_signalType` char(5))
BEGIN	
	UPDATE live_play_list SET 
		r_tid = p_tid,
		st = 'START',
		`status` = 'EXACT_WAIT',
-- 		r_tempPrice = p_tempPrice,
		
		r_signalType = p_signalType,
		r_signalPrice = p_signalPrice,
		r_signalTime = NOW()
	WHERE id = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_NEW_CLOSE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_NEW_CLOSE`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_NEW_CLOSE`(IN `p_uid` int(11),
	IN `p_pid` int(11),
	IN `p_tid` char(36),
	IN `p_oid` char(36),
	IN `p_st` char(20),
	
	IN `p_symbol` char(20),	-- 250905 추가
	IN `p_leverage` char(20),	-- 250905 추가
	IN `p_margin` char(20),	-- 250905 추가
	IN `p_positionSize` char(20),	-- 250905 추가
	
	IN `p_type` char(20),	-- 251127 추가
	IN `p_bunbong` char(20),	-- 251127 추가
	
	IN `p_signalType` char(5),
	IN `p_signalPrice` double(30,10),
	IN `p_signalTime` datetime,
	IN `p_openPrice` double(30,10),
	IN `p_closePrice` double(30,10),
	
	IN `p_pol_tick` DOUBLE(30,10),
	IN `p_pol_sum` double(30,10),
	
	IN `p_win` int(11),
	IN `p_loss` int(11),
	
	IN `p_charge` DOUBLE(30,10),
	IN `p_charge2` DOUBLE(30,10),
	
	IN `p_openTime` datetime,
	IN `p_closeTime` datetime)
BEGIN	
	INSERT INTO live_play_log SET
			uid = p_uid,
			pid = p_pid,
			tid = p_tid,
			oid = p_oid,
			st = p_st,
			signalType = p_signalType,
			signalPrice = p_signalPrice,
			signalTime = p_signalTime,
			openPrice = p_openPrice,
			closePrice = p_closePrice,
			pol_tick = p_pol_tick,
			pol_sum = p_pol_sum,
			charge = p_charge2,
			openTime = p_openTime,
			closeTime = p_closeTime,
			
			symbol = p_symbol,
			leverage = p_leverage,
			margin = p_margin,
			positionSize = p_positionSize,
			
			win_loss = CASE WHEN p_win IS TRUE THEN 'Win' ELSE 'Lose' END,
			bunbong = p_bunbong,
			`type`	= p_type;
			
	UPDATE live_play_list SET
			r_pol_tick = r_pol_tick + p_pol_tick,
			r_charge = r_charge + p_charge,
			r_pol_sum = r_pol_sum + p_pol_sum,
			
			r_profit_cnt = CASE WHEN p_st = 'PROFIT' THEN r_profit_cnt + 1 ELSE r_profit_cnt END,
			r_profit_tick = CASE WHEN p_st = 'PROFIT' THEN r_profit_tick + p_pol_tick ELSE r_profit_tick END,

			r_stop_cnt = CASE WHEN p_st = 'STOP' THEN r_stop_cnt + 1 ELSE r_stop_cnt END,
			r_stop_tick = CASE WHEN p_st = 'STOP' THEN r_stop_tick + p_pol_tick ELSE r_stop_tick END,

			r_forcing_cnt = CASE WHEN p_st = 'FORCING' THEN r_forcing_cnt + 1 ELSE r_forcing_cnt END,
			r_forcing_tick = CASE WHEN p_st = 'FORCING' THEN r_forcing_tick + p_pol_tick ELSE r_forcing_tick END
			
	WHERE id = p_pid;
	
	UPDATE admin_member SET
		price = price + (p_pol_sum - p_charge)
	WHERE id = p_uid;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_NEW_EXACT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_NEW_EXACT`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_NEW_EXACT`(IN `p_id` int(11))
BEGIN	
	UPDATE live_play_list SET 
			`status` = 'EXACT'
-- 			r_tid = p_tid
-- 			r_exactPrice = p_exactPrice,
-- 			r_exact_cnt = r_exact_cnt + 1
-- 			r_exactTime = NOW(),
-- 			r_charge = r_charge + p_charge
	WHERE id = p_id;
	
	
-- 	
-- 	UPDATE admin_member SET
-- 		price = price - p_charge
-- 	WHERE id = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_NEW_EXACT_UPDATE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_NEW_EXACT_UPDATE`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_NEW_EXACT_UPDATE`(IN `p_id` int(11),
	IN `p_uid` int(11),
	IN `p_exactPrice` DOUBLE,
	
	IN `p_qty` DOUBLE,
	IN `p_margin` DOUBLE,
	IN `p_charge` DOUBLE,
	
	IN `p_exact_cnt` INT(11))
BEGIN	
	UPDATE live_play_list SET 
			r_exactPrice = p_exactPrice,
			
			r_qty = r_qty + p_qty,
			r_margin = p_margin,
			
			r_exact_cnt = r_exact_cnt + p_exact_cnt,
			r_exactTime = NOW(),
			r_charge = r_charge + p_charge,
			r_t_charge = r_t_charge + p_charge
	WHERE id = p_id;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_NEW_EXACT_UPDATE2
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_NEW_EXACT_UPDATE2`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_NEW_EXACT_UPDATE2`(IN `p_id` int(11),
	IN `p_uid` int(11),
	IN `p_exactPrice` DOUBLE,
	
	IN `p_qty` DOUBLE,
	IN `p_margin` DOUBLE,
	IN `p_charge` DOUBLE,
	
	IN `p_r_exactTime` DATETIME)
BEGIN	
	UPDATE live_play_list SET 
			r_exactPrice = p_exactPrice,
			
			r_qty = r_qty + p_qty,
			r_margin = p_margin,
			
			r_exact_cnt = r_exact_cnt + 1,
			r_exactTime = p_r_exactTime,
			r_charge = r_charge + p_charge,
			r_t_charge = r_t_charge + p_charge
	WHERE id = p_id;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_NEW_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_NEW_GET`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_NEW_GET`(IN `p_pid` int(11))
BEGIN	
	SELECT *
	FROM live_play_list
	WHERE id = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_NEW_OID_UPDATE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_NEW_OID_UPDATE`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_NEW_OID_UPDATE`(IN `p_id` int(11),
	IN `p_oid` char(36))
BEGIN	
	UPDATE live_play_list SET
		r_oid = p_oid
	WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_NEW_SET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_NEW_SET`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_NEW_SET`(IN `p_id` int(11),
	IN `p_tid` char(36),
	IN `p_uid` char(36),
	IN `p_minQty` DOUBLE(30, 10))
BEGIN	
	UPDATE live_play_list SET
		r_tid = p_tid,
		r_id = p_uid,
-- 		r_qty = p_qty,
		r_minQty = p_minQty
-- 		r_profitPrice = p_profit,
-- 		r_stopPrice = p_stop,
-- 		r_margin = p_margin,

	WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_NEW_UPDATE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_NEW_UPDATE`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_NEW_UPDATE`(IN `p_pid` int(11),
	IN `p_charge` DOUBLE)
BEGIN	
	UPDATE live_play_list SET
			r_charge = r_charge + p_charge,
			r_t_charge = r_t_charge + p_charge
	WHERE id = p_pid;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_ST_TICK
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_ST_TICK`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_ST_TICK`(IN `p_id` int(11),
	IN `p_real_tick` DOUBLE(30, 10))
BEGIN	
	UPDATE live_play_list SET 
			r_real_tick = p_real_tick
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_T_CNT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_T_CNT`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_T_CNT`(IN `p_id` int(11),
	IN `p_t_cnt` int(11))
BEGIN	
	UPDATE live_play_list SET 
			r_t_cnt = p_t_cnt
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_T_ST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_T_ST`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_T_ST`(IN `p_id` int(11),
	IN `p_st` char(1))
BEGIN	
	UPDATE live_play_list SET 
			r_t_st = p_st
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_UUID_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_UUID_GET`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_UUID_GET`(IN `p_uuid` char(20),
	IN `p_symbol` char(20))
BEGIN	
	SELECT p.*
-- 	, m.metaId
	FROM live_play_list p
-- 	INNER JOIN admin_member m ON m.id = p.uid
	WHERE 
		(p.st = 'START' OR p.st = 'STOP')
		AND p.autoST = 'Y' 
		AND (p.`status` = 'READY' OR p.`status` = 'EXACT_WAIT' OR p.`status` = 'EXACT')
		AND p.stoch_id = p_uuid
		AND p.symbol = p_symbol
		AND p.del_st = 'N';
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_UUID_GET2
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_UUID_GET2`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_UUID_GET2`(IN `p_uuid` char(20),
	IN `p_symbol` char(20))
BEGIN	
	SELECT p.*
-- 	, m.metaId
	FROM live_play_list p
-- 	INNER JOIN admin_member m ON m.id = p.uid
	WHERE 
		(p.st = 'START' OR p.st = 'STOP')
		AND p.autoST = 'Y' 
		AND p.`status` = 'EXACT'
		
		AND stoch_id REGEXP CONCAT('^Q_[A-Z]_',p_uuid,'$')
		
		
		AND p.symbol = p_symbol
		AND p.del_st = 'N';
		
		
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_PLAY_Y_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_PLAY_Y_GET`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_PLAY_Y_GET`(IN `p_symbol` char(20),
	IN `p_bun` int(11))
BEGIN	
	SELECT *
	FROM live_play_list
	WHERE 
		autoST = 'Y' 
		AND type = 'C'
		AND bunbong LIKE CONCAT('%_',p_bun) 
		AND st = 'START'
		AND symbol = p_symbol;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_RESULT_ALL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_RESULT_ALL`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_RESULT_ALL`(IN `p_uid` int(11),
	IN `sDate` DATE,
	IN `eDate` DATE)
BEGIN	
	SELECT 
		log.id,
		log.uid,
		log.pid,
		list.a_name,
		log.symbol,
		log.`type`,
		log.bunbong,
		log.win_loss,	
		log.openPrice,
		log.openTime,
		log.closePrice,
		log.closeTime,
		log.signalType,
		log.leverage,
		log.margin,
		log.pol_sum - log.charge AS 'pol_sum'
	FROM live_play_log as log
	INNER JOIN live_play_list AS list ON log.pid = list.id
	WHERE DATE(log.closeTime) >= sDate AND DATE(log.closeTime) <= eDate AND log.uid = p_uid
	ORDER BY log.closeTime DESC;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_RESULT_DETAIL_PAGE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_RESULT_DETAIL_PAGE`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_RESULT_DETAIL_PAGE`(IN `p_uid` int(11),
	IN `p_date` CHAR(10),
	IN `pg` INT,
	IN `block` INT)
BEGIN	
	SELECT SQL_CALC_FOUND_ROWS *
	FROM live_play_log
	WHERE 
		uid = p_uid 
		AND DATE_FORMAT(closeTime,'%Y/%m/%d') = p_date 
	ORDER BY id DESC
	LIMIT pg, block;
	
	SELECT FOUND_ROWS() AS totalCount;
	
	SELECT 
		COUNT(*) AS exact_cnt,
		COUNT(CASE WHEN st = 'PROFIT' THEN 1 END) AS profit_cnt,
		COUNT(CASE WHEN st = 'STOP' THEN 1 END) AS stop_cnt,
		COUNT(CASE WHEN st = 'FORCING' THEN 1 END) AS forcing_cnt,
		SUM(pol_tick) AS pol_tick,
		SUM(charge) AS charge,
		SUM(pol_sum) AS pol_sum
	FROM live_play_log
	WHERE uid = p_uid AND DATE_FORMAT(closeTime,'%Y/%m/%d') = p_date;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_RESULT_EXACT_ALL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_RESULT_EXACT_ALL`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_RESULT_EXACT_ALL`(IN `p_uid` int(11))
BEGIN	
	SELECT id AS 'pid', a_name, r_exactTime, `type`, bunbong, margin, leverage, r_signalType, r_exactTime AS 'openTime', r_exactPrice AS 'openPrice', symbol
	FROM live_play_list
	WHERE uid = p_uid AND `status` = 'EXACT';		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_RESULT_EXPORT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_RESULT_EXPORT`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_RESULT_EXPORT`(IN `p_uid` int(11),
	IN `sDate` DATE,
	IN `eDate` DATE)
BEGIN		
		
	SELECT 
		DATE_FORMAT(log.closeTime,'%Y/%m/%d') AS '날짜',
		COUNT(log.id) AS '진입',
		IFNULL(p.profit_tick, 0) AS '익절',
		IFNULL(l.stop_tick, 0) AS '손절',
		IFNULL(f.forcing_tick, 0) AS '강제청산',
		SUM(log.pol_tick) AS '결과',
		SUM(log.charge) AS '수수료',
		SUM(log.pol_sum) - SUM(log.charge) AS '손입합계'
-- 		IFNULL(p.profit_cnt, 0) AS profit_cnt,
-- 		IFNULL(l.stop_cnt, 0) AS stop_cnt,
-- 		IFNULL(f.forcing_cnt, 0) AS forcing_cnt,
	FROM live_play_log log
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS profit_tick, count(*) AS profit_cnt
		FROM live_play_log log
		WHERE log.st = 'PROFIT' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS p ON p.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS stop_tick, count(*) AS stop_cnt
		FROM live_play_log log
		WHERE log.st = 'STOP' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS l ON l.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS forcing_tick, count(*) AS forcing_cnt
		FROM live_play_log log
		WHERE log.st = 'FORCING' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS f ON f.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	WHERE uid = p_uid
		AND (sDate <= DATE_FORMAT(closeTime, '%Y-%m-%d') AND DATE_FORMAT(closeTime, '%Y-%m-%d') <= eDate)
	GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d');

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_RESULT_ITEM
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_RESULT_ITEM`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_RESULT_ITEM`(IN `p_uid` int(11),
	IN `p_pid` int(11),
	IN `sDate` DATE,
	IN `eDate` DATE)
BEGIN	
	SELECT 
		log.id,
		log.uid,
		log.pid,
		list.a_name,
		log.symbol,
		log.`type`,
		log.bunbong,
		log.win_loss,	
		log.openPrice,
		log.openTime,
		log.closePrice,
		log.closeTime,
		log.signalType,
		log.leverage,
		log.margin,
		log.pol_sum - log.charge AS 'pol_sum'
	FROM live_play_log as log
	INNER JOIN live_play_list AS list ON log.pid = list.id
	WHERE DATE(log.closeTime) >= sDate AND DATE(log.closeTime) <= eDate AND log.pid = p_pid AND log.uid = p_uid
	ORDER BY log.closeTime DESC;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LIVE_RESULT_PAGE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LIVE_RESULT_PAGE`;
delimiter ;;
CREATE PROCEDURE `SP_LIVE_RESULT_PAGE`(IN `p_uid` int(11),
	IN `pg` INT,
	IN `block` INT,
	IN `sDate` DATE,
	IN `eDate` DATE)
BEGIN	
	
-- 	SELECT 
-- 		SQL_CALC_FOUND_ROWS DATE_FORMAT(log.closeTime,'%Y/%m/%d') AS logDate,
-- 		COUNT(log.id) AS exact_cnt,
-- 		COUNT(CASE WHEN log.st = 'PROFIT' THEN 1 END) AS profit_cnt,
-- 		COUNT(CASE WHEN log.st = 'LOSS' THEN 1 END) AS stop_cnt,
-- 		COUNT(CASE WHEN log.st = 'FORCING' THEN 1 END) AS forcing_cnt,
-- 		SUM(log.pol_tick) AS pol_tick,
-- 		SUM(log.charge) AS charge,
-- 		SUM(log.pol_sum) - SUM(log.charge) AS pol_sum,
-- 		
-- 		a.profit_tick,
-- 		b.stop_tick
-- 		
-- 	FROM live_play_log log
-- 	LEFT JOIN (
-- 		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS profit_tick
-- 		FROM live_play_log
-- 		WHERE st = 'PROFIT'
-- 		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
-- 	) AS a ON a.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
-- 	LEFT JOIN (
-- 		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS stop_tick
-- 		FROM live_play_log
-- 		WHERE st = 'LOSS'
-- 		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
-- 	) AS b ON b.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
-- 	WHERE 
-- 				uid = p_uid 
-- 				AND (
-- 				sDate <= DATE_FORMAT(closeTime, '%Y-%m-%d')
-- 				
-- 				 AND DATE_FORMAT(closeTime, '%Y-%m-%d') <= eDate
-- 				
-- 				)
-- 	GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
-- 	LIMIT pg, block;
-- 	
-- 	
	
	
	
	SELECT 
		SQL_CALC_FOUND_ROWS DATE_FORMAT(log.closeTime,'%Y/%m/%d') AS logDate,
		
		SUM(log.pol_tick) AS pol_tick,
		SUM(log.charge) AS charge,
		SUM(log.pol_sum) - SUM(log.charge) AS pol_sum,
		
		COUNT(log.id) AS exact_cnt,
		IFNULL(p.profit_cnt, 0) AS profit_cnt,
		IFNULL(l.stop_cnt, 0) AS stop_cnt,
		IFNULL(f.forcing_cnt, 0) AS forcing_cnt,
		
		IFNULL(p.profit_tick, 0) AS profit_tick,
		IFNULL(l.stop_tick, 0) AS stop_tick,
		IFNULL(f.forcing_tick, 0) AS forcing_tick
		
	FROM live_play_log log
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS profit_tick, count(*) AS profit_cnt
		FROM live_play_log log
		WHERE log.st = 'PROFIT' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS p ON p.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS stop_tick, count(*) AS stop_cnt
		FROM live_play_log log
		WHERE log.st = 'STOP' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS l ON l.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS forcing_tick, count(*) AS forcing_cnt
		FROM live_play_log log
		WHERE log.st = 'FORCING' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS f ON f.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	WHERE uid = p_uid
		AND (sDate <= DATE_FORMAT(closeTime, '%Y-%m-%d') AND DATE_FORMAT(closeTime, '%Y-%m-%d') <= eDate)
	GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	LIMIT pg, block;



	
	SELECT FOUND_ROWS() AS totalCount;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LOG_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LOG_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_LOG_ADD`(IN `p_uid` int(11),
	IN `p_pid` int(11),
  IN `p_log_id` int(11),
  IN `p_uuid` char(15),
  IN `p_db_type` varchar(50),
  IN `p_type` varchar(50),
  IN `p_st` char(20),
  IN `p_signal_price` double(15,10),
  IN `p_result_price` double(15,10),
  IN `p_bunbong` char(10),
  IN `p_second1` int(11),
  IN `p_second2` int(11),
  IN `p_second3` int(11),
  IN `p_second4` int(11),
  IN `p_signal_time` datetime)
BEGIN	
	INSERT INTO alert_log2 SET  
		uid = p_uid,
		pid = p_pid,
		log_id = p_log_id,
		uuid = p_uuid,
		db_type = p_db_type,
		type = p_type,
		st = p_st,
		signal_price = p_signal_price,
		result_price = p_result_price,
		bunbong = p_bunbong,
		second1 = p_second1,
		second2 = p_second2,
		second3 = p_second3,
		second4 = p_second4,
		signal_time = p_signal_time;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LOG_ALERT_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LOG_ALERT_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_LOG_ALERT_ADD`(IN `p_uuid` char(20),
  IN `p_db_type` varchar(50),
  IN `p_type` varchar(50),
  IN `p_symbol` varchar(50),
  IN `p_close` varchar(50),
  IN `p_time` datetime)
BEGIN	
	INSERT INTO alert_log SET  
		uuid = p_uuid,
		db_type = p_db_type,
		type = p_type,
		symbol = p_symbol,
		`close` = p_close,
		`signal_time` = p_time;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LOG_ALERT_ADD3
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LOG_ALERT_ADD3`;
delimiter ;;
CREATE PROCEDURE `SP_LOG_ALERT_ADD3`(IN `p_symbol` char(20),
	IN `p_db_type` char(10),
  IN `p_type` char(10),
  IN `p_bunbong` char(10),
  IN `p_signal_time` datetime)
BEGIN	
	INSERT INTO alert_log3 SET  
		symbol = p_symbol,
		db_type = p_db_type,
		type = p_type,
		bunbong = p_bunbong,
		signal_time = p_signal_time;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LOG_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LOG_GET`;
delimiter ;;
CREATE PROCEDURE `SP_LOG_GET`(IN `p_pid` int(11),
	IN `pg` INT,
	IN `block` INT)
BEGIN	
	SELECT SQL_CALC_FOUND_ROWS *
	FROM alert_log2
	WHERE CASE WHEN p_pid IS NOT NULL THEN (pid = p_pid) ELSE TRUE END
	ORDER BY id DESC
	LIMIT pg, block;
	
	SELECT FOUND_ROWS() AS totalCount;
	
	
	
-- 	INSERT INTO alert_log2 SET  
-- 		uid = p_uid,
-- 		log_id = p_log_id,
-- 		uuid = p_uuid,
-- 		db_type = p_db_type,
-- 		type = p_type,
-- 		st = p_st,
-- 		signal_price = p_signal_price,
-- 		result_price = p_result_price,
-- 		bunbong = p_bunbong,
-- 		second1 = p_second1,
-- 		second2 = p_second2,
-- 		second3 = p_second3,
-- 		second4 = p_second4,
-- 		signal_time = p_signal_time;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_LS_OVC_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_LS_OVC_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_LS_OVC_ADD`(IN `p_symbol` char(8),
	IN `p_ovsdate` datetime,
	IN `p_kordate` datetime,
	IN `p_curpr` double(15,3),
	IN `p_ydiffpr` double(15,3),
	IN `p_ydiffSign` char(1),
	IN `p_open` double(15,3),
	IN `p_high` double(15,3),
	IN `p_low` double(15,3),
	IN `p_chgrate` double(15,3),
	IN `p_trdq` int(11),
	IN `p_totq` int(11),
	IN `p_cgubun` char(1),
	IN `p_mdvolume` int(11),
	IN `p_msvolume` int(11),
	IN `p_ovsmkend` date)
BEGIN	
	INSERT INTO ls_log_ovc SET
		symbol = p_symbol,
    ovsdate = p_ovsdate,
    kordate = p_kordate,
    curpr = p_curpr,
    ydiffpr = p_ydiffpr,
    ydiffSign = p_ydiffSign,
    open = p_open,
    high = p_high,
    low = p_low,
    chgrate = p_chgrate,
    trdq = p_trdq,
    totq = p_totq,
    cgubun = p_cgubun,
    mdvolume = p_mdvolume,
    msvolume = p_msvolume,
    ovsmkend = p_ovsmkend;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MSG_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MSG_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_MSG_ADD`(IN `p_fun` char(20),
	IN `p_code` char(20),
	IN `p_msg` longtext,
	IN `p_uid` int(11),
	IN `p_pid` int(11),
	IN `p_tid` char(12),
	IN `p_symbol` char(20),
	IN `p_side` char(5))
BEGIN	
	INSERT INTO msg_list SET 
		`fun` = p_fun,
		`code` = p_code,
		`msg` = p_msg,
		`uid` = p_uid,
		`pid` = p_pid,
		`tid` = p_tid,
		`symbol` = p_symbol,
		`side` = p_side;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MSG_CNT_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MSG_CNT_GET`;
delimiter ;;
CREATE PROCEDURE `SP_MSG_CNT_GET`(IN `p_uid` int(11))
BEGIN	
	SELECT count(*) AS msg_cnt
	FROM msg_list m
	WHERE m.uid = p_uid AND m.pid IS NOT NULL AND m.st = 'N';
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MSG_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MSG_GET`;
delimiter ;;
CREATE PROCEDURE `SP_MSG_GET`(IN `p_uid` int(11),
	IN `pg` INT,
	IN `block` INT)
BEGIN	
	SELECT SQL_CALC_FOUND_ROWS l.a_name, m.*
	FROM msg_list m
	INNER JOIN live_play_list l ON l.id = m.pid
	WHERE m.uid = p_uid
	ORDER BY m.id DESC
	LIMIT pg, block;
	
	SELECT FOUND_ROWS() AS totalCount;
	
-- 	UPDATE msg_list SET
-- 		st = 'Y'
-- 	WHERE uid = p_uid AND st = 'N';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MSG_ONE_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MSG_ONE_GET`;
delimiter ;;
CREATE PROCEDURE `SP_MSG_ONE_GET`(IN `p_uid` int(11))
BEGIN	
	SELECT l.a_name, m.*
	FROM msg_list m
	INNER JOIN live_play_list l ON l.id = m.pid
	WHERE m.uid = p_uid AND m.pid IS NOT NULL AND m.st = 'N'
	ORDER BY id DESC
	LIMIT 1;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_MSG_PLAY_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_MSG_PLAY_GET`;
delimiter ;;
CREATE PROCEDURE `SP_MSG_PLAY_GET`(IN `p_uid` int(11),
	IN `p_pid` int(11))
BEGIN	
	SELECT l.a_name, m.*
	FROM msg_list m
	INNER JOIN live_play_list l ON l.id = m.pid
	WHERE m.uid = p_uid AND m.pid = p_pid
	ORDER BY m.id DESC;
	
	UPDATE msg_list SET
		st = 'Y'
	WHERE uid = p_uid AND pid = p_pid AND st = 'N';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ORDER_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ORDER_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_ORDER_ADD`(IN `p_st` char(20),
	IN `p_uid` int(11),
	IN `p_pid` int(11),
	IN `p_symbol` char(20),
	IN `p_side` char(5),
	IN `p_qty` double,
	IN `p_leverage` double,
	IN `p_margin` double,
	IN `p_endType` char(10),
	IN `p_cooltime` int(11))
BEGIN	
	INSERT INTO order_list SET 
		uid = p_uid,
		pid = p_pid,
		st = p_st,
		symbol = p_symbol,
		side = p_side,
		qty = p_qty,
		leverage = p_leverage,
		margin = p_margin,
		endType = p_endType,
		coolTime = (DATE_ADD(NOW(), INTERVAL p_cooltime SECOND));
		
	SELECT LAST_INSERT_ID() AS id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ORDER_DEL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ORDER_DEL`;
delimiter ;;
CREATE PROCEDURE `SP_ORDER_DEL`(IN `p_pid` int(11))
BEGIN	
	DELETE FROM order_list WHERE pid = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ORDER_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ORDER_GET`;
delimiter ;;
CREATE PROCEDURE `SP_ORDER_GET`()
BEGIN	

	SELECT *
	FROM order_list
	ORDER BY coolTime;
	 
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ORDER_UPDATE_ALOGO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ORDER_UPDATE_ALOGO`;
delimiter ;;
CREATE PROCEDURE `SP_ORDER_UPDATE_ALOGO`(IN `p_pid` int(11),
	IN `p_oid` CHAR(36))
BEGIN	
	UPDATE order_list SET 
		algoId = p_oid
	WHERE pid = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ORDER_UPDATE_CLOSE_OID
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ORDER_UPDATE_CLOSE_OID`;
delimiter ;;
CREATE PROCEDURE `SP_ORDER_UPDATE_CLOSE_OID`(IN `p_pid` int(11),
	IN `p_oid` LONGTEXT)
BEGIN	
	UPDATE order_list SET 
		close_oid = p_oid
	WHERE pid = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ORDER_UPDATE_C_PUSH_OID
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ORDER_UPDATE_C_PUSH_OID`;
delimiter ;;
CREATE PROCEDURE `SP_ORDER_UPDATE_C_PUSH_OID`(IN `p_pid` int(11),
	IN `p_oid` char(36))
BEGIN	
-- 	UPDATE order_list SET 
-- 		new_oid = p_oid
-- 	WHERE pid = p_pid;
	
	UPDATE order_list
	SET close_oid = JSON_ARRAY_APPEND(close_oid, '$', p_oid)
	WHERE pid = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ORDER_UPDATE_NEW_OID
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ORDER_UPDATE_NEW_OID`;
delimiter ;;
CREATE PROCEDURE `SP_ORDER_UPDATE_NEW_OID`(IN `p_pid` int(11),
	IN `p_oid` LONGTEXT)
BEGIN	
	UPDATE order_list SET 
		new_oid = p_oid
	WHERE pid = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ORDER_UPDATE_PUSH_OID
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ORDER_UPDATE_PUSH_OID`;
delimiter ;;
CREATE PROCEDURE `SP_ORDER_UPDATE_PUSH_OID`(IN `p_pid` int(11),
	IN `p_oid` char(36))
BEGIN	
-- 	UPDATE order_list SET 
-- 		new_oid = p_oid
-- 	WHERE pid = p_pid;
	
	UPDATE order_list
	SET new_oid = JSON_ARRAY_APPEND(new_oid, '$', p_oid)
	WHERE pid = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ORDER_UPDATE_RE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ORDER_UPDATE_RE`;
delimiter ;;
CREATE PROCEDURE `SP_ORDER_UPDATE_RE`(IN `p_id` int(11))
BEGIN	
	UPDATE order_list SET 
		coolTime = (DATE_ADD(NOW(), INTERVAL 3 SECOND)),
		retry = retry + 1
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ORDER_UPDATE_STATUS
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ORDER_UPDATE_STATUS`;
delimiter ;;
CREATE PROCEDURE `SP_ORDER_UPDATE_STATUS`(IN `p_pid` int(11),
	IN `p_st` char(20),
	IN `p_cooltime` int(11))
BEGIN	
	UPDATE order_list SET 
		st = p_st,
		coolTime = (DATE_ADD(NOW(), INTERVAL p_cooltime SECOND))
	WHERE pid = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ORDER_UPDATE_STATUS_CLOSE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ORDER_UPDATE_STATUS_CLOSE`;
delimiter ;;
CREATE PROCEDURE `SP_ORDER_UPDATE_STATUS_CLOSE`(IN `p_st` char(20),
	IN `p_pid` int(11),
	IN `p_qty` double,
	IN `p_endType` char(10),
	IN `p_cooltime` int(11))
BEGIN	
	UPDATE order_list SET 
		st = p_st,
		qty = p_qty,
		endType = p_endType,
		coolTime = (DATE_ADD(NOW(), INTERVAL p_cooltime SECOND))
	WHERE pid = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_S_PLAY_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_S_PLAY_GET`;
delimiter ;;
CREATE PROCEDURE `SP_S_PLAY_GET`()
BEGIN	

	SELECT *
	FROM play_list
	WHERE st IN ('IDLE', 'DEL', 'EDIT');
	 
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_S_PLAY_READY
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_S_PLAY_READY`;
delimiter ;;
CREATE PROCEDURE `SP_S_PLAY_READY`(IN `p_pid` int(11),
	IN `p_uid` int(11))
BEGIN	
	UPDATE play_list SET 
		st = 'READY'
-- 		signalPrice = p_signalPrice,
-- 		entryPrice = p_entryPrice,
-- 		exactPrice = p_exactPrice
	WHERE id = p_pid AND uid = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_EVENT_LOG_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_EVENT_LOG_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_EVENT_LOG_ADD`(IN `p_uid` int(11),
	IN `p_pid` int(11),
	IN `p_tid` char(10),
	IN `p_oid` char(10),
	IN `p_event_type`  char(20),
	IN `p_old_st`  char(20),
	IN `p_new_st`  char(20),
	IN `p_old_status`  char(20),
	IN `p_new_status`  char(20),
	IN `p_signalType`  char(5),
	IN `p_signalPrice` double(15,10),
	IN `p_signalTime` datetime)
BEGIN	
	INSERT INTO event_log SET
		uid = p_uid,
		pid = p_pid,
		tid = p_tid,
		oid = p_oid,
		event_type = p_event_type,
		old_st = p_old_st,
		new_st = p_new_st,
		old_status = p_old_status,
		new_status = p_new_status,
		signalType = p_signalType,
		signalPrice = p_signalPrice,
		signalTime = p_signalTime;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ALL_INIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ALL_INIT`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ALL_INIT`()
BEGIN	
	UPDATE test_play_list SET 
		r_tid = null,
		r_oid = null,
		
		
		r_m_st = 'N',
		r_t_st = 'N',
		r_t_tick = 0,
		r_t_cnt = 0,
		r_tempPrice = null,
		r_signalType = null,
		r_signalPrice = null,
		r_signalTime = null,
		r_exactPrice = null,
		r_exactTime = null,
		
		r_exact_cnt = 0,
		r_profit_cnt = 0,
		r_profit_tick = 0,
		r_stop_cnt = 0,
		r_stop_tick = 0,
		r_forcing_cnt = 0,
		r_forcing_tick = 0,
		r_real_tick = null,
		r_pol_tick = 0,
		r_charge = 0,
		r_pol_sum = 0,
		
		r_profitPrice = 0,
		r_profitTime = null,
		r_stopPrice = 0,
		r_stopTime = null,
		r_endPrice = 0,
		r_endTime = null;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_AUTO_SET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_AUTO_SET`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_AUTO_SET`(IN `p_id` int(11),
	IN `p_autoST` char(1))
BEGIN	
	UPDATE test_play_list SET
		autoST = p_autoST
	WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_DETAIL_ITEM
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_DETAIL_ITEM`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_DETAIL_ITEM`(IN `p_id` int(11))
BEGIN	
	SELECT *
	FROM test_play_list
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_DETAIL_LOG
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_DETAIL_LOG`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_DETAIL_LOG`(IN `p_pid` int(11),
	IN `pg` INT,
	IN `block` INT)
BEGIN	
	SELECT SQL_CALC_FOUND_ROWS *
	FROM test_play_log
	WHERE 
		pid = p_pid
-- 		AND (
-- 			CASE
-- 				WHEN (TIME(NOW()) BETWEEN '09:00:00' AND '23:59:59')
--         THEN (closeTime >= DATE_ADD(CURRENT_DATE(), INTERVAL 9 HOUR) AND closeTime < DATE_ADD(CURRENT_DATE(), INTERVAL 30 HOUR))
--         ELSE (closeTime >= DATE_ADD(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY), INTERVAL 9 HOUR) AND closeTime < DATE_ADD(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY), INTERVAL 30 HOUR))
-- 			END
-- 		)
	ORDER BY id DESC
	LIMIT pg, block;
	
	SELECT FOUND_ROWS() AS totalCount;
	
	
	SELECT 
		COUNT(*) AS exact_cnt,
		COUNT(CASE WHEN st = 'PROFIT' THEN 1 END) AS profit_cnt,
		COUNT(CASE WHEN st = 'STOP' THEN 1 END) AS stop_cnt,
		COUNT(CASE WHEN st = 'FORCING' THEN 1 END) AS forcing_cnt,
		SUM(pol_tick) AS pol_tick,
		SUM(charge) AS charge,
		SUM(pol_sum) AS pol_sum
	FROM test_play_log
	WHERE 
		pid = p_pid
-- 		AND (
-- 			CASE
-- 				WHEN (TIME(NOW()) BETWEEN '09:00:00' AND '23:59:59')
--         THEN (closeTime >= DATE_ADD(CURRENT_DATE(), INTERVAL 9 HOUR) AND closeTime < DATE_ADD(CURRENT_DATE(), INTERVAL 30 HOUR))
--         ELSE (closeTime >= DATE_ADD(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY), INTERVAL 9 HOUR) AND closeTime < DATE_ADD(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY), INTERVAL 30 HOUR))
-- 			END
-- 		)
		;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_DETAIL_TAP
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_DETAIL_TAP`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_DETAIL_TAP`(IN `p_id` int(11),
	IN `p_detailTap` char(1))
BEGIN	
	UPDATE test_play_list SET
		detailTap = p_detailTap
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_EDIT`(IN `p_id` int(11),
	IN `p_symbol` char(20),
	IN `p_bunbong` char(10),
	IN `p_second1` char(10),
	IN `p_second2` char(10),
	IN `p_second3` char(10),
	IN `p_second4` char(10),
	IN `p_enter` DOUBLE(15,10),
	IN `p_cancel` DOUBLE(15,10),
	IN `p_profit` DOUBLE(15,10),
	IN `p_stopLoss` DOUBLE(15,10),
	
	IN `p_leverage` DOUBLE(15,2),
	IN `p_margin` DOUBLE(15,2),
	
	IN `p_minimumOrderST` char(1),
	IN `p_m_cancelStopLoss` DOUBLE(15,10),
	IN `p_m_profit` DOUBLE(15,10),
	IN `p_trendOrderST` char(1),
	IN `p_t_cancelStopLoss` DOUBLE(15,10),
	IN `p_t_profit` DOUBLE(15,10),
	IN `p_t_chase` DOUBLE(15,10),
	IN `p_signalType` char(5),
	IN `p_alarmSignalST` char(1),
	IN `p_alarmResultST` char(1),
	IN `p_orderSize` int(11),
	
	IN `p_t_autoST` char(1),
	IN `p_t_ST` char(1),
	IN `p_t_direct` char(1),
	IN `p_type` char(10),
	
	
	IN `p_direct1ST` char(1),
	IN `p_direct2ST` char(1))
BEGIN	
	UPDATE test_play_list SET 
		symbol = p_symbol,
		bunbong = p_bunbong,
		second1 = p_second1,
		second2 = p_second2,
		second3 = p_second3,
		second4 = p_second4,
		enter = p_enter,
		cancel = p_cancel,
		profit = p_profit,
		stopLoss = p_stopLoss,
		
		leverage = p_leverage,
		margin = p_margin,
		
		minimumOrderST = p_minimumOrderST,
		m_cancelStopLoss = p_m_cancelStopLoss,
		m_profit = p_m_profit,
		trendOrderST = p_trendOrderST,
		t_cancelStopLoss = p_t_cancelStopLoss,
		t_profit = p_t_profit,
		t_chase = p_t_chase,
		signalType = p_signalType,
		alarmSignalST = p_alarmSignalST,
		alarmResultST = p_alarmResultST,
		orderSize = p_orderSize,
		
		
		t_autoST = p_t_autoST,
		t_ST = p_t_ST,
		t_direct = p_t_direct,
		type = p_type,
		
		direct1ST = p_direct1ST,
		direct2ST = p_direct2ST
-- 		t_long = p_t_long,
-- 		t_short = p_t_short,
-- 		t_same = p_t_same,
-- 		t_sameST = p_t_sameST
		
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_INIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_INIT`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_INIT`(IN `p_id` int(11))
BEGIN	
-- 	DELETE FROM play_list WHERE id = p_id;
	UPDATE test_play_list SET 
		`status` = 'READY',
		r_tid = null,
		r_oid = null,
		
		
		r_m_st = 'N',
		r_t_st = 'N',
		r_t_tick = 0,
		r_t_cnt = 0,
		r_tempPrice = null,
		r_signalType = null,
		r_signalPrice = null,
		r_signalTime = null,
		r_exactPrice = null,
		r_exactTime = null,
		r_profitPrice = null,
-- 		r_profitTime = null,
		r_stopPrice = null,
		
		
		
-- 		r_stopTime = null,
-- 		r_endPrice = null,
-- 		r_endTime = null,
-- 		r_profit_tick = null,
-- 		r_stop_tick = 0,
-- 		r_forcing_tick = 0,

		r_real_tick = 0,
		
		r_minQty = 0,
		r_qty = 0,
		r_margin = 0,
		r_t_charge = 0
	WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_INIT2
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_INIT2`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_INIT2`()
BEGIN	
	UPDATE test_play_list SET 
		r_tid = null,
		r_oid = null,
		
		
		r_m_st = 'N',
		r_t_st = 'N',
		r_t_tick = 0,
		r_t_cnt = 0,
		r_tempPrice = null,
		r_signalType = null,
		r_signalPrice = null,
		r_signalTime = null,
		r_exactPrice = null,
		r_exactTime = null,
		
		r_exact_cnt = 0,
		r_profit_cnt = 0,
		r_profit_tick = 0,
		r_stop_cnt = 0,
		r_stop_tick = 0,
		r_forcing_cnt = 0,
		r_forcing_tick = 0,
		r_real_tick = null,
		r_pol_tick = 0,
		r_charge = 0,
		r_pol_sum = 0,
		
		r_profitPrice = 0,
		r_profitTime = null,
		r_stopPrice = 0,
		r_stopTime = null,
		r_endPrice = 0,
		r_endTime = null,
		
		r_qty = 0,
		r_minQty = 0,
		r_margin = 0,
		r_t_charge = 0;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_LOG_LIST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_LOG_LIST`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_LOG_LIST`(IN `p_uid` int(11))
BEGIN	
-- 	select 
-- 		play.id as iid, 
-- 		a.*, 
-- 		play.bunbong, 
-- 		play.autoST, 
-- 		play.enter, 
-- 		a.signalPrice, 
-- 		play.signalType as p_signalType, 
-- 		play.type, 
-- 		a.exactPrice, 
-- 		play.orderSize, 
-- 		play.trendOrderST, 
-- 		play.minimumOrderST,
-- 		play.detailTap,
-- 		play.selectST
-- 	from play_list play
-- 	left join (
-- 		select b.*, a.st, a.real_tick, signalPrice, a.exactPrice, a.signalType
-- 		from play_log a
-- 		inner join (
-- 			select 
-- 				max(id) as id,
-- 				pid,
-- 				sum(profit_tick) as profit_tick,
-- 				sum(stop_tick) as stop_tick,
-- 				
-- 				sum(exact_cnt) as exact_cnt,
-- 				sum(profit_cnt) as profit_cnt,
-- 				sum(stop_cnt) as stop_cnt,
-- 				sum(forcing_cnt) as forcing_cnt,
-- 				sum(forcing_tick) as forcing_tick,
-- 				sum(charge) as charge, 
-- 				sum(pol_tick) as pol_tick,
-- 				sum(pol_sum) as pol_sum
-- 			from play_log
-- 			group by pid
-- 		) as b on a.id = b.id
-- 		where a.uid = p_uid
-- 	) a on a.pid = play.id
-- 	WHERE play.st <> 'DEL' AND play.uid = p_uid;
-- 	
-- 	
	
	SELECT
		*
	FROM test_play_list play
	WHERE play.uid = p_uid AND del_st = 'N';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_POL_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_POL_GET`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_POL_GET`(IN `p_uid` int(11))
BEGIN	
	SELECT SUM(r_pol_sum) AS pol_sum
	FROM test_play_list
	WHERE uid = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_PRICE_SET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_PRICE_SET`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_PRICE_SET`(IN `p_id` int(11),
	IN `p_price` DOUBLE(15, 10))
BEGIN	
	UPDATE admin_member SET
		price = p_price
	WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_SELECT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_SELECT`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_SELECT`(IN `p_id` int(11),
	IN `p_selectST` char(1))
BEGIN	
	UPDATE test_play_list SET
		selectST = p_selectST
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_SET_ST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_SET_ST`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_SET_ST`(IN `p_id` int(11),
	IN `p_st` char(20),
	IN `p_status` char(20))
BEGIN	
-- 	DELETE FROM play_list WHERE id = p_id;
	UPDATE test_play_list SET 
		st = p_st,
		`status` = p_status
	WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_SET_ST2
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_SET_ST2`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_SET_ST2`(IN `p_id` int(11),
	IN `p_st` char(20),
	IN `p_status` char(20),
	IN `p_autoST` char(1))
BEGIN	
-- 	DELETE FROM play_list WHERE id = p_id;
	UPDATE test_play_list SET 
		st = p_st,
		`status` = p_status,
		autoST = p_autoST
	WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_START_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_START_GET`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_START_GET`()
BEGIN	
	SELECT p.*, l.resLine, l.subLine
	FROM test_play_list p
	LEFT JOIN line_list l ON p.symbol = l.symbol AND p.uid = l.uid
	WHERE st = 'START' 
		AND `status` IN ('EXACT_WAIT', 'CANCEL_WAIT', 'EXACT', 'READY')
		OR `status` IN ('FORCING_WAIT', 'FORCING');
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_STOCH_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_STOCH_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_STOCH_EDIT`(IN `p_id` int(11),
	IN `p_uuid` char(20))
BEGIN	
	UPDATE test_play_list SET
		stoch_id = p_uuid
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_STOCH_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_STOCH_GET`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_STOCH_GET`()
BEGIN	
	SELECT id, bunbong, `type`, second2, second3, second4 
	FROM test_play_list;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_STOP
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_STOP`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_STOP`(IN `p_id` int(11))
BEGIN	
-- 	DELETE FROM play_list WHERE id = p_id;
	UPDATE test_play_list SET 
		`st` = 'STOP',
		`status` = 'READY',
		autoST = 'N'
	WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ST_CLOSE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ST_CLOSE`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ST_CLOSE`(IN `p_uid` int(11),
	IN `p_pid` int(11),
	IN `p_tid` char(12),
	IN `p_oid` char(12),
	IN `p_st` char(20),

	IN `p_symbol` char(20),	-- 250905 추가
	IN `p_leverage` char(20),	-- 250905 추가
	IN `p_margin` char(20),	-- 250905 추가
	IN `p_positionSize` char(20),	-- 250905 추가
	
	IN `p_type` char(20),	-- 251127 추가
	IN `p_bunbong` char(20),	-- 251127 추가
	
	IN `p_signalType` char(5),
	IN `p_signalPrice` double(30,10),
	IN `p_signalTime` datetime,
	IN `p_openPrice` double(30,10),
	IN `p_closePrice` double(30,10),
	
	IN `p_pol_tick` DOUBLE(30,10),
	IN `p_pol_sum` double(30,10),
	
	IN `p_win` int(11),
	IN `p_loss` int(11),
	
	IN `p_charge` DOUBLE(30,10),
	IN `p_openTime` datetime,
	IN `p_closeTime` datetime)
BEGIN	
	INSERT INTO test_play_log SET
			uid = p_uid,
			pid = p_pid,
			tid = p_tid,
			oid = p_oid,
			st = p_st,
			signalType = p_signalType,
			signalPrice = p_signalPrice,
			signalTime = p_signalTime,
			openPrice = p_openPrice,
			closePrice = p_closePrice,
			pol_tick = p_pol_tick,
			pol_sum = p_pol_sum,
			charge = p_charge*2,
			openTime = p_openTime,
			closeTime = p_closeTime,
			
			symbol = p_symbol,
			leverage = p_leverage,
			margin = p_margin,
			positionSize = p_positionSize,
			
			
			
			win_loss = CASE WHEN p_win IS TRUE THEN 'Win' ELSE 'Lose' END,
			bunbong = p_bunbong,
			`type`	= p_type;
			
	UPDATE test_play_list SET
			r_pol_tick = r_pol_tick + p_pol_tick,
			r_charge = r_charge + p_charge,
			r_pol_sum = r_pol_sum + p_pol_sum,
			
			r_profit_cnt = CASE WHEN p_st = 'PROFIT' THEN r_profit_cnt + 1 ELSE r_profit_cnt END,
			r_profit_tick = CASE WHEN p_st = 'PROFIT' THEN r_profit_tick + p_pol_tick ELSE r_profit_tick END,

			r_stop_cnt = CASE WHEN p_st = 'STOP' THEN r_stop_cnt + 1 ELSE r_stop_cnt END,
			r_stop_tick = CASE WHEN p_st = 'STOP' THEN r_stop_tick + p_pol_tick ELSE r_stop_tick END,

			r_forcing_cnt = CASE WHEN p_st = 'FORCING' THEN r_forcing_cnt + 1 ELSE r_forcing_cnt END,
			r_forcing_tick = CASE WHEN p_st = 'FORCING' THEN r_forcing_tick + p_pol_tick ELSE r_forcing_tick END,
			
			
			r_win = r_win + p_win,
			r_loss = r_loss + p_loss
			
	WHERE id = p_pid;
	
	UPDATE admin_member SET
		price = price + (p_pol_sum - p_charge)
	WHERE id = p_uid;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ST_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ST_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ST_EDIT`(IN `p_id` int(11),
	IN `p_st` char(20))
BEGIN	
	UPDATE test_play_list SET 
			`status` = p_st
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ST_EXACT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ST_EXACT`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ST_EXACT`(IN `p_id` int(11),
	IN `p_uid` int(11),
	IN `p_exactPrice` DOUBLE(30,10),
	IN `p_tid` char(12),
	IN `p_charge` DOUBLE(30,10),
	IN `p_qty` DOUBLE(30,10))
BEGIN	
	UPDATE test_play_list SET 
			`status` = 'EXACT',
			r_tid = p_tid,
			r_exactPrice = p_exactPrice,
			r_exact_cnt = r_exact_cnt + 1,
			r_exactTime = NOW(),
			r_charge = r_charge + p_charge,
			r_qty = p_qty
	WHERE id = p_id;
	
	UPDATE admin_member SET
		price = price - p_charge
	WHERE id = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ST_EXACT_WAIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ST_EXACT_WAIT`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ST_EXACT_WAIT`(IN `p_pid` int(11),
	IN `p_tid` char(12),
-- 	IN `p_tempPrice` double(15,3),
	IN `p_signalPrice` double(30,10),
	IN `p_signalType` char(5))
BEGIN	
	UPDATE test_play_list SET 
		r_tid = p_tid,
		st = 'START',
		`status` = 'EXACT_WAIT',
-- 		r_tempPrice = p_tempPrice,
		
		r_signalType = p_signalType,
		r_signalPrice = p_signalPrice,
		r_signalTime = NOW()
	WHERE id = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ST_NEW_CLOSE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ST_NEW_CLOSE`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ST_NEW_CLOSE`(IN `p_uid` int(11),
	IN `p_pid` int(11),
	IN `p_tid` char(12),
	IN `p_oid` char(12),
	IN `p_st` char(20),
	IN `p_signalType` char(5),
	IN `p_signalPrice` double(15,10),
	IN `p_signalTime` datetime,
	IN `p_openPrice` double(15,10),
	IN `p_closePrice` double(15,10),
	
	IN `p_pol_tick` DOUBLE(15,10),
	IN `p_pol_sum` double(15,10),
	
	IN `p_charge` DOUBLE(15,10),
	IN `p_charge2` DOUBLE(15,10),
	
	IN `p_openTime` datetime,
	IN `p_closeTime` datetime)
BEGIN	
	INSERT INTO test_play_log SET
			uid = p_uid,
			pid = p_pid,
			tid = p_tid,
			oid = p_oid,
			st = p_st,
			signalType = p_signalType,
			signalPrice = p_signalPrice,
			signalTime = p_signalTime,
			openPrice = p_openPrice,
			closePrice = p_closePrice,
			pol_tick = p_pol_tick,
			pol_sum = p_pol_sum,
			charge = p_charge2,
			openTime = p_openTime,
			closeTime = p_closeTime;
			
	UPDATE test_play_list SET
			r_pol_tick = r_pol_tick + p_pol_tick,
			r_charge = r_charge + p_charge,
			r_pol_sum = r_pol_sum + p_pol_sum,
			
			r_profit_cnt = CASE WHEN p_st = 'PROFIT' THEN r_profit_cnt + 1 ELSE r_profit_cnt END,
			r_profit_tick = CASE WHEN p_st = 'PROFIT' THEN r_profit_tick + p_pol_tick ELSE r_profit_tick END,

			r_stop_cnt = CASE WHEN p_st = 'STOP' THEN r_stop_cnt + 1 ELSE r_stop_cnt END,
			r_stop_tick = CASE WHEN p_st = 'STOP' THEN r_stop_tick + p_pol_tick ELSE r_stop_tick END,

			r_forcing_cnt = CASE WHEN p_st = 'FORCING' THEN r_forcing_cnt + 1 ELSE r_forcing_cnt END,
			r_forcing_tick = CASE WHEN p_st = 'FORCING' THEN r_forcing_tick + p_pol_tick ELSE r_forcing_tick END
			
	WHERE id = p_pid;
	
	UPDATE admin_member SET
		price = price + (p_pol_sum - p_charge)
	WHERE id = p_uid;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ST_NEW_EXACT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ST_NEW_EXACT`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ST_NEW_EXACT`(IN `p_id` int(11))
BEGIN	
	UPDATE test_play_list SET 
			`status` = 'EXACT'
-- 			r_tid = p_tid
-- 			r_exactPrice = p_exactPrice,
-- 			r_exact_cnt = r_exact_cnt + 1
-- 			r_exactTime = NOW(),
-- 			r_charge = r_charge + p_charge
	WHERE id = p_id;
	
	
-- 	
-- 	UPDATE admin_member SET
-- 		price = price - p_charge
-- 	WHERE id = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ST_NEW_EXACT_UPDATE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ST_NEW_EXACT_UPDATE`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ST_NEW_EXACT_UPDATE`(IN `p_id` int(11),
	IN `p_uid` int(11),
	IN `p_exactPrice` DOUBLE(15,10),
	
	IN `p_qty` DOUBLE(15, 10),
	IN `p_margin` DOUBLE(15, 3),
	
-- 	IN `p_tid` char(12),
	
	IN `p_charge` DOUBLE(15,10))
BEGIN	
	UPDATE test_play_list SET 
-- 			`status` = 'EXACT',
-- 			r_tid = p_tid,
			r_exactPrice = p_exactPrice,
			
			r_qty = p_qty,
			r_margin = p_margin,
			
			r_exact_cnt = r_exact_cnt + 1,
			r_exactTime = NOW(),
			r_charge = r_charge + p_charge,
			r_t_charge = p_charge
			
	WHERE id = p_id;
	
	UPDATE admin_member SET
		price = price - p_charge
	WHERE id = p_uid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ST_NEW_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ST_NEW_GET`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ST_NEW_GET`(IN `p_pid` int(11))
BEGIN	
	SELECT *
	FROM test_play_list
	WHERE id = p_pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ST_NEW_OID_UPDATE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ST_NEW_OID_UPDATE`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ST_NEW_OID_UPDATE`(IN `p_id` int(11),
	IN `p_oid` char(12))
BEGIN	
	UPDATE test_play_list SET
		r_oid = p_oid
	WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ST_NEW_SET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ST_NEW_SET`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ST_NEW_SET`(IN `p_id` int(11),
	IN `p_tid` char(12),
-- 	IN `p_qty` DOUBLE(15, 3),
	IN `p_minQty` DOUBLE(15, 10))
BEGIN	
	UPDATE test_play_list SET
		r_tid = p_tid,
-- 		r_qty = p_qty,
		r_minQty = p_minQty
-- 		r_profitPrice = p_profit,
-- 		r_stopPrice = p_stop,
-- 		r_margin = p_margin,

	WHERE id = p_id;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_ST_TICK
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_ST_TICK`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_ST_TICK`(IN `p_id` int(11),
	IN `p_real_tick` DOUBLE(30, 10))
BEGIN	
	UPDATE test_play_list SET 
			r_real_tick = p_real_tick
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_T_CNT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_T_CNT`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_T_CNT`(IN `p_id` int(11),
	IN `p_t_cnt` int(11))
BEGIN	
	UPDATE test_play_list SET 
			r_t_cnt = p_t_cnt
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_T_ST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_T_ST`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_T_ST`(IN `p_id` int(11),
	IN `p_st` char(1))
BEGIN	
	UPDATE test_play_list SET 
			r_t_st = p_st
	WHERE id = p_id;		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_UUID_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_UUID_GET`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_UUID_GET`(IN `p_uuid` char(20),
	IN `p_symbol` char(20))
BEGIN	
	SELECT p.*
-- 	, m.metaId
	FROM test_play_list p
-- 	INNER JOIN admin_member m ON m.id = p.uid
	WHERE 
		(p.st = 'START' OR p.st = 'STOP')
		AND p.autoST = 'Y' 
		AND (p.`status` = 'READY' OR p.`status` = 'EXACT_WAIT' OR p.`status` = 'EXACT')
		AND p.stoch_id = p_uuid
		AND p.symbol = p_symbol
		AND p.del_st = 'N';
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_UUID_GET2
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_UUID_GET2`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_UUID_GET2`(IN `p_uuid` char(20),
	IN `p_symbol` char(20))
BEGIN	
	SELECT p.*
-- 	, m.metaId
	FROM test_play_list p
-- 	INNER JOIN admin_member m ON m.id = p.uid
	WHERE 
		(p.st = 'START' OR p.st = 'STOP')
		AND p.autoST = 'Y' 
		AND p.`status` = 'EXACT'
		
		AND stoch_id REGEXP CONCAT('^Q_[A-Z]_',p_uuid,'$')
		
		
		AND p.symbol = p_symbol
		AND p.del_st = 'N';
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_PLAY_Y_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_PLAY_Y_GET`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_PLAY_Y_GET`(IN `p_symbol` char(20),
	IN `p_bun` int(11))
BEGIN	
	SELECT *
	FROM test_play_list
	WHERE 
		autoST = 'Y' 
		AND type = 'C'
		AND bunbong LIKE CONCAT('%_',p_bun) 
		AND st = 'START'
		AND symbol = p_symbol;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_RESULT_ALL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_RESULT_ALL`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_RESULT_ALL`(IN `p_uid` int(11),
	IN `sDate` DATE,
	IN `eDate` DATE)
BEGIN	
	SELECT 
		log.id,
		log.uid,
		log.pid,
		list.a_name,
		log.symbol,
		log.`type`,
		log.bunbong,
		log.win_loss,	
		log.openPrice,
		log.openTime,
		log.closePrice,
		log.closeTime,
		log.signalType,
		log.leverage,
		log.margin,
		log.pol_sum - log.charge AS 'pol_sum'
	FROM test_play_log as log
	INNER JOIN test_play_list AS list ON log.pid = list.id
	WHERE DATE(log.closeTime) >= sDate AND DATE(log.closeTime) <= eDate AND log.uid = p_uid
	ORDER BY log.closeTime DESC;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_RESULT_DETAIL_PAGE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_RESULT_DETAIL_PAGE`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_RESULT_DETAIL_PAGE`(IN `p_uid` int(11),
	IN `p_date` CHAR(10),
	IN `pg` INT,
	IN `block` INT)
BEGIN	
	SELECT SQL_CALC_FOUND_ROWS *
	FROM test_play_log
	WHERE 
		uid = p_uid 
		AND DATE_FORMAT(closeTime,'%Y/%m/%d') = p_date 
	ORDER BY id DESC
	LIMIT pg, block;
	
	SELECT FOUND_ROWS() AS totalCount;
	
	SELECT 
		COUNT(*) AS exact_cnt,
		COUNT(CASE WHEN st = 'PROFIT' THEN 1 END) AS profit_cnt,
		COUNT(CASE WHEN st = 'STOP' THEN 1 END) AS stop_cnt,
		COUNT(CASE WHEN st = 'FORCING' THEN 1 END) AS forcing_cnt,
		SUM(pol_tick) AS pol_tick,
		SUM(charge) AS charge,
		SUM(pol_sum) AS pol_sum
	FROM test_play_log
	WHERE uid = p_uid AND DATE_FORMAT(closeTime,'%Y/%m/%d') = p_date;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_RESULT_EXACT_ALL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_RESULT_EXACT_ALL`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_RESULT_EXACT_ALL`(IN `p_uid` int(11))
BEGIN	
	SELECT id AS 'pid', a_name, r_exactTime, `type`, bunbong, margin, leverage, r_signalType, r_exactTime AS 'openTime', r_exactPrice AS 'openPrice', symbol
	FROM test_play_list
	WHERE uid = p_uid AND `status` = 'EXACT';		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_RESULT_EXPORT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_RESULT_EXPORT`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_RESULT_EXPORT`(IN `p_uid` int(11),
	IN `sDate` DATE,
	IN `eDate` DATE)
BEGIN		
		
	SELECT 
		DATE_FORMAT(log.closeTime,'%Y/%m/%d') AS '날짜',
		COUNT(log.id) AS '진입',
		IFNULL(p.profit_tick, 0) AS '익절',
		IFNULL(l.stop_tick, 0) AS '손절',
		IFNULL(f.forcing_tick, 0) AS '강제청산',
		SUM(log.pol_tick) AS '결과',
		SUM(log.charge) AS '수수료',
		SUM(log.pol_sum) - SUM(log.charge) AS '손입합계'
-- 		IFNULL(p.profit_cnt, 0) AS profit_cnt,
-- 		IFNULL(l.stop_cnt, 0) AS stop_cnt,
-- 		IFNULL(f.forcing_cnt, 0) AS forcing_cnt,
	FROM test_play_log log
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS profit_tick, count(*) AS profit_cnt
		FROM test_play_log log
		WHERE log.st = 'PROFIT' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS p ON p.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS stop_tick, count(*) AS stop_cnt
		FROM test_play_log log
		WHERE log.st = 'STOP' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS l ON l.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS forcing_tick, count(*) AS forcing_cnt
		FROM test_play_log log
		WHERE log.st = 'FORCING' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS f ON f.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	WHERE uid = p_uid
		AND (sDate <= DATE_FORMAT(closeTime, '%Y-%m-%d') AND DATE_FORMAT(closeTime, '%Y-%m-%d') <= eDate)
	GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d');

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_RESULT_ITEM
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_RESULT_ITEM`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_RESULT_ITEM`(IN `p_uid` int(11),
	IN `p_pid` int(11),
	IN `sDate` DATE,
	IN `eDate` DATE)
BEGIN	
	SELECT 
		log.id,
		log.uid,
		log.pid,
		list.a_name,
		log.symbol,
		log.`type`,
		log.bunbong,
		log.win_loss,	
		log.openPrice,
		log.openTime,
		log.closePrice,
		log.closeTime,
		log.signalType,
		log.leverage,
		log.margin,
		log.pol_sum - log.charge AS 'pol_sum'
	FROM test_play_log as log
	INNER JOIN test_play_list AS list ON log.pid = list.id
	WHERE DATE(log.closeTime) >= sDate AND DATE(log.closeTime) <= eDate AND pid = p_pid AND log.uid = p_uid
	ORDER BY log.closeTime DESC;
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_TEST_RESULT_PAGE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_TEST_RESULT_PAGE`;
delimiter ;;
CREATE PROCEDURE `SP_TEST_RESULT_PAGE`(IN `p_uid` int(11),
	IN `pg` INT,
	IN `block` INT,
	IN `sDate` DATE,
	IN `eDate` DATE)
BEGIN	
	
-- 	SELECT 
-- 		SQL_CALC_FOUND_ROWS DATE_FORMAT(log.closeTime,'%Y/%m/%d') AS logDate,
-- 		COUNT(log.id) AS exact_cnt,
-- 		COUNT(CASE WHEN log.st = 'PROFIT' THEN 1 END) AS profit_cnt,
-- 		COUNT(CASE WHEN log.st = 'LOSS' THEN 1 END) AS stop_cnt,
-- 		COUNT(CASE WHEN log.st = 'FORCING' THEN 1 END) AS forcing_cnt,
-- 		SUM(log.pol_tick) AS pol_tick,
-- 		SUM(log.charge) AS charge,
-- 		SUM(log.pol_sum) - SUM(log.charge) AS pol_sum,
-- 		
-- 		a.profit_tick,
-- 		b.stop_tick
-- 		
-- 	FROM live_play_log log
-- 	LEFT JOIN (
-- 		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS profit_tick
-- 		FROM live_play_log
-- 		WHERE st = 'PROFIT'
-- 		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
-- 	) AS a ON a.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
-- 	LEFT JOIN (
-- 		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS stop_tick
-- 		FROM live_play_log
-- 		WHERE st = 'LOSS'
-- 		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
-- 	) AS b ON b.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
-- 	WHERE 
-- 				uid = p_uid 
-- 				AND (
-- 				sDate <= DATE_FORMAT(closeTime, '%Y-%m-%d')
-- 				
-- 				 AND DATE_FORMAT(closeTime, '%Y-%m-%d') <= eDate
-- 				
-- 				)
-- 	GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
-- 	LIMIT pg, block;
-- 	
-- 	
	
	
	
	SELECT 
		SQL_CALC_FOUND_ROWS DATE_FORMAT(log.closeTime,'%Y/%m/%d') AS logDate,
		
		SUM(log.pol_tick) AS pol_tick,
		SUM(log.charge) AS charge,
		SUM(log.pol_sum) - SUM(log.charge) AS pol_sum,
		
		COUNT(log.id) AS exact_cnt,
		IFNULL(p.profit_cnt, 0) AS profit_cnt,
		IFNULL(l.stop_cnt, 0) AS stop_cnt,
		IFNULL(f.forcing_cnt, 0) AS forcing_cnt,
		
		IFNULL(p.profit_tick, 0) AS profit_tick,
		IFNULL(l.stop_tick, 0) AS stop_tick,
		IFNULL(f.forcing_tick, 0) AS forcing_tick
		
	FROM test_play_log log
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS profit_tick, count(*) AS profit_cnt
		FROM test_play_log log
		WHERE log.st = 'PROFIT' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS p ON p.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS stop_tick, count(*) AS stop_cnt
		FROM test_play_log log
		WHERE log.st = 'STOP' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS l ON l.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	LEFT JOIN (
		SELECT DATE_FORMAT(closeTime,'%Y-%m-%d') AS logDate, SUM(pol_tick) AS forcing_tick, count(*) AS forcing_cnt
		FROM test_play_log log
		WHERE log.st = 'FORCING' AND uid = p_uid
		GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	) AS f ON f.logDate = DATE_FORMAT(closeTime,'%Y-%m-%d')
	WHERE uid = p_uid
		AND (sDate <= DATE_FORMAT(closeTime, '%Y-%m-%d') AND DATE_FORMAT(closeTime, '%Y-%m-%d') <= eDate)
	GROUP BY DATE_FORMAT(closeTime,'%Y-%m-%d')
	LIMIT pg, block;



	
	SELECT FOUND_ROWS() AS totalCount;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_U_ID_CHECK
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_U_ID_CHECK`;
delimiter ;;
CREATE PROCEDURE `SP_U_ID_CHECK`(IN `p_mim_id` VARCHAR(50))
BEGIN	
	SELECT id
	FROM admin_member
	WHERE mem_id = p_mim_id
	LIMIT 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_U_USER_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_U_USER_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_U_USER_ADD`(IN `p_mem_id` varchar(50),
	IN `p_mem_name` varchar(50),
	IN `p_mem_mobile` char(11),
	IN `p_password` varchar(100),
	IN `p_email` varchar(50),
	IN `p_recom` char(10))
BEGIN	
	INSERT INTO admin_member SET
		mem_id = p_mem_id,
		mem_name = p_mem_name,
		mem_mobile = p_mem_mobile,
		`password` = PASSWORD(p_password),
		email = p_email,
		recom = p_recom;
		
	SELECT LAST_INSERT_ID() AS 'userID';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_U_USER_ALL_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_U_USER_ALL_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_U_USER_ALL_EDIT`(IN `p_id` int(11),
	IN `p_allExactST` char(1),
	IN `p_allStopST` char(1),
	IN `p_allExact` int(11),
	IN `p_allStop` int(11),
	IN `p_allStartST` char(1))
BEGIN	
	UPDATE admin_member SET
		allExactST = p_allExactST,
		allStopST = p_allStopST,
		allExact = p_allExact,
		allStop = p_allStop,
		allStartST = p_allStartST
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_U_USER_ALL_EDIT2
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_U_USER_ALL_EDIT2`;
delimiter ;;
CREATE PROCEDURE `SP_U_USER_ALL_EDIT2`()
BEGIN	
	UPDATE admin_member SET
		allStartST = 'N';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_U_USER_AUTO_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_U_USER_AUTO_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_U_USER_AUTO_EDIT`(IN `p_id` int(11),
	IN `p_allStartST` CHAR(1))
BEGIN	
	UPDATE admin_member SET
		allStartST = p_allStartST
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_U_USER_AUTO_RESET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_U_USER_AUTO_RESET`;
delimiter ;;
CREATE PROCEDURE `SP_U_USER_AUTO_RESET`(IN `p_id` int(11))
BEGIN	
	UPDATE admin_member SET
		allStartST = 'N',
		allExactST = 'N',
		allStopST = 'N',
		allExact = null,
		allStop = null

	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_U_USER_PRICE_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_U_USER_PRICE_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_U_USER_PRICE_ADD`(IN `p_id` int(11),
	IN `p_price` DOUBLE(15,3))
BEGIN	
	UPDATE admin_member SET
		price = price + p_price
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_U_USER_PRICE_DEL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_U_USER_PRICE_DEL`;
delimiter ;;
CREATE PROCEDURE `SP_U_USER_PRICE_DEL`(IN `p_id` int(11),
	IN `p_price` DOUBLE(15,3))
BEGIN	
	UPDATE admin_member SET
		price = price - p_price
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_WS_BUNBONG_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_WS_BUNBONG_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_WS_BUNBONG_ADD`(IN `p_symbol` char(8),
	IN `p_open` double(15,2),
	IN `p_high` double(15,2),
	IN `p_low` double(15,2),
	IN `p_close` double(15,2),
	IN `p_ovsdate` datetime,
	IN `p_kordate` datetime)
BEGIN	
	INSERT INTO ls_log_bunbong SET
		symbol = p_symbol,
		`open` = p_open,
		high = p_high,
		low = p_low,
		`close` = p_close,
		ovsdate = p_ovsdate,
		kordate = p_kordate;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_WS_BUNBONG_INIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_WS_BUNBONG_INIT`;
delimiter ;;
CREATE PROCEDURE `SP_WS_BUNBONG_INIT`()
BEGIN	
	DELETE FROM ls_log_bunbong;
	ALTER TABLE ls_log_bunbong AUTO_INCREMENT=1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_WS_PLAY_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_WS_PLAY_GET`;
delimiter ;;
CREATE PROCEDURE `SP_WS_PLAY_GET`(IN `p_type` char(10),
	
	IN `p_bunbong` int(11),
	IN `p_second2` int(11),
	IN `p_second3` int(11),
	IN `p_second4` int(11))
BEGIN	
	SELECT *
	FROM play_list
	WHERE 
				`type` = p_type
		AND bunbong = p_bunbong
		AND second2 = p_second2
		AND second3 = p_second3
		AND second4 = p_second4;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_WS_PLAY_LIST_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_WS_PLAY_LIST_GET`;
delimiter ;;
CREATE PROCEDURE `SP_WS_PLAY_LIST_GET`(IN `p_bunbong` int(11),
	IN `p_second2` int(11),
	IN `p_second3` int(11),
	IN `p_second4` int(11))
BEGIN	
	SELECT *
	FROM stoch_list
	WHERE 
-- 				`stoch_id` = 'Y'
				bunbong = p_bunbong
		AND second2 = p_second2
		AND second3 = p_second3
		AND second4 = p_second4
	LIMIT 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_WS_PLAY_STOCH_ALL_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_WS_PLAY_STOCH_ALL_GET`;
delimiter ;;
CREATE PROCEDURE `SP_WS_PLAY_STOCH_ALL_GET`()
BEGIN	
	SELECT *
	FROM stoch_list;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_WS_PLAY_STOCH_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_WS_PLAY_STOCH_GET`;
delimiter ;;
CREATE PROCEDURE `SP_WS_PLAY_STOCH_GET`()
BEGIN	
	SELECT bunbong, `type`, second2, second3, second4 
	FROM play_list
	GROUP BY bunbong, `type`, second2, second3, second4;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_WS_TICK_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_WS_TICK_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_WS_TICK_ADD`(IN `p_symbol` char(8),
	IN `p_curpr` double(15,2))
BEGIN	
	INSERT INTO ls_tick SET
		symbol = p_symbol,
		curpr = p_curpr;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_WS_TICK_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_WS_TICK_GET`;
delimiter ;;
CREATE PROCEDURE `SP_WS_TICK_GET`(IN `p_symbol` char(8))
BEGIN	
	SELECT *
	FROM ls_tick
	WHERE symbol = p_symbol;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ZZAR_LINE_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ZZAR_LINE_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_ZZAR_LINE_ADD`(IN `p_uid` int(11),
	IN `p_symbol` char(20))
BEGIN	
	INSERT INTO line_list SET
		uid = p_uid,
		symbol = p_symbol;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ZZAR_LINE_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ZZAR_LINE_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_ZZAR_LINE_EDIT`(IN `p_uid` int(11),
	IN `p_symbol` char(20),
	IN `p_subLine` DOUBLE(15,3),
	IN `p_resLine` DOUBLE(15,3))
BEGIN	
	UPDATE line_list SET
		subLine = p_subLine,
		resLine = p_resLine
	WHERE uid = p_uid AND symbol = p_symbol;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ZZAR_LINE_GET
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ZZAR_LINE_GET`;
delimiter ;;
CREATE PROCEDURE `SP_ZZAR_LINE_GET`(IN `p_uid` int(11),
	IN `p_symbol` char(20))
BEGIN	
	SELECT *
	FROM line_list
	WHERE uid = p_uid AND symbol = p_symbol
	LIMIT 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ZZAR_LIVE_PLAY_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ZZAR_LIVE_PLAY_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_ZZAR_LIVE_PLAY_ADD`(IN `p_uid` int(11),
	IN `p_stoch_id` char(20),
	IN `p_a_name` VARCHAR(50),	 -- 추가
	IN `p_symbol` char(20),
	IN `p_bunbong` char(10),
	IN `p_second1` char(10),
	IN `p_second2` char(10),
	IN `p_second3` char(10),
	IN `p_second4` char(10),
	IN `p_enter` DOUBLE(30,10),
	IN `p_cancel` DOUBLE(30,10),
	IN `p_profit` DOUBLE(30,10),
	
	IN `p_stopLoss` DOUBLE(30,10),
	IN `p_stopTime` INT(11),
	IN `p_stopTimeType` CHAR(10),
	IN `p_stopRevST` CHAR(1),
	IN `p_profitRevST` CHAR(1),
	
	IN `p_leverage` DOUBLE(30,10),
	IN `p_margin` DOUBLE(30,10),
	
	IN `p_minimumOrderST` char(1),
	IN `p_m_cancelStopLoss` DOUBLE(30,10),
	IN `p_m_profit` DOUBLE(30,10),
	IN `p_trendOrderST` char(1),
	IN `p_t_cancelStopLoss` DOUBLE(30,10),
	IN `p_t_profit` DOUBLE(30,10),
	IN `p_t_chase` DOUBLE(30,10),
	IN `p_signalType` char(5),
	IN `p_alarmSignalST` char(1),
	IN `p_alarmResultST` char(1),
	IN `p_orderSize` int(11),
	
	IN `p_t_autoST` char(1),
	IN `p_t_ST` char(1),
	IN `p_t_direct` char(1),
	IN `p_type` char(20),
	
	
	IN `p_direct1ST` char(1),
	IN `p_direct2ST` char(1),
	
	
	IN `p_repeatConfig` char(10),
	IN `p_profitTradeType` char(10),
	IN `p_profitFixValue` char(10),
	IN `p_profitAbsValue` double(30,10),
	IN `p_lossTradeType` char(10),
	IN `p_lossFixValue` char(10),
	IN `p_lossAbsValue` double(30,10),
	IN `p_absValue` double(30,10))
BEGIN	
	INSERT INTO live_play_list SET 
		uid = p_uid,
		
		a_name = p_a_name,
		
		stoch_id = p_stoch_id,
		symbol = p_symbol,
		bunbong = p_bunbong,
		second1 = p_second1,
		second2 = p_second2,
		second3 = p_second3,
		second4 = p_second4,
		enter = p_enter,
		cancel = p_cancel,
		profit = p_profit,
		
		stopLoss = p_stopLoss,
		stopTime = p_stopTime,
		stopTimeType = p_stopTimeType,
		stopRevST = p_stopRevST,
		profitRevST = p_profitRevST,
		
		leverage = p_leverage,
		margin = p_margin,
		
		minimumOrderST = p_minimumOrderST,
		m_cancelStopLoss = p_m_cancelStopLoss,
		m_profit = p_m_profit,
		trendOrderST = p_trendOrderST,
		t_cancelStopLoss = p_t_cancelStopLoss,
		t_profit = p_t_profit,
		t_chase = p_t_chase,
		signalType = p_signalType,
		alarmSignalST = p_alarmSignalST,
		alarmResultST = p_alarmResultST,
		orderSize = p_orderSize,
		
		
		t_autoST = p_t_autoST,
		t_ST = p_t_ST,
		t_direct = p_t_direct,
		type = p_type,
		
		direct1ST = p_direct1ST,
		direct2ST = p_direct2ST,
-- 		t_long = p_t_long,
-- 		t_short = p_t_short,
-- 		t_same = p_t_same,
-- 		t_sameST = p_t_sameST


		repeatConfig = p_repeatConfig,
		profitTradeType = p_profitTradeType,
		profitFixValue = p_profitFixValue,
		profitAbsValue = p_profitAbsValue,
		lossTradeType = p_lossTradeType,
		lossFixValue = p_lossFixValue,
		lossAbsValue = p_lossAbsValue,
		absValue = p_absValue;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ZZAR_LIVE_PLAY_DEL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ZZAR_LIVE_PLAY_DEL`;
delimiter ;;
CREATE PROCEDURE `SP_ZZAR_LIVE_PLAY_DEL`(IN `p_id` int(11))
BEGIN	
-- 	DELETE FROM live_play_list WHERE id = p_id;
	
	
	UPDATE live_play_list SET del_ST = 'Y' WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ZZAR_LIVE_PLAY_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ZZAR_LIVE_PLAY_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_ZZAR_LIVE_PLAY_EDIT`(IN `p_id` int(11),
	IN `p_a_name` VARCHAR(50),	 -- 추가
	IN `p_symbol` char(20),
	IN `p_bunbong` char(10),
	IN `p_second1` char(10),
	IN `p_second2` char(10),
	IN `p_second3` char(10),
	IN `p_second4` char(10),
	
	IN `p_enter` DOUBLE(30,10),
	IN `p_cancel` DOUBLE(30,10),
	IN `p_profit` DOUBLE(30,10),
	
	IN `p_stopLoss` DOUBLE(30,10),
	IN `p_stopTime` INT(11),
	IN `p_stopTimeType` CHAR(10),
	IN `p_stopRevST` CHAR(1),
	IN `p_profitRevST` CHAR(1),
	
	IN `p_leverage` DOUBLE(30,10),
	IN `p_margin` DOUBLE(30,10),
	
	IN `p_minimumOrderST` char(1),
	IN `p_m_cancelStopLoss` DOUBLE(30,10),
	IN `p_m_profit` DOUBLE(30,10),
	IN `p_trendOrderST` char(1),
	IN `p_t_cancelStopLoss` DOUBLE(30,10),
	IN `p_t_profit` DOUBLE(30,10),
	IN `p_t_chase` DOUBLE(30,10),
	IN `p_signalType` char(5),
	IN `p_alarmSignalST` char(1),
	IN `p_alarmResultST` char(1),
	IN `p_orderSize` int(11),
	
	IN `p_t_autoST` char(1),
	IN `p_t_ST` char(1),
	IN `p_t_direct` char(1),
	IN `p_type` char(20),
	
	
	IN `p_direct1ST` char(1),
	IN `p_direct2ST` char(1),
	
	
	IN `p_repeatConfig` char(10),
	IN `p_profitTradeType` char(10),
	IN `p_profitFixValue` char(10),
	IN `p_profitAbsValue` double(30,10),
	IN `p_lossTradeType` char(10),
	IN `p_lossFixValue` char(10),
	IN `p_lossAbsValue` double(30,10),
	IN `p_absValue` double(30,10))
BEGIN	
	UPDATE live_play_list SET 
		a_name = p_a_name,
		
		symbol = p_symbol,
		bunbong = p_bunbong,
		second1 = p_second1,
		second2 = p_second2,
		second3 = p_second3,
		second4 = p_second4,
		
		enter = p_enter,
		cancel = p_cancel,
		profit = p_profit,
		
		stopLoss = p_stopLoss,
		stopTime = p_stopTime,
		stopTimeType = p_stopTimeType,
		stopRevST = p_stopRevST,
		profitRevST = p_profitRevST,
		
		leverage = p_leverage,
		margin = p_margin,
		
		minimumOrderST = p_minimumOrderST,
		m_cancelStopLoss = p_m_cancelStopLoss,
		m_profit = p_m_profit,
		trendOrderST = p_trendOrderST,
		t_cancelStopLoss = p_t_cancelStopLoss,
		t_profit = p_t_profit,
		t_chase = p_t_chase,
		signalType = p_signalType,
		alarmSignalST = p_alarmSignalST,
		alarmResultST = p_alarmResultST,
		orderSize = p_orderSize,
		
		
		t_autoST = p_t_autoST,
		t_ST = p_t_ST,
		t_direct = p_t_direct,
		type = p_type,
		
		direct1ST = p_direct1ST,
		direct2ST = p_direct2ST,
-- 		t_long = p_t_long,
-- 		t_short = p_t_short,
-- 		t_same = p_t_same,
-- 		t_sameST = p_t_sameST


		repeatConfig = p_repeatConfig,
		profitTradeType = p_profitTradeType,
		profitFixValue = p_profitFixValue,
		profitAbsValue = p_profitAbsValue,
		lossTradeType = p_lossTradeType,
		lossFixValue = p_lossFixValue,
		lossAbsValue = p_lossAbsValue,
		absValue = p_absValue
		
	WHERE id = p_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ZZAR_TEST_PLAY_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ZZAR_TEST_PLAY_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_ZZAR_TEST_PLAY_ADD`(IN `p_uid` int(11),
	IN `p_stoch_id` char(20),
	IN `p_a_name` VARCHAR(50),	 -- 추가
	IN `p_symbol` char(20),
	IN `p_bunbong` char(10),
	IN `p_second1` char(10),
	IN `p_second2` char(10),
	IN `p_second3` char(10),
	IN `p_second4` char(10),
	IN `p_enter` DOUBLE(30,10),
	IN `p_cancel` DOUBLE(30,10),
	IN `p_profit` DOUBLE(30,10),
	
	IN `p_stopLoss` DOUBLE(30,10),
	IN `p_stopTime` INT(11),
	IN `p_stopTimeType` CHAR(10),
	IN `p_stopRevST` CHAR(1),
	IN `p_profitRevST` CHAR(1),
	
	IN `p_leverage` DOUBLE(30,10),
	IN `p_margin` DOUBLE(30,10),
	
	IN `p_minimumOrderST` char(1),
	IN `p_m_cancelStopLoss` DOUBLE(30,10),
	IN `p_m_profit` DOUBLE(30,10),
	IN `p_trendOrderST` char(1),
	IN `p_t_cancelStopLoss` DOUBLE(30,10),
	IN `p_t_profit` DOUBLE(30,10),
	IN `p_t_chase` DOUBLE(30,10),
	IN `p_signalType` char(5),
	IN `p_alarmSignalST` char(1),
	IN `p_alarmResultST` char(1),
	IN `p_orderSize` int(11),
	
	IN `p_t_autoST` char(1),
	IN `p_t_ST` char(1),
	IN `p_t_direct` char(1),
	IN `p_type` char(20),
	
	
	IN `p_direct1ST` char(1),
	IN `p_direct2ST` char(1),
	
	
	IN `p_repeatConfig` char(10),
	IN `p_profitTradeType` char(10),
	IN `p_profitFixValue` char(10),
	IN `p_profitAbsValue` double(30,10),
	IN `p_lossTradeType` char(10),
	IN `p_lossFixValue` char(10),
	IN `p_lossAbsValue` double(30,10),
	IN `p_absValue` double(30,10))
BEGIN	
	INSERT INTO test_play_list SET 
		uid = p_uid,
		
		a_name = p_a_name,
		
		stoch_id = p_stoch_id,
		symbol = p_symbol,
		bunbong = p_bunbong,
		second1 = p_second1,
		second2 = p_second2,
		second3 = p_second3,
		second4 = p_second4,
		enter = p_enter,
		cancel = p_cancel,
		profit = p_profit,
		
		stopLoss = p_stopLoss,
		stopTime = p_stopTime,
		stopTimeType = p_stopTimeType,
		stopRevST = p_stopRevST,
		profitRevST = p_profitRevST,
		
		leverage = p_leverage,
		margin = p_margin,
		
		minimumOrderST = p_minimumOrderST,
		m_cancelStopLoss = p_m_cancelStopLoss,
		m_profit = p_m_profit,
		trendOrderST = p_trendOrderST,
		t_cancelStopLoss = p_t_cancelStopLoss,
		t_profit = p_t_profit,
		t_chase = p_t_chase,
		signalType = p_signalType,
		alarmSignalST = p_alarmSignalST,
		alarmResultST = p_alarmResultST,
		orderSize = p_orderSize,
		
		
		t_autoST = p_t_autoST,
		t_ST = p_t_ST,
		t_direct = p_t_direct,
		type = p_type,
		
		direct1ST = p_direct1ST,
		direct2ST = p_direct2ST,
-- 		t_long = p_t_long,
-- 		t_short = p_t_short,
-- 		t_same = p_t_same,
-- 		t_sameST = p_t_sameST

		repeatConfig = p_repeatConfig,
		profitTradeType = p_profitTradeType,
		profitFixValue = p_profitFixValue,
		profitAbsValue = p_profitAbsValue,
		lossTradeType = p_lossTradeType,
		lossFixValue = p_lossFixValue,
		lossAbsValue = p_lossAbsValue,
		absValue = p_absValue;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ZZAR_TEST_PLAY_DEL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ZZAR_TEST_PLAY_DEL`;
delimiter ;;
CREATE PROCEDURE `SP_ZZAR_TEST_PLAY_DEL`(IN `p_id` int(11))
BEGIN	
-- 	DELETE FROM test_play_list WHERE id = p_id;
	
	UPDATE test_play_list SET del_ST = 'Y' WHERE id = p_id;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ZZAR_TEST_PLAY_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ZZAR_TEST_PLAY_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_ZZAR_TEST_PLAY_EDIT`(IN `p_id` int(11),
	IN `p_a_name` VARCHAR(50),	 -- 추가
	IN `p_symbol` char(20),
	IN `p_bunbong` char(10),
	IN `p_second1` char(10),
	IN `p_second2` char(10),
	IN `p_second3` char(10),
	IN `p_second4` char(10),
	
	IN `p_enter` DOUBLE(30,10),
	IN `p_cancel` DOUBLE(30,10),
	IN `p_profit` DOUBLE(30,10),
	
	IN `p_stopLoss` DOUBLE(30,10),
	IN `p_stopTime` INT(11),
	IN `p_stopTimeType` CHAR(10),
	IN `p_stopRevST` CHAR(1),
	IN `p_profitRevST` CHAR(1),
	
	IN `p_leverage` DOUBLE(30,10),
	IN `p_margin` DOUBLE(30,10),
	
	IN `p_minimumOrderST` char(1),
	IN `p_m_cancelStopLoss` DOUBLE(30,10),
	IN `p_m_profit` DOUBLE(30,10),
	IN `p_trendOrderST` char(1),
	IN `p_t_cancelStopLoss` DOUBLE(30,10),
	IN `p_t_profit` DOUBLE(30,10),
	IN `p_t_chase` DOUBLE(30,10),
	IN `p_signalType` char(5),
	IN `p_alarmSignalST` char(1),
	IN `p_alarmResultST` char(1),
	IN `p_orderSize` int(11),
	
	IN `p_t_autoST` char(1),
	IN `p_t_ST` char(1),
	IN `p_t_direct` char(1),
	IN `p_type` char(20),
	
	
	IN `p_direct1ST` char(1),
	IN `p_direct2ST` char(1),
	
	
	IN `p_repeatConfig` char(10),
	IN `p_profitTradeType` char(10),
	IN `p_profitFixValue` char(10),
	IN `p_profitAbsValue` double(15,2),
	IN `p_lossTradeType` char(10),
	IN `p_lossFixValue` char(10),
	IN `p_lossAbsValue` double(30,10),
	IN `p_absValue` double(30,10))
BEGIN	
	UPDATE test_play_list SET 
		a_name = p_a_name,
	
		symbol = p_symbol,
		bunbong = p_bunbong,
		second1 = p_second1,
		second2 = p_second2,
		second3 = p_second3,
		second4 = p_second4,
		
		enter = p_enter,
		cancel = p_cancel,
		profit = p_profit,
		
		stopLoss = p_stopLoss,
		stopTime = p_stopTime,
		stopTimeType = p_stopTimeType,
		stopRevST = p_stopRevST,
		profitRevST = p_profitRevST,
		
		leverage = p_leverage,
		margin = p_margin,
		
		minimumOrderST = p_minimumOrderST,
		m_cancelStopLoss = p_m_cancelStopLoss,
		m_profit = p_m_profit,
		trendOrderST = p_trendOrderST,
		t_cancelStopLoss = p_t_cancelStopLoss,
		t_profit = p_t_profit,
		t_chase = p_t_chase,
		signalType = p_signalType,
		alarmSignalST = p_alarmSignalST,
		alarmResultST = p_alarmResultST,
		orderSize = p_orderSize,
		
		
		t_autoST = p_t_autoST,
		t_ST = p_t_ST,
		t_direct = p_t_direct,
		type = p_type,
		
		direct1ST = p_direct1ST,
		direct2ST = p_direct2ST,
-- 		t_long = p_t_long,
-- 		t_short = p_t_short,
-- 		t_same = p_t_same,
-- 		t_sameST = p_t_sameST

		repeatConfig = p_repeatConfig,
		profitTradeType = p_profitTradeType,
		profitFixValue = p_profitFixValue,
		profitAbsValue = p_profitAbsValue,
		lossTradeType = p_lossTradeType,
		lossFixValue = p_lossFixValue,
		lossAbsValue = p_lossAbsValue,
		absValue = p_absValue
		
	WHERE id = p_id;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
