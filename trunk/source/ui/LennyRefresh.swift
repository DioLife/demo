//
//  LennyRefresh.swift
//  LennyRefresh
//
//  Created by Lenny's Macbook Air on 2018/5/6.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

enum LennyPullRefreshStyle: Int {
    case All
    case PullDown
    case PullUp
}

@objc protocol LennyPullRefreshDelegate: NSObjectProtocol {
    
    @objc optional func LennyPullDownRequest()
    @objc optional func LennyPullUpRequest()
}

private let kLenny_Margin: CGFloat = 5.0   //上下边距
private let kLenny_WaterDropSize: CGFloat = 40.0   //水滴尺寸
private let kLenny_PullHeight: CGFloat = 100.0     //下拉高度
private let kLenny_BreakRadius: CGFloat = 5.0     //断开半径
private let kLenny_OffsetAnimationDuration: TimeInterval = 0.2   //偏移动画时间
private let kLenny_FontSize: CGFloat = 14.0       //字体大小
private let kLenny_ContentOffset = "contentOffset"  //监听路径
private let kLenny_ContentInset = "contentInset"
private let kLenny_ContentSize = "contentSize"
private let kLenny_RefreshFinishedText = "刷新完成"
private let kLenny_LoadMoreText = "加载更多"
private let kLenny_LoadingText = "正在加载..."
private let kLenny_RefreshingHeight = kLenny_WaterDropSize + 2.0 * kLenny_Margin  //刷新视图的高度

private let kLenny_StartColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor   //加载器开始的颜色
private let kLenny_EndColor = UIColor.init(red: 38.0/255.0, green: 110.0/255.0, blue: 239.0/255.0, alpha: 1.0).cgColor
private let KLenny_WaterBackColor = UIColor.init(red: 38.0/255.0, green: 110.0/255.0, blue: 239.0/255.0, alpha: 1.0).cgColor
//刷新视图头部文字颜色
private let kLenny_HeaderLabelTextColor = UIColor.init(red: 136.0/255.0, green: 136.0/255.0, blue: 136.0/255.0, alpha: 1.0)
//刷新头部百分比标签文字颜色
private let kLenny_HeaderPercentLabelTextColor = UIColor.init(red: 136.0/255.0, green: 136.0/255.0, blue: 136.0/255.0, alpha: 1.0)
//刷新底部提示文字颜色
private let kLenny_FooterLabelTextColor = UIColor.init(red: 136.0/255.0, green: 136.0/255.0, blue: 136.0/255.0, alpha: 1.0)
//刷新底部百分比标签文字颜色
private let kLenny_FooterPercentLabelTextColor = UIColor.init(red: 136.0/255.0, green: 136.0/255.0, blue: 136.0/255.0, alpha: 1.0)

private enum LennyPullRefreshStatus: Int {
    case NoneRefresh = 3  //没有刷新
    case WillRefresh        //将要刷新
    case DoingRefresh       //正在刷新
    case DidRefreshed       //完成刷新
}

//上拉刷新视图
private class LennyPullFooterView: UIView {
    
    var isSetOffset: Bool  = false
    var currentRefreshStatus = LennyPullRefreshStatus.NoneRefresh
    var superOriginalContentInset = UIEdgeInsets.init()
    
    /*-----------------------*/
    private var _backView: UIView!
    private var _loadLabel: UILabel!
    private var _percentLabel: UILabel!
    private var _progressBarImageView: UIImageView!
    private var _gradientProgressBar: CAGradientLayer!
    private var _progressBar: CAShapeLayer!
    private weak var _delegate: LennyPullRefreshDelegate?
    private var _superView: UIScrollView!
    private var _isDidSendRequest: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, delegate: LennyPullRefreshDelegate?) {
        self.init(frame: frame)
        _delegate = delegate
        self.initData()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        _superView.cancelledObserver()
        if newSuperview != nil {
            _superView.addObserver()
        }
    }
    
    static func stringWith(content: String, constrainedHeight:CGFloat, fontSize: CGFloat) -> CGFloat {
//        let contentSize = NSString(string: content).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: constrainedHeight), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)], context: nil)
    //        return contentSize.width
        return 100
    }
    
    func initData() {
        
        currentRefreshStatus = .NoneRefresh
        _isDidSendRequest = false
        let loadingLabelWidth = LennyPullFooterView.stringWith(content: kLenny_LoadMoreText, constrainedHeight: self.bounds.height, fontSize: 17.0)
        let sumWidth =  loadingLabelWidth + kLenny_WaterDropSize + kLenny_Margin
        _backView = UIView(frame: CGRect.init(x: (self.bounds.width - sumWidth)/2, y: kLenny_Margin, width: kLenny_WaterDropSize, height: kLenny_WaterDropSize))
        _loadLabel = UILabel(frame: CGRect.init(x: _backView.frame.maxX + kLenny_Margin, y: 0, width: loadingLabelWidth, height: self.bounds.height))
        _loadLabel.text = kLenny_LoadMoreText
        _loadLabel.textColor = kLenny_FooterLabelTextColor
        _loadLabel.font = UIFont.systemFont(ofSize: kLenny_FontSize)
        self.addSubview(_loadLabel)
        self.addSubview(_backView)
        
        _percentLabel = UILabel(frame: _backView.bounds)
        _percentLabel.textAlignment = .center
        _percentLabel.font = UIFont.systemFont(ofSize: 10)
        _percentLabel.textColor = kLenny_FooterPercentLabelTextColor
        _percentLabel.text = "0"
        _backView.addSubview(_percentLabel)
        
        _gradientProgressBar = CAGradientLayer.init()
        _gradientProgressBar.frame = _backView.bounds
        _gradientProgressBar.backgroundColor = UIColor.clear.cgColor
        _gradientProgressBar.colors = [kLenny_StartColor, kLenny_EndColor]
        _gradientProgressBar.locations = [NSNumber.init(value: 0.0), NSNumber(value: 1.0)]
        
        _progressBar = CAShapeLayer.init()
        _progressBar.frame = _backView.bounds
        _progressBar.backgroundColor = UIColor.clear.cgColor
        _progressBar.fillColor = UIColor.clear.cgColor
        _progressBar.strokeColor = UIColor.blue.cgColor
        _progressBar.lineWidth = 5.0
        _gradientProgressBar.mask = _progressBar
        
        _backView.layer.addSublayer(_gradientProgressBar)
        
        _progressBarImageView = UIImageView(frame: _backView.frame)
    }
    
    func updateProgressBar(with value: CGFloat) {
        let value = value < 0 ? 0 : value
        var endAngle = value / kLenny_RefreshingHeight
        if endAngle > 1.0 {
            endAngle = 1.0
        }
        let path = CGMutablePath.init()
        path.addArc(center: CGPoint.init(x: _progressBar.frame.size.width / 2.0, y: _progressBar.frame.size.height / 2.0), radius: kLenny_WaterDropSize / 2.0 - 3.0, startAngle: CGFloat(-Double.pi / 2.0), endAngle: CGFloat(Double(endAngle) * Double.pi * 2.0 - Double.pi / 2.0), clockwise: false)
        _progressBar.path = path
        _percentLabel.text = String.init(format: "%.0f", endAngle * 100)
    }
    
    func getProgressBarImage() -> UIImage {
        
        UIGraphicsBeginImageContext(_gradientProgressBar.frame.size)
        let context = UIGraphicsGetCurrentContext()
        _gradientProgressBar.render(in: context!)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    func setImageProgressBarAnimation() {
        let ba = CABasicAnimation.init(keyPath: "transform.rotation.z")
        ba.fromValue = 0
        ba.toValue = Double.pi * 2.0
        ba.duration = 1.0
        ba.isCumulative = true
        ba.repeatCount = Float(FP_INFINITE)
        _progressBarImageView.layer.add(ba, forKey: "")
    }
    
    func setSuperView(superView: UIScrollView) {
        _superView = superView
    }
    
    func setUpRefreshDidFinished() {
        
        _isDidSendRequest = false
        currentRefreshStatus = .DidRefreshed
        if subviews.contains(_progressBarImageView) {
            _progressBarImageView.layer.removeAllAnimations()
            _progressBarImageView.removeFromSuperview()
        }
        if !subviews.contains(_backView) {
            self.addSubview(_backView)
        }
        self.isHidden = true
    }
    
    func resetUpRefreshState() {
        
        isSetOffset = false
        currentRefreshStatus = .NoneRefresh
        _loadLabel.text = kLenny_LoadMoreText
    }
    
    func sendUpRefreshCommand() {
        
        if !_isDidSendRequest {
            _isDidSendRequest = true
            if let delegate = _delegate {
                if delegate.responds(to: #selector(LennyPullRefreshDelegate.LennyPullUpRequest)) {
                    delegate.LennyPullUpRequest!()
                }
            }
        }
    }
    func setProgress(value: CGFloat) {
        
        if currentRefreshStatus == .DoingRefresh || currentRefreshStatus == .DidRefreshed { return }
        superOriginalContentInset = _superView.contentInset
        let actualHeight = _superView.frame.size.height - superOriginalContentInset.bottom - superOriginalContentInset.top
        let beyongHeight = _superView.contentSize.height - actualHeight
        var showFooterOffset = beyongHeight - superOriginalContentInset.top
        if beyongHeight < 0 {
            showFooterOffset = -superOriginalContentInset.top
        }
        let actualOffset = value - showFooterOffset
        if actualOffset > kLenny_RefreshingHeight && currentRefreshStatus == .WillRefresh && _superView.isDragging {
            currentRefreshStatus = .DoingRefresh
        }else if _superView.isDragging {
            if self.isHidden {
                self.isHidden = false
            }
            currentRefreshStatus = .WillRefresh
        }
        
        switch currentRefreshStatus {
        case .NoneRefresh:
            break
        case .WillRefresh:
            if !subviews.contains(_backView) {
                self.addSubview(_backView)
            }
            updateProgressBar(with: actualOffset)
            break
        case .DoingRefresh:
            if subviews.contains(_backView) {
                _backView.removeFromSuperview()
                updateProgressBar(with: kLenny_RefreshingHeight)
            }
            if !subviews.contains(_progressBarImageView) {
                self.addSubview(_progressBarImageView)
                if _progressBarImageView.image == nil {
                    _progressBarImageView.image = getProgressBarImage()
                }
                setImageProgressBarAnimation()
                _loadLabel.text = kLenny_LoadingText
            }
            break
        default:
            break
        }
        if _superView.isDragging && currentRefreshStatus == .DoingRefresh {
            sendUpRefreshCommand()
        }
    }
    func updatePosition() {
        let superHeight = _superView.frame.height - _superView.contentInset.top - _superView.contentInset.bottom
        var _frame = self.frame
        self.frame = CGRect.init(x: _frame.origin.x, y: max(superHeight, _superView.contentSize.height), width: _frame.size.width, height: _frame.size.height)
    }
}

private class LennyPullHeaderView: UIView {
    
    var defaultOffset: CGFloat = 0
    var currentRefreshState: LennyPullRefreshStatus = .NoneRefresh
    var isCloseHeader: Bool = false
    var isRequestEndNoInit: Bool = true
    var superOriginalContentInset: UIEdgeInsets = UIEdgeInsets.zero
    
    /*--------------------*/
    private var _backView: UIView!
    private var _gradientProgressBar: CAGradientLayer!
    private var _progressBar: CAShapeLayer!
    private var _progressBarImageView: UIImageView!
    private var _percentLabel: UILabel!
    private var _refreshAlertLabel: UILabel!
    private var _superView: UIScrollView!
    private weak var _delegate: LennyPullRefreshDelegate?
    private var _isBreak: Bool!
    private var _isSetDefaultOffset: Bool!
    private var _isDidRefresh: Bool!
    private var _isSendRequest: Bool!
    private var _currentRadius: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, delegate: LennyPullRefreshDelegate?) {
        self.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        _delegate = delegate
        initData()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        _superView.cancelledObserver()
        if newSuperview != nil {
            _superView.addObserver()
        }
    }
    
    func setSuperView(superview: UIScrollView) {
        _superView = superview
    }
    func setDelegate(delegate: LennyPullRefreshDelegate?) {
        _delegate = delegate
    }
    
    func createView() -> UIView {
        
        let view = UIView()
        view.frame.size = CGSize(width: kLenny_WaterDropSize, height: kLenny_WaterDropSize)
        view.center = CGPoint(x: self.center.x, y: self.frame.size.height - kLenny_WaterDropSize / 2.0)
        view.backgroundColor = UIColor.init(cgColor: KLenny_WaterBackColor)
        view.layer.cornerRadius = kLenny_WaterDropSize / 2.0
        view.clipsToBounds = true
        return view
    }
    
    func initData() {
        
        _isBreak = false
        _isSendRequest = false
        defaultOffset = 0
        _isSetDefaultOffset = false
        _currentRadius = kLenny_WaterDropSize / 2.0
        _backView = createView()
        self.addSubview(_backView)
        
        _gradientProgressBar = CAGradientLayer.init()
        _gradientProgressBar.frame = _backView.bounds
        _gradientProgressBar.backgroundColor = UIColor.clear.cgColor
        _gradientProgressBar.colors = [kLenny_StartColor, kLenny_EndColor]
        _gradientProgressBar.locations = [NSNumber.init(value: 0.0), NSNumber.init(value: 1.0)]
        _progressBar = CAShapeLayer.init()
        _progressBar.frame = _backView.bounds
        _progressBar.backgroundColor = UIColor.clear.cgColor
        _progressBar.fillColor = UIColor.clear.cgColor
        _progressBar.strokeColor = UIColor.blue.cgColor
        _progressBar.lineWidth = 2.0
        _gradientProgressBar.mask = _progressBar
        _backView.layer.addSublayer(_gradientProgressBar)
        
        _percentLabel = UILabel(frame: _backView.bounds)
        _percentLabel.textAlignment = .center
        _percentLabel.textColor = kLenny_HeaderPercentLabelTextColor
        _percentLabel.font = UIFont.systemFont(ofSize: 10)
        _backView.addSubview(_percentLabel)
        
        _progressBarImageView = UIImageView.init(frame: _backView.frame)
        _progressBarImageView.center.y = _progressBarImageView.frame.width / 2.0
        
        _refreshAlertLabel = UILabel(frame: self.bounds)
        var fra = _refreshAlertLabel.frame
        fra.size.height = kLenny_WaterDropSize
        _refreshAlertLabel.frame = fra
        _refreshAlertLabel.center = _backView.center
        _refreshAlertLabel.textColor = kLenny_HeaderLabelTextColor
        _refreshAlertLabel.font = UIFont.systemFont(ofSize: kLenny_FontSize)
        _refreshAlertLabel.textAlignment = .center
        _refreshAlertLabel.text = kLenny_RefreshFinishedText
        
    }
    
    func updateProgressBar(with value: CGFloat) {
        
        var endAngle = value / kLenny_PullHeight
        if endAngle > 1.0 {
            endAngle = 1.0
        }
        let path = CGMutablePath.init()
        path.addArc(center: CGPoint.init(x: _progressBar.frame.size.width / 2.0, y: _progressBar.frame.size.height / 2.0), radius: kLenny_WaterDropSize / 2.0 - 2.5, startAngle: CGFloat(Double.pi / 2.0), endAngle: CGFloat(Double(endAngle) * Double.pi * 2.0 + Double.pi / 2.0), clockwise: false)
        _progressBar.path = path
        _percentLabel.text = String.init(format: "%.0f", endAngle * 100)
    }
    
    func getProgressBarImage() -> UIImage {
        
        UIGraphicsBeginImageContext(_gradientProgressBar.frame.size)
        let context = UIGraphicsGetCurrentContext()
        _gradientProgressBar.render(in: context!)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    func setImageProgressBarAnimation() {
        
        if _progressBarImageView.image == nil {
            _progressBarImageView.image = getProgressBarImage()
        }
        _progressBarImageView.center.y = _progressBarImageView.frame.size.height / 2.0
        if !subviews.contains(_progressBarImageView) {
            addSubview(_progressBarImageView)
        }
        let ba = CABasicAnimation(keyPath: "transform.rotation.z")
        ba.fromValue = 0
        ba.toValue = Double.pi * 2.0
        ba.duration = 1.0
        ba.isCumulative = true
        ba.repeatCount = Float(FP_INFINITE)
        _progressBarImageView.layer.add(ba, forKey: "")
    }
    
    func setProgressValue(value: CGFloat) {
        
        if currentRefreshState != .DoingRefresh && currentRefreshState != .DidRefreshed {
            superOriginalContentInset = _superView.contentInset
        }
        let actualOffset = value + superOriginalContentInset.top
        let absActualOffset = -actualOffset
        if !_superView.isDragging {
            if currentRefreshState == .WillRefresh || currentRefreshState == .NoneRefresh {
                if absActualOffset > kLenny_RefreshingHeight && absActualOffset <= kLenny_PullHeight {
                    _backView.center.y = frame.size.height - (absActualOffset - kLenny_RefreshingHeight) - kLenny_WaterDropSize / 2.0
                    _currentRadius = (1.0 - (absActualOffset - kLenny_RefreshingHeight) / (kLenny_PullHeight - kLenny_Margin)) * kLenny_WaterDropSize / 2.0
                }else {
                    _currentRadius = kLenny_WaterDropSize / 2.0
                    _backView.center.y = frame.size.height - kLenny_WaterDropSize / 2.0
                }
            }
            updateProgressBar(with: absActualOffset)
            setNeedsDisplay()
        }else {
            if actualOffset < 0 && currentRefreshState != .DoingRefresh && currentRefreshState != .DidRefreshed {
                if _backView.isHidden {
                    _backView.isHidden = false
                }
                if absActualOffset > kLenny_RefreshingHeight {
                    if absActualOffset <= kLenny_PullHeight {
                        _isBreak = false
                        _backView.center.y = frame.size.height - (absActualOffset - kLenny_RefreshingHeight) - kLenny_WaterDropSize / 2.0
                        _currentRadius = (1.0 - (absActualOffset - kLenny_RefreshingHeight) / (kLenny_PullHeight - kLenny_Margin)) * kLenny_WaterDropSize / 2.0
                        currentRefreshState = .WillRefresh
                        if _currentRadius < kLenny_BreakRadius {
                            _isBreak = true
                            currentRefreshState = .DoingRefresh
                            _currentRadius = kLenny_BreakRadius
                        }
                    }else {
                        _isBreak = true
                        _currentRadius = kLenny_BreakRadius
                        currentRefreshState = .DoingRefresh
                        _backView.center.y = kLenny_RefreshingHeight / 2.0
                    }
                }
                updateProgressBar(with: absActualOffset)
                setNeedsDisplay()
                
                switch currentRefreshState {
                case .NoneRefresh:
                    break
                case .WillRefresh:
                    if !subviews.contains(_backView) {
                        addSubview(_backView)
                    }
                    break
                case .DoingRefresh:
                    if subviews.contains(_backView) {
                        _backView.removeFromSuperview()
                        setImageProgressBarAnimation()
                    }
                    break
                case .DidRefreshed:
                    break
                }
                if _superView.isDragging && currentRefreshState == .DoingRefresh {
                    sendDownRefreshCommand()
                }
            }
        }
    }
    
    func setDefaultOffset(value: CGFloat) {
        if !_isSetDefaultOffset {
            defaultOffset = value
            _isSetDefaultOffset = true
        }
    }
    
    func setDownRefreshDidFinished() {
        currentRefreshState = .DidRefreshed
        _isDidRefresh = true
        if subviews.contains(_progressBarImageView) {
            _refreshAlertLabel.center.y = _progressBarImageView.center.y
            _progressBarImageView.removeFromSuperview()
            addSubview(_refreshAlertLabel)
        }
    }
    
    func resetDownRefreshState() {
        updateProgressBar(with: 0)
        _progressBarImageView.layer.removeAllAnimations()
        _progressBarImageView.center.y = _progressBarImageView.frame.size.height / 2.0
        _refreshAlertLabel.center.y = _refreshAlertLabel.frame.height / 2.0
        if subviews.contains(_progressBarImageView) {
            _progressBarImageView.removeFromSuperview()
        }
        if subviews.contains(_refreshAlertLabel) {
            _refreshAlertLabel.removeFromSuperview()
        }
        if !subviews.contains(_backView) {
            addSubview(_backView)
        }
        isRequestEndNoInit = false
        _isSendRequest = false
        _backView.center.y = frame.size.height - kLenny_WaterDropSize / 2.0
        if  currentRefreshState == .WillRefresh {
            _backView.isHidden = false
        }else if currentRefreshState == .DidRefreshed {
            _backView.isHidden = true
            isCloseHeader = false
        }
        _isBreak = false
        currentRefreshState = .NoneRefresh
        setNeedsDisplay()
    }
    
    func setProgressBarEndDragPosition() {
        _progressBarImageView.center.y = frame.size.height - kLenny_RefreshingHeight / 2.0
    }
    
    func sendDownRefreshCommand() {
        
        if !subviews.contains(_progressBarImageView) {
            addSubview(_progressBarImageView)
        }
        _progressBarImageView.center.y = frame.size.height - kLenny_RefreshingHeight / 2.0
        if !_isSendRequest {
            _isSendRequest = true
            if let delegate = _delegate {
                if delegate.responds(to: #selector(LennyPullRefreshDelegate.LennyPullDownRequest)) {
                    delegate.LennyPullDownRequest!()
                }
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        if _isBreak && (currentRefreshState == .DoingRefresh || currentRefreshState == .DidRefreshed) {
            return
        }
        let a = CGPoint.init(x: _backView.frame.origin.x + 0.5, y: _backView.center.y)
        let b = CGPoint.init(x: _backView.frame.maxX - 0.5, y: _backView.center.y)
        let c = CGPoint.init(x: _backView.center.x + _currentRadius - 0.5, y: frame.size.height - _currentRadius)
        let d = CGPoint.init(x: _backView.center.x - _currentRadius + 0.5, y: frame.size.height - _currentRadius)
        let ctrl1 = CGPoint.init(x: d.x, y: d.y - (frame.size.height - _currentRadius - _backView.center.y) / 2.0)
        let ctrl2 = CGPoint.init(x: c.x, y: d.y - (frame.size.height - _currentRadius - _backView.center.y) / 2.0)
        
        let bezierPath = UIBezierPath.init()
        bezierPath.lineJoinStyle = .round
        bezierPath.lineCapStyle = .round
        bezierPath.move(to: a)
        bezierPath.addQuadCurve(to: d, controlPoint: ctrl1)
        bezierPath.addLine(to: c)
        bezierPath.addQuadCurve(to: b, controlPoint: ctrl2)
        bezierPath.move(to: a)
        bezierPath.close()
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(KLenny_WaterBackColor)
        context?.setFillColor(KLenny_WaterBackColor)
        context?.setLineWidth(1.0)
        if _backView.isHidden == false {
            context?.addArc(center: CGPoint.init(x: d.x + _currentRadius - 0.5, y: d.y), radius: _currentRadius - 0.5, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: false)
            context?.drawPath(using: .fillStroke)
            context?.addPath(bezierPath.cgPath)
            context?.drawPath(using: .fillStroke)
        }
        UIGraphicsEndImageContext()
    }
}

private var kLennyHeaderMask = "LennyHeaderView"
private var kLennyFooterMask = "LennyHeaderView"

extension UIScrollView {
    
    private func createHeaderView(with delegate: LennyPullRefreshDelegate?) {
        
        let headerView = LennyPullHeaderView(frame: CGRect.init(x: 0, y: -kLenny_PullHeight, width: UIScreen.main.bounds.width, height: kLenny_PullHeight), delegate: delegate)
        headerView.setSuperView(superview: self)
        objc_setAssociatedObject(self, &kLennyHeaderMask, headerView, .OBJC_ASSOCIATION_RETAIN)
        insertSubview(headerView, at: 0)
    }
    
    private func createFooterView(with delegate: LennyPullRefreshDelegate?) {
        
        let footerView = LennyPullFooterView(frame: CGRect.init(x: 0, y: frame.size.height, width: UIScreen.main.bounds.width, height: kLenny_RefreshingHeight), delegate: delegate)
        footerView.setSuperView(superView: self)
        objc_setAssociatedObject(self, &kLennyFooterMask, footerView, .OBJC_ASSOCIATION_RETAIN)
        insertSubview(footerView, at: 0)
    }
    func setLennyPullRefresh(Style type: LennyPullRefreshStyle, delegate: LennyPullRefreshDelegate) {
        
        addObserver()
        switch type {
        case .All:
            createFooterView(with: delegate)
            createHeaderView(with: delegate)
            break
        case .PullUp:
            createFooterView(with: delegate)
            break
        case .PullDown:
            createHeaderView(with: delegate)
            break
        }
    }
    
    private func getHeaderView() -> LennyPullHeaderView? {
        return objc_getAssociatedObject(self, &kLennyHeaderMask) as? LennyPullHeaderView
    }
    private func getFooterView() -> LennyPullFooterView? {
        return objc_getAssociatedObject(self, &kLennyFooterMask) as? LennyPullFooterView
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print((#file as NSString).lastPathComponent + "." + #function)
        print(keyPath)
        print(change)
        if keyPath == kLenny_ContentOffset {
            scrollViewDidScroll(contentOffset: change?[NSKeyValueChangeKey.newKey] as! CGPoint)
        }else if keyPath == kLenny_ContentSize {
            if let footerView = getFooterView() {
                footerView.updatePosition()
            }
        }
    }
    
    private func scrollViewDidScroll(contentOffset value: CGPoint) {
        
        var defaultOffset: CGFloat = 0.0
        let headerView = getHeaderView()
        let footerView = getFooterView()
        if let headerView = headerView {
            defaultOffset = headerView.superOriginalContentInset.top
        }else if let footerView = footerView {
            defaultOffset = footerView.superOriginalContentInset.top
        }
        
        if value.y < -defaultOffset && headerView != nil {
            if !isDragging {
                scrollViewDidEndDraggingWith(decelerate: true, isUp: false)
            }else {
                if -value.y < contentInset.top {
                    if !headerView!.isCloseHeader && headerView?.currentRefreshState == .DoingRefresh {
                        headerView?.isCloseHeader = true
                        UIView.animate(withDuration: kLenny_OffsetAnimationDuration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                            [weak self] in
                            self?.contentInset = UIEdgeInsetsMake(headerView!.superOriginalContentInset.top, 0, headerView!.superOriginalContentInset.bottom, 0)
                        }, completion: nil)
                    }
                }else if -value.y >= self.contentInset.top + kLenny_RefreshingHeight {
                    if headerView!.isCloseHeader && headerView?.currentRefreshState == .DoingRefresh {
                        headerView?.isCloseHeader = false
                        UIView.animate(withDuration: kLenny_OffsetAnimationDuration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                            [weak self] in
                            self?.contentInset = UIEdgeInsetsMake(headerView!.superOriginalContentInset.top + kLenny_RefreshingHeight, 0, headerView!.superOriginalContentInset.bottom, 0)
                        }, completion: nil)
                    }
                }
            }
            if footerView != nil && footerView?.currentRefreshStatus == .DidRefreshed {
                footerView?.resetUpRefreshState()
            }
            headerView?.setProgressValue(value: value.y)
        }else {
            if !self.isDragging {
                scrollViewDidEndDraggingWith(decelerate: true, isUp: true)
            }
            if headerView != nil && headerView?.currentRefreshState == .DidRefreshed {
                headerView?.resetDownRefreshState()
            }
            if let footerView = footerView {
                footerView.setProgress(value: value.y)
            }
        }
    }
    
    private func scrollViewDidEndDraggingWith(decelerate value: Bool, isUp Up: Bool) {
        
        if Up {
            if let footerView = getFooterView() {
                if footerView.currentRefreshStatus == .DoingRefresh && !footerView.isSetOffset {
                    footerView.isSetOffset = true
                    UIView.animate(withDuration: kLenny_OffsetAnimationDuration, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                        [weak self] in
                        self?.contentInset = UIEdgeInsets.init(top: footerView.superOriginalContentInset.top, left: 0, bottom: kLenny_RefreshingHeight + footerView.superOriginalContentInset.bottom, right: 0)
                    }, completion: nil)
                }else if !footerView.isSetOffset {
                    footerView.resetUpRefreshState()
                }
            }
        }else {
            if let headerView = getHeaderView() {
                if headerView.currentRefreshState == .DoingRefresh {
                    if !headerView.isCloseHeader {
                        self.contentInset = UIEdgeInsetsMake(kLenny_RefreshingHeight + headerView.superOriginalContentInset.top, 0, headerView.superOriginalContentInset.bottom, 0)
                    }
                    headerView.setProgressBarEndDragPosition()
                }else if headerView.currentRefreshState != .DidRefreshed || headerView.isRequestEndNoInit {
                    headerView.resetDownRefreshState()
                }
            }
        }
    }
    
    func LennyDidCompletedWithRefreshIs(downPull down: Bool) {
        
        if down {
            if let headerView = getHeaderView() {
                headerView.setDownRefreshDidFinished()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                    UIView.animate(withDuration: kLenny_OffsetAnimationDuration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                        [weak self] in
                        self?.contentInset = UIEdgeInsetsMake(headerView.superOriginalContentInset.top, 0, headerView.superOriginalContentInset.bottom, 0)
                        }, completion: { (finished) in
                            if !self.isDragging {
                                headerView.resetDownRefreshState()
                            }else {
                                headerView.isRequestEndNoInit = true
                            }
                    })
                }
            }
        }else {
            if let footerView = getFooterView() {
                footerView.setUpRefreshDidFinished()
                UIView.animate(withDuration: kLenny_OffsetAnimationDuration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    [weak self] in
                    self?.contentInset = UIEdgeInsetsMake(footerView.superOriginalContentInset.top, 0, footerView.superOriginalContentInset.bottom, 0)
                }) { (_) in
                    footerView.isSetOffset = false
                    if !self.isDragging {
                        footerView.resetUpRefreshState()
                    }
                }
            }
        }
    }
    
    func cancelledObserver() {
        
        removeObserver(self, forKeyPath: kLenny_ContentSize, context: nil)
        removeObserver(self, forKeyPath: kLenny_ContentOffset, context: nil)
    }
    func addObserver() {
        
        addObserver(self, forKeyPath: kLenny_ContentOffset, options: NSKeyValueObservingOptions.new, context: nil)
        addObserver(self, forKeyPath: kLenny_ContentSize, options: NSKeyValueObservingOptions.new, context: nil)
    }
}
