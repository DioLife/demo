//
//  LHCLogic2.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/7/10.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

/**
 * 六合彩特殊逻辑处理类
 * 针对六合彩中，正特，连码，一肖，合肖，自选不中，连肖 等支持筛选的玩法
 */

protocol PlayButtonDelegate {
    func onButtonDelegate()
}

class LHCLogic2: NSObject {

    let redBo = ["1", "2", "7", "8", "12", "13", "18", "19", "23",
    "24", "29", "30", "34", "35", "40", "45", "46"];
    let blueBo = ["3", "4", "9", "10", "14", "15", "20", "25", "26",
    "31", "36", "37", "41", "42", "47", "48"];
    let greenBo = ["5", "6", "11", "16", "17", "21", "22", "27", "28", "32", "33",
    "38", "39", "43", "44", "49"];
    
    override init() {
        
    }
    
    enum peilvCellLayout {
        case GRIDVIEW
        case HONRIZAL
    }
        
    private var fixFirstNumCountWhenLHC = 0;//在六合彩特殊玩法中使用。代表选择号码时最前面几位号码是固定的不可修改的
    var firstCategoryIndex = 0;
    var secondCategoryIndex = 0;
    var playButtonDelegate:PlayButtonDelegate?;
    
    var playCode = "";//当前玩法
    var playName = "";//当前玩法对应的名称
    var parentCode = "";
    var hxBetOk = true;//是否选择合肖中
    private var singleLineLayout = false;//页面是否一行显示一项赔率项，如尾数，一肖就需要一行显示一个
    var isPlayBarShow = true;//玩法栏显示状态
    
    var firstBtn:UIButton!
    var secondBtn:UIButton!
    
    var summary_btns:UIView!;//合肖时的分栏tab layout
    var leftBtn:UIButton!;
    var rightBtn:UIButton!;
    private var isSelect = false
    
    var controller:UIViewController!
    
    var allDatas:[LHCSpecialData] = [];
    var dialog:LhcSpecialChooseDialog?;
    
    private func loadSpecialJson(){
        DispatchQueue.global().async {
            let path = Bundle.main.path(forResource: "special_lhc", ofType: "json")
            if let pathValue = path{
                let jsonData = NSData.init(contentsOfFile: pathValue)
                let str = String.init(data: jsonData! as Data, encoding: String.Encoding.utf8)
                let models:[LHCSpecialData] = JSONDeserializer<LHCSpecialData>.deserializeModelArrayFrom(json: str)! as! [LHCSpecialData]
                self.allDatas.removeAll()
                self.allDatas = self.allDatas + models
            }
        }
    }
    
    func setFixFirstNumCountWhenLHC(fixCount:Int){
        fixFirstNumCountWhenLHC = fixCount
    }
    
    func isSingleLineLayout() -> Bool{
        return singleLineLayout
    }
    
    @objc func onButtonClick(ui:UIButton){
        
        //先处理合肖分栏tab事件
        if ui.tag == 102 || ui.tag == 103{
            if ui.tag == 102{
                self.hxBetOk = true
                leftBtn.theme_backgroundColor = "Global.themeColor"
                leftBtn.setTitleColor(UIColor.white, for: .normal)
                rightBtn.setTitleColor(UIColor.black, for: .normal)
                rightBtn.backgroundColor = UIColor.clear
            }else{
                self.hxBetOk = false
                leftBtn.backgroundColor = UIColor.clear
                leftBtn.setTitleColor(UIColor.black, for: .normal)
                rightBtn.setTitleColor(UIColor.white, for: .normal)
                rightBtn.theme_backgroundColor = "Global.themeColor"
            }
            //刷新列表
            if let delegate = self.playButtonDelegate{
                delegate.onButtonDelegate()
            }
            return
        }
        
        if let dataOfCurrentPlay = getDataByPlayCode(playCode: playCode){
            
            if (isSelect == false) {
                isSelect = true
                
                showDialog(controller: self.controller, buttonID: ui.tag, dataOfCurrentPlay: dataOfCurrentPlay)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isSelect = false
                }
            }
        }
    }
    
    private func showDialog(controller:UIViewController,buttonID:Int,dataOfCurrentPlay:LHCSpecialData){
        
        var selectIndex = 0
        var list:[LHCSpecialData]?
        if buttonID == 100{
            list = dataOfCurrentPlay.data
            selectIndex = firstCategoryIndex
        }else{
            list = dataOfCurrentPlay.data![firstCategoryIndex].data
            selectIndex = secondCategoryIndex
        }
        guard let dataSources = list else{return}
        let selectedView = LhcSpecialChooseDialog(dataSource: dataSources, viewTitle: "类型选择")
        selectedView.selectedIndex = selectIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            if buttonID == 100{
                self?.firstCategoryIndex = index
                self?.secondCategoryIndex = 0;
            }else if buttonID == 101{
                self?.secondCategoryIndex = index
            }
            self?.hxBetOk = true
            self?.updateButtonsTitle()//选择玩法列表项后需要更新按钮标题
            //刷新列表
            if let delegate = self?.playButtonDelegate{
                delegate.onButtonDelegate()
            }
        }
        controller.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.3, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
            
        }
    }
    
    public func initializeIndexTitle(){
        firstCategoryIndex = 0;
        secondCategoryIndex = 0;
        singleLineLayout = false;
        hxBetOk = true;
        fixFirstNumCountWhenLHC = 0;
    }
    
    //更新按钮的标题
    private func updateButtonsTitle(){
        if let data = getDataByPlayCode(playCode: playCode){
            let button1Data = data.data![firstCategoryIndex];
            firstBtn.setTitle(button1Data.name, for: .normal)
            if self.secondBtn != nil{
                if let s = button1Data.data{
                    let second = !s.isEmpty ? s[secondCategoryIndex].name : ""
                    secondBtn.setTitle(second, for: .normal)
                }
            }
            if (playCode == "hx") {
                let xiao = button1Data.name;
                leftBtn.setTitle(String.init(format: "%@中", xiao), for: .normal)
                rightBtn.setTitle(String.init(format: "%@不中", xiao), for: .normal)
            }
        }
    }
    
    private func getDataByPlayCode(playCode:String) -> LHCSpecialData?{
        for data in self.allDatas{
            if data.code == playCode{
                return data
            }
        }
        return nil;
    }
    
    func clearAfterBetSuccess(){
        initializeIndexTitle()
    }
    
    func find_bet_unpass_msg(selectDatas:[PeilvWebResult]) -> String{
        if selectDatas.isEmpty{
            return "没有选择号码"
        }
        
        var specialLittlePlayCode = ""
        if let dataByPlayCode = getDataByPlayCode(playCode: playCode){
            let data = dataByPlayCode.data![firstCategoryIndex]
            specialLittlePlayCode = data.code
        }
        //连码，自选不中，连肖，合肖情况下的注单计算是按玩法的组合计算
        if playCode == "lm" || playCode == "zxbz" || playCode == "lx" || playCode == "hx"{
            let count = selectDatas.count
            if playCode == "lm"{
                if specialLittlePlayCode == "sze" || specialLittlePlayCode == "sqz"{
                    if count < 3 {
                        return "您至少需要选择3个号码"
                    }
                }else if specialLittlePlayCode == "eqz" || specialLittlePlayCode == "ezt" || specialLittlePlayCode == "tc"{
                    if count < 2{
                        return "您至少需要选择2个号码"
                    }
                }
            }else if playCode == "zxbz"{
                if specialLittlePlayCode == "wbz"{
                    if count != 5 {
                        return "您需要选择5个号码"
                    }
                }else if specialLittlePlayCode == "lbz"{
                    if count != 6 {
                        return "您需要选择6个号码"
                    }
                }else if specialLittlePlayCode == "qbz"{
                    if count != 7 {
                        return "您需要选择7个号码"
                    }
                }else if specialLittlePlayCode == "bbz"{
                    if count != 8 {
                        return "您需要选择8个号码"
                    }
                }else if specialLittlePlayCode == "jbz"{
                    if count != 9 {
                        return "您需要选择9个号码"
                    }
                }else if specialLittlePlayCode == "sbz"{
                    if count != 10 {
                        return "您需要选择10个号码"
                    }
                }else if specialLittlePlayCode == "sybz"{
                    if count != 11 {
                        return "您需要选择11个号码"
                    }
                }else if specialLittlePlayCode == "sebz"{
                    if count != 12 {
                        return "您需要选择12个号码"
                    }
                }

            }else if playCode == "hx"{
                if isEmptyString(str: specialLittlePlayCode){
                    return "请选择生肖号码"
                }
                
                if count > 0{
                    if specialLittlePlayCode == "hxy"{
                        if count != 1 {
                            return "请选择1个生肖"
                        }
                    }else if specialLittlePlayCode == "hxe"{
                        if count != 2 {
                            return "请选择2个生肖"
                        }
                    }else if specialLittlePlayCode == "hxs"{
                        if count != 3 {
                            return "请选择3个生肖"
                        }
                    }else if specialLittlePlayCode == "hxsi"{
                        if count != 4 {
                            return "请选择4个生肖"
                        }
                    }else if specialLittlePlayCode == "hxw"{
                        if count != 5 {
                            return "请选择5个生肖"
                        }
                    }else if specialLittlePlayCode == "hxl"{
                        if count != 6 {
                            return "请选择6个生肖"
                        }
                    }else if specialLittlePlayCode == "hxq"{
                        if count != 7 {
                            return "请选择7个生肖"
                        }
                    }else if specialLittlePlayCode == "hxb"{
                        if count != 8 {
                            return "请选择8个生肖"
                        }
                    }else if specialLittlePlayCode == "hxj"{
                        if count != 9 {
                            return "请选择9个生肖"
                        }
                    }else if specialLittlePlayCode == "hxsh"{
                        if count != 10 {
                            return "请选择10个生肖"
                        }
                    }else if specialLittlePlayCode == "hxsy"{
                        if count != 11 {
                            return "请选择11个生肖"
                        }
                    }
                }else{
                    return "需要选择至少一个生肖"
                }
            }else if playCode == "lx"{
                if specialLittlePlayCode == "lxex"{
                    if count < 2 {
                        return "至少需要选择2个生肖"
                    }
                }else if specialLittlePlayCode == "lxsx"{
                    if count < 3{
                        return "至少需要选择3个生肖"
                    }
                }else if specialLittlePlayCode == "lxsix"{
                    if count < 4{
                        return "至少需要选择4个生肖"
                    }
                }else if specialLittlePlayCode == "lxwx"{
                    if count < 5{
                        return "至少需要选择5个生肖"
                    }
                }
            }
        }
        return ""
    }
    
    func calcOrder(selectDatas:[PeilvWebResult]) -> [PeilvOrder]{
        if selectDatas.isEmpty{
            return []
        }
        let error_msg = find_bet_unpass_msg(selectDatas: selectDatas)
        if !isEmptyString(str: error_msg){
            print("error msg = ",error_msg)
            return []
        }
        ////连码，自选不中，连肖，合肖情况下的注单计算是按玩法的组合计算
        if playCode == "lm"{
            return calcLmOrder(selectDatas:selectDatas)
        }else if playCode == "yxa" || playCode == "wsa"{
            return calcNormalOrder(selectDatas:selectDatas)
        }else if playCode == "hx"{
            return calcHxOrder(selectDatas:selectDatas)
        }else if playCode == "zxbz"{
            return calcZxbzOrder(selectDatas:selectDatas)
        }else if playCode == "lx"{
            return calcLxOrder(selectDatas:selectDatas)
        }else{
            return calcNormalOrder(selectDatas:selectDatas)
        }
    }
    
    
    //计算连肖注数
    private func calcLxOrder(selectDatas:[PeilvWebResult]) -> [PeilvOrder]{
        
        if let dataByPlayCode = getDataByPlayCode(playCode: playCode){
            let first = dataByPlayCode.data![firstCategoryIndex]
            let second = first.data![secondCategoryIndex]
            //先处理单选/复式，拖胆
            if second.code == "dxfs"{
                var loop = 3
                if first.code == "lxex"{
                    loop = 2
                }else if first.code == "lxsx"{
                    loop = 3
                }else if first.code == "lxsix"{
                    loop = 4
                }else if first.code == "lxwx"{
                    loop = 5
                }
                //玩法code
                var carr = Array.init(repeating: "", count: selectDatas.count)
                var narr = Array.init(repeating: "", count: selectDatas.count)
                for i in 0...selectDatas.count - 1{
                    carr[i] = selectDatas[i].code
                    narr[i] = selectDatas[i].numName
                }
                var codes = [String]()
                ZhuxuanLogic.combination(ia: carr, n: loop, results: &codes,format:",")
                var numbers = [String]()
                ZhuxuanLogic.combination(ia: narr, n: loop, results: &numbers,format:",")
                let inputMoney = selectDatas[0].inputMoney
                if codes.isEmpty{
                    return []
                }
                var orders = [PeilvOrder]()
                if codes.count == numbers.count{
                    for j in 0...codes.count-1{
                        let order = PeilvOrder()
                        order.a = inputMoney
                        order.c = numbers[j]
                        order.d = codes[j]
                        order.i = first.code
                        order.oddName = first.name
                        orders.append(order)
                    }
                }
                return orders
            }else if second.code == "td"{
                var orders = [PeilvOrder]()
                if selectDatas.count < fixFirstNumCountWhenLHC{
                    return []
                }
                var numbers = [String]()
                var codesOfNumber = [String]()
                var suffix = ""
                var suffixCode = ""
                for i in 0...selectDatas.count-1{
                    let result = selectDatas[i]
                    if i >= fixFirstNumCountWhenLHC{
                        let n = suffix + result.numName
                        let code = suffixCode + result.code
                        numbers.append(n)
                        codesOfNumber.append(code)
                    }else{
                        suffix.append(result.numName)
                        suffix.append(",")
                        suffixCode.append(result.code)
                        suffixCode.append(",")
                    }
                }
                let inputMoney = selectDatas[0].inputMoney
                if codesOfNumber.count == numbers.count{
                    for j in 0...numbers.count-1{
                        let order = PeilvOrder()
                        order.a = inputMoney
                        order.c = numbers[j]
                        order.d = codesOfNumber[j]
                        order.i = first.code
                        order.oddName = first.name
                        orders.append(order)
                    }
                }
                return orders
            }
        }
        return []
    }

    //计算自选不中注数,所有选中的号码合起来构成一注
    private func calcZxbzOrder(selectDatas:[PeilvWebResult]) -> [PeilvOrder]{
        var numbers = ""
        var i = ""
        var a: Float = 0
        var d = ""
        
        var numName = "";
        if let data = getDataByPlayCode(playCode: playCode){
            let d = data.data![firstCategoryIndex]
            numName = d.name
        }
        
        for result in selectDatas{
            numbers = numbers + result.numName + ","
            i = result.playCode
            a = result.inputMoney
            d = d + result.code + ","
        }
        if !isEmptyString(str: numbers) && numbers.hasSuffix(","){
            numbers = (numbers as NSString).substring(to: numbers.count-1)
        }
        if !isEmptyString(str: d) && d.hasSuffix(","){
            d = (d as NSString).substring(to: d.count-1)
        }
        var orders = [PeilvOrder]()
        let order = PeilvOrder()
        order.a = a
        order.c = numbers
        order.d = d
        order.i = i
        order.oddName = numName
        orders.append(order)
        return orders
    }
    
    //计算合肖注数,所有选中的生肖合起来构成一注
    private func calcHxOrder(selectDatas:[PeilvWebResult]) -> [PeilvOrder]{
        
        var numbers = ""
        var i = ""
        var a:Float = 0
        var d = ""
        var numName = "";
        if let data = getDataByPlayCode(playCode: playCode){
            let d = data.data![firstCategoryIndex]
            numName = d.name
        }
        for result in selectDatas{
            numbers = numbers + result.numName + ","
            i = result.playCode
            a = result.inputMoney
            d = result.code
        }
        if !isEmptyString(str: numbers) && numbers.hasSuffix(","){
            numbers = (numbers as NSString).substring(to: numbers.count-1)
        }
        var orders = [PeilvOrder]()
        let order = PeilvOrder()
        order.a = a
        order.c = numbers
        order.d = d
        order.i = i
        order.oddName = numName
        orders.append(order)
        return orders
    }
    
    private func calcNormalOrder(selectDatas:[PeilvWebResult]) -> [PeilvOrder]{
        var orders = [PeilvOrder]()
        for result in selectDatas{
            let order = PeilvOrder()
            order.a = result.inputMoney
            order.c = result.numName
            order.d = result.code
            order.i = result.playCode
            order.oddName = result.itemName
            orders.append(order)
        }
        return orders
    }
    
    private func calcLmOrder(selectDatas:[PeilvWebResult])->[PeilvOrder]{
        if let dataByPlayCode = getDataByPlayCode(playCode: playCode){
            let first = dataByPlayCode.data![firstCategoryIndex]
            let second = first.data![secondCategoryIndex]
            //先处理单选/复式，拖胆
            if second.code == "dxfs"{
                var loop = 3
                if first.code == "eqz" || first.code == "ezt" || first.code == "tc"{
                    loop = 2
                }
                //玩法code
                var carr = Array.init(repeating: "", count: selectDatas.count)
                var narr = Array.init(repeating: "", count: selectDatas.count)
                for i in 0...selectDatas.count - 1{
                    carr[i] = selectDatas[i].code
                    narr[i] = selectDatas[i].numName
                }
                var codes = [String]()
                ZhuxuanLogic.combination(ia: carr, n: loop, results: &codes,format:",")
                var numbers = [String]()
                ZhuxuanLogic.combination(ia: narr, n: loop, results: &numbers,format:",")
                let inputMoney = selectDatas[0].inputMoney
                if codes.isEmpty{
                    return []
                }
                var orders = [PeilvOrder]()
                if codes.count == numbers.count{
                    for j in 0...codes.count-1{
                        let order = PeilvOrder()
                        order.a = inputMoney
                        order.c = numbers[j]
                        order.d = codes[j]
                        order.i = first.code
                        order.oddName = first.name
                        orders.append(order)
                    }
                }
                return orders
            }else if second.code == "td"{
                var orders = [PeilvOrder]()
                if selectDatas.count < fixFirstNumCountWhenLHC{
                    return []
                }
                var numbers = [String]()
                var codesOfNumber = [String]()
                var suffix = ""
                var suffixCode = ""
                for i in 0...selectDatas.count-1{
                    let result = selectDatas[i]
                    if i >= fixFirstNumCountWhenLHC{
                        let n = suffix + result.numName
                        let code = suffixCode + result.code
                        numbers.append(n)
                        codesOfNumber.append(code)
                    }else{
                        suffix.append(result.numName)
                        suffix.append(",")
                        suffixCode.append(result.numName)
                        suffixCode.append(",")
                    }
                }
                let inputMoney = selectDatas[0].inputMoney
                if codesOfNumber.count == numbers.count{
                    for j in 0...numbers.count-1{
                        let order = PeilvOrder()
                        order.a = inputMoney
                        order.c = numbers[j]
                        order.d = codesOfNumber[j]
                        order.i = first.code
                        order.oddName = first.name
                        orders.append(order)
                    }
                }
                return orders
            }
            
            //-------------------------------------------------------------------------
            if second.code == "sxdp" || second.code == "wsdp" || second.code == "hhdp"{
                ////生肖，尾数，混合对碰时只能选择两个号码
                if selectDatas.count != 2 && !selectDatas.isEmpty{
                    print("生肖，尾数，混合对碰时只能选择两个号码")
                    return []
                }
                let firstData = selectDatas[0].helpNumber.components(separatedBy: ",")
                let secondData = selectDatas[1].helpNumber.components(separatedBy: ",")
                let firstCodes = selectDatas[0].codesOfHelpNumbers
                let secondCodes = selectDatas[1].codesOfHelpNumbers
                
                var numbers = [String]()
                var codes = [String]()
                for i in 0...firstData.count-1{
                    for j in 0...secondData.count-1{
                        numbers.append(firstData[i]+","+secondData[j])
                        codes.append(firstCodes[i]+","+secondCodes[j])
                    }
                }
                let inputMoney = selectDatas[0].inputMoney
                var orders = [PeilvOrder]()
                if codes.count == numbers.count{
                    for j in 0...numbers.count-1{
                        let order = PeilvOrder()
                        order.a = inputMoney
                        order.c = numbers[j]
                        order.d = codes[j]
                        order.i = first.code
                        order.oddName = first.name
                        orders.append(order)
                    }
                }
                return orders
            }
        }
        return []
    }
    
    //当选择了六合彩 连码等特殊玩法下的过滤项，重新选择数据源
    /**
     * 选择特殊下拉玩法时，重新准备列表展现的数据
     * @param play 当前玩法数据
     */
    public func getListWhenSpecialClick(play:BcLotteryPlay) ->Dictionary<String,AnyObject>?{
        
        if play.children.isEmpty{
            return nil
        }
        switch playCode {
        case "lm":
            return buildLmPlayDatas(play:play)
        case "hx":
            singleLineLayout = true
            if hxBetOk{
                leftBtn.theme_backgroundColor = "Global.themeColor"
                leftBtn.setTitleColor(UIColor.white, for: .normal)
                rightBtn.backgroundColor = UIColor.clear
                rightBtn.setTitleColor(UIColor.black, for: .normal)
            }else{
                leftBtn.backgroundColor = UIColor.clear
                leftBtn.setTitleColor(UIColor.black, for: .normal)
                rightBtn.setTitleColor(UIColor.white, for: .normal)
                rightBtn.theme_backgroundColor = "Global.themeColor"
            }
            return buildHxPlayDatas(play:play,betOk: hxBetOk)
        case "zxbz":
            return buildZxbzPlayDatas(play:play)
        case "lx":
            singleLineLayout = true
            return buildLxPlayDatas(play:play)
        case "yxa":
            singleLineLayout = true
            return buildYxPlayDatas(play:play)
        case "wsa":
            singleLineLayout = true
            return buildWeishuPlayDatas(play:play)
        case "txa":
            singleLineLayout = true
            return buildTexiaoPlayDatas(play:play)
        default:
            return buildNormPlayDatas(play:play)
        }
    }
    
    //构造普通的下注号码数据源(是直接从原有的玩法数据中根据选择的firstCategoryIndex获取的)
    private func buildNormPlayDatas(play:BcLotteryPlay) -> Dictionary<String,AnyObject>{
        let item = play.children[firstCategoryIndex]
        var list = [BcLotteryPlay]()
        list.append(item)
        var map:Dictionary<String,AnyObject> = [:]
        map["datas"] = list as AnyObject
        return map
    }
    
    /**
     * 构造特肖下注号码数据源
     * @param play 选择的特肖原始玩法及赔率数据
     * @return map:
     * "datas":重新构造的下注赔率数据；
     * "fixFirstCount"：选择号码时最前面固定的数据个数；
     * "maxOfOneZhu":最大选择号码数。无此项说明无限
     */
    private func buildTexiaoPlayDatas(play:BcLotteryPlay) -> Dictionary<String,AnyObject>{
        let selectPlay = getZhenteData(play:play)
        var list = [BcLotteryPlay]()
        list.append(selectPlay)
        var map:Dictionary<String,AnyObject> = [:]
        map["datas"] = list as AnyObject
        return map
    }
    
    //构造正特的赔率数据列表
    private func getZhenteData(play:BcLotteryPlay) -> BcLotteryPlay{
        let p = BcLotteryPlay()
        //选中的那个玩法对应的玩法数据
        let selectedPlay = play.children[firstCategoryIndex]
        p.name = selectedPlay.name
        p.code = selectedPlay.code
        var peilvs = [PeilvWebResult]()
        for i in 0...selectedPlay.peilvs.count-1{
            let sx = selectedPlay.peilvs[i]
            let odd = PeilvWebResult()
            odd.maxOdds = sx.maxOdds
            odd.minOdds = sx.minOdds
            let sxs = getNumberStrFromShenXiaoName(sx: sx.numName)
            odd.helpNumber = sxs
            odd.numName = sx.numName
            odd.playCode = p.code
            odd.code = sx.code
            peilvs.append(odd)
        }
        p.peilvs = peilvs
        return p;
    }
    
    /**
     * 构造尾数下注号码数据源
     * @param play 选择的尾数原始玩法及赔率数据
     * @return map:
     * "datas":重新构造的下注赔率数据；
     * "fixFirstCount"：选择号码时最前面固定的数据个数；
     * "singleline" 是否一行一个赔率项
     * "maxOfOneZhu":最大选择号码数。无此项说明无限
     */
    private func buildWeishuPlayDatas(play:BcLotteryPlay) -> Dictionary<String,AnyObject>{
        let selectPlay = getWeishuData(play:play)
        var list = [BcLotteryPlay]()
        list.append(selectPlay)
        var map:Dictionary<String,AnyObject> = [:]
        map["datas"] = list as AnyObject
        map["fixFirstCount"] = 0 as AnyObject
        return map
    }
    
    //构造尾数的赔率数据列表
    private func getWeishuData(play:BcLotteryPlay) -> BcLotteryPlay{
        let p = BcLotteryPlay()
        //选中的那个玩法对应的玩法数据
        let selectedPlay = play.children[firstCategoryIndex]
        p.name = selectedPlay.name
        p.code = selectedPlay.code
        var peilvs = [PeilvWebResult]()
        for i in 0...selectedPlay.peilvs.count-1{
            let sx = selectedPlay.peilvs[i]
            let odd = PeilvWebResult()
            odd.maxOdds = sx.maxOdds
            odd.minOdds = sx.minOdds
            let weishus = getWeishuFromArrays(index: i)
            var numbers = ""
            if !isEmptyString(str: weishus) && weishus.contains("|"){
                numbers = weishus.components(separatedBy: "|")[1]
            }
            odd.helpNumber = numbers
            odd.numName = sx.numName
            odd.playCode = p.code
            odd.code = sx.code
            peilvs.append(odd)
        }
        p.peilvs = peilvs
        return p;
    }
    
    /**
     * 构造一肖下注号码数据源
     * @param play 选择的一肖原始玩法及赔率数据
     * @return map:
     * "datas":重新构造的下注赔率数据；
     * "fixFirstCount"：选择号码时最前面固定的数据个数；
     * "maxOfOneZhu":最大选择号码数。无此项说明无限
     */
    private func buildYxPlayDatas(play:BcLotteryPlay) -> Dictionary<String,AnyObject>{
        
        let selectPlay = getYixiaoData(play:play)
        var list = [BcLotteryPlay]()
        list.append(selectPlay)
        var map:Dictionary<String,AnyObject> = [:]
        map["datas"] = list as AnyObject
        map["fixFirstCount"] = 0 as AnyObject
        return map
        
    }
    
    //构造一肖的赔率数据列表
    private func getYixiaoData(play:BcLotteryPlay) -> BcLotteryPlay{
        let p = BcLotteryPlay()
        //选中的那个玩法对应的玩法数据
        let selectedPlay = play.children[firstCategoryIndex]
        p.name = selectedPlay.name
        p.code = selectedPlay.code
        var peilvs = [PeilvWebResult]()
        for sx in selectedPlay.peilvs{
            let odd = PeilvWebResult()
            odd.maxOdds = sx.maxOdds
            odd.minOdds = sx.minOdds
            let help = getNumberStrFromShenXiaoName(sx: sx.numName)
            odd.helpNumber = help
            odd.numName = sx.numName
            odd.playCode = p.code
            odd.code = sx.code
            peilvs.append(odd)
        }
        p.peilvs = peilvs
        return p;
    }
    
    /**
     * 构造连肖下注号码数据源
     * @param play 选择的连肖原始玩法及赔率数据
     * @return map:
     * "datas":重新构造的下注赔率数据；
     * "fixFirstCount"：选择号码时最前面固定的数据个数；
     * "maxOfOneZhu":最大选择号码数。无此项说明无限
     */
    private func buildLxPlayDatas(play:BcLotteryPlay) -> Dictionary<String,AnyObject>?{
        
        if let data = getDataByPlayCode(playCode: playCode){
            let firstData = data.data![firstCategoryIndex]
            let selectPlay = getLXShenxiaoData(play:play)
//            let item = play.children[firstCategoryIndex]
            var list = [BcLotteryPlay]()
            list.append(selectPlay)
            var map:Dictionary<String,AnyObject> = [:]
            map["datas"] = list as AnyObject
            
            if firstData.code == "lxex"{
                map["fixFirstCount"] = 1 as AnyObject
            }else if firstData.code == "lxsx"{
                map["fixFirstCount"] = 2 as AnyObject
            }else if firstData.code == "lxsix"{
                map["fixFirstCount"] = 3 as AnyObject
            }else if firstData.code == "lxwx"{
                map["fixFirstCount"] = 4 as AnyObject
            }
            return map
        }
        return nil
    }
    
    /**
     * 构造自选不中下注号码数据源
     * @param play 选择的连码原始玩法及赔率数据
     * @return map:
     * "datas":重新构造的下注赔率数据；
     * "fixFirstCount"：选择号码时最前面固定的数据个数；
     * "maxOfOneZhu":最大选择号码数。无此项说明无限
     */
    private func buildZxbzPlayDatas(play:BcLotteryPlay) -> Dictionary<String,AnyObject>?{
        
        if let _ = getDataByPlayCode(playCode: playCode){
//            let firstData = data.data![firstCategoryIndex]
            let item = play.children[firstCategoryIndex]
            var list = [BcLotteryPlay]()
            list.append(item)
            var map:Dictionary<String,AnyObject> = [:]
            map["datas"] = list as AnyObject
            map["fixFirstCount"] = 0 as AnyObject
            ////最大选择的号码即是自选不中中的不中数，即是第一个按钮的索引数加5(从五不中开始)
            map["numOfOneZhu"] = (firstCategoryIndex+5) as AnyObject
            return map
        }
        return nil
    }
    
    
    /**
     * 构造合肖下注号码数据源;说明:(合肖玩法时是将所有生肖的中与不中赔率项整理出来)
     * @param play 选择的连码原始玩法及赔率数据
     * @param betOk 合肖中或者不中
     * @return map:
     * "datas":重新构造的下注赔率数据；
     * "fixFirstCount"：选择号码时最前面固定的数据个数；
     * "maxOfOneZhu":最大选择号码数。无此项说明无限
     */
    private func buildHxPlayDatas(play:BcLotteryPlay,betOk:Bool) -> Dictionary<String,AnyObject>?{
        if let data = getDataByPlayCode(playCode: playCode){
            let firstData = data.data![firstCategoryIndex]
//            let secondData = firstData.data![secondCategoryIndex]
            ////合肖1-11列表
            let children = play.children
            var hxPeilv:PeilvWebResult!
            if !children.isEmpty{
                for hxs in children{
                    if hxs.code == firstData.code{
                        var peilvs = hxs.peilvs
                        if peilvs.count == 2{
                            if betOk{
                                hxPeilv = peilvs[0]
                            }else{
                                hxPeilv = peilvs[1]
                            }
                        }
                        break
                    }
                }
            }
            if hxPeilv == nil{
                return nil
            }
            let selectPlay = getHxShenxiaoData(hxPeilv: hxPeilv, selectedData: firstData)
            var list = [BcLotteryPlay]()
            list.append(selectPlay)
            
            var map:Dictionary<String,AnyObject> = [:]
            map["datas"] = list as AnyObject
            map["fixFirstCount"] = 0 as AnyObject
            ////最大选择的号码即是合肖几肖数，即是第一个按钮的索引数加1
            map["numOfOneZhu"] = (firstCategoryIndex + 1) as AnyObject
            return map
        }
        return nil
    }
    
    /**
     * 构造连码下注号码数据源
     * @param play 选择的连码原始玩法及赔率数据
     * @return map:
     * "datas":重新构造的下注赔率数据；
     * "fixFirstCount"：选择号码时最前面固定的数据个数；
     * "maxOfOneZhu":最大选择号码数。无此项说明无限
     */
    private func buildLmPlayDatas(play:BcLotteryPlay) -> Dictionary<String,AnyObject>?{
        if let data = getDataByPlayCode(playCode: playCode){
            let firstData = data.data![firstCategoryIndex]
            let secondData = firstData.data![secondCategoryIndex]
            //生肖对碰
            if secondData.code == "sxdp"{
                singleLineLayout = true
                //获取生肖的赔率数据列表
                let selectedPlay = getShenxiaoData(play: play, firstData: firstData, needCodes: true)
                var list = [BcLotteryPlay]()
                list.append(selectedPlay)
                
                var map:Dictionary<String,AnyObject> = [:]
                map["datas"] = list as AnyObject
                map["fixFirstCount"] = 2 as AnyObject
                map["numOfOneZhu"] = 2 as AnyObject
                return map
            //尾数对碰
            }else if(secondData.code == "wsdp"){
                singleLineLayout = true;
                //获取尾数的赔率数据列表
                let selectedPlay = getWeishuData(play: play, firstData: firstData, needCodes: true)
                var list = [BcLotteryPlay]()
                list.append(selectedPlay)
                
                var map:Dictionary<String,AnyObject> = [:]
                map["datas"] = list as AnyObject
                map["fixFirstCount"] = 2 as AnyObject
                map["numOfOneZhu"] = 2 as AnyObject
                return map
            //混合对碰
            }else if(secondData.code == "hhdp"){
                singleLineLayout = true;
                //选中的那个玩法对应的玩法数据
                let selectedPlay = getShenxiaoData(play: play, firstData: firstData, needCodes: true)
                let selectedPlay2 = getWeishuData(play: play, firstData: firstData, needCodes: true)
                selectedPlay.peilvs += selectedPlay2.peilvs
                
                var list = [BcLotteryPlay]()
                list.append(selectedPlay)
                var map:Dictionary<String,AnyObject> = [:]
                map["datas"] = list as AnyObject
                map["fixFirstCount"] = 2 as AnyObject
                return map
            //拖胆
            }else if secondData.code == "td"{
                singleLineLayout = false
                let item = play.children[firstCategoryIndex]
                let p = BcLotteryPlay()
                p.name = firstData.name
                p.code = firstData.code
                //选中的那个玩法对应的玩法数据
                var peilvs = [PeilvWebResult]()
                for sx in item.peilvs{
                    let odd = PeilvWebResult()
                    odd.maxOdds = sx.maxOdds
                    odd.minOdds = sx.minOdds
                    odd.currentOdds = sx.currentOdds
                    odd.secondMinodds = sx.currentSecondOdds
                    odd.helpNumber = sx.helpNumber
                    odd.numName = sx.numName
                    odd.code = sx.code
                    peilvs.append(odd)
                }
                p.peilvs = peilvs
                
                var list = [BcLotteryPlay]()
                list.append(p)
                var map:Dictionary<String,AnyObject> = [:]
                map["datas"] = list as AnyObject
                if firstData.code == "sqz" || firstData.code == "sze"{
                    map["fixFirstCount"] = 2 as AnyObject
                }else{
                    map["fixFirstCount"] = 1 as AnyObject
                }
                return map
            //其他
            }else{
                singleLineLayout = false
                let item = play.children[firstCategoryIndex]
                let p = BcLotteryPlay()
                p.name = firstData.name
                p.code = firstData.code
                //选中的那个玩法对应的玩法数据
                var peilvs = [PeilvWebResult]()
                for sx in item.peilvs{
                    let odd = PeilvWebResult()
                    odd.maxOdds = sx.maxOdds
                    odd.minOdds = sx.minOdds
                    odd.currentOdds = sx.currentOdds
                    odd.secondMinodds = sx.currentSecondOdds
                    odd.helpNumber = sx.helpNumber
                    odd.numName = sx.numName
                    odd.code = sx.code
                    peilvs.append(odd)
                }
                p.peilvs = peilvs
                var list = [BcLotteryPlay]()
                list.append(p)
                var map:Dictionary<String,AnyObject> = [:]
                map["datas"] = list as AnyObject
                map["fixFirstCount"] = 0 as AnyObject
                return map
            }
        }
        return nil
    }
    
    //构造连肖中的生肖的赔率数据列表
    private func getLXShenxiaoData(play:BcLotteryPlay) -> BcLotteryPlay{
        let p = BcLotteryPlay()
        //选中的那个玩法对应的玩法数据
        let selectedPlay = play.children[firstCategoryIndex]
        p.name = selectedPlay.name
        p.code = selectedPlay.code
        var peilvs = [PeilvWebResult]()
        for sx in selectedPlay.peilvs{
            let odd = PeilvWebResult()
            odd.maxOdds = sx.maxOdds
            odd.minOdds = sx.minOdds
            let help = getNumberStrFromShenXiaoName(sx: sx.numName)
            odd.helpNumber = help
            odd.numName = sx.numName
            odd.playCode = p.code
            odd.code = sx.code
            peilvs.append(odd)
        }
        p.peilvs = peilvs
        return p;
    }
    
    //构造合肖的生肖赔率数据列表
    private func getHxShenxiaoData(hxPeilv:PeilvWebResult,selectedData:LHCSpecialData) -> BcLotteryPlay{
        let p = BcLotteryPlay()
        p.name = selectedData.name
        p.code = selectedData.code
        let sxs = getNumbersFromShengXiao()
        //选中的那个玩法对应的玩法数据
        var peilvs = [PeilvWebResult]()
        for sx in sxs{
            let odd = PeilvWebResult()
            odd.maxOdds = hxPeilv.maxOdds
            odd.minOdds = hxPeilv.minOdds
            let nums = sx.components(separatedBy: "|")
            let helpNumbers = nums[1]
            odd.helpNumber = helpNumbers
            odd.numName = nums[0]
            odd.playCode = p.code
            odd.code = hxPeilv.code
            peilvs.append(odd)
        }
        p.peilvs = peilvs
        return p;
    }
    
    //构造生肖的赔率数据列表
    private func getShenxiaoData(play:BcLotteryPlay,firstData:LHCSpecialData,needCodes:Bool) -> BcLotteryPlay{
        let sxs = getNumbersFromShengXiao()
        let p = BcLotteryPlay()
        p.name = firstData.name
        p.code = firstData.code
        //选中的那个玩法对应的玩法数据
        let selectedPlay = play.children[firstCategoryIndex]
        var peilvs = [PeilvWebResult]()
        for sx in sxs{
            let odd = PeilvWebResult()
            odd.maxOdds = selectedPlay.peilvs[0].maxOdds
            odd.minOdds = selectedPlay.peilvs[0].minOdds
            let helpNumbers = sx.components(separatedBy: "|")[1]
            odd.helpNumber = helpNumbers
            if needCodes{
                odd.codesOfHelpNumbers = getCodesFromHelpNumbers(numbers: helpNumbers, selectedPlay: selectedPlay)
            }
            odd.numName = sx.components(separatedBy: "|")[0]
            odd.playCode = p.code
            peilvs.append(odd)
        }
        p.peilvs = peilvs
        return p;
    }
    
    //构造尾数的赔率数据列表
    private func getWeishuData(play:BcLotteryPlay,firstData:LHCSpecialData,needCodes:Bool) -> BcLotteryPlay{
        let sxs = getWeishuArrays()
        let p = BcLotteryPlay()
        p.name = firstData.name
        p.code = firstData.code
        //选中的那个玩法对应的玩法数据
        let selectedPlay = play.children[firstCategoryIndex]
        var peilvs = [PeilvWebResult]()
        for sx in sxs{
            let odd = PeilvWebResult()
            odd.checkbox = true
            odd.code = firstData.code
            odd.maxOdds = selectedPlay.peilvs[0].maxOdds
            odd.minOdds = selectedPlay.peilvs[0].minOdds
            let helpNumbers = sx.components(separatedBy: "|")[1]
            odd.helpNumber = helpNumbers
            if needCodes{
                odd.codesOfHelpNumbers = getCodesFromHelpNumbers(numbers: helpNumbers, selectedPlay: selectedPlay)
            }
            odd.numName = sx.components(separatedBy: "|")[0]
            peilvs.append(odd)
        }
        p.peilvs = peilvs
        return p;
    }
    
    //从选择的赔率项中遍历获取到所有子辅助号码的对应赔率code
    private func getCodesFromHelpNumbers(numbers:String,selectedPlay:BcLotteryPlay) -> [String]{
        if numbers.contains(","){
            let numArray = numbers.components(separatedBy: ",")
            var codeArray = [String].init(repeating: "", count: numArray.count)
            for i in 0...numArray.count-1{
                let n = numArray[i]
                if !selectedPlay.peilvs.isEmpty{
                    for peilv in selectedPlay.peilvs{
                        if peilv.numName == n{
                            codeArray[i] = peilv.code
                            break;
                        }
                    }
                }
            }
            return codeArray
        }
        return []
    }
    
    public func initAllDatas(){
        loadSpecialJson()
    }
    
    
    //辅助列表头
    public func createHeaderView(controller:UIViewController,playCode:String) -> UIView?{
        
        self.controller = controller
        self.playCode = playCode
        
        if playCode == "lm" || playCode == "lx" {
            let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth*0.67, height: 44))
            header.backgroundColor = UIColor.init(hex: 0xf0f0f0)
            
            //第一个按钮
            firstBtn = UIButton.init(frame: CGRect.init(x: header.bounds.origin.x+20, y: header.bounds.origin.y+5, width: header.bounds.width/2-20, height: header.bounds.height - 10))
            firstBtn.setTitleColor(UIColor.black, for: .normal)
            firstBtn.backgroundColor = UIColor.clear
            firstBtn.layer.borderWidth = 1
            firstBtn.layer.borderColor = UIColor.black.cgColor
            firstBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            firstBtn.tag = 100
            firstBtn.addTarget(self, action: #selector(onButtonClick(ui:)), for: .touchUpInside)
            //按钮的选中未选中的指示箭头
            let indictor1 = UIImageView.init(frame: CGRect.init(x: firstBtn.bounds.origin.x+firstBtn.bounds.width/2+7+30, y:  firstBtn.bounds.origin.y+firstBtn.bounds.height/2-2, width: 7, height: 4))
            indictor1.image = UIImage.init(named: "arrow_down")
            firstBtn.addSubview(indictor1)
            
            //第二个按钮
            secondBtn = UIButton.init(frame: CGRect.init(x: header.bounds.origin.x+header.bounds.width/2+10, y: header.bounds.origin.y+5, width: header.bounds.width/2-20, height: header.bounds.height - 10))
            secondBtn.setTitleColor(UIColor.black, for: .normal)
            secondBtn.backgroundColor = UIColor.clear
            secondBtn.layer.borderWidth = 1
            secondBtn.layer.borderColor = UIColor.black.cgColor
            secondBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            secondBtn.tag = 101
            secondBtn.addTarget(self, action: #selector(onButtonClick(ui:)), for: .touchUpInside)
            //按钮的选中未选中的指示箭头
            let indictor2 = UIImageView.init(frame: CGRect.init(x: secondBtn.bounds.origin.x+secondBtn.bounds.width/2+7+30, y:  secondBtn.bounds.origin.y+secondBtn.bounds.height/2-2, width: 7, height: 4))
            indictor2.image = UIImage.init(named: "arrow_down")
            secondBtn.addSubview(indictor2)
            
            updateButtonsTitle()
            header.addSubview(firstBtn)
            header.addSubview(secondBtn)
            
            firstBtn.snp.makeConstraints { (make) in
                make.top.bottom.left.equalToSuperview()
                make.right.equalTo(secondBtn.snp.left)
                make.width.equalTo(secondBtn.snp.width)
            }
            
            secondBtn.snp.makeConstraints { (make) in
                make.top.bottom.right.equalToSuperview()
                make.left.equalTo(firstBtn.snp.right)
                make.width.equalTo(firstBtn.snp.width)
            }
            
            indictor1.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview().inset(45)
                make.width.equalTo(7)
                make.height.equalTo(4)
            }
            
            indictor2.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview().inset(45)
                make.width.equalTo(7)
                make.height.equalTo(4)
            }
            
            return header
        }else if playCode == "hx"{
            
            let header = UIView.init(frame: CGRect.init(x: self.isPlayBarShow ? kScreenWidth*0.33 : kScreenWidth*0.05, y: 0, width: self.isPlayBarShow ? kScreenWidth*0.67 : kScreenWidth*0.95, height: 88))
            
            let headerOne = UIView.init(frame: CGRect.init(x: header.bounds.origin.x, y: 0, width: self.isPlayBarShow ? kScreenWidth*0.67 : kScreenWidth*0.95, height: 44))
//            headerOne.backgroundColor = UIColor.init(hex: 0xf0f0f0)
            //第一个按钮
            firstBtn = UIButton.init(frame: CGRect.init(x: headerOne.bounds.origin.x+20, y: headerOne.bounds.origin.y+5, width: headerOne.bounds.width-20, height: headerOne.bounds.height - 10))
            firstBtn.setTitleColor(UIColor.black, for: .normal)
            firstBtn.backgroundColor = UIColor.clear
            firstBtn.layer.borderWidth = 1
            firstBtn.layer.borderColor = UIColor.black.cgColor
            firstBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            firstBtn.tag = 100
            firstBtn.addTarget(self, action: #selector(onButtonClick(ui:)), for: .touchUpInside)
            //按钮的选中未选中的指示箭头
            let indictor1 = UIImageView.init(frame: CGRect.init(x: firstBtn.bounds.origin.x+firstBtn.bounds.width/2+7+30, y:  firstBtn.bounds.origin.y+firstBtn.bounds.height/2-2, width: 7, height: 4))
            indictor1.image = UIImage.init(named: "arrow_down")
            firstBtn.addSubview(indictor1)
            headerOne.addSubview(firstBtn)
            
            //分栏按钮，肖中，肖不中
            let headerTwo = UIView.init(frame: CGRect.init(x: header.bounds.origin.x, y: 44, width: self.isPlayBarShow ? kScreenWidth*0.67 : kScreenWidth*0.95, height: 44))
            headerTwo.backgroundColor = UIColor.init(hex: 0xf0f0f0)
            //第一个按钮
            leftBtn = UIButton.init(frame: CGRect.init(x: headerTwo.bounds.origin.x+10, y: headerTwo.bounds.origin.y+5, width: headerTwo.bounds.width/2-20, height: headerTwo.bounds.height - 10))
            leftBtn.setTitleColor(UIColor.black, for: .normal)
            leftBtn.backgroundColor = UIColor.clear
            leftBtn.layer.borderWidth = 1
            leftBtn.layer.borderColor = UIColor.black.cgColor
            leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            leftBtn.tag = 102
            leftBtn.addTarget(self, action: #selector(onButtonClick(ui:)), for: .touchUpInside)
            
            //第二个按钮
            rightBtn = UIButton.init(frame: CGRect.init(x: headerTwo.bounds.origin.x+headerTwo.bounds.width/2+10, y: headerTwo.bounds.origin.y+5, width: headerTwo.bounds.width/2-20, height: headerTwo.bounds.height - 10))
            rightBtn.setTitleColor(UIColor.black, for: .normal)
            rightBtn.backgroundColor = UIColor.clear
            rightBtn.layer.borderWidth = 1
            rightBtn.layer.borderColor = UIColor.black.cgColor
            rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            rightBtn.tag = 103
            rightBtn.addTarget(self, action: #selector(onButtonClick(ui:)), for: .touchUpInside)
            headerTwo.addSubview(leftBtn)
            headerTwo.addSubview(rightBtn)
            
//            headerOne.backgroundColor = UIColor.red
//            headerTwo.backgroundColor = UIColor.green
//            firstBtn.backgroundColor = UIColor.blue
//            leftBtn.backgroundColor = UIColor.black
//            rightBtn.backgroundColor = UIColor.yellow
            
            updateButtonsTitle();
            
            header.addSubview(headerOne)
            header.addSubview(headerTwo)
            
            headerOne.snp.makeConstraints { (make) in
                make.left.top.right.equalToSuperview()
                make.height.equalTo(44)
            }
            
            headerTwo.snp.makeConstraints { (make) in
                make.left.bottom.right.equalToSuperview()
                make.height.equalTo(44)
                make.top.equalTo(headerOne.snp.bottom)
            }
            
            firstBtn.snp.makeConstraints { (make) in
                make.top.left.bottom.right.equalToSuperview()
            }

            leftBtn.snp.makeConstraints { (make) in
                make.top.bottom.left.equalToSuperview()
            }
            
            rightBtn.snp.makeConstraints { (make) in
                make.top.bottom.right.equalToSuperview()
                make.left.equalTo(leftBtn.snp.right)
                make.width.equalTo(leftBtn.snp.width)
            }
            
            indictor1.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview().inset(45)
                make.width.equalTo(7)
                make.height.equalTo(4)
            }
            
            return header
        }else if playCode == "zxbz" || playCode == "ztm" || playCode == "zm16"{
            
            let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth*0.67, height: 44))
            header.backgroundColor = UIColor.init(hex: 0xf0f0f0)
            
            let headerOne = UIView.init(frame: CGRect.init(x: self.isPlayBarShow ? kScreenWidth*0.33 : kScreenWidth*0.05, y: 0, width: self.isPlayBarShow ? kScreenWidth*0.67 : kScreenWidth*0.95, height: 44))
            headerOne.backgroundColor = UIColor.init(hex: 0xf0f0f0)
            
            //第一个按钮
            firstBtn = UIButton.init(frame: CGRect.init(x: headerOne.bounds.origin.x+20, y: headerOne.bounds.origin.y+5, width: headerOne.bounds.width-20, height: headerOne.bounds.height - 10))
            firstBtn.setTitleColor(UIColor.black, for: .normal)
            firstBtn.backgroundColor = UIColor.clear
            firstBtn.layer.borderWidth = 1
            firstBtn.layer.borderColor = UIColor.black.cgColor
            firstBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            firstBtn.tag = 100
            firstBtn.addTarget(self, action: #selector(onButtonClick(ui:)), for: .touchUpInside)
            //按钮的选中未选中的指示箭头
            let indictor1 = UIImageView.init(frame: CGRect.init(x: firstBtn.bounds.origin.x+firstBtn.bounds.width/2+7+30, y:  firstBtn.bounds.origin.y+firstBtn.bounds.height/2-2, width: 7, height: 4))
            indictor1.image = UIImage.init(named: "arrow_down")
            
            firstBtn.addSubview(indictor1)
            headerOne.addSubview(firstBtn)
            header.addSubview(headerOne)
            
            headerOne.snp.makeConstraints { (make) in
                make.left.top.right.equalToSuperview()
                make.height.equalTo(44)
            }
            
            firstBtn.snp.makeConstraints { (make) in
                make.top.left.bottom.right.equalToSuperview()
            }
            
            indictor1.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview().inset(45)
                make.width.equalTo(7)
                make.height.equalTo(4)
            }
            
            updateButtonsTitle();
            return header
        }else if playCode == "yxa" || playCode == "wsa" || playCode == "txa"{
            return UIView.init(frame: CGRect.zero)
        }
        return nil
    }
    
    /**
     * 机选时的处理函数
     * @param orderCount 机选几单
     @param choosePlays 当前选择的玩法列表
     */
    public func randomBet(choosePlays:[BcLotteryPlay],orderCount:Int) -> [PeilvOrder]{
//        let orders = peilvRandomBet(orderCount: orderCount, minPeilvCount: minPeilvCount, allPlays: allPlays,lhcLogic: &lhcLogic)
        var orders = [PeilvOrder]()
        for _ in 0...orderCount-1{
            let peilvWebResults = PeilvLogic.selectRandomPeilvDatas(selectPlay: choosePlays, randomOrderCount: 1, minPeilvCount: minRandomPeilvs())
            let results = calcOrder(selectDatas: peilvWebResults)
            if !results.isEmpty{
                orders = orders + results
            }
        }
        return orders
    }
    
    //根据不同玩法，取出对应的构成一单需要选择的最小赔率数，如连码三全中-单选/复式
    private func minRandomPeilvs() -> Int{
        if playCode == "lm"{
            if let data = getDataByPlayCode(playCode: playCode){
                let first = data.data![firstCategoryIndex]
                if first.code == "sze" || first.code == "sqz"{
                    return 3
                }else{
                    return 2
                }
            }
        }else if playCode == "hx"{
            if let data = getDataByPlayCode(playCode: playCode){
                let first = data.data![firstCategoryIndex]
                if first.code == "hxy"{
                    return 1
                }else if first.code == "hxe"{
                    return 2
                }else if first.code == "hxs"{
                    return 3
                }else if first.code == "hxsi"{
                    return 4
                }else if first.code == "hxw"{
                    return 5
                }else if first.code == "hxl"{
                    return 6
                }else if first.code == "hxq"{
                    return 7
                }else if first.code == "hxb"{
                    return 8
                }else if first.code == "hxj"{
                    return 9
                }else if first.code == "hxsh"{
                    return 10
                }else if first.code == "hxsy"{
                    return 11
                }
            }
        }else if playCode == "zxbz"{
            if let data = getDataByPlayCode(playCode: playCode){
                let first = data.data![firstCategoryIndex]
                if first.code == "wbz"{
                    return 5
                }else if first.code == "lbz"{
                    return 6
                }else if first.code == "qbz"{
                    return 7
                }else if first.code == "bbz"{
                    return 8
                }else if first.code == "jbz"{
                    return 9
                }else if first.code == "sbz"{
                    return 10
                }else if first.code == "sybz"{
                    return 11
                }else if first.code == "sebz"{
                    return 12
                }
            }
        }else if playCode == "lx"{
            if let data = getDataByPlayCode(playCode: playCode){
                let first = data.data![firstCategoryIndex]
                if first.code == "lxex"{
                    return 2
                }else if first.code == "lxsx"{
                    return 3
                }else if first.code == "lxsix"{
                    return 4
                }else if first.code == "lxwx"{
                    return 5
                }
            }
        }
        return 1
    }
    
    
    
    
    
    
}
