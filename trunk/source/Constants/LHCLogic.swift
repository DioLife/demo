////
////  LHCLogic.swift
////  gameplay
////
////  Created by yibo-johnson on 2018/6/15.
////  Copyright © 2018年 yibo. All rights reserved.
////
//
//import UIKit
//
////@objc public protocol PlayButtonDelegate: class {
////    @objc optional func onButtonDelegate(tag:Int,selectIndex:Int,dataSource:[String],refresh:Bool,playCode:String)
////}
//
////处理六合彩连马，合肖，只选不中，连肖等特殊玩法的下注逻辑
//class LHCLogic : NSObject{
//
//    let lm_category_one = ["三中二","三全中","二全中","二中特","特串"]
//    let lm_category_two = ["单选/复式","胆拖","生肖对碰","尾数对碰","混合对碰"]
//    let hx_category = ["前肖","后肖","天肖","地肖","野兽","家禽","单","双"]
//    let zxbz_category = ["五不中","六不中","七不中","八不中","九不中","十不中","十一不中","十二不中"]
//    let lx_category_one = ["连肖二肖","连肖三肖","连肖四肖","连肖五肖"]
//    let lx_category_two = ["单选/复式","胆拖"]
//
//    var firstCategoryIndex:Int = 0
//    var secondCategoryIndex:Int = 0
//    var delegate:PlayButtonDelegate?
//    private var is_play_bar_show = true;//玩法拖动条是否显示
//
//    var cpCode:String = ""
//    var cpVersion:String = ""
//    var playCode:String = "" //当前玩法
//    var specialLittlePlayCode = "" //当前玩法下的分类小玩法
//    var parentCode:String = ""
//    var header:UIView!
//    var table:UITableView!
//    var shengxiaos:[String] = []
//    lazy var slected_shenxiao_when_hx:NSMutableArray=NSMutableArray()//保存各生肖项的选中状态
//    lazy var tian_xiao:[String] = ["牛","兔","龙","马","猴","猪"]
//    lazy var di_xiao:[String] = ["鼠","虎","蛇","羊","鸡","狗"]
//
//    //注意合肖时，是加个生肖tableview到头部
//    func handle_lhc_special_play(playCode:String,parentcode:String,cpCode:String,cpVersion:String) -> UIView?{
//
//        self.playCode = playCode
//        self.parentCode = parentcode
//        self.cpCode = cpCode
//        self.cpVersion = cpVersion
//
//        if header != nil{
//            for view in header.subviews{
//                view.removeFromSuperview()
//            }
//            header = nil
//        }
//        if (playCode == "lm") && isEmptyString(str: parentcode){
//            return lm_play()
//        }else if (playCode == "hx") && isEmptyString(str: parentcode){
//            return hx_play()
//        }else if (playCode == "lx") && isEmptyString(str: parentcode){
//            return lm_play()
//        }else if (playCode == "zxbz") && isEmptyString(str: parentcode){
//            return zxbz_play()
//        }
//        return nil
//    }
//
//    func update_playcode(playCode:String){
//        self.playCode = playCode
//    }
//
//    private func zxbz_play() -> UIView{
//
//        header = UIView.init(frame: CGRect.init(x: self.is_play_bar_show ? kScreenWidth*0.33 : kScreenWidth*0.05, y: 0, width: self.is_play_bar_show ? kScreenWidth*0.67 : kScreenWidth*0.95, height: 44))
//        header.backgroundColor = UIColor.init(hex: 0x3B945C)
//        let categorybtn = UIButton.init(frame: CGRect.init(x: header.bounds.origin.x+10, y: header.bounds.origin.y+5, width: header.bounds.width-20, height: header.bounds.height - 10))
//        categorybtn.titleLabel?.textColor = UIColor.white
//        categorybtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        categorybtn.setBackgroundImage(UIImage.init(named: "lot_name_bg"), for: .normal)
//        categorybtn.setTitle(zxbz_category[self.firstCategoryIndex], for: .normal)
//        categorybtn.addTarget(self, action: #selector(onButtonClick(ui:)), for: .touchUpInside)
//        categorybtn.tag = 101
//        let indictor = UIImageView.init(frame: CGRect.init(x: categorybtn.bounds.origin.x+categorybtn.bounds.width/2+7+30, y:  categorybtn.bounds.origin.y+categorybtn.bounds.height/2-2, width: 7, height: 4))
//        indictor.image = UIImage.init(named: "arrow_down")
//        categorybtn.addSubview(indictor)
//        header.addSubview(categorybtn)
//        return header
//    }
//
//
//    private func lm_play() -> UIView{
//
//        header = UIView.init(frame: CGRect.init(x: self.is_play_bar_show ? kScreenWidth*0.33 : kScreenWidth*0.05, y: 0, width: self.is_play_bar_show ? kScreenWidth*0.67 : kScreenWidth*0.95, height: 44))
//        header.backgroundColor = UIColor.init(hex: 0x3B945C)
//
//        let categorybtn = UIButton.init(frame: CGRect.init(x: header.bounds.origin.x+10, y: header.bounds.origin.y+5, width: header.bounds.width/2-20, height: header.bounds.height - 10))
//        categorybtn.titleLabel?.textColor = UIColor.white
//        categorybtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        categorybtn.setBackgroundImage(UIImage.init(named: "lot_name_bg"), for: .normal)
//        categorybtn.setTitle(self.playCode == "lx" ? lx_category_one[self.firstCategoryIndex] : lm_category_one[self.firstCategoryIndex], for: .normal)
//        categorybtn.addTarget(self, action: #selector(onButtonClick(ui:)), for: .touchUpInside)
//        categorybtn.tag = 101
//        let indictor2 = UIImageView.init(frame: CGRect.init(x: categorybtn.bounds.origin.x+categorybtn.bounds.width/2+7+30, y:  categorybtn.bounds.origin.y+categorybtn.bounds.height/2-2, width: 7, height: 4))
//        indictor2.image = UIImage.init(named: "arrow_down")
//        categorybtn.addSubview(indictor2)
//
//        let secondarybtn = UIButton.init(frame: CGRect.init(x: header.bounds.origin.x+header.bounds.width/2+10, y: header.bounds.origin.y+5, width: header.bounds.width/2-20, height: header.bounds.height - 10))
//        secondarybtn.setTitle(lm_category_two[self.secondCategoryIndex], for: .normal)
//        secondarybtn.titleLabel?.textColor = UIColor.white
//        secondarybtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        secondarybtn.setBackgroundImage(UIImage.init(named: "lot_name_bg"), for: .normal)
//        secondarybtn.setTitle(lm_category_two[self.secondCategoryIndex], for: .normal)
//        secondarybtn.addTarget(self, action: #selector(onButtonClick(ui:)), for: .touchUpInside)
//        secondarybtn.tag = 102
//        let indictor = UIImageView.init(frame: CGRect.init(x: categorybtn.bounds.origin.x+categorybtn.bounds.width/2+7+30, y:  categorybtn.bounds.origin.y+categorybtn.bounds.height/2-2, width: 7, height: 4))
//        indictor.image = UIImage.init(named: "arrow_down")
//        secondarybtn.addSubview(indictor)
//
//        header.addSubview(categorybtn)
//        header.addSubview(secondarybtn)
//        return header
//    }
//
//    //合肖玩法时-需要添加一个生肖的列表作为头
//    private func hx_play() -> UIView{
//        header = UIView.init(frame: CGRect.init(x: self.is_play_bar_show ? kScreenWidth*0.33 : kScreenWidth*0.05, y: 0, width: self.is_play_bar_show ? kScreenWidth*0.67 : kScreenWidth*0.95, height: 44*12+44+5))
//        header.backgroundColor = UIColor.init(hex: 0x3B945C)
//        let categorybtn = UIButton.init(frame: CGRect.init(x: header.bounds.origin.x+10, y: header.bounds.origin.y+5, width: header.bounds.width-20, height: 44))
//        categorybtn.titleLabel?.textColor = UIColor.white
//        categorybtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        categorybtn.setBackgroundImage(UIImage.init(named: "lot_name_bg"), for: .normal)
//        categorybtn.setTitle(hx_category[self.firstCategoryIndex], for: .normal)
//        categorybtn.addTarget(self, action: #selector(onButtonClick(ui:)), for: .touchUpInside)
//        categorybtn.tag = 101
//        let indictor = UIImageView.init(frame: CGRect.init(x: categorybtn.bounds.origin.x+categorybtn.bounds.width/2+7+30, y:  categorybtn.bounds.origin.y+categorybtn.bounds.height/2-2, width: 7, height: 4))
//        indictor.image = UIImage.init(named: "arrow_down")
//        categorybtn.addSubview(indictor)
//        header.addSubview(categorybtn)
//
//        if self.shengxiaos.isEmpty{
//            shengxiaos = getNumbersFromShengXiao()
//        }
//        table = UITableView.init(frame: CGRect.init(x: header.bounds.origin.x, y: 44+5, width: header.bounds.width, height: 12*44))
//        table.delegate = self
//        table.dataSource = self
//        table.isScrollEnabled = false
//        table.reloadData()
//        header.addSubview(table)
//
//        return header
//    }
//
//    private func getDataSource(tag:Int) -> [String]{
//        var dataSource:[String] = []
//        if tag == 101{
//            if (self.playCode == "lm") && isEmptyString(str: self.parentCode){
//                dataSource = dataSource + lm_category_one
//            }else if (playCode == "hx") && isEmptyString(str: self.parentCode){
//                dataSource = dataSource + hx_category
//            }else if (playCode == "lx") && isEmptyString(str: self.parentCode){
//                dataSource = dataSource + lx_category_one
//            }else if (self.playCode == "zxbz") && isEmptyString(str: self.parentCode){
//                dataSource = dataSource + zxbz_category
//            }
//        }else{
//            if (self.playCode == "lm") && isEmptyString(str: self.parentCode){
//                dataSource = dataSource + lm_category_two
//            }else if (playCode == "lx") && isEmptyString(str: self.parentCode){
//                dataSource = dataSource + lx_category_two
//            }
//        }
//        return dataSource
//    }
//
//    func handle_hx_category_select(select_index:Int){
//        if self.playCode != "hx"{
//            return
//        }
//        let name = self.hx_category[select_index]
//        if name == "前肖"{
//            self.slected_shenxiao_when_hx.removeAllObjects()
//            for index in 0...(self.shengxiaos.count/2)-1{
//                if !self.slected_shenxiao_when_hx.contains(index){
//                    self.slected_shenxiao_when_hx.add(index)
//                }
//            }
//        }else if name == "后肖"{
//            self.slected_shenxiao_when_hx.removeAllObjects()
//            for index in self.shengxiaos.count/2...(self.shengxiaos.count/2)-1{
//                if !self.slected_shenxiao_when_hx.contains(index){
//                    self.slected_shenxiao_when_hx.add(index)
//                }
//            }
//        }else if name == "天肖"{
//            self.slected_shenxiao_when_hx.removeAllObjects()
//            for index in 0...self.shengxiaos.count - 1{
//                let sx = self.shengxiaos[index]
//                let array = sx.components(separatedBy: "|")
//                if self.tian_xiao.contains(array[0]){
//                    self.slected_shenxiao_when_hx.add(index)
//                }
//            }
//        }else if name == "地肖"{
//            self.slected_shenxiao_when_hx.removeAllObjects()
//            for index in 0...self.shengxiaos.count - 1{
//                let sx = self.shengxiaos[index]
//                let array = sx.components(separatedBy: "|")
//                if self.di_xiao.contains(array[0]){
//                    self.slected_shenxiao_when_hx.add(index)
//                }
//            }
//        }else{
//            self.slected_shenxiao_when_hx.removeAllObjects()
//        }
//    }
//
//    @objc func onButtonClick(ui:UIButton){
//
//        if let delegate = self.delegate{
//            let dataSource:[String] = getDataSource(tag: ui.tag)
//            delegate.onButtonDelegate!(tag: ui.tag, selectIndex: ui.tag == 101 ? self.firstCategoryIndex : self.secondCategoryIndex,
//                                       dataSource: dataSource,refresh:(self.playCode != "hx"),playCode: self.playCode)
//        }
//    }
//
//    func updateTitle(tag:Int,selectListPos:Int){
//        var dataSource:[String] = getDataSource(tag: tag)
//        if !dataSource.isEmpty{
//            let title = dataSource[selectListPos]
//            print("the title === ",title)
//            let button:UIButton = tag == 101 ? self.header?.subviews[0] as! UIButton : self.header?.subviews[1] as! UIButton
//            button.setTitle(title, for: .normal)
//        }
//    }
//
//    func updateIndex(tag:Int,selectIndex:Int){
//        if tag == 101{
//            self.firstCategoryIndex = selectIndex
//        }else if tag == 102{
//            self.secondCategoryIndex = selectIndex
//        }
//    }
//
//    func updateLittlePlayCode(littleCode:String){
//        self.specialLittlePlayCode = littleCode
//    }
//
//    func updatePlayBarStatus(play_bar_show:Bool){
//        self.is_play_bar_show = play_bar_show
//    }
//
//    func initializeIndexTitle(){
//        self.firstCategoryIndex = 0
//        self.secondCategoryIndex = 0
//        self.slected_shenxiao_when_hx.removeAllObjects()
//        if self.header != nil{
//            if self.header.subviews.count == 2{
//                updateTitle(tag: 101, selectListPos: 0)
//                updateTitle(tag: 102, selectListPos: 0)
//            }else if self.header.subviews.count == 1{
//                updateTitle(tag: 101, selectListPos: 0)
//            }
//        }
//    }
//
//    func clearAfterBetSuccess(){
//        self.slected_shenxiao_when_hx.removeAllObjects()
//        if self.table != nil{
//            self.table.reloadData()
//        }
//    }
//
//    //合肖情况下，将shenxiao子玩法当做特殊分类玩法code
//    func update_hx_little_code(little_code:String){
//        if self.playCode == "hx"{
//            self.specialLittlePlayCode = little_code
//        }
//    }
//
//    func find_bet_unpass_msg(selectDatas:[PeilvWebResult]) -> String{
//        if selectDatas.isEmpty{
//            return "没有选择号码"
//        }
//        //连码，自选不中，连肖，合肖情况下的注单计算是按玩法的组合计算
//        if playCode == "lm" || playCode == "zxbz" || playCode == "lx" || playCode == "hx"{
//            let count = selectDatas.count
//            if playCode == "lm"{
//                if specialLittlePlayCode == "sze" || specialLittlePlayCode == "sqz"{
//                    if count < 3 {
//                        return "您至少需要选择3个号码"
//                    }
//                }else if specialLittlePlayCode == "eqz" || specialLittlePlayCode == "ezt" || specialLittlePlayCode == "tc"{
//                    if count < 2{
//                        return "您至少需要选择2个号码"
//                    }
//                }
//            }else if playCode == "zxbz"{
//                if specialLittlePlayCode == "wbz"{
//                    if count != 5 {
//                        return "您需要选择5个号码"
//                    }
//                }else if specialLittlePlayCode == "lbz"{
//                    if count != 6 {
//                        return "您需要选择6个号码"
//                    }
//                }else if specialLittlePlayCode == "qbz"{
//                    if count != 7 {
//                        return "您需要选择7个号码"
//                    }
//                }else if specialLittlePlayCode == "bbz"{
//                    if count != 8 {
//                        return "您需要选择8个号码"
//                    }
//                }else if specialLittlePlayCode == "jbz"{
//                    if count != 9 {
//                        return "您需要选择9个号码"
//                    }
//                }else if specialLittlePlayCode == "sbz"{
//                    if count != 10 {
//                        return "您需要选择10个号码"
//                    }
//                }else if specialLittlePlayCode == "sybz"{
//                    if count != 11 {
//                        return "您需要选择11个号码"
//                    }
//                }else if specialLittlePlayCode == "sebz"{
//                    if count != 12 {
//                        return "您需要选择12个号码"
//                    }
//                }
//
//            }else if playCode == "hx"{
//                if isEmptyString(str: self.specialLittlePlayCode){
//                    return "请选择生肖号码"
//                }
//                let numbers = getSelectedShenxiaos()
//                if !isEmptyString(str: numbers){
//                    let array = numbers.components(separatedBy: ",")
//                    if specialLittlePlayCode == "hxy"{
//                        if array.count != 1 {
//                            return "请选择1个生肖"
//                        }
//                    }else if specialLittlePlayCode == "hxe"{
//                        if array.count != 2 {
//                            return "请选择2个生肖"
//                        }
//                    }else if specialLittlePlayCode == "hxs"{
//                        if array.count != 3 {
//                            return "请选择3个生肖"
//                        }
//                    }else if specialLittlePlayCode == "hxsi"{
//                        if array.count != 4 {
//                            return "请选择4个生肖"
//                        }
//                    }else if specialLittlePlayCode == "hxw"{
//                        if array.count != 5 {
//                            return "请选择5个生肖"
//                        }
//                    }else if specialLittlePlayCode == "hxl"{
//                        if array.count != 6 {
//                            return "请选择6个生肖"
//                        }
//                    }else if specialLittlePlayCode == "hxq"{
//                        if array.count != 7 {
//                            return "请选择7个生肖"
//                        }
//                    }else if specialLittlePlayCode == "hxb"{
//                        if array.count != 8 {
//                            return "请选择8个生肖"
//                        }
//                    }else if specialLittlePlayCode == "hxj"{
//                        if array.count != 9 {
//                            return "请选择9个生肖"
//                        }
//                    }else if specialLittlePlayCode == "hxsh"{
//                        if array.count != 10 {
//                            return "请选择10个生肖"
//                        }
//                    }else if specialLittlePlayCode == "hxsy"{
//                        if array.count != 11 {
//                            return "请选择11个生肖"
//                        }
//                    }
//                }else{
//                    return "需要选择至少一个生肖"
//                }
//            }else if playCode == "lx"{
//                if specialLittlePlayCode == "lxex"{
//                    if count < 2 {
//                        return "至少需要选择2个生肖"
//                    }
//                }else if specialLittlePlayCode == "lxsx"{
//                    if count < 3{
//                        return "至少需要选择3个生肖"
//                    }
//                }else if specialLittlePlayCode == "lxsix"{
//                    if count < 4{
//                        return "至少需要选择4个生肖"
//                    }
//                }else if specialLittlePlayCode == "lxwx"{
//                    if count < 5{
//                        return "至少需要选择5个生肖"
//                    }
//                }
//            }
//        }
//        return ""
//    }
//
//    /*
//     合肖玩法时，计算的注数号码是从头部生肖中选择出来的生肖串
//     @param selectDatas
//     @param numbers 生肖号码串
//    */
//    func calcHxOrder(selectDatas:[PeilvWebResult],numbers:String) -> [PeilvOrder]{
//        if selectDatas.isEmpty{
//            return []
//        }
//        if isEmptyString(str: numbers){
//            return []
//        }
//        var orders:[PeilvOrder] = []
//        let data = selectDatas[0]
//        let order = PeilvOrder()
//        order.a = data.inputMoney
//        order.c = numbers
//        order.d = data.code
//        order.i = data.playCode
//        order.oddName = data.numName
//        orders.append(order)
//        return orders
//    }
//
//    /*
//     @param playCode 当前玩法
//     @param specialLittlePlayCode 当前玩法下的分类小玩法
//     */
//    func calcOrder(selectDatas:[PeilvWebResult]) -> [PeilvOrder]{
//        if selectDatas.isEmpty{
//            return []
//        }
//
//        let error_msg = find_bet_unpass_msg(selectDatas: selectDatas)
//        if !isEmptyString(str: error_msg){
//            return []
//        }
//        var orders:[PeilvOrder] = []
//        //连码，自选不中，连肖，合肖情况下的注单计算是按玩法的组合计算
//        if playCode == "lm" || playCode == "zxbz" || playCode == "lx" || playCode == "hx"{
//            if playCode == "lm"{
//                var loop = 0
//                if specialLittlePlayCode == "sze" || specialLittlePlayCode == "sqz"{
//                    loop = 3
//                }else if specialLittlePlayCode == "ezt" || specialLittlePlayCode == "eqz" || specialLittlePlayCode == "tc"{
//                    loop = 2
//                }
//                if loop == 0{
//                    return []
//                }
//                //玩法code
//                var carr = Array.init(repeating: "", count: selectDatas.count)
//                var narr = Array.init(repeating: "", count: selectDatas.count)
//                for i in 0...selectDatas.count - 1{
//                    carr[i] = selectDatas[i].code
//                    narr[i] = selectDatas[i].numName
//                }
//                var codes = [String]()
//                ZhuxuanLogic.combination(ia: carr, n: loop, results: &codes,format:",")
//                var numbers = [String]()
//                ZhuxuanLogic.combination(ia: narr, n: loop, results: &numbers,format:",")
//                let inputMoney = selectDatas[0].inputMoney
//                if codes.isEmpty{
//                    return []
//                }
//                if codes.count == numbers.count{
//                    for j in 0...codes.count-1{
//                        let order = PeilvOrder()
//                        order.a = inputMoney
//                        order.c = numbers[j]
//                        order.d = codes[j]
//                        order.i = specialLittlePlayCode
//                        order.oddName = selectDatas[0].numName
//                        orders.append(order)
//                    }
//                }
//                return orders
//            }else if playCode == "zxbz"{
//                if !selectDatas.isEmpty{
//                    let data = selectDatas[0]
//                    var numbers = ""
//                    for d in selectDatas{
//                        numbers = numbers + d.numName
//                        numbers.append(",")
//                    }
//                    if numbers.count > 0{
//                        numbers = (numbers as NSString).substring(to: numbers.count - 1)
//                    }
//                    let order = PeilvOrder()
//                    order.a = data.inputMoney
//                    order.c = numbers
//                    order.d = data.code
//                    order.i = data.playCode
//                    order.oddName = data.numName
//                    orders.append(order)
//                }
//                return orders
//            }else if playCode == "hx"{
//                if isEmptyString(str: specialLittlePlayCode){
//                    return []
//                }
//                return calcHxOrder(selectDatas: selectDatas, numbers: getSelectedShenxiaos())
//            }else if playCode == "lx"{
//                var loop = 0
//                if specialLittlePlayCode == "lxex"{
//                    loop = 2
//                }else if specialLittlePlayCode == "lxsx"{
//                    loop = 3
//                }else if specialLittlePlayCode == "lxsix"{
//                    loop = 4
//                }else if specialLittlePlayCode == "lxwx"{
//                    loop = 5
//                }
//                if loop == 0{
//                    return []
//                }
//                //玩法code
//                var carr = Array.init(repeating: "", count: selectDatas.count)
//                var narr = Array.init(repeating: "", count: selectDatas.count)
//                for i in 0...selectDatas.count - 1{
//                    carr[i] = selectDatas[i].code
//                    narr[i] = selectDatas[i].numName
//                }
//                var codes = [String]()
//                ZhuxuanLogic.combination(ia: carr, n: loop, results: &codes,format:",")
//                var numbers = [String]()
//                ZhuxuanLogic.combination(ia: narr, n: loop, results: &numbers,format:",")
//                let inputMoney = selectDatas[0].inputMoney
//                if codes.isEmpty{
//                    return []
//                }
//                if codes.count == numbers.count{
//                    for j in 0...codes.count-1{
//                        let order = PeilvOrder()
//                        order.a = inputMoney
//                        order.c = numbers[j]
//                        order.d = codes[j]
//                        order.i = specialLittlePlayCode
//                        order.oddName = selectDatas[0].numName
//                        orders.append(order)
//                    }
//                }
//                return orders
//            }
//        }else{
//            for result in selectDatas{
//                let order = PeilvOrder()
//                order.a = result.inputMoney
//                order.c = result.number
//                order.d = result.code
//                order.i = result.playCode
//                order.oddName = result.numName
//                orders.append(order)
//            }
//        }
//        return orders
//    }
//
//}
//
//extension LHCLogic : UITableViewDelegate,UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.shengxiaos.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "shenxiao") as? ShenxiaoCell
//        if cell == nil{
//            cell = ShenxiaoCell.init(style: .default, reuseIdentifier: "shenxiao")
//        }
//        let data = self.shengxiaos[indexPath.row]
//        cell?.setupData(shenxiao: data, cpCode: self.cpCode, cpVersion: self.cpVersion)
//        if self.slected_shenxiao_when_hx.contains(indexPath.row){
//            cell?.backgroundColor = UIColor.init(hex: 0x0184C15)
//        }else{
//            cell?.backgroundColor = UIColor.init(hex: 0x3B945C)
//        }
//        return cell!
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "shenxiao") as? ShenxiaoCell
//        if self.slected_shenxiao_when_hx.contains(indexPath.row){
//            self.slected_shenxiao_when_hx.remove(indexPath.row)
//            cell?.backgroundColor = UIColor.init(hex: 0x3B945C)
//        }else{
//            slected_shenxiao_when_hx.add(indexPath.row)
//            cell?.backgroundColor = UIColor.init(hex: 0x0184C15)
//        }
//        tableView.reloadData()
//    }
//
//    func getSelectedShenxiaos() -> String{
//        if self.shengxiaos.isEmpty{
//            return ""
//        }
//        var numbers = ""
//        if self.slected_shenxiao_when_hx.count > 0{
//            for index in 0...self.slected_shenxiao_when_hx.count - 1{
//                let selectRow = self.slected_shenxiao_when_hx[index] as! Int
//                let a:[String] = self.shengxiaos[selectRow].components(separatedBy: "|")
//                if a.count == 2{
//                    numbers.append(a[0])
//                    numbers.append(",")
//                }
//            }
//        }
//        if numbers.count > 0{
//            numbers = (numbers as NSString).substring(to: numbers.count - 1)
//        }
//        return numbers
//    }
//
//}
