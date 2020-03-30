//
//  APServiceBusinessClass.h
//  MobileClassPhone
//  推送业务处理
//  Created by Eggache_Yang on 17-16-10.
//  Copyright (c) 2017年 Eggache_Yang. All rights reserved.
//


/*
 
 
 必要的框架
 CFNetwork.framework
 CoreFoundation.framework
 CoreTelephony.framework
 SystemConfiguration.framework
 CoreGraphics.framework
 Foundation.framework
 UIKit.framework
 Security.framework
 libz.dylib
 
 
 */

#import <Foundation/Foundation.h>

// 可以直接使用  JPush  使用该类的方法
#define JPush       [LYPushBusinessClass sharedManager]

//处理消息的block
typedef void (^ProcessingPushMsgBlock)(NSDictionary *dict);

@interface LYPushBusinessClass : NSObject

/**
 *  单例
 *
 *  @return 当前类的实例
 */
+ (instancetype)sharedManager;

/**
 *  注册APNS类型
 *  在方法application:didFinishLaunchingWithOptions中调用
 *
 *  @param launchOptions    didFinishLaunchingWithOptions所带参数
 *  @param appkey           一个JPush 应用必须的,唯一的标识. 请参考 JPush 相关说明文档来获取这个标识.
 *  @param isProduction     是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
 *  @param block            客户端需要自己处理消息时的block，接收一个NSDictionary对象，不处理则传nil
 */
- (void)registerForRemoteNotificationTypes:(NSDictionary *)launchOptions
                                    appkey:(NSString *)appkey
                          apsForProduction:(BOOL)isProduction
                             ProcessingMsg:(ProcessingPushMsgBlock)block;

/**
 *  注册deviceToken并绑定registrationID
 *  在方法application:didRegisterForRemoteNotificationsWithDeviceToken:中调用
 *
 *  @param deviceToken  didRegisterForRemoteNotificationsWithDeviceToken所带参数
 */
- (void)registerDeviceToken:(NSData *)deviceToken;

/*
 *  向服务器提交绑定registrationID
 */
- (void)setRegistrationID;
/*
 *  取消registrationID绑定
 */
- (void)cancelRegistrationID:(dispatch_block_t)finishBlock;

/**
 *  从推送消息入口进入，进行相应处理
 *  一般在方法application:didReceiveRemoteNotification:中调用
 *
 *  @param pushDic  didReceiveRemoteNotification所带参数
 *  @param block 客户端需要自己处理消息时的block，接收一个NSDictionary对象，不处理则传nil
 */
- (void)processingPushMessage:(NSDictionary *)pushDic
                ProcessingMsg:(ProcessingPushMsgBlock)block
                    showAlert:(BOOL)showAlert;

/**
 *  无论已何种方式启动程序，都需清除推送服务器对badge值的设定，以免后台自动累加造成计数不准确
 *  一般只需在applicationWillEnterForeground:方法中调用，其他地方做了相应处理
 */
- (void)cleanJPushBadge;

@end
