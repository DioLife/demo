//
//  SelectLotteryTypeView.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/9.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class GoucaiDetailView: UIView {

    static let fixedTableViewRowHeight: CGFloat = 50.0

    var selectedIndex: Int = 0
    var didSelected: ( ( Int, String) -> Void)?
    var kLenny_InsideDataSource: [String]!
    
    var kTitleLabelHeight: CGFloat = 30
    
    var kHeight: CGFloat {
        let h = GoucaiDetailView.fixedTableViewRowHeight * CGFloat(kLenny_InsideDataSource.count) + kTitleLabelHeight
        return  h <  300 ? h : 300
    }
    
    private var mainTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(dataSource: [String], viewTitle: String ,bottomHeight: CGFloat) {
        self.init(frame: CGRect.zero)
        kLenny_InsideDataSource = dataSource
        
        let label = UILabel()
        addSubview(label)
        label.whc_Top(0).whc_Left(0).whc_Right(0).whc_Height(kTitleLabelHeight)
//        label.backgroundColor = UIColor.mainColor()
        label.theme_backgroundColor = "Global.themeColor"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "     " + viewTitle
        
        self.addSubview(mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 30, right: 0, bottom: bottomHeight)
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
        mainTableView.separatorStyle = .none
        
        let nib = UINib(nibName: "GoucaiDetailCell", bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: "goucaiDetailCell")
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
        
        if selectedIndex >= 1 {
            mainTableView.scrollToRow(at: IndexPath.init(row: selectedIndex - 1, section: 0), at: UITableViewScrollPosition.middle, animated: true)
        }
        
    }
    
    @objc func didTaped() {
        
        dismissGroupDetailView()
    }

     func dismissGroupDetailView() {
        UIView.animate(withDuration: 0.1, animations: {
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

extension GoucaiDetailView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kLenny_InsideDataSource.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return GoucaiDetailView.fixedTableViewRowHeight
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goucaiDetailCell") as? GoucaiDetailCell else {fatalError("The dequeued cell is not an instance of SportOrderCell.")}
//        cell.titleLabel.text = kLenny_InsideDataSource[indexPath.row]
        cell.titleLabel.text = kLenny_InsideDataSource[indexPath.row]
        cell.titleLabel.numberOfLines = 0
        return cell
    }
}
