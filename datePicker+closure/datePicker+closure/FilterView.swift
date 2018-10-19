//
//  FilterView.swift
//  YiboGameIos
//
//  Created by William on 2018/10/17.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class FilterView: UIView,UITextFieldDelegate {
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var startTimeTF: UITextField!
    @IBOutlet weak var endTimeTF: UITextField!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var cancelBtnValueClousure:((_ text:String)->Void)?
    var sureBtnValueClousure:((_ userName:String, _ startTime:String, _ endTime:String)->Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myTextField.delegate = self
        
        let backview = Bundle.main.loadNibNamed("MyDatePicker", owner: self, options: nil)?.last as! MyDatePicker
//        backview.backgroundColor = UIColor.yellow
        startTimeTF.inputView = backview
        backview.cancelBtnValue = {(text:String) -> Void in
            print(text)
            self.myTextField.resignFirstResponder()
            self.startTimeTF.resignFirstResponder()
            self.endTimeTF.resignFirstResponder()
        }
        backview.sureBtnValue = {(text:String) -> Void in
            print(text)
            self.startTimeTF.text = text
            self.myTextField.resignFirstResponder()
            self.startTimeTF.resignFirstResponder()
            self.endTimeTF.resignFirstResponder()
        }
        
        
        
        let backview2 = Bundle.main.loadNibNamed("MyDatePicker", owner: self, options: nil)?.last as! MyDatePicker
//        backview2.backgroundColor = UIColor.orange
        endTimeTF.inputView = backview2
        backview2.cancelBtnValue = {(text:String) -> Void in
            print(text)
            self.myTextField.resignFirstResponder()
            self.startTimeTF.resignFirstResponder()
            self.endTimeTF.resignFirstResponder()
        }
        backview2.sureBtnValue = {(text:String) -> Void in
            print(text)
            self.endTimeTF.text = text
            self.myTextField.resignFirstResponder()
            self.startTimeTF.resignFirstResponder()
            self.endTimeTF.resignFirstResponder()
        }
        
        
        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
    
    @objc func sureAction() {
        self.myTextField.resignFirstResponder()
        self.startTimeTF.resignFirstResponder()
        self.endTimeTF.resignFirstResponder()
        if self.sureBtnValueClousure != nil {
            self.sureBtnValueClousure!(myTextField.text!, startTimeTF.text!, endTimeTF.text!)
        }
    }
    
    @objc func cancelAction() {
        self.myTextField.resignFirstResponder()
        self.startTimeTF.resignFirstResponder()
        self.endTimeTF.resignFirstResponder()
        if self.cancelBtnValueClousure != nil {
            self.cancelBtnValueClousure!("cancel")
        }
    }
    
    
    //点击return键响应的方法
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
