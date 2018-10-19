//
//  AppDelegate.m
//  TabBarController
//
//  Created by William on 2018/10/16.
//  Copyright © 2018年 William. All rights reserved.
//

#import "AppDelegate.h"
#import "OneViewController.h"
#import "MyNavgationController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "MyTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//https://www.cnblogs.com/jukaiit/p/5066468.html
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self create];
    [self createViewControllers];
    
    return YES;
}

// 创建分栏控制器管理的子视图控制器
- (void)createViewControllers {
    OneViewController *oneVC = [[OneViewController alloc] init];
    oneVC.title = @"oneVC";
    oneVC.tabBarItem.image = [UIImage imageNamed:@"home"];
    oneVC.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected@"];
    MyNavgationController *navCtrl1 = [[MyNavgationController alloc] initWithRootViewController:oneVC];
    //    navCtrl1.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
    
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    twoVC.title = @"twoVC";
    twoVC.tabBarItem.image = [UIImage imageNamed:@"message"];
    twoVC.tabBarItem.selectedImage = [UIImage imageNamed:@"message_selected"];
    UINavigationController *navCtrl2 = [[UINavigationController alloc] initWithRootViewController:twoVC];
    
    ThreeViewController *threeVC = [[ThreeViewController alloc] init];
    threeVC.title = @"threeVC";
    threeVC.tabBarItem.image = [UIImage imageNamed:@"profile"];
    threeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"profile_selected"];
    UINavigationController *navCtrl3 = [[UINavigationController alloc] initWithRootViewController:threeVC];
    
    FourViewController *fourVC = [[FourViewController alloc] init];
    fourVC.title = @"fourVC";
    fourVC.tabBarItem.image = [UIImage imageNamed:@"search"];
    fourVC.tabBarItem.selectedImage = [UIImage imageNamed:@"search_selected"];
    UINavigationController *navCtrl4 = [[UINavigationController alloc] initWithRootViewController:fourVC];
    
//    FiveViewController *fiveVC = [[FiveViewController alloc] init];
//    UINavigationController *navCtrl5 = [[UINavigationController alloc] initWithRootViewController:fiveVC];
//
//    SixViewController *sixVC = [[SixViewController alloc] init];
//    UINavigationController *navCtrl6 = [[UINavigationController alloc] initWithRootViewController:sixVC];
    
    
    MyTabBarController *tabBarCtrl = [[MyTabBarController alloc] init];
    tabBarCtrl.view.backgroundColor = [UIColor cyanColor];
    // 分栏控制器管理的视图控制器的tabBarController属性，自动指向分栏控制器。
    // 当分栏控制器管理的视图控制器的个数超过五个时，会自动创建一个more的导航控制器，并且自动将第五个以及以后的视图控制器添加到more导航控制器中。
    tabBarCtrl.viewControllers = @[navCtrl1, navCtrl2, navCtrl3, navCtrl4];//, navCtrl5, navCtrl6];
    
    // 取到分栏控制器的分栏
    UITabBar *tabBar = tabBarCtrl.tabBar;
    // 设置分栏的风格
    tabBar.barStyle = UIBarStyleBlack;
    // 是否透明
    tabBar.translucent = NO;
    // 设置分栏的前景颜色
    tabBar.barTintColor = [UIColor brownColor];
    // 设置分栏元素项的颜色
    tabBar.tintColor = [UIColor purpleColor];
//    // 设置分栏按钮的选中指定图片
//    tabBar.selectionIndicatorImage = [UIImage imageNamed:@"search"];
    
    self.window.rootViewController = tabBarCtrl;
}

-(void)create {
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    vc1.title = @"VC1";
    
    // 视图控制器的分栏按钮
    // 视图控制器的分栏按钮，如果没有被显示创建，并且被使用了，则会自动根据视图控制器的title来创建
    //vc1.tabBarItem;
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor yellowColor];
    vc2.title = @"VC2";
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor blueColor];
    vc3.title = @"VC3";
    
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor greenColor];
    vc4.title = @"VC4";
    
    // 创建分栏(标签栏)控制器, 和导航控制器一样，都是用来管理视图控制器的容器类型的控制器。
    // 分栏控制器和导航控制器一样，也是通过viewControllers来管理其子视图控制器
    UITabBarController *tabBarCtrl = [[UITabBarController alloc] init];
    
    tabBarCtrl.view.backgroundColor = [UIColor cyanColor];
    
    // 把数据中得视图器交给分栏控制器管理
    // 分栏控制器会自动将其管理的视图控制器的分栏按钮(UITabBarItem)放到分栏上显示
    tabBarCtrl.viewControllers = @[vc1, vc2, vc3, vc4];
    
    // 设置窗口的根视图控制器为分栏控制器
    self.window.rootViewController = tabBarCtrl;
    
    // 取到分栏控制器的分栏
    UITabBar *tabBar = tabBarCtrl.tabBar;
    
    // 设置分栏的风格
    tabBar.barStyle = UIBarStyleBlack;
    
    // 是否透明
    tabBar.translucent = NO;
    
    // 设置分栏的前景颜色
    tabBar.barTintColor = [UIColor brownColor];
    
    // 设置分栏元素项的颜色
    tabBar.tintColor = [UIColor purpleColor];
    
    // 设置分栏按钮的选中指定图片
    tabBar.selectionIndicatorImage = [UIImage imageNamed:@"search"];
    
    [self.window makeKeyAndVisible];
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
