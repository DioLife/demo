//
//  LotsMenuView.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/13.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import Kingfisher

//体育注单窗

protocol LotsMenuDelegate {
//    func onSportWindowCallback(acceptBestPeilv:Bool,inputMoney:String,notAutoPop:Bool,datas:[SportBean])
//    func onSportWindowClose(acceptBestPeilv:Bool,inputMoney:String,notAutoPop:Bool,datas:[SportBean])
    func onLotSelect(lotData:LotteryData)
}

class LotsMenuView: UIView ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var lotImg:UIImageView!
    @IBOutlet weak var lotNameTV:UILabel!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var headerBgImage: UIImageView!
    
    var _shareViewBackground :UIView!
    var _window             :UIWindow!
    var lotDatas:[LotteryData] = []
    var windowDelegate:LotsMenuDelegate?
    var isShow = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        headerBgImage.theme_image = "General.personalHeaderBg"
        headerBgImage.contentMode = .scaleAspectFill
        headerBgImage.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        let nib = UINib(nibName: "lot_cell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableView.register(nib, forCellReuseIdentifier: "lotCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func cancelAction(){
        dismiss()
    }
    
    func show() {
        if _shareViewBackground == nil{
            _shareViewBackground = UIView.init(frame: UIScreen.main.bounds)
            _shareViewBackground.backgroundColor = UIColor.clear
            _shareViewBackground.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(cancelAction)))
        }
        _window = UIWindow.init(frame: UIScreen.main.bounds)
        _window.windowLevel = UIWindowLevelAlert+1
        _window.backgroundColor = UIColor.clear
        _window.isHidden = true
        _window.isUserInteractionEnabled = true
        _window.addSubview(_shareViewBackground)
        _window.addSubview(self)
        _window.isHidden = false
        
        self.frame = CGRect.init(x:0, y:0, width:kScreenWidth/2, height:kScreenHeight)
        UIView.animate(withDuration: 0.5, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
        })
        self.isShow = true
        
    }
    
    func hidden() {
        self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
        self.frame = CGRect.init(x:0, y:0, width:kScreenWidth, height:kScreenHeight)
        self._window = nil
        self.isShow = false
    }
    
    func setData(items:[LotteryData],lotCode:String,lotName:String){
        
        lotNameTV.text = lotName
        // set lottery picture
        let imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + lotCode + ".png")
        lotImg.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
        
        lotDatas.removeAll()
        lotDatas = lotDatas + items
        tableView.reloadData()
    }
    
    @objc func dismiss() {
        hidden()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lotDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "lotCell") as? LotCell  else {
            fatalError("The dequeued cell is not an instance of SportOrderCell.")
        }
        let data = self.lotDatas[indexPath.row]
        cell.setupData(lotData: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = self.windowDelegate{
            delegate.onLotSelect(lotData: self.lotDatas[indexPath.row])
        }
    }

}
