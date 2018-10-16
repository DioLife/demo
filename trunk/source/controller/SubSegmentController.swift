//
//  SubSegmentController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/14.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import Kingfisher
/*
 主界面分栏子视图控制器
 官方，信用，真人，电子，体育
 */
class SubSegmentController: BaseController ,UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var gameDatas = [LotteryData]()//the lottery game data for single tab page
    @IBOutlet weak var gridview: UICollectionView!
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        setViewBackgroundColorTransparent(view: self.view)
        setViewBackgroundColorTransparent(view: gridview)
        
        gridview.delegate = self
        gridview.dataSource = self
        gridview.register(CPViewCell.self, forCellWithReuseIdentifier:"cell")
        gridview.showsVerticalScrollIndicator = false
        self.gridview.reloadData()
    }
    
    func reload(){
        if self.gridview != nil {
            self.gridview.reloadData()
        }
    }
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (kScreenWidth-0.5*6)/3, height: 130)
    }
    
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameDatas.count
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CPViewCell
        let data = self.gameDatas[indexPath.row]
        cell.setupData(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lotData = self.gameDatas[indexPath.row]
        let data = self.gameDatas[indexPath.row]
        
        if data.moduleCode == CAIPIAO_MODULE_CODE{
            
            if !YiboPreference.getLoginStatus() {
                loginWhenSessionInvalid(controller: self)
                return
            }
            
            let touzhuController = UIStoryboard(name: "touzh_page",bundle:nil).instantiateViewController(withIdentifier: "touzhu")
            let touzhuPage = touzhuController as! TouzhController
            touzhuPage.lotData = lotData
            self.navigationController?.pushViewController(touzhuPage, animated: true)
        }else{
            guard let dCode = lotData.czCode else {return}
            if lotData.moduleCode == SPORT_MODULE_CODE{
                if dCode == "hgty"{
                    let vc = UIStoryboard(name: "new_sport_page", bundle:nil).instantiateViewController(withIdentifier: "sport")
                    let sport = vc as! NewSportController
                    self.navigationController?.pushViewController(sport, animated: true)
                }else{
                    showToast(view: self.view, txt: "开发中，敬请期待")
                }
            }else if lotData.moduleCode == REAL_MODULE_CODE{
                forwardReal(controller: self, requestCode: 0, playCode: dCode)
            }else if lotData.moduleCode == GAME_MODULE_CODE{
                
                if dCode == "bydr" || dCode == "bbin" || dCode == "ab" {
                    forwardGame(controller: self, playCode: dCode, gameCodeOrID: "")
                }else {
                    let vc = UIStoryboard(name: "innner_game_list", bundle: nil).instantiateViewController(withIdentifier: "gameList") as! GameListController
                    vc.gameCode = dCode
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
}

