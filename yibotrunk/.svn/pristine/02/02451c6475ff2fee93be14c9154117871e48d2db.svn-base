//
//  BigPanController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/27.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class BigPanController: BaseController,UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,BigPanFooterDelegate{
    
    @IBOutlet weak var tablview:UICollectionView!
    var bigDatas:[String] = []
    var footerView:BigPanFooterView!
    var activeID:Int64 = 0
    var couJianResult:CouJianResult!
    var currentLoopTimes = -1;
    var focusPos = -1;//聚集的点，即中奖奖项Item所在的位置
    let MAX_LOOP_TIMES = 4;//轮动几次

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "大转盘"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        tablview.delegate = self
        tablview.dataSource = self
        tablview.showsVerticalScrollIndicator = false
        //添加头视图
        tablview.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        loadWebData()
    }
    
    func loadWebData() -> Void {
        request(frontDialog: true,method: .get, loadTextStr:"获取中...", url:BIG_WHEEL_DATA_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    if isEmptyString(str: resultJson){
                        Tool.confirm(title: "溫馨提示", message: "您还没有大转盘抽奖活动，请添加活动后再重试", controller: self)
                        return
                    }
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = BigPanResultWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            guard let result = result.content else {return}
                            self.activeID = Int64(result.activeId)
                            self.bigDatas.removeAll()
                            self.bigDatas = self.bigDatas + result.awardNames
                            self.tablview.reloadData()
                            //同步尾部的数据
                            self.footerView.actionAwardRecord(controller: self, activeId: self.activeID)
                            self.footerView.updateActivitys(rule: result.activity_rule, condition: result.activity_condition, notices: result.activity_notices)
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    
    //delegate mark
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bigDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (kScreenWidth-0.5*6 - 20)/4, height: 80)
    }
    
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_pan", for: indexPath) as! BigPanCell
        let data = self.bigDatas[indexPath.row]
        cell.label.text = data
        if self.focusPos == -1{
            cell.bgimg.image = UIImage.init(named: "bigpan_normal_bg")
        }else{
            if indexPath.row == self.focusPos{
                cell.bgimg.image = UIImage.init(named: "bigpan_focus_bg")
            }else{
                cell.bgimg.image = UIImage.init(named: "bigpan_normal_bg")
            }
        }
        return cell
    }
    
    //创建头视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            //添加尾部视图
            footer.addSubview(self.addFooterContent())
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: kScreenWidth, height: 600)
    }
    
    func addFooterContent() -> UIView {
        if footerView == nil{
            footerView = Bundle.main.loadNibNamed("big_pan_footer", owner: nil, options: nil)?.first as? BigPanFooterView
            if let view = footerView{
                
                view.delegate = self
//                view.frame = CGRect.init(x: 0, y: 10, width: kScreenWidth, height: 400)
                view.awardView.layer.cornerRadius = 5
                view.startBtn.layer.cornerRadius = 22.5
//                view.toastView.layer.cornerRadius = 5
                
                view.awardOrderView.backgroundColor = UIColor.clear
//                let path = UIBezierPath(roundedRect: view.v1.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 5, height: 5))
//                let layer = CAShapeLayer()
//                layer.frame = view.v1.bounds
//                layer.path = path.cgPath
//                view.v1.layer.mask = layer
//
//                let path2 = UIBezierPath(roundedRect: view.v2.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 5, height: 5))
//                let layer2 = CAShapeLayer()
//                layer2.frame = view.v2.bounds
//                layer2.path = path2.cgPath
//                view.v2.layer.mask = layer2
            }
        }
        return footerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let lotData = self.bigDatas[indexPath.row]
        
    }
    
    func onChouJianEvent() {
        //转动转盘之前先获取之次抽奖应中的奖项数据。
        actionPickBigWheel(activeID: self.activeID);
    }
    
    //获取抽奖结果数据
    func actionPickBigWheel(activeID:Int64) -> Void {
        request(frontDialog: true,method: .get, loadTextStr:"抽奖中...", url:BIG_WHEEL_ACTION_URL,params: ["activeId":activeID],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    if isEmptyString(str: resultJson){
                        return
                    }
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "抽奖失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = CouJianResultWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            guard let result = result.content else {return}
                            self.couJianResult = result
                            if self.couJianResult != nil{
                                print(String.init(format: "%@%d", self.couJianResult.awardName,self.couJianResult.index))
                            }
                            self.currentLoopTimes = -1
                            self.focusPos = -1
                            self.startCoujianAnimation()
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "抽奖失败"))
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func startCoujianAnimation(){
        if self.couJianResult == nil{
            return
        }
        //disable coujian button
        self.footerView.startBtn.isEnabled = false
        self.footerView.startBtn.backgroundColor = UIColor.lightGray
        
        var stopPos = couJianResult.index
        print("the final stop pos = ",stopPos)
        stopPos = stopPos - 1////抽奖的中奖奖项index是从1开始的，要减1处理
        let totalLoopTimes = Int64(self.bigDatas.count*MAX_LOOP_TIMES) + stopPos
        var newPos = focusPos
        newPos = newPos + 1
        currentLoopTimes = currentLoopTimes + 1
        let posInOneLoop = newPos % self.bigDatas.count
        self.focusPos = posInOneLoop
        self.tablview.reloadData()
        print("posInOneLoop = ",posInOneLoop)
        print("current loop = ",currentLoopTimes)
        print("total loop = ",totalLoopTimes)
        if currentLoopTimes < totalLoopTimes{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self.startCoujianAnimation()
            }
        }else{
            self.footerView.startBtn.isEnabled = true
            self.footerView.startBtn.backgroundColor = UIColor.red
            let msg = String.init(format: "您抽到:%@", self.couJianResult != nil ? self.couJianResult.awardName : "")
            Tool.confirm(title: "温馨提示", message: msg, controller: self)
        }
        
    }
    

}
