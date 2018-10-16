//
//  NewBigPanWiningCell.swift
//  gameplay
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit

class NewBigPanWiningCell: UITableViewCell {
    var winningLable = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        self.winningLable.backgroundColor = UIColor.white.withAlphaComponent(0)
        self.addSubview(winningLable)
        winningLable.whc_Left(0).whc_Right(0).whc_Top(0).whc_Bottom(0)
        winningLable.textColor = UIColor.black
        winningLable.font = UIFont.systemFont(ofSize: 14.0)
        winningLable.textAlignment = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
