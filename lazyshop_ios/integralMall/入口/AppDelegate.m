//
//  AppDelegate.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AppDelegate.h"

#import "RootViewController.h"

// UI
#import <DLUIKit/DLLoadingSetting.h>
// 分享
#import <DLShareSDK/DLShareController.h>
// 支付
#import <DLIAPService/DLOtherPayController.h>
// 数据统计
#import "ThirdStatisticsHelper.h"
// 推送
#import "LYPushBusinessClass.h"
// 版本更新
#import "CheckUpdateManager.h"

@interface AppDelegate ()

@property (strong, nonatomic)UINavigationController *pushNavigationController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 基础设置
    [self baseSetting];
    // 分享设置
    [self shareSetting];
    // 统计设置
    [self dataStatisticsSetting];
    // 支付设置
    [self paySetting];
    // 推送设置
    [self pushSetting:launchOptions];
    
    // 创建window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    RootViewController *rootVC = [RootViewController new];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.pushNavigationController = rootNav;
    rootNav.navigationBar.hidden = YES;
    self.window.rootViewController = rootNav;
    [self.window makeKeyAndVisible];
    
    // 状态栏
    application.statusBarHidden = NO;
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}

#pragma mark -基础设置
- (void)baseSetting
{
    // 网络状态监测
    [[NetStatusHelper sharedInstance] startNotifier];
    [[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNetStatusHelperChangedNotification
                                                             object:nil]
       takeUntil:self.rac_willDeallocSignal]
      filter:^BOOL(id value) {
          return ([NetStatusHelper sharedInstance].netStatus != NoneNet);
      }]subscribeNext:^(id x) {
          [[[LYAppCheckManager shareInstance] checkIsAppAgree] subscribeNext:^(id x) {
              CLog(@"网络状态变化,重新获取审核状态成功");
          } error:^(NSError *error) {
              CLog(@"网络状态变化,重新获取审核状态失败:%@",error);
          }];
      }];

    // 设置加载框属性
    [DLLoadingSetting sharedInstance].loadingColor = [CommUtls colorWithHexString:APP_MainColor];
    [DLLoadingSetting sharedInstance].autoTableShowTime = YES;
}

#pragma mark -分享设置
- (void)shareSetting
{
    [[DLShareController shareInstance] registerShareSDKWithQQAppKey:nil
                                                       previewImage:[UIImage imageNamed:@"180"]
                                                            htmlStr:nil
                                                           titleStr:@"懒店"
                                                          detailStr:@"轻松购物"];
    [DLShareController shareInstance].WXAppKey = WX_APP_ID;
}

#pragma mark -支付设置
- (void)paySetting
{
    [[DLOtherPayController sharedInstance] configWithAliPayAliPayAppScheme:ALI_PAY_SCHEME
                                                                   wxAppID:WX_APP_ID
                                                         unionPayAppScheme:UNION_PAY_SCHEME];
}

#pragma mark -数据统计
- (void)dataStatisticsSetting
{
    // 友盟统计
    [ThirdStatisticsHelper setAppversion];
    [ThirdStatisticsHelper startWithAppkey:UMENG_KEY];
}

#pragma mark -推送

// 推送设置
- (void)pushSetting:(NSDictionary *)launchOptions
{
#if !TARGET_IPHONE_SIMULATOR
    BOOL isProduction = NO;
#ifndef DEBUG
    isProduction = YES;
#endif
    // 注册推送
    [JPush registerForRemoteNotificationTypes:launchOptions
                                       appkey:J_PUSH_KEY
                             apsForProduction:isProduction
                                ProcessingMsg:nil];
#endif
}

// 程序已启动，点击推送进入应用调用此方法
// 程序在运行，推送过来直接调用此方法
// 如果 App状态为正在前台或者后台运行，那么此函数将被调用，并且可通过AppDelegate的applicationState是否为UIApplicationStateActive判断程序是否在前台运行。此种情况在此函数中处理：
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    CLog(@"didReceiveRemoteNotification");
    BOOL showAlert = (application.applicationState == UIApplicationStateActive?YES:NO);
    [JPush processingPushMessage:userInfo
                   ProcessingMsg:nil
                       showAlert:showAlert];
}

// 注册推送错误
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    CLog(@"apns -> 注册推送功能时发生错误， 错误信息:\n %@", err);
}

// 注册推送成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPush registerDeviceToken:deviceToken];
}

#pragma mark -打开应用
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self commonOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self commonOpenURL:url];
}
// iOS9以上调用
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [self commonOpenURL:url];
}

// openUrl
- (BOOL)commonOpenURL:(NSURL *)url
{
    if([[DLOtherPayController sharedInstance] isUrlFromWXPay:url]){
        // 微信支付
        return [[DLOtherPayController sharedInstance] processUrlFromWXPay:url];
    }else if([[DLOtherPayController sharedInstance] isUrlFromAliPay:url]){
        // 支付宝支付
        return [[DLOtherPayController sharedInstance] processUrlFromAliPay:url];
    }else if ([[DLOtherPayController sharedInstance] isUrlFromUnionPay:url]){
        // 银联支付
        return [[DLOtherPayController sharedInstance] dealUnionPayResultWithUrl:url];
    }else{
        // 分享
        return [[DLShareController shareInstance] applicationOpenURL:url];
    }
}

// 刷新token
- (void)refreshToken {
    if ([AccountService shareInstance].isLogin) {
        [[[AccountService shareInstance] refreshToken] subscribeNext:^(id x) {
            CLog(@"刷新token成功");
        } error:^(NSError *error) {
            if ([AccountService shareInstance].isLogin) {
                [[AccountService shareInstance] logOut:^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                    message:@"登录信息已过期"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"重新登录", nil];
                    [alert show];
                    [alert.rac_buttonClickedSignal subscribeNext:^(id x) {
                        if ([x integerValue] == 1) {
                            [PublicEventManager judgeLoginToPushWithNavigationController:nil
                                                                               pushBlock:nil];
                        }
                    }];
                }];
            }
        }];
    }
}

#pragma mark -应用状态

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

// 程序即将进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // 刷新token

    // 检测版本更新
    [[CheckUpdateManager shareInstance] checkAppUpdateWithNoUpdate:nil
                                                           loading:NO];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
