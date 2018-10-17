//
//  SnailSampleViews.swift
//  <https://github.com/snail-z/OverlayController-Swift.git>
//
//  Created by zhanghao on 2017/2/24.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

import UIKit

typealias BackClosureType = (_ anyObj: AnyObject) -> Void   // Closure type definition
typealias ItemClickedClosureType = (_ anyObj: AnyObject, _ index: Int) -> Void

/**
 - Protocol -
 ! SnailFullViewDelegate
 */
protocol SnailFullViewDelegate: class {
    func fullView(whenTapped fullView: SnailFullView)
    func fullView(_ fullView: SnailFullView, didSelectItemAt index: Int)
}

// MARK:- SnailFullView -

class SnailFullView: UIView, UIScrollViewDelegate {

    weak var delegate: SnailFullViewDelegate?

    public var item_size: CGSize = CGSize(width: 85, height: 115)
    public var pageViews: [UIImageView] = []
    public var bannerViews: [BannerView] = []
    public var items: [BannerItem] = [] {
        didSet { setItems(items: items) }
    }
    
    let closeButton = UIButton(), closeIcon = UIButton(), scrollContainer = UIScrollView()
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white
//        let blurVisualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
//        blurVisualEffect.frame = self.frame
//        self.addSubview(blurVisualEffect)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fullTapped(_:))))
        commonInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    /**
     - rowCount: 默认每行显示3个
     - rows:     默认每页显示2行
     - pages:    共2页
     */
    private let rowCount: CGFloat = 3, rows: CGFloat = 3, pages: CGFloat = 1
    private var gap: CGFloat!, space: CGFloat!
    
    //MARK:消失
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        })
    }
    /** 指定视图实现方法 */
    func show() {
        let wind = UIApplication.shared.keyWindow
        self.alpha = 0
        
        wind?.addSubview(self)
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 1
        })
    }
    
    private func commonInitialization() {
        closeButton.backgroundColor = UIColor.white
        closeButton.isUserInteractionEnabled = false
        closeButton.addTarget(self, action: #selector(closeClicked(_:)), for: .touchUpInside)
        self.addSubview(closeButton)
        closeButton.size = CGSize(width: UIScreen.width, height: 44)
        closeButton.bottom = UIScreen.height
        closeIcon.isUserInteractionEnabled = false
        closeIcon.imageView?.contentMode = .scaleAspectFit
        closeIcon.setImage(UIImage(named: "popup_关闭"), for: .normal)
        closeIcon.size = CGSize(width: 30, height: 30)
        closeIcon.center = closeButton.center
        self.addSubview(closeIcon)
        UIView.animate(withDuration: 0.5) {
            self.closeIcon.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
        }
        
        scrollContainer.bounces = false
        scrollContainer.showsHorizontalScrollIndicator = false
        scrollContainer.isPagingEnabled = true
        scrollContainer.delaysContentTouches = true
        scrollContainer.delegate = self
        self.addSubview(scrollContainer)
        
        gap = 15.0
        space = (UIScreen.width - rowCount * item_size.width) / (rowCount + 1)
        scrollContainer.size = CGSize(width: UIScreen.width, height: item_size.height * rows + gap + 70)
        scrollContainer.bottom = UIScreen.height - closeButton.height
        scrollContainer.contentSize = CGSize(width: UIScreen.width * pages, height: scrollContainer.height)
        
        for index in 0..<Int(pages) {
            let pageView = UIImageView()
            pageView.size = scrollContainer.size
            pageView.x = CGFloat(index) * UIScreen.width
            pageView.isUserInteractionEnabled = true
            scrollContainer.addSubview(pageView)
            pageViews.append(pageView)
        }
    }
    
    func setItems(items: Array<BannerItem>) {
        for (index, imageView) in pageViews.enumerated() {
            for i in 0..<Int(rows * rowCount) {
                let l = i % Int(rowCount)
                let v = i / Int(rowCount)
                
                let banner = BannerView()
                banner.isUserInteractionEnabled = true
                banner.tag = i + index * Int(rows * rowCount)
                banner.size = item_size
                banner.x = (item_size.width + space) * CGFloat(l) + space
                banner.y = (item_size.height + gap)  * CGFloat(v) + gap
                banner.backgroundColor = UIColor.clear
                imageView.addSubview(banner)
                bannerViews.append(banner)
                banner.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemSelected(_:))))
                if banner.tag < items.count {
                    banner.item = items[banner.tag]
                    banner.icon.isUserInteractionEnabled = false
                    banner.label.font = UIFont.systemFont(ofSize: 14)
                    banner.label.textColor = UIColor.init(red: 82/255, green: 82/255, blue: 82/255, alpha: 1.0)
                }
            
                // - Animation support -
                banner.alpha = 0
                banner.transform = CGAffineTransform(translationX: 0, y: rows * item_size.height)
                UIView.animate(withDuration: 0.75, delay: TimeInterval(i) * 0.03, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
                    banner.alpha = 1
                    banner.transform = .identity
                }, completion: nil)
            }
        }
    }
    
    /// - Actions ☟ -
    
    func itemSelected(_ sender: UITapGestureRecognizer) {
        shakeAnimate(duration: 0.35, aView: sender.view!, animationValues: [
            NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(1.5, 1.5, 1.0)),
            NSValue(caTransform3D: CATransform3DIdentity)
        ])
        
        //点击最后一个按钮时是滑入第二页
//        if Int(rows * rowCount - 1) == sender.view!.tag {
//            scrollContainer.setContentOffset(CGPoint(x: UIScreen.width, y: 0), animated: true)
//        } else {
            delegate?.fullView(self, didSelectItemAt: sender.view!.tag)
            self.dismiss()
//        }
    }
    
    func closeClicked(_ sender: UIButton) {
        scrollContainer.setContentOffset(.zero, animated: true)
    }
    
    func fullTapped(_ sender: UITapGestureRecognizer) {
        fallAnimate { (finished: Bool) in
            self.dismiss()
            self.delegate?.fullView(whenTapped: sender.view as! SnailFullView)
        }
    }
    
    // - Animation support ☟ -
    
    func shakeAnimate(duration: CFTimeInterval, aView: UIView, animationValues: Array<NSValue>) {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        keyframeAnimation.duration = duration
        keyframeAnimation.values = animationValues
        aView.layer.add(keyframeAnimation, forKey: nil)
    }
    
    func fallAnimate(completions: ((Bool) -> Swift.Void)? = nil) {
        if !closeButton.isUserInteractionEnabled {
            UIView.animate(withDuration: 0.25) {
                self.closeIcon.transform = .identity
            }
        }
        for (index, banner) in bannerViews.enumerated() {
            UIView.animate(withDuration: 0.25, delay: 0.025 * Double(bannerViews.count - index), options: UIViewAnimationOptions.curveEaseOut, animations: {
                banner.alpha = 0
                banner.transform = CGAffineTransform(translationX: 0, y: self.rows * self.item_size.height)
            }, completion: { (finished: Bool) in
                if index == self.bannerViews.count - 1 { completions!(finished) }
            })
        }
    }
    
    /// - UIScrollViewDelegate -
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index: Int = Int(scrollView.contentOffset.x / kScreenWidth + 0.5)
        closeButton.isUserInteractionEnabled = index > 0
        self.closeIcon.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        self.closeIcon.setImage(UIImage(named: index > 0 ? "popup_返回" : "popup_关闭"), for: .normal)
    }
}
