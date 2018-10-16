//
//  LennyModelSaving.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class LennyModel: NSObject { }
 var kBrokenLineItems = "kBrokenLineItems"
private var kLastArray = "kLastArray"
private var kBrokenLineItems_Pointer = "brokenLineItems_Pointer"
extension LennyModel {
    
    static var allLotteryQueryModel: AllLotteryQueryModel? {
        get {
            if let model = WHC_ModelSqlite.query(AllLotteryQueryModel.self).first {
                return model as? AllLotteryQueryModel
            }else {
                return nil
            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(AllLotteryQueryModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var chargeModel: ChargeModel? {
        get {
            if let model = WHC_ModelSqlite.query(ChargeModel.self).first {
                return model as? ChargeModel
            }else {
                return nil
            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(ChargeModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var withdrawModel: WithdrawModel? {
        get {
            if let model = WHC_ModelSqlite.query(WithdrawModel.self).first {
                return model as? WithdrawModel
            }else {
                return nil
            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(WithdrawModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var allLotteryTypesModel: AllLotteryTypesModel? {
        get {
            if let model = WHC_ModelSqlite.query(AllLotteryTypesModel.self).first {
                return model as? AllLotteryTypesModel
            }else {
                return nil
            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(AllLotteryTypesModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var bankCardListModel: BankCardListModel? {
        get {
            if let model = WHC_ModelSqlite.query(BankCardListModel.self).first {
                return model as? BankCardListModel
            }else {
                return nil
            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(BankCardListModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var userInfoMode: UserInfoModel? {
        get {
            if let model = WHC_ModelSqlite.query(UserInfoModel.self).first {
                return model as? UserInfoModel
            }else {
                return nil
            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(UserInfoModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var accountTypesModel: AccountTypesModel? {
        get {
            if let model = WHC_ModelSqlite.query(AccountTypesModel.self).first {
                return model as? AccountTypesModel
            }else {
                return nil
            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(AccountTypesModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var modifyPwdResultModel: ModifyPwdResultModel? {
        get {
            if let model = WHC_ModelSqlite.query(ModifyPwdResultModel.self).first {
                return model as? ModifyPwdResultModel
            }else {
                return nil
            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(ModifyPwdResultModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    
    static var geRenBaoBiaoModel: GeRenBaoBiaoModel? {
        get {
            if let model = WHC_ModelSqlite.query(GeRenBaoBiaoModel.self).first {
                return model as? GeRenBaoBiaoModel
            }else {
                return nil
            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(GeRenBaoBiaoModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var teamBaoBiaoModel: TeamBaoBiaoModel? {
        get {
//            if let model = WHC_ModelSqlite.query(GeRenBaoBiaoModel.self).first {
//                return model as? GeRenBaoBiaoModel
//            }else {
                return nil
//            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(GeRenBaoBiaoModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var accountChangeModel: AccountChangeModel? {
        get {
            if let model = WHC_ModelSqlite.query(AccountChangeModel.self).first {
                return model as? AccountChangeModel
            }else {
                return nil
            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(AccountChangeModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var allLotteryResultsModel: AllLotteryResultsModel?
//        get {
////            if let model = WHC_ModelSqlite.query(AllLotteryResultsModel.self).first {
////                return model as? AllLotteryResultsModel
////            }else {
//                return nil
////            }
//        }
//        set {
//            if let _ = WHC_ModelSqlite.query(AllLotteryResultsModel.self).first {
//                WHC_ModelSqlite.update(newValue, where: "")
//            }else {
//                WHC_ModelSqlite.insert(newValue)
//            }
//        }
        
//    }

    static var receiveMessageModel: ReceiveMessageModel? {
        get {
            //            if let model = WHC_ModelSqlite.query(AllLotteryResultsModel.self).first {
            //                return model as? AllLotteryResultsModel
            //            }else {
            return nil
            //            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(ReceiveMessageModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var sendMessageModel: SendMessageModel? {
        get {
            //            if let model = WHC_ModelSqlite.query(AllLotteryResultsModel.self).first {
            //                return model as? AllLotteryResultsModel
            //            }else {
            return nil
            //            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(SendMessageModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var readMessageModel: ReadMessageModel? {
        get {
            //            if let model = WHC_ModelSqlite.query(AllLotteryResultsModel.self).first {
            //                return model as? AllLotteryResultsModel
            //            }else {
            return nil
            //            }
        }
        set {
            if let _ = WHC_ModelSqlite.query(ReadMessageModel.self).first {
                WHC_ModelSqlite.update(newValue, where: "")
            }else {
                WHC_ModelSqlite.insert(newValue)
            }
        }
    }
    
    static var lastArray: [String]? {
        get {
            return objc_getAssociatedObject(self, &kLastArray) as? [String]
        }
        set {
            objc_setAssociatedObject(self, &kLastArray, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
