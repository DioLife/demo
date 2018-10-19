//
//  MyDatePicker.swift
//  YiboGameIos
//
//  Created by William on 2018/10/18.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class MyDatePicker: UIView {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var MyDatePicker: UIDatePicker!
    
    var dateString = ""
    
    var sureBtnValue:((_ text:String)->Void)?
    var cancelBtnValue:((_ text:String)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        MyDatePicker.addTarget(self, action: #selector(getDate(datePicker:)), for: UIControlEvents.valueChanged)
        
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
    }
    
    // MARK: - 日期选择器选择处理方法
    @objc func getDate(datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        let date = datePicker.date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = formatter.string(from: date)
        self.dateString = dateStr
//        print(dateStr)
    }
    
    @objc func cancelAction() {
        if self.cancelBtnValue != nil {
            self.cancelBtnValue!("startAction")
        }
    }
    
    @objc func sureAction() {
        if self.sureBtnValue != nil {
            self.sureBtnValue!(self.dateString)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
