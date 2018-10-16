//
//  JifenViewController.swift
//  gameplay
//
//  Created by William on 2018/8/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
//LennyBasicViewController
class JifenViewController: LennyBasicViewController,UITableViewDataSource,UITableViewDelegate {

    let indentifier = "cell"
    private var mainPageView:UITableView!
    
    var dataArray = Array<JifenDataRow>()
    var isAttachInTabBar = true
    var selectedView: GoucaiDetailView = GoucaiDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDate()
        setViews()
        setUp()
        getData()
    }
    
    func getData() {
        let params = ["type":filterLotCode, "startTime":filterStartTime, "endTime":filterEndTime]
        request(frontDialog: true, method: .post, loadTextStr: "正在获取数据...", url: SCORE_HISTORY_DATA, params: params) { (resultJson:String, resultStatus:Bool) in
            
            if !resultStatus {
                if resultJson.isEmpty {
                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                }else{
                    showToast(view: self.view, txt: resultJson)
                }
                return
            }
//            print(resultJson)
            if let result = JifenDataModel.deserialize(from: resultJson) {
                if result.success{
                    self.dataArray.removeAll()
                    for item in (result.content?.rows)! {
                        self.dataArray.append(item)
                    }
                    self.mainPageView.reloadData()
                }
            }
        }
    }
    
    func setUp() {
        mainPageView = UITableView(frame: self.view.frame, style: UITableViewStyle.plain)
        
        setViewBackgroundColorTransparent(view: self.mainPageView)
        mainPageView.tableFooterView = UIView.init()
        mainPageView.dataSource = self
        mainPageView.delegate = self
        contentView.addSubview(mainPageView)
        mainPageView.register(UINib.init(nibName: "JifenCell", bundle: nil), forCellReuseIdentifier: indentifier)
    }
    
    override func adjustRightBtn() -> Void {
        super.adjustRightBtn()
        if YiboPreference.getLoginStatus(){
            self.navigationItem.rightBarButtonItems?.removeAll()
            let button = UIButton(type: .custom)
            button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
            //        button.setImage(UIImage.init(named: "filter"), for: .normal)
            button.setTitle("筛选", for: .normal)
            button.contentHorizontalAlignment = .right
            button.addTarget(self, action: #selector(rightBarButtonItemAction(button:)), for: .touchUpInside)
            button.isSelected = false
            button.theme_setTitleColor("Global.barTextColor", forState: .normal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        }
    }
    
 
    
    var filterUsername = ""
    var filterLotCode = ""
    var filterStartTime = ""
    var filterEndTime = ""
    var current_index = 0
    
    private func setViews() {
        if self.title == nil {self.title = "积分兑换"}
        if !isAttachInTabBar{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        }
    }
    
    func initDate(){
        self.filterStartTime = getTodayZeroTime()
        self.filterEndTime = getTomorrowNowTime()
    }
    
    @objc private func rightBarButtonItemAction(button: UIButton) {
        
        if button.isSelected == false {
            if contentView.viewWithTag(101) != nil { return }
            let filterView = JifenFilterView(height: 200,controller:self)
            filterView.initializeDate(start: self.filterStartTime, end: self.filterEndTime)
            
            filterView.didClickCancleButton = {
                self.rightBarButtonItemAction(button: button)
            }
            filterView.didClickConfirmButton = {(username:String,lotCode:String,startTime:String,endTime:String)->Void in
                self.rightBarButtonItemAction(button: button)
                self.filterUsername = username
                self.filterLotCode = lotCode
                self.filterStartTime = startTime
                self.filterEndTime = endTime
            }
            filterView.tag = 101
            contentView.addSubview(filterView)
            filterView.frame = CGRect.init(x: 0, y: -180, width: MainScreen.width, height: 180)
            contentView.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
                filterView.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 180)
                self.mainPageView.frame = CGRect.init(x: 0, y: 180, width: MainScreen.width, height: self.contentView.height)
            }) { ( _) in
                button.isSelected = true
            }
        }else {
            button.isSelected = false
            let filterView = contentView.viewWithTag(101)
            UIView.animate(withDuration: 0.5, animations: {
                filterView?.alpha = 0
                filterView?.frame = CGRect.init(x: 0, y: -180, width: MainScreen.width, height: 180)
                self.mainPageView.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: self.contentView.height)
            }) { ( _) in
                filterView?.removeFromSuperview()
                button.isSelected = false
                self.getData() //刷新数据
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArray.count + 1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:JifenCell? = (tableView.dequeueReusableCell(withIdentifier: indentifier, for: indexPath)) as? JifenCell
        if indexPath.row == 0 {
            cell?.setView(index: indexPath.row, model: JifenDataRow())
            cell?.isUserInteractionEnabled = false
        }else {
            let model = self.dataArray[indexPath.row - 1]
            print(model.createDatetime)
            cell?.setView(index: indexPath.row, model: model)
        }
        return cell!
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let indexP = IndexPath.init(row: indexPath.row - 1, section: indexPath.section)
            showGoucaiDetailView(indexPath: indexP)
        }
    }
    
    //MARK: - 购彩详情列表
    private func showGoucaiDetailView(indexPath: IndexPath){
//        let dataSource = ["aaaa","vvvvvvv","cccc"]
        let model = self.dataArray[indexPath.row]
        let typeStrig = getTypeSting(type: model.type!)
        let dataSource = ["变动类型:\(typeStrig)","变动前积分:\(model.beforeScore!)",
            "变动分数:\(model.score!)","变动后积分:\(model.afterScore!)",
            "创建时间:\(model.createDatetime!)","备注:\(model.remark!)"]
        selectedView = GoucaiDetailView(dataSource: dataSource, viewTitle: "积分详情", bottomHeight: 40)
        
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width - 100).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            self.selectedView.transform = CGAffineTransform.identity
        }) { (_) in
        }
    }
    
    func getTypeSting(type:Int) -> String {
        switch type {
//        case 0:
//            return ""
        case 1:
            return "活动积分扣除"
        case 2:
            return "会员签到"
        case 3:
            return "现金兑换积分"
        case 4:
            return "积分兑换现金"
        case 5:
            return "存款赠送"
        case 6:
            return "人工添加"
        case 7:
            return "人工扣除"
        default:
            return "error"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedView.dismissGroupDetailView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
