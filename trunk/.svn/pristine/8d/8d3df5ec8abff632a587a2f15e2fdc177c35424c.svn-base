//
//  SelectLotteryTypeView.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/9.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

protocol NewSelectViewDelegate {
    func gotoBrowerWithType(type: Int,allways: Bool)
}

class NewSelectView: UIView {
    
    var delegate:NewSelectViewDelegate?
    static let cellIdentifier = "newSelectViewCell"
    static let fixedTableViewRowHeight: CGFloat = 51.0

    var selectedIndex: Int = 0
    var didSelected: ( ( Int, String) -> Void)?
    var kLenny_InsideDataSource: [(String,String)]!
    
    var kTitleLabelHeight: CGFloat = 44
    let bottomHeight:CGFloat = 44
    
    var kHeight: CGFloat {
        let h = NewSelectView.fixedTableViewRowHeight * CGFloat(kLenny_InsideDataSource.count) + kTitleLabelHeight + bottomHeight
        return  h <  300 ? h : 300
    }
    
    private var mainTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(dataSource: [(icon:String,title:String)], viewTitle: String) {
        self.init(frame: CGRect.zero)
        kLenny_InsideDataSource = dataSource
        
        let label = UILabel()
        addSubview(label)
        label.whc_Top(0).whc_Left(0).whc_Right(0).whc_Height(kTitleLabelHeight)
        label.theme_backgroundColor = "Global.themeColor"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = viewTitle
        label.textAlignment = .center
        
        let closeBtn = UIButton()
        addSubview(closeBtn)
        closeBtn.whc_CenterY(0,toView: label).whc_Right(8).whc_Width(20).whc_Height(20)
        closeBtn.setImage(UIImage(named: "closeButtonImg"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        
        let nib = UINib(nibName: "NewSelectedViewCell", bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: "newSelectedViewCell")
        self.addSubview(mainTableView)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
        mainTableView.separatorStyle = .singleLine
        
        let leftButton = UIButton()
        setupButton(button: leftButton, title: "设为默认")
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        let rightButton = UIButton()
        setupButton(button: rightButton, title: "仅限这次")
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        leftButton.whc_Left(0).whc_Bottom(0).whc_Height(bottomHeight).whc_Right(0,toView:rightButton).whc_WidthEqual(rightButton)
        rightButton.whc_Left(0,toView:leftButton).whc_Bottom(0).whc_Height(bottomHeight).whc_Right(0).whc_WidthEqual(leftButton)
        mainTableView.whc_Left(0).whc_Bottom(0,toView:leftButton).whc_Right(0).whc_Top(0,toView:label)
        
        let separateLine = UIView()
        addSubview(separateLine)
        separateLine.backgroundColor = UIColor.groupTableViewBackground
        separateLine.whc_Bottom(0).whc_Left(0,toView: leftButton).whc_Width(1).whc_Height(bottomHeight)
        
        let separateLineTop = UIView()
        addSubview(separateLineTop)
        separateLineTop.backgroundColor = UIColor.groupTableViewBackground
        separateLineTop.whc_Top(-43,toView: separateLine).whc_Left(0).whc_Right(0).whc_Height(1)
    }
    
    @objc func leftButtonAction() {
        if let deleagate = self.delegate {
            deleagate.gotoBrowerWithType(type: selectedIndex,allways:true)
            dismissAction()
        }
    }
    
    @objc func rightButtonAction() {
        if let deleagate = self.delegate {
            deleagate.gotoBrowerWithType(type: selectedIndex,allways:false)
            dismissAction()
        }
    }

    private func setupButton(button: UIButton,title: String) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = UIColor.white
        button.theme_setTitleColor("Global.themeColor", forState: .normal)
        addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        self.window?.insertSubview(view, belowSubview: self)
        view.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        view.tag = 1022
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(didTaped))
        view.addGestureRecognizer(tap)
        
        mainTableView.scrollToRow(at: IndexPath.init(row: selectedIndex, section: 0), at: UITableViewScrollPosition.middle, animated: true)
    }
    
    @objc func closeBtnClick() {
        dismissAction()
    }
    
    @objc func didTaped() {
        dismissAction()
    }
    
    private func dismissAction() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0.1
            self.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        }) { (_) in
            
            let view = self.window?.viewWithTag(1022)
            view?.removeFromSuperview()
            self.mainTableView.whc_ResetConstraints().removeFromSuperview()
            self.alpha = 0
        }
    }
}

extension NewSelectView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        for cell in tableView.visibleCells {
            if let selectedCell = cell as? NewSelectedViewCell {
                selectedCell.rightIcon.image = nil
            }
        }
       
        if let selectedCell = tableView.cellForRow(at: indexPath) as? NewSelectedViewCell {
            selectedCell.rightIcon.image = UIImage(named: "select_broswer_point")
        }
        
        selectedIndex = indexPath.row
        didSelected?(indexPath.row, kLenny_InsideDataSource[indexPath.row].1)
    }
}

extension NewSelectView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kLenny_InsideDataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewSelectView.fixedTableViewRowHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newSelectedViewCell") as? NewSelectedViewCell else {fatalError("The dequeued cell is not an instance of NewSelectedViewCell.")}
        
        let stringTupe = kLenny_InsideDataSource[indexPath.row]
        cell.icon.image = UIImage(named: "\(stringTupe.0)")
        cell.rightIcon.image = UIImage(named: indexPath.row == selectedIndex ? "select_broswer_point" : "")
        cell.titleLabel.text = "\(stringTupe.1)"
        
        return cell
    }
}
