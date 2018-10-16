//
//  WebviewListController.swift
//  gameplay
//
//  Created by admin on 2018/8/15.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit
import WebKit

var webViewHeightDic = [String:CGFloat]()

class WebviewList: UIView {
    
    var mainTableView = UITableView()
    
    var noticeResuls: [NoticeResult]!
    var openedIndexes: [Int] = [0]
    
    init(noticeResuls: [NoticeResult]) {
    
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))

        self.noticeResuls = noticeResuls
        
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue:"webViewListHeightChanged"), object: nil)

        setupUI()
    }
    
    @objc func test(nofi:Notification){
        if let indexArray = nofi.object as? Array<Int>{
            if indexArray.count > 0 {
                self.mainTableView.reloadRows(at: [IndexPath.init(row: 1, section: indexArray[0])], with: .middle)
            }
        }
    }
    
    //MARK: - 初始化视图、 添加事件
    private func setupUI() {
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
//        let tapGesture = UITapGestureRecognizer()
//        tapGesture.addTarget(self, action: #selector(tapViewAction))
//        self.addGestureRecognizer(tapGesture)

        let header = UIView()
        addSubview(header)
        header.whc_Top(100).whc_Left(50).whc_Height(50).whc_Right(50)
        header.theme_backgroundColor = "Global.themeColor"
        
        let closeButton = UIButton()
        header.addSubview(closeButton)
        closeButton.whc_CenterY(0).whc_Right(8).whc_Height(25).whc_Width(25)
        closeButton.setImage(UIImage(named: "closeButtonImg"), for: .normal)
        closeButton.imageView?.contentMode = .scaleAspectFit
        closeButton.addTarget(self, action: #selector(closeButtonClick), for: .touchUpInside)
        
        let titleLabel = UILabel()
        header.addSubview(titleLabel)
        titleLabel.whc_CenterY(0).whc_CenterX(0).whc_Right(5,toView:closeButton)
        titleLabel.text = "平台公告"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 17.0)

        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
        self.addSubview(mainTableView)
        mainTableView.whc_Top(0,toView:header).whc_LeadingEqual(header).whc_Bottom(140).whc_WidthEqual(header)
        
        
        let bottomBottomView = UIView()
        bottomBottomView.backgroundColor = UIColor.white
        self.addSubview(bottomBottomView)
        bottomBottomView.whc_Top(0,toView:mainTableView).whc_LeadingEqual(header).whc_Height(40).whc_TrailingEqual(header)
        
        let notipsAgainBtn = UIButton()
        bottomBottomView.addSubview(notipsAgainBtn)
        notipsAgainBtn.setTitle("不再弹出", for: .normal)
        notipsAgainBtn.theme_backgroundColor = "Global.themeColor"
        notipsAgainBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        notipsAgainBtn.setTitleColor(UIColor.white, for: .normal)
        notipsAgainBtn.addTarget(self, action: #selector(notipsAgainBtnClick), for: .touchUpInside)
        
        let cancelBtn = UIButton()
        bottomBottomView.addSubview(cancelBtn)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.theme_backgroundColor = "Global.themeColor"
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cancelBtn.setTitleColor(UIColor.white, for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        
        notipsAgainBtn.whc_Leading(0).whc_Bottom(0).whc_Height(40).whc_Right(1,toView:cancelBtn).whc_WidthEqual(cancelBtn)
        
        cancelBtn.whc_Trailing(0).whc_Bottom(0).whc_Height(40).whc_Left(0,toView:notipsAgainBtn).whc_WidthEqual(notipsAgainBtn)
    }
    
    @objc func notipsAgainBtnClick() {
        YiboPreference.setAlert_isAll(value: "off" as AnyObject)
        dismiss()
    }
    
    @objc func cancelBtnClick() {
        dismiss()
    }
    
    //MARK: - 点击事件
    @objc func closeButtonClick() {
        dismiss()
    }
    
//    @objc func tapViewAction() {
//        dismiss()
//    }
    
    func show() {
        let wind = UIApplication.shared.keyWindow
        self.alpha = 0
        
        wind?.addSubview(self)
        
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 1
        })
    }
    
    private func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
                webViewHeightDic = [String:CGFloat]()
                NotificationCenter.default.removeObserver(self)
            }
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITableViewDataSource
extension WebviewList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if openedIndexes.contains(section) {
            return 2
        }else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let array = noticeResuls {
            return array.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == 0 {
            return 44
        }else {
            if openedIndexes.contains(indexPath.section) {
                if let archiveHeight = webViewHeightDic["\(indexPath.section)"] {
                    return archiveHeight
                }
            }
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = WebviewListTitleCell.init(style: .default, reuseIdentifier: "webviewListTitleCell\(indexPath.section)\(indexPath.row)")
        
        let model = self.noticeResuls[indexPath.section]
        if indexPath.row == 0 {
            cell.configCell(iconThemeColor: "Global.themeColor", titleContentsP: model.title)
            cell.configDateString(dateStamp: model.time)
            cell.accessoryType = .disclosureIndicator
        }else if indexPath.row == 1 {
            cell.configSection(sectionNum: indexPath.section)
            cell.configWebCell(constants: model.content)
            cell.accessoryType = .none
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension WebviewList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if openedIndexes.contains(indexPath.section) {
                for openedIndex in 0..<openedIndexes.count {
                    if openedIndexes[openedIndex] == indexPath.section {
                        openedIndexes.remove(at: openedIndex)
                        tableView.reloadData()
                        break
                    }
                }
                
            }else {
                openedIndexes.append(indexPath.section)
                tableView.reloadData()
//                tableView.reloadRows(at: [IndexPath.init(row: 1, section: indexPath.section)], with: .middle)
            }
        }
    }
    
}


































