//
//  SlideContainerController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/21.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol MenuDelegate {
    func menuEvent(isRight:Bool)
}

class SlideContainerController: UIViewController, UIGestureRecognizerDelegate,MenuDelegate {
    
    enum HZSSliderState {
        case Cener, Left, Right
    }
    
    //Public property
    private(set) var leftVC: UIViewController?
    private(set) var centerVC: UIViewController
    private(set) var rightVC: UIViewController?
    private(set) var state: HZSSliderState = .Cener
    var animationDuration: TimeInterval = 0.25
    var scaleEnable: Bool = false
    var scale: CGFloat = 0.85
    var sideMovable: Bool = false
    var recoverCenterClosure: (() -> Void)?
    var backgroundIMG: UIImage? {
        didSet {
            backgroundImgView.image = backgroundIMG
        }
    }
    //Private property
    private let backgroundImgView: UIImageView = UIImageView()
    private var touchAtLeft: Bool = false
    private var leftCenter: CGPoint = CGPoint.zero
    private var centerCenter: CGPoint = CGPoint.zero
    private var rightCenter: CGPoint = CGPoint.zero
    private var distanceFromLeft: CGFloat = 0
    private var centerButton: UIButton?
    private var enable_edge: CGFloat = 75
    private var screen_width: CGFloat {
        return kScreenWidth
    }
    private var mini_triggerDistance: CGFloat {
        return screen_width*0.4
    }
    private var max_moveDistance: CGFloat {
        return scaleEnable ? (screen_width/2) : (screen_width/2)
    }
    private var menu_begin: CGFloat {
        return sideMovable ? 60 : 0
    }
    var opacityBtn:UIButton?
    
    //Public func
    init(centerViewController: UIViewController, leftViewController: UIViewController?, rightViewController: UIViewController?) {
        self.centerVC = centerViewController
        self.leftVC = leftViewController
        self.rightVC = rightViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    func showLeftViewController(animated: Bool) -> Void {
        guard let left = leftVC else { return }
        
        view.window?.endEditing(true)
        left.view.isHidden = false
        rightVC?.view.isHidden = true
        let center = view.center
        UIView.animate(withDuration: animated ? animationDuration : 0, animations: {
            left.view.center = center
            self.centerVC.view.center = CGPoint(x: center.x + self.max_moveDistance, y: center.y)
            if self.scaleEnable {
                self.centerVC.view.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
            }
        }) { (finished) in
            self.state = .Left
            self.rightVC?.view.center = CGPoint(x: center.x + self.menu_begin, y: center.y)
            self.addCenterButton()
            self.distanceFromLeft = self.max_moveDistance
            //更改侧边菜单的宽度和中心点
            self.leftVC?.view.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth/2, height: kScreenHeight)
            self.leftVC?.view.center = CGPoint.init(x: kScreenWidth*0.25, y: kScreenHeight/2)
//
//            self.centerVC.view.frame = CGRect.init(x: kScreenWidth/2, y: 0, width: kScreenWidth/2, height: kScreenHeight)
//            self.centerVC.view.center = CGPoint.init(x: kScreenWidth*0.75, y: kScreenHeight/2)
        }
    }
    
    func showRightViewController(animated: Bool) -> Void {
        guard let right = rightVC else { return }
        
        view.window?.endEditing(true)
        leftVC?.view.isHidden = true
        right.view.isHidden = false
        let center = view.center
        UIView.animate(withDuration: animated ? animationDuration : 0, animations: {
            self.centerVC.view.center = CGPoint(x: center.x - self.max_moveDistance, y: center.y)
            if self.scaleEnable {
                self.centerVC.view.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
            }
        }) { (finished) in
            self.state = .Right
            self.leftVC?.view.center = CGPoint(x: center.x - self.menu_begin, y: center.y)
            self.addCenterButton()
            self.distanceFromLeft = -self.max_moveDistance
            //更改侧边菜单的宽度和中心点
            self.rightVC?.view.frame = CGRect.init(x: kScreenWidth/2, y: 0, width: kScreenWidth/2, height: kScreenHeight)
            self.rightVC?.view.center = CGPoint.init(x: kScreenWidth*0.75, y: kScreenHeight/2)
        }
    }
    
    func showCenterViewController(animated: Bool) -> Void {
        
        //移除主界面蒙版视图
        if self.opacityBtn != nil{
            self.opacityBtn?.removeFromSuperview()
            self.opacityBtn = nil
        }
        
        view.window?.endEditing(true)
        let center = view.center
        UIView.animate(withDuration: animated ? animationDuration : 0, animations: {
            self.leftVC?.view.center = CGPoint(x: center.x - self.menu_begin, y: center.y)
            self.rightVC?.view.center = CGPoint(x: center.x + self.menu_begin, y: center.y)
            self.centerVC.view.center = center
            self.centerVC.view.transform = CGAffineTransform.identity
        }) { (finished) in
            self.state = .Cener
            self.centerButton?.removeFromSuperview()
            self.centerButton = nil
            self.distanceFromLeft = 0
        }
    }
    
    func setCenterViewControllerWith(viewController: UIViewController, animated: Bool) -> Void {
        if centerVC == viewController { return }
        
        viewController.view.center = centerVC.view.center
        viewController.view.transform = centerVC.view.transform
        viewController.view.alpha = 0;
        addViewController(viewController: viewController)
        hideViewController(viewController: centerVC)
        centerVC = viewController
        UIView.animate(withDuration: animated ? animationDuration : 0, animations: {
            viewController.view.alpha = 1.0
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     摇动结束
     */
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("摇动结束")
        ///此处设置摇一摇需要实现的功能
        NotificationCenter.default.post(name: NSNotification.Name("shakeEnd"), object: self, userInfo: ["post":"NewTest"])
    }
    /**
     开始摇动
     */
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("开始摇动")
        NotificationCenter.default.post(name: NSNotification.Name("shakeBegin"), object: self, userInfo: ["post":"NewTest"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.applicationSupportsShakeToEdit = true  //允许监听手机摇晃
        UIApplication.shared.isStatusBarHidden = false
        
        //backgroundIMG
        backgroundImgView.frame = view.bounds
        backgroundImgView.contentMode = .scaleAspectFill
        backgroundImgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(backgroundImgView)
        
        //childView
        if let left = leftVC {
            self.addViewController(viewController: left)
            left.view.center = CGPoint(x: self.view.center.x - menu_begin, y: self.view.center.y)
        }
        if let right = rightVC {
            self.addViewController(viewController: right)
            right.view.center = CGPoint(x: self.view.center.x + menu_begin, y: self.view.center.y)
        }
        self.addViewController(viewController: centerVC)
        
        //panGesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandler(gesture:)))
        panGesture.delegate = self
//        view.addGestureRecognizer(panGesture)
    }
    
    @objc func panHandler(gesture: UIPanGestureRecognizer) {
        guard leftVC != nil || rightVC != nil else { return }
        
        let xTranslation = gesture.translation(in: view).x
        distanceFromLeft += xTranslation
        gesture.setTranslation(CGPoint.zero, in: view)
        
        switch gesture.state {
        case .began:
            let startXPoint = gesture.location(in: view).x
            if startXPoint <= enable_edge {
                touchAtLeft = true
            } else {
                touchAtLeft = false
            }
            view.window?.endEditing(true)
        case .changed:
            if let left = leftVC {
                leftCenter = left.view.center
            }
            if let right = rightVC {
                rightCenter = right.view.center
            }
            centerCenter = centerVC.view.center
            
            switch state {
            case .Cener:
                if touchAtLeft && leftVC != nil {
                    movingAroundLeft()
                } else if touchAtLeft == false && rightVC != nil {
                    movingAroundRight()
                }
            case .Left:
                movingAroundLeft()
            case .Right:
                movingAroundRight()
            }
            if let left = leftVC {
                left.view.center = leftCenter
            }
            if let right = rightVC {
                right.view.center = rightCenter
            }
            centerVC.view.center = centerCenter
            
            //中间视图的缩放
            if scaleEnable && ((rightVC != nil && touchAtLeft == false) || (leftVC != nil && touchAtLeft == true)) {
                let localScale = (1 - abs(distanceFromLeft)/max_moveDistance) * (1 - scale) + scale
                centerVC.view.transform = CGAffineTransform(scaleX: localScale, y: localScale)
            }
        case .ended:
            let velocity = gesture.velocity(in: view)
            switch state {
            case .Cener:
                if distanceFromLeft > mini_triggerDistance && velocity.x > 0{
                    showLeftViewController(animated: true)
                } else if distanceFromLeft < -mini_triggerDistance && velocity.x < 0 {
                    showRightViewController(animated: true)
                } else {
                    showCenterViewController(animated: true)
                }
            case .Left:
                if distanceFromLeft < max_moveDistance - mini_triggerDistance && velocity.x < 0 {
                    showCenterViewController(animated: true)
                } else {
                    showLeftViewController(animated: true)
                }
            case .Right:
                if distanceFromLeft > -max_moveDistance + mini_triggerDistance && velocity.x > 0 {
                    showCenterViewController(animated: true)
                } else {
                    showRightViewController(animated: true)
                }
            }
        default:
            return
        }
    }
    
    //MARK: Private method
    private func movingAroundLeft() {
        guard let left = leftVC else { return }
        
        left.view.isHidden = false
        rightVC?.view.isHidden = true
        if distanceFromLeft >= max_moveDistance {
            leftCenter = view.center
            centerCenter.x = view.center.x + max_moveDistance
            distanceFromLeft = max_moveDistance
        } else if distanceFromLeft <= 0 {
            leftCenter.x = -menu_begin
            centerCenter = view.center
            distanceFromLeft = 0
        } else {
            leftCenter.x = view.center.x - menu_begin + abs(distanceFromLeft/max_moveDistance) * menu_begin
            centerCenter.x = view.center.x + distanceFromLeft
        }
    }
    
    private func movingAroundRight() {
        guard let right = rightVC else { return }
        
        right.view.isHidden = false
        leftVC?.view.isHidden = true
        if distanceFromLeft <= -max_moveDistance {
            rightCenter.x = view.center.x
            centerCenter.x = view.center.x - max_moveDistance
            distanceFromLeft = -max_moveDistance
        } else if distanceFromLeft >= 0 {
            rightCenter.x = view.center.x + menu_begin
            centerCenter = view.center
            distanceFromLeft = 0
        } else {
            rightCenter.x = view.center.x + menu_begin + abs(distanceFromLeft/max_moveDistance) * -menu_begin
            centerCenter.x = view.center.x + distanceFromLeft
        }
    }
    
    private func addCenterButton() {
        if centerButton == nil {
            centerButton = UIButton(type: .system)
            centerButton?.backgroundColor = UIColor.clear
            centerButton?.addTarget(self, action: #selector(centerButtonAction), for: .touchUpInside)
            view.addSubview(centerButton!)
        }
        centerButton?.frame = centerVC.view.frame
    }
    @objc func centerButtonAction() {
        showCenterViewController(animated: true)
        if let closure = recoverCenterClosure {
            closure()
            print("kkkkkkkkk")
        }
    }
    
    //MARK: viewController operate
    private func addViewController(viewController: UIViewController) {
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
    private func hideViewController(viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    //MARK: UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if centerVC is UINavigationController {
            let nav = centerVC as! UINavigationController
            if nav.viewControllers.count > 1 { return false }
        }
        
        if gestureRecognizer is UIPanGestureRecognizer {
            let point = touch.location(in: gestureRecognizer.view)
            if state == .Left {
                if point.x >= screen_width - enable_edge {
                    return true
                } else {
                    return false
                }
            } else if state == .Right {
                if point.x <= enable_edge {
                    return true
                } else {
                    return false
                }
            } else {
                if point.x >= enable_edge && point.x <= screen_width - enable_edge {
                    return false
                } else {
                    return true
                }
            }
        }
        return true
    }
    
    func menuEvent(isRight: Bool) {
        //给主界面添加一个半透明黑色蒙版
        if self.opacityBtn != nil{
            self.opacityBtn?.removeFromSuperview()
            self.opacityBtn = nil
        }
        opacityBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        opacityBtn?.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        opacityBtn?.addTarget(self, action: #selector(onOpacityBtnClick), for: .touchUpInside)
        self.centerVC.view.addSubview(opacityBtn!)
        self.centerVC.view.bringSubview(toFront: opacityBtn!)
        if isRight{
            self.showRightViewController(animated:true)
        }else{
            self.showLeftViewController(animated: true)
        }
    }
    
    
    @objc func onOpacityBtnClick(){
//        self.centerButtonAction()
    }
}


extension UIViewController {
    var hzs_sliderController: SlideContainerController? {
        var iter = self.parent
        while iter != nil {
            if iter is SlideContainerController {
                return iter as? SlideContainerController
            } else if iter?.parent != nil && iter?.parent != iter {
                iter = iter?.parent
            } else {
                iter = nil
            }
        }
        return nil
    }
    
    func hzs_sliderControllerShowLeftViewController(animated: Bool) {
        self.hzs_sliderController?.showLeftViewController(animated: animated)
    }
    
    func hzs_sliderControllerShowRightViewController(animated: Bool) {
        self.hzs_sliderController?.showRightViewController(animated: animated)
    }
    
    func hzs_sliderControllerShowCenterViewController(animated: Bool) {
        self.hzs_sliderController?.showCenterViewController(animated: animated)
    }
    
    func hzs_sliderControllerSetCenterRecoverColsure(closure: @escaping () -> Void) {
        self.hzs_sliderController?.recoverCenterClosure = closure
    }
}
