//
//  SetBankPwdController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/1.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class SetBankPwdController: BaseController,UITextFieldDelegate {

    @IBOutlet weak var npwdInput:CustomFeildText!
    @IBOutlet weak var apwdInput:CustomFeildText!
    @IBOutlet weak var btn:UIButton!
    var delegate:BankDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.addTarget(self, action: #selector( onBtnClick), for: UIControlEvents.touchUpInside)
        btn.theme_backgroundColor = "Global.themeColor"
        btn.layer.cornerRadius = 5
        npwdInput.delegate = self
        apwdInput.delegate = self
        self.navigationItem.title = "设置提款密码"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func onBtnClick(){
        let new = npwdInput.text
        let anew = apwdInput.text
    
        if isEmptyString(str: new!){
            showToast(view: self.view, txt: "请输入新密码")
            return
        }
        if !limitPwd(account: new!){
            showToast(view: self.view, txt: "密码请输入6-16个英文字母和数字组合")
            return
        }
        if isEmptyString(str: anew!){
            showToast(view: self.view, txt: "请再次输入新密码")
            return
        }
        if new! != anew!{
            showToast(view: self.view, txt: "两次密码设置不一致")
            return
        }
        
        request(frontDialog: true,method: .post, loadTextStr:"正在提交...",url: POST_SET_BANK_PWD_URL,
                params: ["oldPwd":"","newPwd":new!,"okPwd":anew!,"type":"2"],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "设置失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = SetBankPwdWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            showToast(view: self.view, txt: "设置密码成功")
                            //回调通知提款界面重新检测帐户信息
                            if let delegate = self.delegate{
                                delegate.onBankSetting()
                            }
                            self.navigationController?.popViewController(animated: true)
//                            self.dismiss(animated: true, completion: nil)
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "设置失败"))
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
}
