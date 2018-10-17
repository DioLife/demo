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
    
    @IBOutlet weak var titleUI:UILabel!
    @IBOutlet weak var closeButton:UIButton!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var defaultButton:UIButton!
    @IBOutlet weak var justOneTimebutton:UIButton!
    
    
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
    
    override func awakeFromNib() {
        
        closeButton.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        defaultButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        justOneTimebutton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        let nib = UINib(nibName: "NewSelectedViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "newSelectedViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initSource(dataSource: [(icon:String,title:String)], viewTitle: String) {
        kLenny_InsideDataSource = dataSource
        self.tableView.reloadData()
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToWindow() {
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        view.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        self.window?.insertSubview(view, belowSubview: self)
        view.tag = 1022
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(didTaped))
        view.addGestureRecognizer(tap)
        tableView.scrollToRow(at: IndexPath.init(row: selectedIndex, section: 0), at: UITableViewScrollPosition.middle, animated: true)
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
            self.tableView.removeFromSuperview()
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
            selectedCell.rightIcon.image = UIImage(named: "select_browser_point")
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
        if kLenny_InsideDataSource == nil{
            return 0
        }
        return kLenny_InsideDataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewSelectView.fixedTableViewRowHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newSelectedViewCell") as? NewSelectedViewCell else {fatalError("The dequeued cell is not an instance of NewSelectedViewCell.")}
        
        let stringTupe = kLenny_InsideDataSource[indexPath.row]
        cell.icon.image = UIImage(named: "\(stringTupe.0)")
        cell.rightIcon.image = UIImage(named: indexPath.row == selectedIndex ? "select_browser_point" : "")
        cell.titleLabel.text = "\(stringTupe.1)"
        
        return cell
    }
}
