//
//  HideViewController.m
//  HideDemoOC
//
//  Created by hello on 2019/5/14.
//  Copyright © 2019 Dio. All rights reserved.
//

#import "HideViewController.h"
#import "CAButton.h"
#import "YCMenuView.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "UIColor+Hex.h"
#import <Masonry.h>

#define LL_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

@interface HideViewController ()<UIWebViewDelegate>

@property (nonatomic ,retain) CAButton *btn;
@property (nonatomic, strong) NSMutableArray *menuList;
@property (nonatomic ,strong)UIWebView *myweb;

@end

@implementation HideViewController

#pragma mark -- web界面 暂时先不用WKWebView
-(UIWebView *)webView {
    if (!_myweb) {
        _myweb=[[UIWebView alloc]init];
        _myweb.delegate=self;
        _myweb.scrollView.showsVerticalScrollIndicator=NO;
        _myweb.scrollView.showsHorizontalScrollIndicator=NO;
        NSString *urlString = self.model.homeUrl;
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        [_myweb loadRequest:[NSURLRequest requestWithURL:url]];
    }
    return _myweb;
}

#pragma mark-- 监听横竖屏
- (void)changeRotate:(NSNotification*)noti {
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait
        || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
        //竖屏
        [self setUI:YES];
    } else {
        //横屏
        [self setUI:NO];
    }
}
-(void)setUI:(BOOL)isbool{
    if (isbool) {
        [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(30, 0, 0, 0));
        }];
        [self.webView reload];
    }else{
        
        [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        [self.webView reload];
    }
}
//初始化界面
-(void)initUI{
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        //iPhone X以上机型留出安全区 固定头部30 底部20
        if (LL_iPhoneX) {
            if ([self.model.headHidden isEqualToString:@"1"]) {
                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 20, 0));
            }else{
                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(30, 0, 20, 0));
            }
        }else{
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }
    }];
    self.view.backgroundColor=[UIColor colorWithHexString:self.model.footColor];
    [self setStatusBarBackgroundColor:[UIColor colorWithHexString:self.model.headColor]];
    [self.view addSubview:self.btn];
    [ self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@60);
        make.left.equalTo(self.view.mas_left).offset(60);
        make.top.equalTo(self.view.mas_top).offset(60);
    }];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    /**
     js交互代码
     context 是与后台约定好的方法名，不要修改
     */
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"context"] = ^(){
        NSArray * args = [JSContext currentArguments];//传过来的参数
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",args[0]]]] ) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",args[0]]] ];
            }
        });
    };
}

-(BOOL)prefersStatusBarHidden{
    NSString *isOr = self.model.headHidden;
    if ([isOr isEqualToString:@"1"]) {
        return  YES;
    }else{
        return NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    //设置悬浮按钮位置
    [self.view addSubview:self.btn];
    [ self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@60);
        make.left.equalTo(self.view.mas_left).offset(60);
        make.top.equalTo(self.view.mas_top).offset(60);
    }];
    
    //获取展开列表
    [self getMemuListFromBackend];
    
    //背景颜色
    self.view.backgroundColor = [UIColor colorWithHexString:self.model.footColor];
    //取后后传过来的颜色,并显示在屏幕上
    [self setStatusBarBackgroundColor:[UIColor colorWithHexString:self.model.headColor]];
}

//刘海颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


-(void)getMemuListFromBackend {
    self.menuList = [NSMutableArray array];
    NSString *listStr = self.model.functionArr;
    NSArray *list = [listStr componentsSeparatedByString:@","];
    for (NSString *title in list) {
        UIImage *image = [UIImage imageNamed:title];
        YCMenuAction *action = [YCMenuAction actionWithTitle:title image:image handler:^(YCMenuAction *action) {
            NSLog(@"点击了%@",action.title);
            [self handleWeb:action.title];
        }];
        [self.menuList addObject:action];
    }
}

#pragma 加悬浮按钮
-(CAButton *)btn {
    if (!_btn) {
        _btn=[[CAButton alloc]init];
        [_btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
        _btn.layer.cornerRadius=30;
        _btn.clipsToBounds=YES;
        [ _btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
//点击按钮触发的方法
- (void)buttonAction:(UIButton *)sender {
    NSLog(@"touch btn");
    YCMenuView *view = [YCMenuView menuWithActions:self.menuList width:140 relyonView:self.btn];
    view.maxDisplayCount = 10;
    view.alpha = 0.7;
    [view show];
}

-(void)handleWeb:(NSString *)title {
    if ([title isEqualToString:@"首页"]) {
        NSURL *url = [NSURL URLWithString:self.model.homeUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.myweb loadRequest:request];
    }else if ([title isEqualToString:@"刷新"]){
        [self.myweb reload];
    }else if ([title isEqualToString:@"返回"]){
        if (self.myweb.canGoBack == YES) {
            [self.myweb goBack];
        }
    }else if ([title isEqualToString:@"浏览器打开"]){
        NSURL *url = [NSURL URLWithString:self.model.openSafariUrl];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否使用外部浏览器打开？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [UIApplication.sharedApplication openURL:url];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"不用" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [self.myweb loadRequest:request];
        }];
        
        [alertController addAction:defaultAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if ([title isEqualToString:@"优惠活动"]){
        NSURL *url = [NSURL URLWithString:self.model.activityUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.myweb loadRequest:request];
    }
}

@end
