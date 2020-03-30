//
//  DLOtherPayController.h
//  Pods
//
//  Created by LY on 16/11/8.
//
//

#import <Foundation/Foundation.h>

/*
    ！注意：
        1、配置公共参数：
            如果需要底层获取支付签名，需要配置公共参数；
            否则只需配置 aliPayAppScheme、wxAppID、unionPayAppScheme等。
        2、配置URL Types
        3、配置LSApplicationQueriesSchemes白名单
        4、调用支付API即可，界面loading底层已写好；若支付成功、失败个性化处理在回调block写。
 */

typedef void (^DLOtherPayCompleteBlock) (void);

@interface DLOtherPayController : NSObject

/**
 *  单例
 */
+ (DLOtherPayController *)sharedInstance;

/**
 *  配置公共参数
 *
 *  @param aliPayAppScheme   支付宝在info.plist注册的urlTypeScheme值
 *  @param wxAppID           微信key 如:wx6dd347df63deb7c1
 *  @param unionPayAppScheme 银联在info.plist注册的urlTypeScheme值
 */
- (void)configWithAliPayAliPayAppScheme:(NSString *)aliPayAppScheme
                                wxAppID:(NSString *)wxAppID
                      unionPayAppScheme:(NSString *)unionPayAppScheme;

/*------------------ 支付宝 -------------------*/

/**
 *  支付宝支付
 *
 *  @param orderString     支付宝签名
 *  @param paySuccessBlock 支付成功的回调
 *  @param payFailedBlock  支付失败的回调
 */
- (void)startAliPayWithOrderString:(NSString *)orderString
                        paySuccess:(DLOtherPayCompleteBlock)paySuccessBlock
                         payFailed:(DLOtherPayCompleteBlock)payFailedBlock;

/**
 *  是否从支付宝打开应用
 *
 *  @param url 接收到的url
 *
 *  @return bool
 */
- (BOOL)isUrlFromAliPay:(NSURL *)url;

/**
 *  设置支付宝支付结果回调
 *
 *  @param url 接收到的url
 *
 *  @return YES
 */
- (BOOL)processUrlFromAliPay:(NSURL *)url;

/*------------------ 微信支付 -------------------*/

/**
 *  微信支付
 *
 *  @param appID           微信appID
 *  @param partnerID       partnerID
 *  @param prepayID        prepayID
 *  @param nonceStr        nonceStr
 *  @param timeStamp       timeStamp
 *  @param package         package
 *  @param sign            sign
 *  @param isAppAgree      isAppAgree
 *  @param paySuccessBlock 支付成功回调
 *  @param payFailedBlock  支付失败回调
 */
- (void)startWXPayWithAppid:(NSString *)appID
                  partnerID:(NSString *)partnerID
                   prepayID:(NSString *)prepayID
                   nonceStr:(NSString *)nonceStr
                  timeStamp:(int)timeStamp
                    package:(NSString *)package
                       sign:(NSString *)sign
                 isAppAgree:(BOOL)isAppAgree
                 paySuccess:(DLOtherPayCompleteBlock)paySuccessBlock
                  payFailed:(DLOtherPayCompleteBlock)payFailedBlock;

/**
 *  是否从微信打开应用
 *
 *  @param url 接收到的url
 *
 *  @return bool
 */
- (BOOL)isUrlFromWXPay:(NSURL *)url;

/**
 *  设置微信支付结果回调
 *
 *  @param url 接收到的url
 *
 *  @return bool
 */
- (BOOL)processUrlFromWXPay:(NSURL *)url;

/*------------------ 银联 -------------------*/

/**
 *  银联支付
 *
 *  @param tranNum        交易流水号
 *  @param viewController 当前viewController
 *  @param successBlock   支付成功的回调
 *  @param failedBlock    支付失败的回调
 */
- (void)startUnionSDKPayWithTranNumber:(NSString *)tranNum
                        viewController:(UIViewController *)viewController
                            paySuccess:(DLOtherPayCompleteBlock)successBlock
                             payFailed:(DLOtherPayCompleteBlock)failedBlock;

/**
 *  判断URL是否来自于银联支付
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isUrlFromUnionPay:(NSURL *)url;

/**
 *  处理银联支付结果
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)dealUnionPayResultWithUrl:(NSURL *)url;

@end
