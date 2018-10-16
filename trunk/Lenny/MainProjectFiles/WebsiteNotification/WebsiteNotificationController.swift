//
//  WebsiteNotificationController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class WebsiteNotificationController: LennyBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }
    

    private let mainTableView = UITableView()
    private func setViews() {
        
        self.title = "网站公告"
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        contentView.addSubview(mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.tableHeaderView = tableHeaderView()
        mainTableView.tableFooterView = UIView()
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.estimatedRowHeight = 56
        
    }
    private func tableHeaderView() -> UIView {
        
        let viewHeader = UIView(frame: CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 33))
        viewHeader.backgroundColor = UIColor.ccolor(with: 71, g: 71, b: 69)
        
        let view = UIView()
        viewHeader.addSubview(view)
        view.whc_Top(13).whc_Left(17).whc_Width(8).whc_Height(8)
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.backgroundColor = UIColor.mainColor()
        
        let label = UILabel()
        viewHeader.addSubview(label)
        label.whc_CenterY(0).whc_Left(35).whc_WidthAuto().whc_Height(13)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.text = "公告列表"
        
        return viewHeader
    }
}

extension WebsiteNotificationController: UITableViewDelegate {
    
}

extension WebsiteNotificationController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = WebsiteNotificationCell.init(style: .default, reuseIdentifier: "cell")
        }
        return cell!
    }
}
