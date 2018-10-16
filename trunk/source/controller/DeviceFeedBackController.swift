//
//  DeviceFeedBackController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/19.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class DeviceFeedBackController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var inputText:CustomFeildText!
    @IBOutlet weak var commitBtn:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupthemeBgView(view: self.view)
        self.navigationItem.title = "建议反馈"
        inputText.delegate = self
        commitBtn.layer.cornerRadius = 5
        commitBtn.theme_backgroundColor = "Global.themeColor"
        commitBtn.addTarget(self, action: #selector(onCommit), for: UIControlEvents.touchUpInside)
    }
    
    @objc func onCommit() -> Void {
        if isEmptyString(str: inputText.text!){
            showToast(view: self.view, txt: "请输入您的建议")
            return
        }
        showToast(view: self.view, txt: "提交建议成功，感谢您的支持")
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
