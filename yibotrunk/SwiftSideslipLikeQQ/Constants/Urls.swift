//
//  Urls.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/13.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit

import Alamofire
var defaultHeader:HTTPHeaders = ["Accept-Charset":"utf-8","Accept":"application/json","Connection":"Keep-Alive",
                                 "Accept-Language":"zh-CN,en,*","Cookie":"SESSION=0832194ifhajdkfl",
                                 "X-Requested-With":"XMLHttpRequest","User-Agent":"ios/1.1.11000"]


var BASE_URL = getDomainUrl()
var PORT = ""

let SYS_CONFIG_URL = "/native/config.do"//系统配置
let ALL_GAME_DATA_URL = "/native/all_games.do"//获取彩种等所有数据
let VALID_RED_PACKET_URL = "/native/getValidRedPacket.do";//获取可用红包信息
let RED_PACKET_RECORD_URL = "/native/redPacketRecord.do";//已抢红包记录
let FAKE_PACKET_DATAS = "/native/fake_package_data.do"//红包假数据
let GRAB_RED_PACKET_URL = "/native/grabPacket.do";//抢红包
let LOTTERYS_URL = "/native/getLoctterys.do"//获取彩种信息
let BIG_WHEEL_DATA_URL = "/native/bigwheel.do";//大转盘活动数据
let BIG_WHEEL_ACTION_URL = "/native/turnlateAward.do";//大转盘抽奖动作
let GAME_PLAYS_URL = "/native/getGamePlays.do";//获取某彩种对应的玩法列表
let TOKEN_BETS_URL = "/native/bet_token.do";//下注验证令牌口令
let WIN_LOST_URL = "/native/win_lost.do"//今日输赢
let LOGIN_URL = "/native/login.do";//登录
let DO_BETS_URL = "/native/doBets.do";
let LOTTERY_RECORD_URL = "/native/getBcLotteryRecords.do";//获取彩票投注记录
let SPORT_RECORDS = "/native/getSportRecords.do";//体育投注记录
let NEW_SPORT_RECORDS = "/native/getSportV2Records.do";//新体育投注记录
let SBSPORT_RECORDS = "/native/sb_record.do";//沙巴体育投注记录
let ACCOUNT_CHANGE_RECORD_URL = "/native/accountChangeRecord.do";//帐变记录
let OPEN_RESULT_DETAIL_URL = "/native/open_result_detail.do";//获取开奖公告详情
let LOTTERY_LAST_RESULT_URL = "/native/lastResult.do";//获取彩票最后一期的开奖结果
let LOTTERY_COUNTDOWN_URL = "/native/getCountDown.do";//获取彩票最后一期的倒计时数
let NOTICE_URL = "/native/new_notice.do";//获取公告消息
let MEMINFO_URL = "/native/meminfo.do";//获取帐号相关信息
let LUNBO_URL = "/native/lunbo.do";//获取轮播图
let BIG_WHEEL_AWARD_RECORD_URL = "/native/turnRecord.do";//大转盘中奖记录
let LOGIN_OUT_URL = "/native/logout.do";//登出
let UNREAD_MSG_COUNT_URL = "/native/getMsgCount.do";//获取未读消息数
let ACQURIE_NOTICE_POP_URL = "/native/getPopNotices.do";//获取公告弹窗内容
let ACTIVE_BADGE_URL = "/native/active_badges.do";//优惠活动角标数
let CHECK_UPDATE_URL = "/native/updateVersion.do";//在线检测升级接口
let ALL_LOTTERYS_COUNTDOWN_URL = "/native/getLotterysCountDown.do";//获取所有彩票倒计时数
let OPEN_RESULTS_URL = "/native/open_results.do";//获取开奖公告
let ACQUIRE_ACTIVES_URL = "/native/active_infos.do";
let SET_ACTIVE_READ_URL = "/native/read_active.do";//设优惠活动为已读
let GET_PVODDS_URL = "/native/getOdds.do";//获取玩法对应的赔率
let DO_SIX_MARK_URL = "/native/doSixMarkBet.do";//六合彩下注
let DO_PEILVBETS_URL = "/native/dolotV2Bet.do";//赔率版下注
let REG_CONFIG_URL = "/native/regconfig.do";//注册配置信息
let REGISTER_VCODE_IMAGE_URL = "/native/regVerifycode.do";//获取注册验证码图片
let REGISTER_URL = "/native/register.do";//会员注册
let REG_GUEST_URL = "/native/reg_guest.do";//试玩帐号注册
let LOTTERY_RECORD_DETAIL_URL = "/native/getOrderDetail.do";//获取彩票投注记录详情
let MODIFY_LOGIN_PASS = "/native/modify_pass.do";//修改登录密码
let MODIFY_CASH_PASS = "/native/modify_cashpass.do";//修改取款密码
let MESSAGE_LIST_URL = "/native/message_list.do";//站内信记录
let SET_READ_URL = "/native/read.do";//设为已读
let DELETE_MESSAGE_URL = "/native/message_delete.do";//删除
let SPORT_DATA_URL = "/native/getSportsData.do";//获取体育赛事数据
let SPORT_BETS_URL = "/native/sportBet.do";//体育下单投注
let SPORT_VALID_BETS_URL = "/native/valiteOdds.do";//校验下单投注
let GET_OTHER_PLAY_DATA = "/native/getDatasBesidesLotterys.do";//获取，电子，真人，游戏数据
let SPORT_RECORDS_DETAIL = "/native/getSportRecordsDetail.do";//体育投注记录详情
let GET_PAY_METHODS_URL = "/native/pay_methods.do";//获取充值方式
let SUBMIT_PAY_URL = "/native/submit_pay.do";//提交充值
let CHECK_PICK_MONEY_URL = "/native/check_account_security.do";//检查提款帐户请求
let POST_SET_BANK_PWD_URL = "/native/set_receipt_pwd.do";//提交设置的提款密码
let POST_BANK_DATA_URL = "/native/post_bank_data.do";//提交银行信息设置
let PICK_MONEY_DATA_URL = "/native/pick_money_data.do";//获取提款的配置及帐号数据
let POST_PICK_MONEY_URL = "/native/post_pick_money.do";//提交提款请求
let REAL_CONVERT_DATA_URL = "/native/getRealGameData.do";//额度转换真人数据
let SIGN_URL = "/native/sign.do";//签到
let ACCOUNT_URL = "/native/accountInfo.do";//帐号信息
let CHARGE_DRAW_RECORD_URL = "/native/money_records.do";//获取充值提款记录
let EXCHANGE_CONFIG_URL = "/native/exchangeConfig.do";//积分兑换的配置列表
let EXCHANGE_URL = "/native/exchange.do";//积分兑换
let ZUIHAO_QISHU_URL = "/native/getQiHaoForChase.do";//获取追号期数
let PAY_RESULT_SAFARI = "/native/pay_safari.do"
let PAY_RESULT_SPECIAL_SAFARI = "/native/pay_special_safari.do"
let BBIN_SAFARI = "/native/bbin_redirect.do"
let SYNC_PAY_METHODS = "/native/sync_pay_methods.do"
let LOTTERY_CANCEL_ORDER_URL = "/native/cancelOrder.do";//撤销下注的订单
let SPSPORT_URL = "/native/enter_sbsport.do"//获取萨巴体育跳转链接
let RECOMMAND = "/native/my_recommand.do" //我的推荐 推荐信息
let RECOMMAND_ADDUSER = "/native/recommend_adduser.do" //我的推荐 添加会员
//第三方接口，非原生定义
let REAL_GAME_BALANCE_URL = "/rc4m/getBalance.do";//获取真人或电子的余额，
let SBSPORT_BALANCE_URL = "/center/sbTrans/getBalance.do";//获取沙巴余额，
let FEE_CONVERT_URL = "/rc4m/thirdRealTransMoney.do";//真人额度转换接口
let SBFEE_CONVERT_URL = "/center/sbTrans/thirdTrans.do";//沙巴额度转换接口
let GAME_NB_URL = "/forwardNbChess.do";//nb game
let GAME_TT_URL = "/forwardTtLottery.do";//TT彩票跳转接口
let REAL_AG_URL = "/forwardAg.do";//AG真人娱乐接口
let REAL_MG_URL = "/forwardMg.do";//MG真人娱乐接口
let REAL_BBIN_URL = "/forwardBbin.do";//BBIN真人娱乐接口
let REAL_AB_URL = "/forwardAb.do";//AB真人娱乐接口
let REAL_OG_URL = "/forwardOg.do";//OG真人娱乐接口
let REAL_DS_URL = "/forwardDs.do";//ds真人娱乐接口
let GAME_PT_URL = "/forwardPt.do";//pt电子游戏接口
let GAME_QT_URL = "/forwardQt.do";//qt电子游戏接口
let GAME_MG_URL = "/forwardMg.do";//mg电子游戏接口
let GAME_KYQP_URL = "/forwardKYChess.do";//开元棋牌电子游戏接口
let REAL_BET_RECORD_URL = "/mobile/betRecord/getLiveBetRecord.do";//真人投注记录
let GAME_BET_RECORD_URL = "/mobile/betRecord/getEgameBetRecord.do";//电子投注记录
let ONLINE_PAY_URL = "/onlinepay/pay.do";// 在线支付接口
let PAY_QRCODE_URL = "/onlinepay/utils/getWecahtQrcode.do";// 获取支付二维码接口








