//
//  BetHistorylistFilterView.swift
//  gameplay
//
//  Created by admin on 2018/8/17.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit

class BetHistorylistFilterView: UIView {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var platformNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        
        cancelButton.layer.cornerRadius = 3.0
        cancelButton.layer.masksToBounds = true
        confirmButton.layer.cornerRadius = 3.0
        confirmButton.layer.masksToBounds = true
        
        setupBorder(view: firstTextField)
        setupBorder(view: secondTextField)
        setupBorder(view: platformNameLabel)
        setupBorder(view: startTimeLabel)
        setupBorder(view: endTimeLabel)
    }
    
    private func setupBorder(view: UIView) {
        view.layer.cornerRadius = 3.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.cc_224().cgColor
        view.clipsToBounds = true
    }
    
    var didClickCancelAcion: (() -> Void)?
    var didClickConfirmAction: (() -> Void)?
    var didClickStartTimeAction: (() -> Void)?
    var didClickEndTimeaAction: (() -> Void)?
    var didClickPlatformAction: (() -> Void)?
    
    @IBAction func cancelAction(_ sender: UIButton) {
        didClickCancelAcion?()
    }
    
    
    @IBAction func confirmAction(_ sender: UIButton) {
        didClickConfirmAction?()
    }
    
    @IBAction func platformShowAction(_ sender: UIButton) {
        didClickPlatformAction?()
    }
    
    @IBAction func startTimeShow(_ sender: UIButton) {
        didClickStartTimeAction?()
    }
    
    @IBAction func endTimeShow(_ sender: UIButton) {
        didClickEndTimeaAction?()
    }

}
