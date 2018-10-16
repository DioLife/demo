//
//  WebviewListTitleCell.swift
//  gameplay
//
//  Created by admin on 2018/8/16.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit
import WebKit

//protocol WebviewListTitleCellDelegate {
//    func cellHeightForWebView(sectionIndex: Int,height: CGFloat)
//}

class WebviewListTitleCell: UITableViewCell {
    
//    var delegate: WebviewListTitleCellDelegate?
    private let leftIcon = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let accessoryImage = UIImageView()
    private var customView = WKWebView()
    private var sectionIndex = 0

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    func configSection(sectionNum: Int = 0) {
        self.sectionIndex = sectionNum
    }
    
    func configDateString(dateStamp: Int64) {
        dateLabel.text = timeStampToString(timeStamp: dateStamp, format: "yyyy-MM-dd")
    }
    
    func configCell(leftIconP: String = "", iconThemeColor: String = "",titleContentsP: String = "") {
        
        titleLabel.text = titleContentsP
        
        if !isEmptyString(str: iconThemeColor) {
            leftIcon.theme_backgroundColor = ThemeColorPicker.init(keyPath: iconThemeColor)
        }else {
            leftIcon.backgroundColor = .clear
        }
        
        hideWebView(hide: true)
    }
    
    func configWebCell(constants: String = "") {
        
        if !isEmptyString(str: constants) {
            customView.navigationDelegate = self
            customView.sizeThatFits(CGSize.zero)
            
            let webContents = constants + "<meta name=" + "\"viewport\"" + " " + "content=\"width=device-width," + " " + "initial-scale=1.0," + " " + "shrink-to-fit=no\">"
            
            customView.loadHTMLString(webContents, baseURL: URL.init(string: BASE_URL))
        }else {
        }
        hideWebView(hide: false)
    }
    
    private func hideWebView(hide: Bool) {
        customView.isHidden = hide
        leftIcon.isHidden = !hide
        titleLabel.isHidden = !hide
        dateLabel.isHidden = !hide
        accessoryImage.isHidden = true
    }
        
    private func setupUI() {
        addSubview(leftIcon)
        addSubview(titleLabel)
        addSubview(customView)
        addSubview(dateLabel)
        addSubview(accessoryImage)
        
        customView.scrollView.zoomScale = 1.5
        
        customView.isHidden = true
        leftIcon.isHidden = true
        titleLabel.isHidden = true
        dateLabel.isHidden = true
        accessoryImage.isHidden = true
        
        leftIcon.whc_CenterY(0).whc_Left(8).whc_Width(20).whc_Height(20)
        accessoryImage.contentMode = .scaleAspectFill
        accessoryImage.whc_Right(5).whc_CenterY(0,toView:leftIcon).whc_Width(20).whc_Height(25)
        dateLabel.whc_CenterY(0,toView:titleLabel).whc_Right(5,toView:accessoryImage).whc_Width(80)
        titleLabel.whc_Top(0).whc_Left(8,toView:leftIcon).whc_Bottom(0).whc_Height(44).whc_GreaterOrEqual().whc_Right(5,toView:dateLabel)
        customView.whc_Top(0).whc_Left(8).whc_Bottom(0).whc_Right(8)
        
        leftIcon.layer.cornerRadius = 10
        leftIcon.layer.masksToBounds = true
        
        leftIcon.contentMode = .scaleAspectFill
        titleLabel.textColor = UIColor.darkText
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        titleLabel.numberOfLines = 2
        
        dateLabel.textColor = UIColor.darkGray
        dateLabel.textAlignment = .right
        dateLabel.font = UIFont.systemFont(ofSize: 13.0)
        
        accessoryImage.image = UIImage(named: "more")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.leftIcon.theme_backgroundColor = ThemeColorPicker.init(keyPath: "Global.themeColor")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.leftIcon.theme_backgroundColor = ThemeColorPicker.init(keyPath: "Global.themeColor")
    }
}


extension WebviewListTitleCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        
            if let archiveHeight = webViewHeightDic["\(self.sectionIndex)"] {
                print("已缓存过该高度：\(archiveHeight)")
            }else {
                //        customView.scrollView.zoomScale = 3.0
                webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
                    if complete != nil {   //scrollHeight 657  //offsetHeight 681 // clientHeight  681  //availHeight 不可用
                        //                webView.evaluateJavaScript("document.body.offsetHeight", completionHandler: { (height, error) in
                        //                document.documentElement.clientHeight  // 681
                        webView.evaluateJavaScript("document.documentElement.offsetHeight", completionHandler: { (height, error) in
                            if let webViewHeight = height as? CGFloat{
                                print("网页视图的高度: \(webViewHeight)")
                                self.customView.whc_Top(0).whc_Left(8).whc_Bottom(0).whc_Right(8).whc_Height(webViewHeight)
                                self.layoutSubviews()
                                webViewHeightDic["\(self.sectionIndex)"] = webViewHeight
                                print("所有字典打印高度: \(webViewHeightDic)")
                                
                                NotificationCenter.default.post(name: NSNotification.Name("webViewListHeightChanged"), object: [self.sectionIndex])
                            }
                        })
                    }
                    
                })

        }
        
    }
}

