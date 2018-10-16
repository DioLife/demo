//
//  RedPackageViewController.swift
//  gameplay
//
//  Created by William on 2018/8/23.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class RedPackageViewController: BaseController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var moneyIconIMV: UIImageView!//金钱符号
    @IBOutlet weak var bottomBGIMV: UIImageView!//底部背景
    @IBOutlet weak var zhjiangShowlabel: UILabel!//中奖后显示奖金
    @IBOutlet weak var toBGTop: NSLayoutConstraint!//顶部图片 距上的距离
    
    let identify = "SwiftCell"
    var recordArray = Array<PacketRecordBean>()
    var redPacketId = 0
    
    func setImages() {
        var imageArray = Array<UIImage>()
        for i in 1...5 {
            print(i)
            if let image = UIImage.init(named: "\(i).png") {
                imageArray.append(image)
            }
        }
        moneyIconIMV.animationImages = imageArray
        moneyIconIMV.animationDuration = 0.3 //动画间隔
        
        //抢红包触发
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(clickOneTap(sender:)))
        oneTap.numberOfTapsRequired = 1
        moneyIconIMV.isUserInteractionEnabled = true
        moneyIconIMV.addGestureRecognizer(oneTap)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "抢红包"
        if glt_iphoneX {
            toBGTop.constant = 20
        }
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        setImages()//加载动画图片
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.separatorStyle = .none
        self.myTableView.isUserInteractionEnabled = false
        //创建一个重用的单元格
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: identify)
        
        loadWebData()//下载数据
        
        //控制器
        Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
    }
    //顶部文字上下翻滚
    @objc func tickDown(){
        if self.recordArray.count == 0 {
            return
        }
        
        let offsetY = self.myTableView.contentOffset.y + 10
        self.myTableView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true) //30 * scrollIndex
        
        // 提前1个cell，开始加载更多数据源
        if (self.myTableView.indexPathsForVisibleRows?.contains(IndexPath.init(row: self.recordArray.count - 1, section: 0)))! {
            self.recordArray += self.recordArray
            self.myTableView.reloadData()
        }
    }
    
    //获取可用红包信息
    func loadWebData() -> Void {
        request(frontDialog: true,method: .get, loadTextStr:"获取红包数据中...", url:VALID_RED_PACKET_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = RedPacketWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            guard let redPacket = result.content else {return}
                            self.redPacketId = redPacket.id
                            self.getData(redPacketId: redPacket.id)
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
    
    //红包假数据
    func getData(redPacketId:Int) {
        request(frontDialog: true,method: .post, loadTextStr:"获取记录中...", url:RED_PACKET_RECORD_URL,params:["redPacketId":redPacketId],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
//                    print(resultJson)
                    if let result = GrabRedPacketRecordWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
//                            guard let redPacket:[PacketRecordBean] = result.content else {return}
                            if let redPacket = result.content {
                                self.recordArray = redPacket
                                self.myTableView.reloadData()
                            }
                        }else{
                            if let errorMsg = result.msg{
                                Tool.confirm(title: "温馨提示", message: errorMsg, controller: self)
                            }else{
//                                Tool.confirm(title: "温馨提示", message: "获取失败,请检查是否登录", controller: self)
//                                loginWhenSessionInvalid(controller: self) //如果没登陆，就跳到登陆页
                            }
                            if (result.code == 0 || result.code == 10000) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recordArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as UITableViewCell
        let model = self.recordArray[indexPath.row]
        let name = model.account.prefix(1)
        cell.textLabel?.text = "恭喜"+name+"****中现金\(model.money)元!"
        return cell
    }
    
    
    //实现手势方法  单击手势
    @objc func clickOneTap(sender: UITapGestureRecognizer) {
        moneyIconIMV.startAnimating()
        moneyIconIMV.isUserInteractionEnabled = false
        let deadline = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.moneyIconIMV.stopAnimating()
            self.openAction()
            self.moneyIconIMV.isUserInteractionEnabled = true
        }
//        print("单击手势")
    }
    
    @objc func openAction(){
        request(frontDialog: true,method: .post, loadTextStr:"抢红包中...", url:GRAB_RED_PACKET_URL,params:["redPacketId":self.redPacketId],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "抢红包失败"))
                            
                            self.bottomBGIMV.image = UIImage.init(named:"notzhjiang")
                            self.moneyIconIMV.isHidden = true
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = GrabPacketWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            guard let money = result.content else {return}
                            if money > 0{
                                self.showGrabDialog(money: money)
                            }
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                                self.moneyIconIMV.stopAnimating()
                            }else{
                                showToast(view: self.view, txt: convertString(string: "抢红包失败"))
                                self.bottomBGIMV.image = UIImage.init(named:"notzhjiang")
                                self.moneyIconIMV.isHidden = true
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func showGrabDialog(money:Float) -> Void {
        self.moneyIconIMV.isHidden = true
        self.bottomBGIMV.image = UIImage.init(named:"zhongjiang")
        
        let message = String.init(format: "恭喜您抢到了%.2f元", money)
        self.zhjiangShowlabel.isHidden = false
        self.zhjiangShowlabel.text = message
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
