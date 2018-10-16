//
//  AccoutFilterSelectView.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class AccoutFilterSelectView: UIView {

    static let fixedTableViewRowHeight: CGFloat = 51.0
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var selectedIndex: Int = 0
    var didSelected: ( ( Int, AccountTypeBean) -> Void)?
    var kLenny_InsideDataSource: [AccountTypeBean]!
    
    var kTitleLabelHeight: CGFloat = 30
    
    var kHeight: CGFloat {
        let h = LennySelectView.fixedTableViewRowHeight * CGFloat(kLenny_InsideDataSource.count) + kTitleLabelHeight
        return  h <  300 ? h : 300
    }
    
    private var mainTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(dataSource: [AccountTypeBean], viewTitle: String) {
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
        mainTableView.whc_AutoSize(left: 0, top: 30, right: 0, bottom: 0)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
        mainTableView.separatorStyle = .none
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
        
        UIView.animate(withDuration: 0.3, animations: {
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

extension AccoutFilterSelectView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        for cell in tableView.visibleCells {
            cell.imageView?.image = UIImage(named: "unselected")
        }
        tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "selected")
        
        didSelected?(indexPath.row, kLenny_InsideDataSource[indexPath.row])
        didTaped()
    }
}

extension AccoutFilterSelectView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kLenny_InsideDataSource.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return LennySelectView.fixedTableViewRowHeight
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell" + String(indexPath.row))
        
        cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell" + String(indexPath.row))
        cell?.textLabel?.text = kLenny_InsideDataSource[indexPath.row].name
        cell?.textLabel?.numberOfLines = 0
        cell?.imageView?.image = UIImage(named: "unselected")
        if indexPath.row == selectedIndex {
            cell?.imageView?.image = UIImage(named: "selected")
        }
        
        return cell!
    }
}
