//
//  LennyTableViewController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import SkeletonView

class LennyTableViewController: LennyBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }

    let mainTableView = UITableView()
    
    private func setViews() {
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableHeaderView = tableHeaderView()
        mainTableView.tableFooterView = tableFooterView()
        mainTableView.separatorStyle = .none
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.estimatedRowHeight = estimatedRowHeight()
        contentView.addSubview(mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.allowsSelection = false
        
    }
    
    override func refreshTableViewData() {
        mainTableView.reloadData()
    }
    
    func estimatedRowHeight() -> CGFloat {
        return 56
    }
    
    func tableHeaderView() -> UIView {
        return tableHeaderViewWith(title: "")!
    }
    func tableHeaderViewWith(title: String) -> UIView? {
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
        label.text = title
        
        return viewHeader
    }
    func tableFooterView() -> UIView {
        return UIView()
    }
    
    var numberOfSection: Int {
        return 1
    }
    var numberOfRowsInsection: [Int] {
        return [5]
    }
    var cells: [UITableViewCell] {
        return [UITableViewCell()]
    }
    var sectionHeaderHeight: [CGFloat] {
        return [CGFloat]()
    }
    var sectionHeaderView: [UIView] {
        return [UIView]()
    }
    
}


extension LennyTableViewController: UITableViewDelegate {
    
}

extension LennyTableViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdenfierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInsection[section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cells.count == 0 { return UITableViewCell() }
        if numberOfSection == 1 {
            if indexPath.row < cells.count {
                cell = cells[indexPath.row]
            }else {
                cell = cells.last
            }
        }else {
//            if indexPath.section == 0 && indexPath.row == 0 {
//                kIndexPathArray.removeAll()
//            }
//            kIndexPathArray.append(indexPath)
//            cell = cells[kIndexPathArray.count - 1]
            var index = 0
            for i in 0 ..< indexPath.section {
                index += numberOfRowsInsection[i]
            }
            index += indexPath.row
            if index < cells.count {
                cell = cells[index]
            }else {
                cell = cells.last
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sectionHeaderHeight.count == 0 { return 0}
        if section >= sectionHeaderHeight.count { return sectionHeaderHeight.last! }
        return sectionHeaderHeight[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if sectionHeaderView.count == 0 { return UIView()}
        if section >= sectionHeaderView.count { return sectionHeaderView.last! }
        return sectionHeaderView[section]
    }
    
}
