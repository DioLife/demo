//
//  AddBankCardSelectCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class AddBankCardSelectCell: UITableViewCell {
    var isSelect = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var bankDatas:[String] = []
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private let button_Select = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = UIFont.systemFont(ofSize: 12)
        textLabel?.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        contentView.addSubview(button_Select)
        
        button_Select.whc_CenterY(0).whc_Left(100).whc_Top(5).whc_Bottom(5).whc_Height(40).whc_Right(20)
        button_Select.setTitle("", for: .normal)
        button_Select.setTitleColor(UIColor.ccolor(with: 51, g: 51, b: 51), for: .normal)
        button_Select.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button_Select.setImage(UIImage(named: "pulldown"), for: .normal)
        contentView.layoutIfNeeded()
        button_Select.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -button_Select.width)
        button_Select.titleEdgeInsets = UIEdgeInsetsMake(0, -button_Select.width, 0, 0)
        button_Select.setTitleShadowColor(UIColor.ccolor(with: 136, g: 136, b: 136), for: .highlighted)
        button_Select.addTarget(self, action: #selector(button_SelectorClickHandle), for: .touchUpInside)
        
        self.whc_AddBottomLine(0.5, color: UIColor.ccolor(with: 224, g: 224, b: 224))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setTitleLabelText(value: String) {
        textLabel?.text = value
    }
    
    func cellTransferType() -> (Int, String) {
        
        return (selectedIndex, kLenny_TransferTypes[selectedIndex])
    }
    
    private var selectedIndex: Int = 0
    
    @objc private func button_SelectorClickHandle() {
        if (isSelect == false) {
            isSelect = true
            showSelectedView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isSelect = false
            }
        }
    }
    
    private func showSelectedView() {
        if self.bankDatas.isEmpty{
            return
        }
        setSelected(true, animated: true)
        let selectedView = LennySelectView(dataSource: bankDatas, viewTitle: "请选择开户银行")
        selectedView.selectedIndex = selectedIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.button_Select.setTitle(selectedView.kLenny_InsideDataSource[index], for: .normal)
            self?.selectedIndex = index
            
        }
        self.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
            self.setSelected(false, animated: true)
        }
    }
}
