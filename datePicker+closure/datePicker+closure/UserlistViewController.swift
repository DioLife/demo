//
//  UserlistViewController.swift
//  YiboGameIos
//
//  Created by William on 2018/10/17.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import SnapKit

class UserlistViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var myview:FilterView!
    var isChange = false
    
    var table:UITableView!
    let indentifier = "cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "用户列表"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "筛选", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightTopBtn))
        
        myview = Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)?.last as! FilterView
        myview.backgroundColor = UIColor.green
        view.addSubview(myview)
        myview.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(-140)
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.height.equalTo(140)
        }
        myview.cancelBtnValueClousure = {(text:String) -> Void in
            print(text)
            self.myview.snp.updateConstraints { (make) in
                make.top.equalTo(self.view).offset(-140)
            }
            self.table.snp.updateConstraints { (make) in
                make.top.equalTo(self.myview.snp.bottom).offset(0)
            }
            self.isChange = !self.isChange
        }
        myview.sureBtnValueClousure = {(userName:String,startTime:String,endTime:String) -> Void in
            print(userName, startTime, endTime)
            self.myview.snp.updateConstraints { (make) in
                make.top.equalTo(self.view).offset(-140)
            }
            self.table.snp.updateConstraints { (make) in
                make.top.equalTo(self.myview.snp.bottom).offset(0)
            }
            self.isChange = !self.isChange
        }
        

        //设置UITableView的位置
        table = UITableView(frame: self.view.frame, style: UITableViewStyle.plain)
        self.table.backgroundColor = UIColor.orange
        //设置数据源
        self.table.dataSource = self
        //设置代理
        self.table.delegate = self
        let header = Bundle.main.loadNibNamed("UserlistHeader", owner: self, options: nil)?.last as! UserlistHeader
        header.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
//        table.tableHeaderView = header
        let testHeader = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        testHeader.backgroundColor = UIColor.orange
        testHeader.addSubview(header)
        table.tableHeaderView = testHeader
        
        table.tableFooterView = UIView()
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.top.equalTo(self.myview.snp.bottom).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
        //注册UITableView，cellID为重复使用cell的Identifier
        self.table.register(UINib.init(nibName: "UserlistCell", bundle: nil), forCellReuseIdentifier: indentifier)
    }
    
    @objc func rightTopBtn(){
        if isChange {
            myview.snp.updateConstraints { (make) in
                make.top.equalTo(self.view).offset(-140)
            }
            table.snp.updateConstraints { (make) in
                make.top.equalTo(self.myview.snp.bottom).offset(0)
            }
        }else {
            myview.snp.updateConstraints { (make) in
                make.top.equalTo(self.view).offset(68)
            }
            table.snp.updateConstraints { (make) in
//                make.top.equalTo(self.view).offset(140)
                make.top.equalTo(self.myview.snp.bottom).offset(0)
            }
        }
        isChange = !isChange
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 200
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserlistCell! = (tableView.dequeueReusableCell(withIdentifier: indentifier, for: indexPath)) as? UserlistCell
        cell.userName.text = "Jim"
        cell.userType.text = "会员"
        cell.registerTime.text = "2018-10-19 10:21:21"
        cell.balance.text = "1.5"
        return cell!
    }

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myview.myTextField.resignFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
