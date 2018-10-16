//
//  CalenderController2.swift
//  gameplay
//
//  Created by William on 2018/8/14.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import Kingfisher

class CalenderController2: BaseController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var calenderLabel: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var lastMonthButton: UIButton!//月份加调
    @IBOutlet weak var nextMonthButton: UIButton!//月份后调
    @IBOutlet weak var signDays: UILabel!//已签到天数 (该功能被删掉)
    @IBOutlet weak var signNow: UIButton!//签到按钮
    
    var myView:AlertView!//自定义弹出框
    
    var dataArray:[QiandaoRows]!
    
    var dateArray = ["日","一","二","三","四","五","六"]
    let calenderCellId = "calenderCellId";
    let dateCellId = "DateCellId";
    
    var currentYear :Int = 2017;
    var currentMonth :Int = 10;
    var currentDay :Int = 23;
    
    var showYear :Int = 0
    var showMonth :Int = 0
    var showDay :Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "签到"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        dataArray = Array<QiandaoRows>()
        
        currentYear = NSDate.getCurrentYear();
        currentMonth = NSDate.getCurrentMonth();
        currentDay = NSDate.getCurrentDay();
        
        showYear = self.currentYear
        showMonth = self.currentMonth
        
        addAllViews()
        getData() //获取数据
    }
    
    func getData() {
        request(frontDialog: true, method: .post, loadTextStr: "正在获取...", url: native_sign_record) { (resultJson:String, resultStatus:Bool) in
            
            if !resultStatus {
                if resultJson.isEmpty {
                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                }else{
                    showToast(view: self.view, txt: resultJson)
                }
                return
            }
            if let result = Qiangdao.deserialize(from: resultJson) {
                if result.success{
                    self.dataArray.removeAll()//清空数组 重新添加数据
                    let rows = result.content?.rows
                    for item in rows!{
//                        print("signDate",item.signDate!)
//                        print("signDays",item.signDays!)
                        self.dataArray.append(item)
                    }
                    self.collection.reloadData()
                }else{
                    if !isEmptyString(str: result.msg){
                        showToast(view: self.view, txt: result.msg)
                    }else{
                        showToast(view: self.view, txt: convertString(string: "获取失败"))
                    }
                    if result.code == 0{
                        loginWhenSessionInvalid(controller: self)
                    }
                }
            }
        }
    }
    
    
    func addAllViews(){
        self.view.backgroundColor = UIColor(hexString: "#f9d03c")
        //加载签到底部图片
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                let url = config.content.pc_sign_logo
                if let imageURL = URL(string: url){
                    self.topImage.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "qiandaoinTop"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }
        let frameWidth = self.collection.frame.size.width
        let frameHeight = self.collection.frame.size.height
        
        let itemWidth = (frameWidth - 12) / 7
        let itemHeight = (frameHeight - 10) / 6
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width:itemWidth,height:itemHeight)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.init(r: 75, g: 68, b: 149)
//        collection.isScrollEnabled = false
        collection.collectionViewLayout = layout
        collection.register(DateCell.self, forCellWithReuseIdentifier: dateCellId)
        collection.register(CalenderCell.self, forCellWithReuseIdentifier: calenderCellId)
        self.view.addSubview(collection);
        
        
        lastMonthButton.addTarget(self, action: #selector(lastMonthButtonAction), for: .touchUpInside)
        calenderLabel.text = String.init(format: "%d 年 %d 月 ", currentYear,currentMonth)
        nextMonthButton.addTarget(self, action: #selector(nextMonthButtonAction), for: .touchUpInside)
        //打卡签到
        signNow.addTarget(self, action: #selector(sign(sender:)), for: .touchUpInside)
    }
    @objc func lastMonthButtonAction() -> Void {
        if showMonth == 1 {
            showMonth = 12
            showYear -= 1;
        }else{
            showMonth -= 1;
        }
        calenderLabel.text = String.init(format: "%d 年 %d 月 ", showYear,showMonth)
        collection.reloadData();
    }
    @objc func nextMonthButtonAction()->Void{
        if showMonth == 12 {
            showMonth = 1
            showYear += 1;
        }else{
            showMonth += 1;
        }
        calenderLabel.text = String.init(format: "%d 年 %d 月 ", showYear,showMonth)
        collection.reloadData();
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return dateArray.count;
        }
        let firstWeekDay = NSDate.firstWeekdayInMonth(year: showYear, month: showMonth)
        let daysInThinsMonth = NSDate.getDaysInMonth(year: showYear, month: showMonth)
        return (firstWeekDay + daysInThinsMonth)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        if indexPath.section == 1{
            
            let firstWeekDay = NSDate.firstWeekdayInMonth(year: showYear, month: showMonth);
            let daysInThinsMonth = NSDate.getDaysInMonth(year: showYear, month: showMonth);
            let index = indexPath.row;
            
            var day = 0;
            let regCell = cell as! CalenderCell
            
            regCell.label.backgroundColor = UIColor.white;
            if index < firstWeekDay{
                
                regCell.label.backgroundColor = UIColor.init(r: 75, g: 68, b: 149)
                regCell.label.text = ""
                
            }else if index > (firstWeekDay + daysInThinsMonth - 1) {
                
                regCell.label.backgroundColor = UIColor.init(r: 75, g: 68, b: 149)
                regCell.label.text = ""
                
            }else {
                day = index - firstWeekDay + 1;
                regCell.label.text = String.init(format: "%d", day);
            }
            
            if showYear > currentYear || (showYear == currentYear && showMonth > currentMonth) || (showYear == currentYear && showMonth == currentMonth && day > currentDay){
                regCell.label.textColor = UIColor.gray;
            }else{
                regCell.label.textColor = UIColor.black;
            }
            
            //添加签到标记
            if judgeDateInMark(year: showYear, month: showMonth, day: day) {
                regCell.label.backgroundColor = UIColor.init(r: 254, g: 240, b: 80)
            }else{
                regCell.label.backgroundColor = UIColor.white
            }
            //今天是否签到
            if  (showYear == currentYear && showMonth == currentMonth && day == currentDay) && judgeDateInMark(year: currentYear, month: currentMonth, day: currentDay){
                signNow.isEnabled = false
                signNow.backgroundColor = UIColor.gray
                signNow.setTitle("已签到", for: UIControlState.normal)
                regCell.myDot.isHidden = false
            }else{
                regCell.myDot.isHidden = true
            }

            
        }
    }
    
    //判断要显示的天 是否在标记的日期里
    func judgeDateInMark(year:Int, month:Int, day:Int) -> Bool {
        for item in self.dataArray {
//            let ymd2 = NSDate.getYearAndMonthAndDayFromTimestamp(timestamp: 1534695129535)
//            print(ymd2)
            let ymd = NSDate.getYearAndMonthAndDayFromTimestamp(timestamp: TimeInterval(item.signDate!))
            let myyear = ymd[0]
            let mymonth = ymd[1]
            let myday = ymd[2]
            if year == myyear && month == mymonth && day == myday{
                return true
            }
        }
        return false
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateCellId, for: indexPath) as! DateCell;
            cell.label.text = dateArray[indexPath.row];
            cell.label.textColor = UIColor.white
//            cell.backgroundColor = UIColor.init(r: 148, g: 138, b: 146)
            return cell;
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: calenderCellId, for: indexPath) as! CalenderCell
        
        return cell
    }
    
    //查看签到记录
    @IBAction func QueryMarkRecord(_ sender: UIButton) {
        myView = Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)?.last as! AlertView
//        myView.isUserInteractionEnabled = false
        self.view.addSubview(myView)
        myView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(self.view.height / 3.6)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.centerX.equalTo(self.view.centerX)
            make.height.equalTo(self.view.height / 1.7)
        }
        configSideRadius(view: myView)//设置圆角
//        self.view.backgroundColor = UIColor.lightGray
        myView.dataArray = self.dataArray //给tableView赋值
        
        
        //点击弹出框上删除按钮 响应事件
        myView.didSelected = {( num, str) -> Void in
            self.myView.removeFromSuperview()
//            self.view.backgroundColor = UIColor.white
        }
    }
    //点击屏幕弹出框也消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.myView != nil && self.view.subviews.contains(self.myView!) {
            myView.removeFromSuperview()
//            self.view.backgroundColor = UIColor.white
        }
    }
    //MARK: 设置某个圆角
    func configSideRadius(view: UIView) {
        view.layer.cornerRadius = 10 //圆角弧度
        view.layer.masksToBounds = true  //是否把圆角边切去
        view.layer.borderWidth = 8   //设置边框 的宽度
        view.layer.borderColor = UIColor.init(r: 254, g: 215, b: 92).cgColor //设置边框的颜色
    }
    
    //打卡签到
    @objc func sign(sender: UIButton) {
        request(frontDialog: true,method: .post, loadTextStr:"签到中...", url:NEWSIGN_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "签到失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = SignResultWraper.deserialize(from: resultJson){
                        if result.success{
                            
                            showToast(view: self.view, txt: "签到成功")
                            let date = Date()
                            let calendar = Calendar.current
                            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                            let year =  components.year
                            let month = components.month
                            let day = components.day
                            let dateString = String.init(format: "%d%d%d", year!,month!,day!)
                            
                            let userName = YiboPreference.getUserName()
                            let baseUrl = getDomainUrl()
                            let signKey = dateString + userName + baseUrl
                            
                            let ignDateStr = YiboPreference.getSignDate()
                            if !ignDateStr.contains(signKey) {
                                YiboPreference.save_signDate(value: "\(signKey),\(ignDateStr)" as AnyObject)
                            }
                            self.getData()//签到完成更新数据
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "签到失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
}
