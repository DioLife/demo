
//
//  OpenCenterController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/11/20.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher
//开奖公告页
class OpenCenterController:BaseMainController,UITableViewDataSource,UITableViewDelegate,LennyPullRefreshDelegate{

    @IBOutlet weak var tableView:UITableView!
    var datas:[KaijianEntify] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustRightBtn()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.setLennyPullRefresh(Style: .All, delegate: self)
        loadDatas(pullDown: true,showDialog: true)
        
    }
    
    override func adjustRightBtn() -> Void {
        super.adjustRightBtn()
        if YiboPreference.getLoginStatus(){
            self.navigationItem.rightBarButtonItems?.removeAll()
            let menuBtn = UIBarButtonItem.init(image: UIImage.init(named: "icon_menu"), style: .plain, target: self, action: #selector(BaseMainController.actionMenu))
            self.navigationItem.rightBarButtonItem = menuBtn
            //            let qrBtn = UIBarButtonItem.init(title: "二维码", style: .plain, target: self, action: #selector(BaseMainController.actionQRCode))
            let qr_icon = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
            qr_icon.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(actionQRCode))
            qr_icon.addGestureRecognizer(tap)
            qr_icon.image = UIImage.init(named: "qr")
            qr_icon.layer.borderColor = UIColor.white.cgColor
            qr_icon.layer.borderWidth = 2
            let qrBtn = UIBarButtonItem.init(customView: qr_icon)
            self.navigationItem.rightBarButtonItems = [menuBtn,qrBtn]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lotCode = self.datas[indexPath.row].lotCode
        let lotName = self.datas[indexPath.row].lotName
        let lotType = self.datas[indexPath.row].lotType
        openOpenResultController(controller: self, cpName: lotName, cpBianMa: lotCode, cpTypeCode: String.init(describing: lotType))
    }
    
    func loadDatas(pullDown down:Bool,showDialog:Bool) -> Void {
        request(frontDialog: showDialog, loadTextStr:"获取中...",url:OPEN_RESULTS_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    self.tableView.LennyDidCompletedWithRefreshIs(downPull: down)
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取数据失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = OpenResultWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            if let result = result.content{
                                self.datas.removeAll()
                                self.datas = self.datas + result
                                self.tableView.reloadData()
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取数据失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ballWidth:CGFloat = 30
        let data = self.datas[indexPath.row]
        if !isEmptyString(str: data.haoma){
            if data.haoma.contains(","){
                let totalBallWidth = ballWidth * CGFloat(data.haoma.components(separatedBy: ",").count)
                let viewPlaceHoldWidth = kScreenWidth - 60 - 30 - 8
                //如果ballview占位宽度不大于实际号码宽度，则需要换行处理
                if totalBallWidth > viewPlaceHoldWidth{
                    return 140
                }
            }
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kaijianCell") as? KaiJianCell  else {
            fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
        }
        let data = self.datas[indexPath.row]
        if !isEmptyString(str: data.lotName){
            cell.czName.text = data.lotName
        }else{
            cell.czName.text = "暂无彩种"
        }
        let cpVersion  = VERSION_1
        if !isEmptyString(str: data.haoma){
            if data.haoma.contains(","){
                cell.emptyHaomaUI.isHidden = true
                cell.ballViews.isHidden = false
                cell.ballViews.setupBalls(nums: data.haoma.components(separatedBy: ","), offset: 0, lotTypeCode: String.init(describing: data.lotType), cpVersion: cpVersion,ballsViewWidth: cell.ballViews.width)
            }else{
                cell.emptyHaomaUI.isHidden = false
                cell.ballViews.isHidden = true
                cell.emptyHaomaUI.text = data.haoma
            }
        }else{
            let nums = "等,待,开,奖"
            cell.ballViews.setupBalls(nums: nums.components(separatedBy: ","), offset: 0,lotTypeCode: String.init(describing: data.lotType), cpVersion: cpVersion,ballsViewWidth: cell.ballViews.width)
        }
        if !isEmptyString(str: data.qihao){
            cell.lastQihao.text = String.init(format: "第%@期", data.qihao)
        }else{
            cell.lastQihao.text = "暂无期号"
        }
        
        if !isEmptyString(str: data.lotCode){
            // set lottery picture
            let imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + data.lotCode + ".png")
            cell.icon?.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            cell.icon?.image = UIImage(named: "default_lottery")
        }
        
        return cell
    }
    
    func LennyPullUpRequest() {
        loadDatas(pullDown: false,showDialog: false)
    }
    
    func LennyPullDownRequest() {
        loadDatas(pullDown: true,showDialog: false)
    }
}
