//
//  LennyNetworkRequest.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

let defaultCountOfRequestPagesize = 20

private let basic_Url = getDomainUrl()

//获取所有彩票信息借口
/*
 名称：native/all_lotterys.do
 请求方式:GET
 依赖会话：否
 入参:
 version：彩种版本(0-全部 1-官方 2-信用)
 示例:
 http://a001.com:8080/game-play/native/all_lotterys.do?version=0
 */
private let path_ObtainAllLotteryTypes = "/native/all_lotterys.do"
private let path_PersonReports = "/native/person_report_list.do"
private let path_TeamReports = "/native/reportTeamList.do"

/*
 一，开奖结果接口:
 名称：native/result_chart_list.do
 请求方式:GET
 依赖会话：否
 入参:
 pageNumber：页码
 pageSize=20：每页大小
 gameCode：彩种编码
 示例:
 http://a001.com:8080/game-play/native/result_chart_list.do?pageNumber=1&pageSize=20&lotCode=FFC&qihao=
 */
private let path_ObtainLotteryResults = "/native/result_chart_list.do"

/*
 四，注册接口
 
 名称：native/register.do
 请求方式:post
 依赖会话：否
 入参:
 */
private let path_Registration = "/native/register.do"
/*
 彩种信息， 彩种限额
 */
private let path_LotteryInfo = "/native/lotteryData.do"
/*
 收件箱列表
 */
private let path_Msg_Receive_list = "/native/msg_receive_list.do"
/// 获取银行列表
private let path_BankList = "/native/get_banks.do"
/**
 * 购彩查询，追号查询
 * @param session
 * @param lotCode 彩种编码
 * @param startTime 开始时间
 * @param endTime 结束时间
 * @param qihao 期号
 * @param version 彩票版本
 * @param order 订单号
 * @param zuihaoOrder 追号编号
 * @param status 订单状态
 * @param queryType 查询类型 1--下注 2--追号
 * @param playCode 玩法编码
 * @param include 是否包含下级 0--否 1--是
 * @param username 用户名
 */
private let path_LotteryQuery = "/native/lottery_query.do"
/**
modify login or withdraw password
 **/
private let path_ModifyPwd = "/native/modify_pwd.do"
private let API_CHARGERECORDLIST = "/native/chargeRecordList.do";
private let API_ACCOUNT_CHANGE_TYPES = "/native/account_change_types.do"
private let API_ACCOUNT_CHANGE_LIST = "/native/account_change_list.do"
private let API_USER_INFO = "/native/user_info.do";
private let API_BANK_LIST = "/native/bank_list.do";
private let API_READ_MESSAGE = "/native/read_message.do";
private let API_DELETE_MESSAGE = "/native/receive_delete.do";
private let API_DELETE_SEND_MESSAGE = "/native/send_delete.do"
private let API_MSG_SEND_LIST = "/native/msg_send_list.do";
private let API_SEND_MSG = "/native/send_msg.do";



typealias completionHandler = ((DataResponse<Any>)) -> Void
class LennyNetworkRequest: NSObject {

    private static func basic_Request(url: URL, method: HTTPMethod, parameter: Parameters?, encoding: URLEncoding, header: HTTPHeaders?, completionHandle: @escaping completionHandler) {
        
        Alamofire.request(url, method: method, parameters: parameter, encoding: encoding, headers: header).responseJSON { (dataResponse) in
            dataResponse.result.ifFailure {
                // 统一的 错误处理
            }
            dataResponse.result.ifSuccess {
                
            }
            completionHandle(dataResponse)
        }
    }
    
    private static func expandBasic_Request(maxAge:Int = 10,url: URL, method: HTTPMethod, parameter: Parameters?, encoding: URLEncoding, header: HTTPHeaders?, completionHandle: @escaping completionHandler) {
        
        Alamofire.request(url, method: method, parameters: parameter, encoding: encoding, headers: header).responseJSON { (dataResponse) in
            dataResponse.result.ifFailure {
                // 统一的 错误处理
            }
            dataResponse.result.ifSuccess {
                
            }
            completionHandle(dataResponse)
        }.cache(maxAge: maxAge)
    }
    
    
    //提交修改密码
    static func commitModifyPwd(oldpwd: String, newpwd: String,type:String, response: @escaping (_ model: ModifyPwdResultModel?) -> Void){
        let url = URL.init(string: basic_Url + path_ModifyPwd)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        let parameter = ["oldPwd": oldpwd,"newPwd":newpwd,"okPwd":newpwd,"type":type]
        basic_Request(url: url!, method: .post, parameter: parameter, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
//                    let s = String.init(data: data, encoding: .utf8)
//                    print("sssssssss = ",s)
                    let model = ModifyPwdResultModel.sexy_json(data)
                    LennyModel.modifyPwdResultModel = model
                    response(model)
                }
            }
        }
    }
    
    static func commitSendMesage(params:Dictionary<String,Any>, response: @escaping (_ model: SendMessageModel?) -> Void){
        let url = URL.init(string: basic_Url + API_SEND_MSG)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .post, parameter: params, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = SendMessageModel.sexy_json(data)
                    LennyModel.sendMessageModel = model
                    response(model)
                }
            }
        }
    }
    
    
    /////获取所有彩票信息借口 version：彩种版本(0-全部 1-官方 2-信用)
    static func obtainAllLotteryTypes(version: Int, response: @escaping (_ model: AllLotteryTypesModel?) -> Void) {
//        DispatchQueue.main.async {
//            if let model = LennyModel.allLotteryTypesModel {
//                response(model)
//            }
//        }
        let url = URL.init(string: basic_Url + path_ObtainAllLotteryTypes)
        let parameter = ["version": version]
        basic_Request(url: url!, method: .get, parameter: parameter, encoding: .default, header: nil) { (dataResponse) in
            
            dataResponse.result.ifSuccess {
                
                if let data = dataResponse.data {
                    let model = AllLotteryTypesModel.sexy_json(data)
                    LennyModel.allLotteryTypesModel = model
                    response(model)
                }
            }
            dataResponse.result.ifFailure {
                response(nil)
            }
        }
    }
    
    /////获取银行卡列表
    static func obtainBankList(response: @escaping (_ model: BankCardListModel?) -> Void) {
        DispatchQueue.main.async {
            if let model = LennyModel.bankCardListModel {
                response(model)
            }
        }
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        let url = URL.init(string: basic_Url + API_BANK_LIST)
        basic_Request(url: url!, method: .get, parameter: nil, encoding: .default, header: defaultHeader) { (dataResponse) in
            
            dataResponse.result.ifSuccess {
                
                if let data = dataResponse.data {
                    let model = BankCardListModel.sexy_json(data)
                    LennyModel.bankCardListModel = model
                    response(model)
                }
            }
            dataResponse.result.ifFailure {
                response(nil)
            }
        }
    }
    
    /////获取用户资料
    static func obtainUserinfo(response: @escaping (_ model: UserInfoModel?) -> Void) {
//        DispatchQueue.main.async {
//            if let model = LennyModel.userInfoMode {
//                response(model)
//            }
//        }
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        let url = URL.init(string: basic_Url + API_USER_INFO)
        basic_Request(url: url!, method: .get, parameter: nil, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = UserInfoModel.sexy_json(data)
                    LennyModel.userInfoMode = model
                    response(model)
                }
            }
            dataResponse.result.ifFailure {
                response(nil)
            }
        }
    }
    
    
//    // 修改用户资料
    static func modifyUserInfo(realName: String,username: String,phone: String,email: String,qq: String, wechat: String, response: @escaping (_ model: UserInfoModel?) -> Void) {
        let url = URL.init(string: basic_Url + API_ModifyUSER_INFO)
        
        var parameter:Dictionary<String,AnyObject> = [:]
        if realName.length > 0 {parameter["realName"] = realName as AnyObject}
        if username.length > 0 {parameter["username"] = username as AnyObject}
        if phone.length > 0 {parameter["phone"] = phone as AnyObject}
        if email.length > 0 {parameter["email"] = email as AnyObject}
        if qq.length > 0 {parameter["qq"] = qq as AnyObject}
        if wechat.length > 0 {parameter["wechat"] = wechat as AnyObject}

        print("pooooo = ",parameter)
        
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .post, parameter: parameter, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    print("data === \(data)")
                    let model = UserInfoModel.sexy_json(data)
                    LennyModel.userInfoMode = model
                    response(model)
                }
            }
           dataResponse.result.ifFailure {
                response(nil)
            }
        }
    }
    
    
    //获取团队报表列表数据
    static func obtainTeamReports(startTime:String,endTime:String,userName:String,pageNumber:Int,
                                    pageSize:Int, response: @escaping (_ model: TeamBaoBiaoModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + path_TeamReports)
        let parameter = ["startTime": startTime,"endTime": endTime,"username": userName,
                         "pageNumber": pageNumber,"pageSize": pageSize] as [String : Any]
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .get, parameter: parameter, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    print("data === \(data)")
                    let model = TeamBaoBiaoModel.sexy_json(data)
                    LennyModel.teamBaoBiaoModel = model
                    response(model)
                }
            }
            dataResponse.result.ifFailure {
                response(nil)
            }
        }
    }
    
    //获取个人报表列表数据
    static func obtainPersonReports(startTime:String,endTime:String,lotCode:String,queryType:Int,pageNumber:Int,
                                    pageSize:Int, response: @escaping (_ model: GeRenBaoBiaoModel?) -> Void) {
//        DispatchQueue.main.async {
//            if let model = LennyModel.geRenBaoBiaoModel {
//                response(model)
//            }
//        }
        let url = URL.init(string: basic_Url + path_PersonReports)
        let parameter = ["startTime": startTime,"endTime": endTime,"lotCode": lotCode,"queryType": queryType,
                         "pageNumber": pageNumber,"pageSize": pageSize] as [String : Any]
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .get, parameter: parameter, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = GeRenBaoBiaoModel.sexy_json(data)
                    LennyModel.geRenBaoBiaoModel = model
                    response(model)
                }
            }
            dataResponse.result.ifFailure {
                response(nil)
            }
        }
    }
    
    //获取账变报表列表数据
    //types:多个账变类型以逗号拼接
    static func obtainAccountChangeReports(startTime:String,endTime:String,include:Int,username:String,pageNumber:Int,
                                           pageSize:Int,types:String, response: @escaping (_ model: AccountChangeModel?) -> Void) {
        //        DispatchQueue.main.async {
        //            if let model = LennyModel.geRenBaoBiaoModel {
        //                response(model)
        //            }
        //        }
        let url = URL.init(string: basic_Url + API_ACCOUNT_CHANGE_LIST)
        let parameter = ["startTime": startTime,"endTime": endTime,"include": include,"username": username,"types":types,
                         "pageNumber": pageNumber,"pageSize": pageSize] as [String : Any]
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .get, parameter: parameter, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = AccountChangeModel.sexy_json(data)
                    LennyModel.accountChangeModel = model
                    response(model)
                }
            }
            dataResponse.result.ifFailure {
                response(nil)
            }
        }
    }
    
    static func obtainLotteryResults(pageNumber: Int, gameCode: String, response: @escaping (_ model: AllLotteryResultsModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + path_ObtainLotteryResults)
        let pageSize: Int = 20
        let parameter: Parameters = ["pageNumber": pageNumber,
                         "pageSize": pageSize,
                         "lotCode": gameCode]
//        print("kkkkkkkkkk = ",YiboPreference.getToken())
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        expandBasic_Request(maxAge:60,url: url!, method: .get, parameter: parameter, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = AllLotteryResultsModel.sexy_json(data)
                    LennyModel.allLotteryResultsModel = model
                    response(model)
                }
            }
        }
    }
    
    static func obtainLotteryData( response: @escaping (_ model: AllLotteryResultsModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + path_LotteryInfo)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .get, parameter: nil, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = AllLotteryResultsModel.sexy_json(data)
                    LennyModel.allLotteryResultsModel = model
                    response(model)
                }
            }
        }
    }
    
    static func obtainMessageReceiveList(response: @escaping (_ model: ReceiveMessageModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + path_Msg_Receive_list)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .get, parameter: nil, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = ReceiveMessageModel.sexy_json(data)
                    LennyModel.receiveMessageModel = model
                    response(model)
                }
            }
        }
    }
    
    static func obtainMessageSendList(response: @escaping (_ model: SendMessageModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + API_MSG_SEND_LIST)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .get, parameter: nil, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = SendMessageModel.sexy_json(data)
                    LennyModel.sendMessageModel = model
                    response(model)
                }
            }
        }
    }
    
    static func readMessage(sid:Int64,rid:Int64,response: @escaping (_ model: ReadMessageModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + API_READ_MESSAGE)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .post, parameter: ["rid":rid,"sid":sid], encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = ReadMessageModel.sexy_json(data)
                    LennyModel.readMessageModel = model
                    response(model)
                }
            }
        }
    }
    
    static func deleteReceiveMessage(receiveMessageId: Int64,response: @escaping (_ model: ReadMessageModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + API_DELETE_MESSAGE)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .post, parameter: ["ids":receiveMessageId], encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = ReadMessageModel.sexy_json(data)
                    LennyModel.readMessageModel = model
                    response(model)
                }
            }
        }
    }
    
    static func deleteSentMessage(messageId: Int64,response: @escaping (_ model: SendMessageModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + API_DELETE_SEND_MESSAGE)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .post, parameter: ["ids":messageId], encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = SendMessageModel.sexy_json(data)
                    LennyModel.sendMessageModel = model
                    response(model)
                }
            }
        }
    }
    
    static func deleteMessage(rid:Int,response: @escaping (_ model: ReadMessageModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + API_DELETE_MESSAGE)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .post, parameter: ["rid":rid], encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = ReadMessageModel.sexy_json(data)
                    LennyModel.readMessageModel = model
                    response(model)
                }
            }
        }
    }
    
    
    //查询购彩记录请求方法
    static func obtainLotteryQuery(lotteryCode: String, startTime: String, endTime: String, qihao: String, version: String, order: String, zuihaoOrder: String, status: String, queryType: String, playCode: String, include: String, username: String, pageSize: String,pageNumber: String,response: @escaping (_ model: AllLotteryQueryModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + path_LotteryQuery)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-Agent"] = String.init(format: "ios/%@", getVerionName())
        let parameter: Parameters = [
                                    "lotCode": lotteryCode,
                                     "startTime": startTime,
                                     "endTime": endTime,
                                     "qihao": qihao,
                                     "version": version,
//                                     "order": order,
                                     "zuihaoOrder": zuihaoOrder,
                                     "status": status,
                                     "queryType": queryType,
                                     "playCode": playCode,
                                     "include": include,
                                     "username": username,
                                     "pageSize": pageSize,
                                     "pageNumber":pageNumber
        ]
        
        basic_Request(url: url!, method: .get, parameter: parameter, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = AllLotteryQueryModel.sexy_json(data)
//                    LennyModel.allLotteryQueryModel = model
                    response(model)
                }
            }
        }
    }
    
    //查询充值记录接口方法
    //type 0、充值记录 1.提现记录
    static func obtainChargeQuery(order: String, startTime: String, endTime: String, type:Int,pageNumber: Int, pageSize:Int, response: @escaping (_ model: ChargeModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + API_CHARGERECORDLIST)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-Agent"] = String.init(format: "ios/%@", getVerionName())
        let parameter: Parameters = [
                                     "startTime": startTime,
                                     "endTime": endTime,
                                     "order": order,
                                     "type": type,
                                     "pageSize": pageSize,
                                     "pageNumber":pageNumber]
        basic_Request(url: url!, method: .get, parameter: parameter, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = ChargeModel.sexy_json(data)
                    LennyModel.chargeModel = model
                    response(model)
                }
            }
        }
    }
    
    //查询账变类型接口方法
    static func obtainAccountChangeTypesQuery(response: @escaping (_ model: AccountTypesModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + API_ACCOUNT_CHANGE_TYPES)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-Agent"] = String.init(format: "ios/%@", getVerionName())
        basic_Request(url: url!, method: .get, parameter: nil, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = AccountTypesModel.sexy_json(data)
                    LennyModel.accountTypesModel = model
                    response(model)
                }
            }
        }
    }
    
    //查询提款记录接口方法
    //type 0、充值记录 1.提现记录
    static func obtainWidthdrawQuery(order: String, startTime: String, endTime: String, type:Int,pageNumber: Int, pageSize:Int, response: @escaping (_ model: WithdrawModel?) -> Void) {
        
        let url = URL.init(string: basic_Url + API_CHARGERECORDLIST)
        defaultHeader["Cookie"] = "SESSION="+YiboPreference.getToken()
        defaultHeader["User-Agent"] = String.init(format: "ios/%@", getVerionName())
        let parameter: Parameters = [
            "startTime": startTime,
            "endTime": endTime,
            "order": order,
            "type": type,
            "pageSize": pageSize,
            "pageNumber":pageNumber]
        basic_Request(url: url!, method: .get, parameter: parameter, encoding: .default, header: defaultHeader) { (dataResponse) in
            dataResponse.result.ifFailure {
                response(nil)
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data {
                    let model = WithdrawModel.sexy_json(data)
                    LennyModel.withdrawModel = model
                    response(model)
                }
            }
        }
    }
    
    
    
    
    
}
