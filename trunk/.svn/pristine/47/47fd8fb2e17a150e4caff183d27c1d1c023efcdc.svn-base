//
//  BankCardCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/18.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class BankCardCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private let label_BankNameTitle = UILabel()
    private let label_SubTitle = UILabel()
    private let label_Detail = UILabel()
    private let label_BanCardNumber = UILabel()
    
    func setModel(model: BankCardModel) {
        label_BankNameTitle.text = model.bankName
        label_SubTitle.text = model.bankNameSubtitle
        label_Detail.text = model.detail
        label_BanCardNumber.text = model.bankCardNumber
    }
    
    func setModel(bankListModel:BankCardListContent){
        label_BankNameTitle.text = bankListModel.bankName
//        label_SubTitle.text = bankListModel.bankAddress
        label_SubTitle.isHidden = true
        label_Detail.text = bankListModel.bankAddress
        label_BanCardNumber.text = bankListModel.cardNo
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViewBackgroundColorTransparent(view: self)
        
        let imageViewBG = UIImageView()
        contentView.addSubview(imageViewBG)
        imageViewBG.whc_Top(10).whc_Left(13).whc_Right(13).whc_Height(100).whc_Bottom(5)
//        imageViewBG.image = UIImage(named: "topup_bankcard")
        imageViewBG.layer.borderColor = UIColor.white.cgColor
        imageViewBG.layer.borderWidth = 1
        imageViewBG.layer.cornerRadius = 3.0
        imageViewBG.layer.masksToBounds = true
        setupNoPictureAlphaBgView(view: imageViewBG, bgViewColor: "MemberPage.bankCardBgViewColor")
        
        let imageView_Icon = UIImageView()
        imageViewBG.addSubview(imageView_Icon)
        imageView_Icon.whc_Top(12).whc_Left(25).whc_Width(30).whc_Height(30)
//        imageView_Icon.image = UIImage(named: "topup_icbcicon")
        imageView_Icon.theme_image = "MemberPage.bankCardTag"
        
        imageViewBG.addSubview(label_BankNameTitle)
        label_BankNameTitle.whc_Top(15).whc_Left(85).whc_WidthAuto().whc_Height(15)
        label_BankNameTitle.font = UIFont.boldSystemFont(ofSize: 15)
        label_BankNameTitle.textColor = UIColor.white
        
        imageViewBG.addSubview(label_SubTitle)
        label_SubTitle.whc_Top(8, toView: label_BankNameTitle).whc_LeftEqual(label_BankNameTitle).whc_WidthAuto().whc_Height(13)
        label_SubTitle.font = UIFont.systemFont(ofSize: 10)
        label_SubTitle.textColor = UIColor.colorWithRGB(r: 255, g: 255, b: 255, alpha: 0.5)
        
        imageViewBG.addSubview(label_Detail)
        label_Detail.whc_Top(3, toView: label_SubTitle).whc_LeftEqual(label_BankNameTitle).whc_WidthAuto().whc_Height(12)
        label_Detail.font = UIFont.systemFont(ofSize: 10)
        label_Detail.textColor = UIColor.colorWithRGB(r: 255, g: 255, b: 255, alpha: 0.5)
        
        imageViewBG.addSubview(label_BanCardNumber)
        label_BanCardNumber.whc_Top(10, toView: label_Detail).whc_LeftEqual(label_BankNameTitle).whc_WidthAuto().whc_Height(15)
        label_BanCardNumber.font = UIFont.systemFont(ofSize: 15)
        label_BanCardNumber.textColor = UIColor.white
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
