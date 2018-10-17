//
//  CpMainController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/12.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

protocol EnterTouzhuDelegate {
    func bindTouzhuPage(controller:UIViewController)
}

class CpMainController: BaseController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var lotteryName:UILabel!
    @IBOutlet weak var lotteryOpenTime:UILabel!
    @IBOutlet weak var resultBalls:BallsView!
    @IBOutlet weak var touzhuBtn:UIButton!
    @IBOutlet weak var caipiaos:UICollectionView!
    var lotterys = [LotteryData]()
    var randomLotData:LotteryData?
    var bindShakeDelegate:EnterTouzhuDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "彩票"
        caipiaos!.register(CPViewCell.self, forCellWithReuseIdentifier:"cell")
        caipiaos.showsVerticalScrollIndicator = false
        loadLotteryData()
        // 给开始按钮设置圆角
        touzhuBtn.layer.cornerRadius = 17.5
        touzhuBtn.addTarget(self,action:#selector(performTouzhu),for:.touchUpInside)
        //default balls value set when we havent get result from web
        let viewPlaceHoldWidth = kScreenWidth - 30
        resultBalls.setupBalls(nums: ["?","?","?"],offset: 0, lotTypeCode: "",cpVersion: YiboPreference.getVersion(), viewPlaceHoldWidth: viewPlaceHoldWidth)
        
    }
    
    //随机彩种开奖结果栏点快捷投注
    func performTouzhu() -> Void {
        if let data = self.randomLotData{
            if let lotteryCode = data.code{
                syncLotteryPlaysByCode(controller: self, lotteryCode: lotteryCode, shakeDelegate: self.bindShakeDelegate)
            }else{
                showToast(view: self.view, txt: "没有彩种编码")
            }
        }
    }
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lotterys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (kScreenWidth-0.5*6)/3, height: 130)
    }
    
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CPViewCell
        if let lotName = self.lotterys[indexPath.row].name{
            cell.titleLabel?.text = lotName
        }else{
            cell.titleLabel?.text = "暂无名称"
        }
        if let lotCode = self.lotterys[indexPath.row].code{
            // set lottery picture
            var name = lotCode
            if lotCode == YHC_CODE{
                name = "native_" + lotCode
            }
            let imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + name + ".png")
            cell.imgView?.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            cell.imgView?.image = UIImage(named: "default_lottery")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lotData = self.lotterys[indexPath.row]
        if let lotteryCode = lotData.code{
            if lotteryCode == YHC_CODE{
                forwardGame(controller: self, playCode: lotteryCode, gameCodeOrID: "")
                return
            }
            syncLotteryPlaysByCode(controller: self, lotteryCode: lotteryCode, shakeDelegate: self.bindShakeDelegate)
        }else{
            showToast(view: self.view, txt: "没有彩种编码")
        }
    }
    
    /**
     * 取出一个随机的彩种及随机的玩法，用于快捷下注
     * @param lotterys
     * @return
     */
    func figureRandomLottery(lotterys:[LotteryData]) -> Void{
        if lotterys.isEmpty{
            return
        }
        var randomNumber:Int = Int(arc4random() % UInt32((lotterys.count)))
        if randomNumber == lotterys.count{
            randomNumber = randomNumber - 1
        }
        let randomLot = lotterys[randomNumber]
        self.randomLotData = randomLot
        if let data = self.randomLotData{
            getOpenResultDetail(code:data.code!);
        }
    }
    
    func updateFastView(result:[OpenResultDetail]) -> Void {
        if result.isEmpty{
            return
        }
        let detail = result[0]
        if let data = self.randomLotData{
            let viewPlaceHoldWidth = kScreenWidth - 30
            lotteryName.text = String.init(format: "[%@] 最新开奖:", data.name!)
            resultBalls.setupBalls(nums: detail.haoMaList, offset: 0, lotTypeCode: data.czCode!, cpVersion: YiboPreference.getVersion(), viewPlaceHoldWidth: viewPlaceHoldWidth)
            lotteryOpenTime.text = String.init(format: "每%@开奖", getFormatTime(secounds: TimeInterval(data.duration)))
        }
    }
    
    func getOpenResultDetail(code:String) -> Void {
        
        let params:Dictionary<String,AnyObject> = ["lotCode":code as AnyObject]
        request(frontDialog: false, loadTextStr:"获取中...", url: OPEN_RESULT_DETAIL_URL,
                params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        return
                    }
                    if let result = OpenResultDetailWraper.deserialize(from: resultJson){
                        if result.success{
                            if let lotterysValue = result.content{
                                //获取到随机彩种的开奖信息后，更新快捷下注面板
                                self.updateFastView(result:lotterysValue);
                            }
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                        }
                    }
        })
    }
    
    func loadLotteryData() {
        request(frontDialog: true, loadTextStr:"获取中...", url:LOTTERYS_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = LotterysWraper.deserialize(from: resultJson){
                        if result.success{
                            if let lotterysValue = result.content{
                                self.lotterys.removeAll()
                                self.lotterys = self.lotterys + lotterysValue
                                self.caipiaos.reloadData()//refresh collect view again after pick lotterys from network
                                //获取到彩种信息后，根据所有彩种随机取某个彩种并获取开奖结果
                                self.figureRandomLottery(lotterys: lotterysValue)
                            }
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            //save system config to user default
                            YiboPreference.saveLotterys(value: resultJson as AnyObject)
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
    
}
