//
//  TueijianAddViewController.swift
//  gameplay
//
//  Created by William on 2018/8/19.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
//LennyBasicViewController
class TueijianAddViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var myUserName: UITextField!
    @IBOutlet weak var passwords: UITextField!
    @IBOutlet weak var surepassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加会员"
        
        myUserName.delegate = self
        passwords.delegate = self
        surepassword.delegate = self
        
        myUserName.borderStyle = .none//边框样式
        passwords.borderStyle = .none//边框样式
        surepassword.borderStyle = .none//边框样式
        
        myUserName.clearButtonMode = .always  //一直显示清除按钮
        passwords.clearButtonMode = .always
        surepassword.clearButtonMode = .always
        
        passwords.isSecureTextEntry = true //输入内容会显示成小黑点
        surepassword.isSecureTextEntry = true
    }
    
    //点击return键响应的方法
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        return true
    }
    
    //点屏幕回收键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //收起键盘
        myUserName.resignFirstResponder()
        passwords.resignFirstResponder()
        surepassword.resignFirstResponder()
    }
    
    @IBAction func action01(_ sender: UIButton) {
        //收起键盘
        myUserName.resignFirstResponder()
        passwords.resignFirstResponder()
        surepassword.resignFirstResponder()
        
        if self.passwords.text != self.surepassword.text {
            showToast(view: self.view, txt: convertString(string: "两次密码不一致"))
            return
        }
        
        let vc =  BaseController()
        vc.request(frontDialog: true, method: .post, loadTextStr: "正在添加...", url:SAVE_MY_RECOMMENDED_URL, params: ["username":self.myUserName.text!,"password":self.passwords.text!] ) { (resultJson:String, resultStatus:Bool) in
            
            print(resultJson)
            if !resultStatus {
                if resultJson.isEmpty {
                    showToast(view: self.view, txt: convertString(string: "添加失败"))
                }else{
                    showToast(view: self.view, txt: resultJson)
                }
                return
            }
            
            if let result = TueijainAdd.deserialize(from: resultJson) {
                if result.success{
                    showToast(view: self.view, txt: convertString(string: "添加成功"))
                    //点击发送通知
                    NotificationCenter.default.post(name: NSNotification.Name("tueijianJump"), object: self, userInfo: ["post":"you are ready to jump!"])
                }else{
                    if isEmptyString(str: result.msg){
                        showToast(view: self.view, txt: result.msg)
                    }else{
                        showToast(view: self.view, txt: "添加失败")
                    }
                }
            }
           
        }
    }
    
    //最后要记得移除通知
    deinit {
        /// 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
