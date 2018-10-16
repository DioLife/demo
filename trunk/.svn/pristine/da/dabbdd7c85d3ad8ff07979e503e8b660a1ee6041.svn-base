//
//  SendMessageReceiverTableViewCell.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/8.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

protocol LevelSelectDelegate {
    func onLevelDelegate(up:Bool)
}

class SendMessageReceiverCell: UITableViewCell {

    var delegate:LevelSelectDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

     let label_Title = UILabel()
     let button_SuperiorLeader = UIButton()
     let button_Subordinate = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNoPictureAlphaBgView(view: self)
        
        contentView.addSubview(label_Title)
        label_Title.whc_Top(12).whc_Left(12).whc_Height(12).whc_WidthAuto().whc_Bottom(15)
        label_Title.font = UIFont.systemFont(ofSize: 12)
        label_Title.textColor = UIColor.ccolor(with: 0, g: 0, b: 0)
        label_Title.text = "收件人："
        
        contentView.addSubview(button_SuperiorLeader)
        button_SuperiorLeader.whc_CenterYEqual(label_Title).whc_CenterX(-50).whc_Width(60).whc_Height(15)
        button_SuperiorLeader.setImage(UIImage(named: "receiver_selected"), for: .normal)
        button_SuperiorLeader.setTitle("上级", for: .normal)
        button_SuperiorLeader.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        button_SuperiorLeader.setTitleColor(UIColor.ccolor(with: 136, g: 136, b: 136), for: .normal)
        setThemeButtonTitleColorGlassWhiteOtherGray(button: button_SuperiorLeader)
        button_SuperiorLeader.isSelected = true
        button_SuperiorLeader.addTarget(self, action: #selector(buttonSuperiorClickHandle(button:)), for: .touchUpInside)
        
        contentView.addSubview(button_Subordinate)
        button_Subordinate.whc_CenterYEqual(label_Title).whc_CenterX(50).whc_Width(60).whc_Height(15)
        button_Subordinate.setImage(UIImage(named: "receiver_noselected"), for: .normal)
        button_Subordinate.setTitle("下级", for: .normal)
        button_Subordinate.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        setThemeButtonTitleColorGlassWhiteOtherGray(button: button_Subordinate)
        button_Subordinate.isSelected = false
        button_Subordinate.addTarget(self, action: #selector(buttonSubordinateClickHandle(button:)), for: .touchUpInside)
        
        self.whc_AddBottomLine(1.0, color: UIColor.ccolor(with: 224, g: 224, b: 224))
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonSuperiorClickHandle(button: UIButton) {
        
        button.isSelected = true
        button.setImage(UIImage(named: "receiver_selected"), for: .normal)
        
        button_Subordinate.isSelected = false
        button_Subordinate.setImage(UIImage(named: "receiver_noselected"), for: .normal)
        if let delegate = self.delegate{
            delegate.onLevelDelegate(up: true)
        }
    }
    
    @objc private func buttonSubordinateClickHandle(button: UIButton) {
        
        button.isSelected = true
        button.setImage(UIImage(named: "receiver_selected"), for: .normal)
        
        button_SuperiorLeader.isSelected = false
        button_SuperiorLeader.setImage(UIImage.init(named: "receiver_noselected"), for: .normal)
        if let delegate = self.delegate{
            delegate.onLevelDelegate(up: false)
        }
    }
    
    
}
