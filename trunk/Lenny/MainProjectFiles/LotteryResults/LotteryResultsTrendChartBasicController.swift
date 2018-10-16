//
//  LotteryResultsTrendChartBasicController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/25.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import SkeletonView

///走势图
class LotteryResultsTrendChartBasicController: LennyBasicViewController {
    var isAttachInTabBar = true
    var shouldCarryOut = false
    var lotType = "1"
    let mainTableView = UITableView()
    var sectionNumber: Int = 0
//    var pageNum:Int = 0  //页数
    var dataArr:[AllLotteryResultsList] = [AllLotteryResultsList]()
    var codeRankArr:[AllLotteryResultsCodeNums] = [AllLotteryResultsCodeNums]()
    var codeRands:[AllLotteryResultsCodeRank] = [AllLotteryResultsCodeRank]()
    
//    //MARK: - 趋势统计
//    //MARK: 历史开奖数据
//    private func historyResults() -> [Array<String>] {
//        var numsFatherArray = [Array<String>]()
//        for model in dataArr {
//            if let numsArray = model.result?.components(separatedBy: ",") {
//                numsFatherArray.append(numsArray)
//            }
//        }
//        return numsFatherArray
//    }
//
//    //MARK: 出现次数
//    private func calculateAppearTimes(pageIndex: Int, startEnd: (start:Int,end:Int)) -> String
//    {
//        var sum: Int = 0
//        let array = historyResults() // 7,8,1,3,0
//        for numStrArray in 0..<array.count {
//            let array = array[numStrArray]
//            if let num = Int(array[pageIndex]) {
//                if num == pageIndex {
//                    sum += 1
//                }
//            }
//        }
//
//        for index in startEnd.start...startEnd.end {
//            if "\(index)" ==
//        }
//
//        return "\(sum)"
//    }
//
//    //MARK: 返回开奖结果每一位上的sum的数组
//    private func appearTimesArray() -> Array<String> {
//        var array = [String]()
//        for index in 0..<historyResults()[0].count {
//            array.append(calculateAppearTimes(pageIndex: index))
//        }
//
//        return array
//    }

    
    //MARK: - 获取趋势图的数据
    @objc private func loadLotteryResults(pageNumber: Int, code:String,refreshTable: Bool) {
        publicLoadLotteryResults(pageNumber: pageNumber, code: code,refreshTable:refreshTable)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shouldCarryOut = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        shouldCarryOut = false
    }
    
    func publicLoadLotteryResults(pageNumber: Int, code:String,refreshTable: Bool) {
        
        LennyNetworkRequest.obtainLotteryResults(pageNumber: pageNumber, gameCode: code) { [weak self](model) in
            DispatchQueue.main.async {
                if model == nil{
                    return
                }
                if model?.content == nil{
                    return
                }
                if model?.content?.history == nil{
                    return
                }
                if model?.content?.history?.list == nil{
                    return
                }
                
                if model?.content?.codeRank == nil{
                    return
                }
                
                self?.analysis(list: (model!.content?.history?.list)!,codeRankList: (model!.content?.codeRank)!, pageNumber: LotteryResultsInstance.shared.pageNum,refreshTable:refreshTable)//解析
            }
        }
    }
    
    //解析请求数据结果 AllLotteryResultsModel
    func analysis(list:[AllLotteryResultsList],codeRankList:[AllLotteryResultsCodeRank],pageNumber: Int,refreshTable: Bool) {
        if list.count == 0 {
            showToast(view: self.view, txt: "没有更多数据")
        }else {
            self.dataArr += list
            //定位crash
            // index out of range
            if pageIndex > (codeRankList.count - 1) {return}
            self.codeRankArr += (Array)(codeRankList[pageIndex].CodeNums!)
            self.codeRands += codeRankList
            LotteryResultsInstance.shared.dataArr = self.dataArr
            LotteryResultsInstance.shared.codeRands = self.codeRands
            if refreshTable {
                refreshTableViewData()
            }
        }
    }
    
    @objc fileprivate func footerRefresh(){
        loadLotteryResults(pageNumber: LotteryResultsInstance.shared.pageNum, code: code,refreshTable:true)
        LotteryResultsInstance.shared.pageNum += 1
    }
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
//        setupthemeBgView(view: self.view)
    }
    
    override func viewDidLayoutSubviews() {
        
        if !isAttachInTabBar{
            mainTableView.frame  = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 64 - 90)
        }else {
            if #available(iOS 11, *) {} else {
                mainTableView.frame  = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 64 - 49 - 90)
            }
        }
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    ///控制器的Index
    var pageIndex: Int = 0
    
    override var hasNavigationBar: Bool {
        return false
    }
    
    private func setViews() {
        
        setViewBackgroundColorTransparent(view: mainTableView)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
        mainTableView.tableHeaderView = tableViewHeader()
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.separatorStyle = .none
        mainTableView.estimatedRowHeight = 30
        contentView.addSubview(mainTableView)
        
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: self.isAttachInTabBar ? 44 : 0)
    }
    
    private func tableViewFooter() -> UIView {
        let gridWidth_Height: CGFloat = 30.0
        let footerView = UIView()
        footerView.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 200)
        
        let stackView1 = WHC_StackView()
        footerView.addSubview(stackView1)
//        stackView1.whc_Top(0).whc_Right(0).whc_Width(gridWidth_Height * 10).whc_Height(gridWidth_Height)
        stackView1.whc_Top(0).whc_Right(0).whc_Width(screenWidth - CGFloat(80)).whc_Height(gridWidth_Height)

        stackView1.whc_Column = 10
        stackView1.whc_Orientation = .all
        stackView1.whc_SegmentLineSize = 0.45
        let label1 = UILabel()
        footerView.addSubview(label1)
        label1.whc_Top(0).whc_Height(gridWidth_Height).whc_Left(0).whc_Width(80)
        label1.font = UIFont.systemFont(ofSize: 15)
        label1.textColor = UIColor.purple
        label1.textAlignment = .center
        label1.text = "出现次数"
        
        for s in appearTimes() {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.black
            label.textAlignment = .center
            label.text = s
            stackView1.addSubview(label)
        }
        
//        let appearsTimesArray = appearTimesArray()
//        for value in appearsTimesArray {
//            let label = UILabel()
//            label.font = UIFont.systemFont(ofSize: 12)
//            label.textColor = UIColor.black
//            label.textAlignment = .center
//            label.text = value
//            stackView1.addSubview(label)
//        }
        
        stackView1.whc_StartLayout()
        
        let stackView2 = WHC_StackView()
        footerView.addSubview(stackView2)
//        stackView2.whc_Top(0, toView: stackView1).whc_Height(gridWidth_Height).whc_Right(0).whc_Width(gridWidth_Height * 10)
        stackView2.whc_Top(0,toView: stackView1).whc_Right(0).whc_Width(screenWidth - CGFloat(80)).whc_Height(gridWidth_Height)
        stackView2.whc_Column = 10
        stackView2.whc_Orientation = .all
        stackView2.whc_SegmentLineSize = 0.45
        let label2 = UILabel()
        footerView.addSubview(label2)
        label2.whc_Top(0, toView: label1).whc_Height(gridWidth_Height).whc_Left(0).whc_Width(80)
        label2.font = UIFont.systemFont(ofSize: 15)
        label2.textColor = UIColor.purple
        label2.textAlignment = .center
        label2.text = "平均遗漏"
        for s in averageOmission() {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.black
            label.textAlignment = .center
            label.text = s
            stackView2.addSubview(label)
        }
        stackView2.whc_StartLayout()
        
        let stackView3 = WHC_StackView()
        footerView.addSubview(stackView3)
        stackView3.whc_Top(0, toView: stackView2).whc_Right(0).whc_Width(screenWidth - CGFloat(80)).whc_Height(gridWidth_Height)
        stackView3.whc_Column = 10
        stackView3.whc_Orientation = .all
        stackView3.whc_SegmentLineSize = 0.45
        let label3 = UILabel()
        footerView.addSubview(label3)
        label3.whc_Top(0,toView: label2).whc_Height(gridWidth_Height).whc_Left(0).whc_Width(80)
        label3.font = UIFont.systemFont(ofSize: 15)
        label3.textColor = UIColor.purple
        label3.textAlignment = .center
        label3.text = "最大遗漏"
        for s in maxOmission() {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.black
            label.textAlignment = .center
            label.text = s
            stackView3.addSubview(label)
        }
        stackView3.whc_StartLayout()
        let stackView4 = WHC_StackView()
        footerView.addSubview(stackView4)
        stackView4.whc_Top(0, toView: stackView3).whc_Right(0).whc_Width(screenWidth - CGFloat(80)).whc_Height(gridWidth_Height)
        stackView4.whc_Column = 10
        stackView4.whc_Orientation = .all
        stackView4.whc_SegmentLineSize = 0.45
        let label4 = UILabel()
        footerView.addSubview(label4)
        label4.whc_Top(0,toView: label3).whc_Height(gridWidth_Height).whc_Left(0).whc_Width(80)
        label4.font = UIFont.systemFont(ofSize: 15)
        label4.textColor = UIColor.purple
        label4.textAlignment = .center
        label4.text = "最大连出"
        for s in maxContinuous() {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.black
            label.textAlignment = .center
            label.text = s
            stackView4.addSubview(label)
        }
        stackView4.whc_StartLayout()
        
        let button = UIButton()
        footerView.addSubview(button)
        button.whc_Top(10, toView: stackView4).whc_Left(20).whc_Right(20).whc_Height(35)
        button.addTarget(self, action: #selector(self.footerRefresh), for: .touchUpInside)
        button.setTitle("加载更多", for: .normal)
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.red
        button.isHidden = false
        
        return footerView
    }
    
    private func appearTimes() -> [String] {
        
        var appaerTimes = [String]()
        for i in 0 ..< 10 {
            var times: Int = 0
            for l: UILabel in brokenLineItems! {
                if i == Int(l.text!)! {
                    times += 1
                }
            }
            appaerTimes.append(String(times))
        }
        return appaerTimes
    }
    private func maxContinuous() -> [String] {
        
        var averageOmission = [String].init(repeating: "0", count: 10)
        for i in 0 ..< 10 {
            var times: Int = 0
            for j in 0 ..< brokenLineItems!.count {
                if i == Int(brokenLineItems![j].text!)! {
                    times = 1
                    if j >= brokenLineItems!.count - 2 { break }
                    if i == Int(brokenLineItems![j + 1].text!)! {
                        times += 1
                    }
                }
                if times > 1 { break }
            }
            averageOmission[i] = String(times)
        }
        return averageOmission
    }
    private func maxOmission() -> [String] {
        
        return ["0", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
    }
    private func averageOmission() -> [String] {
        
        return ["0", "0", "0", "0", "0", "0", "0", "0", "0", "0"]
    }
    private func tableViewHeader() -> UIView {
        
        //表格头‘期数’宽高
        let footerHeaderColoumH: CGFloat = 28
        let footerHeaderColoumW: CGFloat = 80
        let footerView = UIView()
        footerView.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 28)
        let label_Title = UILabel()
        footerView.addSubview(label_Title)
        label_Title.whc_Top(0).whc_Left(0).whc_Height(footerHeaderColoumH).whc_Bottom(0).whc_Width(footerHeaderColoumW)
//            .whc_Right(11 * 28.0)
        label_Title.font = UIFont.boldSystemFont(ofSize: 17)
        label_Title.textColor = UIColor.gray
        label_Title.text = "期数"
        label_Title.textAlignment = .center
        
        
        let stackView = WHC_StackView()
        footerView.addSubview(stackView)
        stackView.whc_Top(0).whc_Bottom(0).whc_Left(0, toView: label_Title).whc_Right(0)
        stackView.whc_Column = 10
        stackView.whc_Orientation = .all
        stackView.whc_SegmentLineSize = 0.45
        stackView.whc_SegmentLineColor = UIColor.cc_224()
        if lotType == "5"
        {
            stackView.whc_Column = 11
            for i in 1 ..< 12 {
                let label = UILabel()
                stackView.addSubview(label)
                label.font = UIFont.boldSystemFont(ofSize: 17)
                label.text = String(i)
                label.textColor = UIColor.cc_136()
                label.textAlignment = .center
            }
        }else if lotType == "3"
        {
            
            stackView.whc_Column = 10
            for i in 1 ..< 11 {
                let label = UILabel()
                stackView.addSubview(label)
                label.font = UIFont.boldSystemFont(ofSize: 17)
                label.text = String(i)
                label.textColor = UIColor.cc_136()
                label.textAlignment = .center
            }
        }else if lotType == "4"
        {
            stackView.whc_Column = 6
            for i in 1 ..< 7 {
                let label = UILabel()
                stackView.addSubview(label)
                label.font = UIFont.boldSystemFont(ofSize: 17)
                label.text = String(i)
                label.textColor = UIColor.cc_136()
                label.textAlignment = .center
            }
        }
        else {
            for i in 0 ..< 10 {
                let label = UILabel()
                stackView.addSubview(label)
                label.font = UIFont.boldSystemFont(ofSize: 17)
                label.text = String(i)
                label.textColor = UIColor.cc_136()
                label.textAlignment = .center
            }
        }
        stackView.whc_StartLayout()
        
        footerView.whc_AddBottomLine(0.5, color: UIColor.cc_224())
        footerView.whc_AddTopLine(0.5, color: UIColor.cc_224())
        
        return footerView
    }
    
    var code: String! = "CQSSC" {
        didSet {
        }
    }
    
    override func refreshTableViewData() {
        
        setViews()
        self.brokenLineItems = []
        mainTableView.reloadData()
        mainTableView.layoutIfNeeded()
        
//        drawLines2()
        drawLineAction()
        mainTableView.tableFooterView = tableViewFooter()
    }
    
    private func convertPointers() {
        
        var arr_Pointers = [CGPoint]()
        for l in self.brokenLineItems! {
            
            arr_Pointers.append(l.superview!.convert(l.center, to: contentView))
        }
    }
    
    
    func drawLineAction() {
        let linesCount = dataArr.count
        if lotType == "3" {
            for i in 0 ..< linesCount {
                
                let indexPath = IndexPath.init(row: i,section: 0)
                if (mainTableView.indexPathsForVisibleRows?.contains(indexPath))! {
                    let indexCount = dataArr.count - 1
                    let cell = mainTableView.cellForRow(at: indexPath) as? TrendChartSaiCheCell
                    var item_last = dataArr[i == 0 ? i : i - 1]
                    let item = dataArr[i]
                    var item_next = dataArr[i == indexCount ? indexCount : i + 1]
                    
                    if i == 0 { item_last = item }
                    if i == indexCount { item_next = item }
                    
                    cell?.drawLinesWith(currentPointerIndex: Int(item.results()[pageIndex])!, nextPointerIndex: Int(item_next.results()[pageIndex])!, lastPointerIndex: Int(item_last.results()[pageIndex])!)
                }
                
            }
        }
        else if lotType == "5"
        {
            
            for i in 0 ..< linesCount {
                
                let indexPath = IndexPath.init(row: i,section: 0)
                
                if (mainTableView.indexPathsForVisibleRows?.contains(indexPath))! {
                    let indexCount = dataArr.count - 1
                    let cell = mainTableView.cellForRow(at: indexPath) as? TrendChartElevenCell
                    var item_last = dataArr[i == 0 ? i : i - 1]
                    let item = dataArr[i]
                    var item_next = dataArr[i == indexCount ? indexCount : i + 1]
                    
                    if i == 0 { item_last = item }
                    if i == indexCount { item_next = item }
                    cell?.drawLinesWith(currentPointerIndex: Int(item.results()[pageIndex])!, nextPointerIndex: Int(item_next.results()[pageIndex])!, lastPointerIndex: Int(item_last.results()[pageIndex])!)
                }
            }
        }else if lotType == "4"
        {
            
            for i in 0 ..< linesCount {
                
                let indexPath = IndexPath.init(row: i,section: 0)
                if (mainTableView.indexPathsForVisibleRows?.contains(indexPath))! {
                    let indexCount = dataArr.count - 1
                    let cell = mainTableView.cellForRow(at: IndexPath.init(row: i, section: 0)) as? TrendChartKuai3Cell
                    var item_last = dataArr[i == 0 ? i : i - 1]
                    let item = dataArr[i]
                    var item_next = dataArr[i == indexCount ? indexCount : i + 1]
                    
                    if i == 0 { item_last = item }
                    if i == indexCount { item_next = item }
                    
                    cell?.drawLinesWith(currentPointerIndex: Int(item.results()[pageIndex])!, nextPointerIndex: Int(item_next.results()[pageIndex])!, lastPointerIndex: Int(item_last.results()[pageIndex])!)
                }
            }
        }else {
            for i in 0 ..< linesCount {

                let indexPath = IndexPath.init(row: i,section: 0)
                if (mainTableView.indexPathsForVisibleRows?.contains(indexPath))! {
                    let indexCount = dataArr.count - 1
                    let cell = mainTableView.cellForRow(at: IndexPath.init(row: i, section: 0)) as? TrendChartCell
                    
                    var item_last = dataArr[i == 0 ? i : i - 1]
                    let item = dataArr[i]
                    var item_next = dataArr[i == indexCount ? indexCount : i + 1]
                    
                    if i == 0 { item_last = item }
                    if i == indexCount { item_next = item }
                    
                    cell?.drawLinesWith(currentPointerIndex: Int(item.results()[pageIndex])!, nextPointerIndex: Int(item_next.results()[pageIndex])!, lastPointerIndex: Int(item_last.results()[pageIndex])!)
                }
            }
            
        }
    }
    
    //MARK: drawLines2
    func drawLines2() {
        
        if shouldCarryOut == false {
            shouldCarryOut = true
            drawLineAction()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.shouldCarryOut = false
            }
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.drawLines2()
    }
}

extension LotteryResultsTrendChartBasicController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//    }
}
extension LotteryResultsTrendChartBasicController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LennyModel.allLotteryResultsModel?.content?.history?.list == nil {
            return 0
        }
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if LennyModel.allLotteryResultsModel == nil {return UITableViewCell() }
        let cell = TrendChartCell.init(style: .default, reuseIdentifier: "cell")
        
        let item = dataArr[indexPath.row]
        
        let isTwoMultiple = indexPath.row % 2 == 0
        
        if lotType == "5" {
            let cell = TrendChartElevenCell.init(style: .default, reuseIdentifier: "cell")
            cell.setTitle(value: "第" + trimQihao(currentQihao: item.period!) + "期")
            
            let array: [String] = codeRands[pageIndex].obtainDatas11X5By(pageIndex: pageIndex, rowIndex: indexPath.row, codeRankArr: codeRankArr, dataArr: dataArr)
            cell.setValues(values:array, And: item.results()[pageIndex], associatedContrller: self)
            
//            setupNoPictureAlphaBgView(view: cell,alpha: isTwoMultiple ? 0.4 : 0.2,bgViewColor: isTwoMultiple ? "FrostedGlass.whiteGlassOtherGray" : "FrostedGlass.subColorImageCoverColor")
            
            setupNoPictureAlphaBgView(view: cell,alpha: isTwoMultiple ? 0.4 : 0.2)
            
            return cell
        }
        if lotType == "3" {
            let cell = TrendChartSaiCheCell.init(style: .default, reuseIdentifier: "cell")
            cell.setTitle(value: "第" + trimQihao(currentQihao: item.period!) + "期")
            
            let array: [String] = codeRands[pageIndex].obtainDatasBy(pageIndex: pageIndex, rowIndex: indexPath.row, codeRankArr: codeRankArr, dataArr: dataArr)
            cell.setValues(values:array, And: item.results()[pageIndex], associatedContrller: self)
            
//            setupNoPictureAlphaBgView(view: cell,alpha: isTwoMultiple ? 0.4 : 0.2,bgViewColor: isTwoMultiple ? "FrostedGlass.whiteGlassOtherGray" : "FrostedGlass.subColorImageCoverColor")
            
            setupNoPictureAlphaBgView(view: cell,alpha: isTwoMultiple ? 0.4 : 0.2)
            
            return cell
        }
        if lotType == "4"{
            let cell = TrendChartKuai3Cell.init(style: .default, reuseIdentifier: "cell")
            cell.setTitle(value: "第" + trimQihao(currentQihao: item.period!) + "期")
            
            let array: [String] = codeRands[pageIndex].obtainDatasBy(pageIndex: pageIndex, rowIndex: indexPath.row, codeRankArr: codeRankArr, dataArr: dataArr)
            cell.setValues(values:array, And: item.results()[pageIndex], associatedContrller: self)
            
//            setupNoPictureAlphaBgView(view: cell,alpha: isTwoMultiple ? 0.4 : 0.2,bgViewColor: isTwoMultiple ? "FrostedGlass.whiteGlassOtherGray" : "FrostedGlass.subColorImageCoverColor")
            
            setupNoPictureAlphaBgView(view: cell,alpha: isTwoMultiple ? 0.4 : 0.2)
            
            return cell
        }else if lotType == "1" {
            cell.setTitle(value: "第" + trimQihao(currentQihao: item.period!) + "期")
            
            let array: [String] = codeRands[pageIndex].obtainDatasBy(pageIndex: pageIndex, rowIndex: indexPath.row, codeRankArr: codeRankArr, dataArr: dataArr)
            cell.setValues(values:array, And: item.results()[pageIndex], associatedContrller: self)
            
//            setupNoPictureAlphaBgView(view: cell,alpha: isTwoMultiple ? 0.4 : 0.2,bgViewColor: isTwoMultiple ? "FrostedGlass.whiteGlassOtherGray" : "FrostedGlass.subColorImageCoverColor")
            
            setupNoPictureAlphaBgView(view: cell,alpha: isTwoMultiple ? 0.4 : 0.2)
            
            return cell
        }
        
        let array = trimQihao(currentQihao: item.period!)
        cell.setTitle(value: "第" + array + "期")
        
        let defaultArray: [String] = codeRands[pageIndex].obtainDatasBy(pageIndex: pageIndex, rowIndex: indexPath.row, codeRankArr: codeRankArr, dataArr: dataArr)
        cell.setValues(values:defaultArray, And: item.results()[pageIndex], associatedContrller: self)
        
//        setupNoPictureAlphaBgView(view: cell,alpha: isTwoMultiple ? 0.4 : 0.2,bgViewColor: isTwoMultiple ? "FrostedGlass.whiteGlassOtherGray" : "FrostedGlass.subColorImageCoverColor")
        
        setupNoPictureAlphaBgView(view: cell,alpha: isTwoMultiple ? 0.4 : 0.2)
        
        return cell
    }
}

extension LotteryResultsTrendChartBasicController {
    
    var brokenLineItems: [UILabel]? {
        get {
            return objc_getAssociatedObject(self, &kBrokenLineItems) as? [UILabel]
        }
        set {
            objc_setAssociatedObject(self, &kBrokenLineItems, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

