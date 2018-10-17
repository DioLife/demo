//
//  CalenderController.swift
//  Qiandao2
//
//  Created by William on 2018/8/14.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

protocol CalenderControllerDelegate {
    func didSelectData(year:Int ,month:Int, day:Int)->Void
}

class CalenderController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var delegate :CalenderControllerDelegate?
    
    var collection : UICollectionView!
    let lastMonthButton = UIButton();
    let calenderLabel = UILabel();
    let nextMonthButton = UIButton();
    
    var dateArray = ["日","一","二","三","四","五","六"]//显示日历上的星期
    let calenderCellId = "calenderCellId"//天数
    let dateCellId = "DateCellId"//星期
    
    var currentYear :Int = 2017//今年 年份
    var currentMonth :Int = 10//今年今月 月份
    var currentDay :Int = 23//今天 日数
    
    var showYear :Int = 0 //显示的年份
    var showMonth :Int = 0 //显示的月份
    var showDay :Int = 0 //点击的天
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white;
        currentYear = NSDate.getCurrentYear()
        currentMonth = NSDate.getCurrentMonth()
        currentDay = NSDate.getCurrentDay()
        
        showYear = self.currentYear
        showMonth = self.currentMonth
        
        addAllViews()
    }
    
    func addAllViews(){
        let frameWidth = self.view.frame.size.width;
        let frameHeight = self.view.frame.size.height;
        
        let itemWidth = frameWidth / 7 - 5;
        let itemHeight = itemWidth;
        let layout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsets.zero;
        layout.itemSize = CGSize(width:itemWidth,height:itemHeight);
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        
        collection = UICollectionView.init(frame:CGRect(x:0,y:0 ,width:frameWidth,height:frameHeight / 1.5), collectionViewLayout: layout);
        collection.center = self.view.center;
        collection.delegate = self;
        collection.dataSource = self;
        collection.register(DateCell.self, forCellWithReuseIdentifier: dateCellId)
        collection.register(CalenderCell.self, forCellWithReuseIdentifier: calenderCellId)
        collection.backgroundColor = UIColor.white;
        self.view.addSubview(collection);
        
        
        let collOriginY = collection.frame.origin.y;
        let buttonHeight :CGFloat = 40;
        let buttonWidth = frameWidth / 3.0
        
        lastMonthButton.frame = CGRect(x:0,y:collOriginY - buttonHeight,width:buttonWidth,height:buttonHeight);
        lastMonthButton.setTitle("<<上月", for: .normal);
        lastMonthButton.setTitleColor(UIColor.black, for: .normal);
        lastMonthButton.addTarget(self, action: #selector(CalenderController.lastMonthButtonAction), for: .touchUpInside)
        self.view.addSubview(lastMonthButton);
        
        calenderLabel.frame = CGRect(x:buttonWidth ,y:lastMonthButton.frame.origin.y,width:buttonWidth,height:buttonHeight);
        calenderLabel.textAlignment = .center;
        calenderLabel.font = UIFont.systemFont(ofSize: 22);
        calenderLabel.backgroundColor =  UIColor(red: 41/255, green: 160/255, blue: 230/255, alpha: 1);
        self.view.addSubview(calenderLabel);
        calenderLabel.font = UIFont.systemFont(ofSize: 13);
        calenderLabel.text = String.init(format: "%d 年 %d 月 ", currentYear,currentMonth)
        
        nextMonthButton.frame = CGRect(x:buttonWidth * 2,y:lastMonthButton.frame.origin.y,width:buttonWidth,height:buttonHeight);
        nextMonthButton.setTitle("下月>>", for: .normal);
        nextMonthButton.setTitleColor(UIColor.black, for: .normal);
        nextMonthButton.addTarget(self, action: #selector(CalenderController.nextMonthButtonAction), for: .touchUpInside)
        self.view.addSubview(nextMonthButton);
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
    
    //collection view delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return dateArray.count
        }
        let firstWeekDay = NSDate.firstWeekdayInMonth(year: showYear, month: showMonth)
        let daysInThinsMonth = NSDate.getDaysInMonth(year: showYear, month: showMonth)
        return (firstWeekDay + daysInThinsMonth)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        if indexPath.section == 1{
            var day = 0//根据indexPath.row判断后 日历中显示的天
            let regCell = cell as! CalenderCell
            regCell.label.backgroundColor = UIColor.white;
            
            let firstWeekDay = NSDate.firstWeekdayInMonth(year: showYear, month: showMonth)
            let daysInThinsMonth = NSDate.getDaysInMonth(year: showYear, month: showMonth)
            let index = indexPath.row
            //在这个collectinView里 这个月第一天前的几个cell不显示，这个月最后一天后的cell不显示
            if index < firstWeekDay{
                regCell.label.backgroundColor = UIColor.white
                regCell.label.text = ""
            }else if index > (firstWeekDay + daysInThinsMonth - 1) {
                regCell.label.backgroundColor = UIColor.white
                regCell.label.text = ""
            }else {
                day = index - firstWeekDay + 1
                regCell.label.text = String.init(format: "%d", day)
            }
            
            //把今天标记一下
//            if showYear == currentYear && showMonth == currentMonth && day == currentDay{
//                regCell.label.backgroundColor = UIColor(red: 225/255, green: 75/255, blue: 6/255, alpha: 1);
//            }else{
//                regCell.label.backgroundColor = UIColor.white;
//            }
            
            //把指定时间戳的日期标记一下
//            let ymd = NSDate.getYearAndMonthAndDayFromTimestamp(timestamp: 1534172409847)
//            let myyear = ymd[0]
//            let mymonth = ymd[1]
//            let myday = ymd[2]
//            if showYear == myyear && showMonth == mymonth && day == myday{
//                regCell.label.backgroundColor = UIColor(red: 225/255, green: 75/255, blue: 6/255, alpha: 1)
//            }else{
//                regCell.label.backgroundColor = UIColor.white;
//            }
            /** 把上面的代码抽出来放到一个方法里 **/
            if judgeDateInMark(year: showYear, month: showMonth, day: day){
                regCell.label.backgroundColor = UIColor(red: 225/255, green: 75/255, blue: 6/255, alpha: 1)
            }else{
                regCell.label.backgroundColor = UIColor.white;
            }
            
            
            //超过今天的日期颜色为灰色，今天及之前的颜色为黑色
            if showYear > currentYear || (showYear == currentYear && showMonth > currentMonth) || (showYear == currentYear && showMonth == currentMonth && day > currentDay){
                regCell.label.textColor = UIColor.gray;
            }else{
                regCell.label.textColor = UIColor.black;
            }
        }
    }
    
    //判断要显示的天 是否在标记的日期里
    func judgeDateInMark(year:Int, month:Int, day:Int) -> Bool {
        let ymd = NSDate.getYearAndMonthAndDayFromTimestamp(timestamp: 1534172409847)
        let myyear = ymd[0]
        let mymonth = ymd[1]
        let myday = ymd[2]
        if year == myyear && month == mymonth && day == myday{
            return true
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateCellId, for: indexPath) as! DateCell;
            cell.label.text = dateArray[indexPath.row];
            return cell;
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: calenderCellId, for: indexPath) as! CalenderCell;
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return;
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CalenderCell;
        let string = cell.label.text;
        
        if string == nil || string == "" {
            return;
        }
        
        let showDay = Int(string!)!
        if showYear > currentYear || (showYear == currentYear && showMonth > currentMonth) || (showYear == currentYear && showMonth == currentMonth && showDay > currentDay){
            
            return ;
        }
        if self.delegate != nil {
            self.delegate?.didSelectData(year: showYear, month: showMonth, day: showDay);
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//显示日历的cell
class CalenderCell: UICollectionViewCell {
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = self.bounds
        label.textAlignment = .center;
        label.layer.cornerRadius = 15;
        label.layer.masksToBounds = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//显示星期的cell
class DateCell: UICollectionViewCell {
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = self.bounds
        label.textAlignment = .center;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
