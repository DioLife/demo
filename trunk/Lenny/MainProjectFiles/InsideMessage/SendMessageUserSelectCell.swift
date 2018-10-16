//
//  SendMessageTitleCell.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/8.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

protocol DownLevelUserDelegate {
    func selectedUsed(id:String,hasData:Bool)
}

class SendMessageUserSelectCell: UITableViewCell {
    var isSelect = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var controller:UIViewController?
    var datas:[UserListSmallBean]?
    let selectedUser = UIButton()
    var selectedNames:[String] = []
    var delegate:DownLevelUserDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let label = UILabel()
        contentView.addSubview(label)
        label.whc_Top(13).whc_Height(12).whc_Left(13).whc_WidthAuto().whc_Bottom(15)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.ccolor(with: 0, g: 0, b: 0)
        label.text = "用户："
        
        contentView.addSubview(selectedUser)
        selectedUser.whc_Width(300).whc_Right(20).whc_Height(30).whc_CenterY(0)
        selectedUser.setTitle("请选择下级用户", for: .normal)
        selectedUser.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        selectedUser.addTarget(self, action: #selector(selectUser), for: .touchUpInside)
        selectedUser.setTitleColor(UIColor.black, for: .normal)
        
        self.whc_AddBottomLine(1, color: UIColor.ccolor(with: 224, g: 224, b: 224))
        selectionStyle = .none
        
    }
    
    func updateView(isup:Bool){
        if isup{
            self.isHidden = true
        }else{
            self.isHidden = false
        }
    }
    
    func bind(controller:UIViewController,datas:[UserListSmallBean]){
        self.controller = controller
        self.datas = datas
        
        if (isSelect == false) {
            isSelect = true
            showDownUserDialog(controller: controller, data: datas)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isSelect = false
            }
        }
        
    }
    
    @objc func selectUser(){
        if self.datas != nil{
            
            if (isSelect == false) {
                isSelect = true
                showDownUserDialog(controller:self.controller!,data:self.datas!)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isSelect = false
                }
            }
            
        }else{
            if let delegate = self.delegate{
                delegate.selectedUsed(id: "", hasData: false)
            }
        }
    }
    
    private func showDownUserDialog(controller:UIViewController,data:[UserListSmallBean]){
        
        var names:[String] = []
        for item in data{
            if let name = item.username{
                names.append(name)
            }
        }
        if names.isEmpty{
            return
        }
        let selectedView = LennySelectView(dataSource: names, viewTitle: "请选择用户")
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            if let delegate = self?.delegate{
                if !(self?.selectedNames.contains(names[index]))!{
                    self?.selectedNames.append(names[index])
                }
                self?.updateTitles()
                delegate.selectedUsed(id: String(data[index].id), hasData: true)
            }
        }
        controller.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
            //            self.setSelected(false, animated: true)
        }
    }
    
    private func updateTitles(){
        if !self.selectedNames.isEmpty{
            var names = ""
            for name in self.selectedNames{
                names += name
                names += ","
            }
            names = (names as NSString).substring(to: names.count - 1)
            self.selectedUser.setTitle(names, for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
