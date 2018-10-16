//
//  GeRenZongLanCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class GeRenZongLanCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private let label1_Title = UILabel()
    private let label2_Title = UILabel()
    private let label3_Title = UILabel()
    
    private let label1_Value = UILabel()
    private let label2_Value = UILabel()
    private let label3_Value = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = WHC_StackView()
        stackView.whc_Column = 3
        stackView.whc_Orientation = .all
        contentView.addSubview(stackView)
        stackView.whc_Height(40).whc_Top(0).whc_Bottom(0).whc_Left(0).whc_Right(0)
        
        label1_Title.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        label1_Title.font = UIFont.systemFont(ofSize: 12)
        label1_Title.textAlignment = .center
        stackView.addSubview(label1_Title)
        
        label2_Title.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        label2_Title.font = UIFont.systemFont(ofSize: 12)
        label2_Title.textAlignment = .center
        stackView.addSubview(label2_Title)
        
        label3_Title.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        label3_Title.font = UIFont.systemFont(ofSize: 12)
        label3_Title.textAlignment = .center
        stackView.addSubview(label3_Title)
        
        label1_Value.textColor = UIColor.mainColor()
        label1_Value.font = UIFont.systemFont(ofSize: 12)
        label1_Value.textAlignment = .center
        stackView.addSubview(label1_Value)
        
        label2_Value.textColor = UIColor.mainColor()
        label2_Value.font = UIFont.systemFont(ofSize: 12)
        label2_Value.textAlignment = .center
        stackView.addSubview(label2_Value)
        
        label3_Value.textColor = UIColor.mainColor()
        label3_Value.font = UIFont.systemFont(ofSize: 12)
        label3_Value.textAlignment = .center
        stackView.addSubview(label3_Value)
        
        stackView.whc_StartLayout()
        
        whc_AddBottomLine(0.5, color: UIColor.ccolor(with: 224, g: 224, b: 224))
    }
    
    func setTitles(titles: [String]) {
        label1_Title.text = titles[0]
        label2_Title.text = titles[1]
        label3_Title.text = titles[2]
    }
    func setValues(values: [String]) {
        label1_Value.text = values[0]
        label2_Value.text = values[1]
        label3_Value.text = values[2]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
