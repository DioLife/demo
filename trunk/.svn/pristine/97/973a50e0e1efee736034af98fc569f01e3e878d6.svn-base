//
//  ModifyPwdController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/19.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class ModifyPwdController: BaseController,UITextFieldDelegate {
    
    @IBOutlet weak var opwdInput:CustomFeildText!
    @IBOutlet weak var npwdInput:CustomFeildText!
    @IBOutlet weak var apwdInput:CustomFeildText!
    @IBOutlet weak var btn:UIButton!
    var isLoginPwdModify = false

    override func viewDidLoad() {
        super.viewDidLoad()
        btn.addTarget(self, action: #selector( onBtnClick), for: UIControlEvents.touchUpInside)
        opwdInput.delegate = self
        npwdInput.delegate = self
        apwdInput.delegate = self
        if isLoginPwdModify{
            self.navigationItem.title = "登陆密码修改"
        }else{
            self.navigationItem.title = "取款密码修改"
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        btn.layer.cornerRadius = 20
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func onBtnClick(){
        let old = opwdInput.text
        let new = npwdInput.text
        let anew = apwdInput.text
        
        if isEmptyString(str: old!){
            showToast(view: self.view, txt: "请输入旧密码")
            return
        }
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
        
        request(frontDialog: true,method: .post, loadTextStr:"正在提交修改...",url: isLoginPwdModify ? MODIFY_LOGIN_PASS : MODIFY_CASH_PASS,params: ["oldpassword":old!,"newpassword":new!,"confirmpassword":anew!],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "修改失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = ActivesResultWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            if self.isLoginPwdModify{
                                showToast(view: self.view, txt: "修改密码成功,请重新登陆")
                                let time: TimeInterval = 0.5
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                                    self.navigationController?.popViewController(animated: true)
                                    self.dismiss(animated: true, completion: nil)
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }else{
                                showToast(view: self.view, txt: "修改取款密码成功")
                                let time: TimeInterval = 0.5
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                                    self.navigationController?.popViewController(animated: true)
                                    self.dismiss(animated: true, completion: nil)
                                }
                            }
                            
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "修改失败"))
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
