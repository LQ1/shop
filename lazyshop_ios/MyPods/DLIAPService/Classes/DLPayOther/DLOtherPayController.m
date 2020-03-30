//
//  DLOtherPayController.m
//  Pods
//
//  Created by LY on 16/11/8.
//
//

#import "DLOtherPayController.h"

#import <JSONKit-NoWarning/JSONKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import <WeXSDK/WXApi.h>
//#import "WxApi.h"
#import "UPPaymentControl.h"

#import <DLUIKit/DLLoading.h>

#import "DLPaymentMacro.h"

@interface DLOtherPayController ()<WXApiDelegate>

// 支付宝
@property (nonatomic,copy  ) NSString                *aliPayAppScheme;
@property (nonatomic,copy  ) NSString                *aliSDKVersion;
@property (nonatomic,copy  ) DLOtherPayCompleteBlock aliPaySuccessBlock;
@property (nonatomic,copy  ) DLOtherPayCompleteBlock aliPayFailedBlock;
// 微信
@property (nonatomic,copy  ) NSString                *wxAppID;
@property (nonatomic,copy  ) DLOtherPayCompleteBlock wxPaySuccessBlock;
@property (nonatomic,copy  ) DLOtherPayCompleteBlock wxPayFailedBlock;
// 银联
@property (nonatomic,copy  ) NSString                *unionPayAppScheme;
@property (nonatomic,copy  ) DLOtherPayCompleteBlock unionPaySuccessBlock;
@property (nonatomic,copy  ) DLOtherPayCompleteBlock unionPayFailedBlock;

@end

@implementation DLOtherPayController

#pragma mark - 单例

static DLOtherPayController *otherPayInstance = nil;

+ (DLOtherPayController *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        otherPayInstance                  = [[super allocWithZone:NULL] init];
    });
    
    return otherPayInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [DLOtherPayController sharedInstance];
}

+ (id)copy
{
    return [DLOtherPayController sharedInstance];
}

#pragma mark -配置参数
- (void)configWithAliPayAliPayAppScheme:(NSString *)aliPayAppScheme
                                wxAppID:(NSString *)wxAppID
                      unionPayAppScheme:(NSString *)unionPayAppScheme
{
    // 支付宝
    self.aliPayAppScheme   = aliPayAppScheme;
    self.aliSDKVersion     = AliPaySDKVersion;
    // 微信
    self.wxAppID           = wxAppID;
    if (wxAppID.length) {
        [WXApi registerApp:wxAppID];
    }
    // 银联
    self.unionPayAppScheme = unionPayAppScheme;
}

#pragma mark -支付宝
// 支付宝支付
- (void)startAliPayWithOrderString:(NSString *)orderString
                        paySuccess:(DLOtherPayCompleteBlock)paySuccessBlock
                         payFailed:(DLOtherPayCompleteBlock)payFailedBlock
{
    self.aliPaySuccessBlock = paySuccessBlock;
    self.aliPayFailedBlock = payFailedBlock;
    [self startAliPayWithOrderString:orderString];
}
// 调用支付宝SDK支付
- (void)startAliPayWithOrderString:(NSString *)orderString
{
    @weakify(self);
    // 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:self.aliPayAppScheme callback:^(NSDictionary *resultDic) {
        @strongify(self);
        // !处理网页支付结果
        [self processPayResult:resultDic];
    }];
}

// 是否从支付宝打开应用
- (BOOL)isUrlFromAliPay:(NSURL *)url
{
    if ([url.host isEqualToString:@"safepay"]) {
        return YES;
    }
    return NO;
}

// 处理支付宝钱包支付结果
- (BOOL)processUrlFromAliPay:(NSURL *)url
{
    @weakify(self);
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        @strongify(self);
        // !处理支付宝钱包支付结果
        [self processPayResult:resultDic];
    }];
    return YES;
}
// 处理支付宝支付结果
- (void)processPayResult:(NSDictionary *)resultDict
{
    NSString *resultStatus = resultDict[@"resultStatus"];
    if ([resultStatus isEqualToString:@"9000"]){
        [DLLoading DLToolTipInWindow:@"支付成功"];
        if (self.aliPaySuccessBlock) {
            self.aliPaySuccessBlock();
        }
    }else if([resultStatus isEqualToString:@"6001"]){
        [DLLoading DLToolTipInWindow:@"已取消支付!"];
        if (self.aliPayFailedBlock) {
            self.aliPayFailedBlock();
        }
    }else{
        [DLLoading DLToolTipInWindow:@"支付失败!"];
        if (self.aliPayFailedBlock) {
            self.aliPayFailedBlock();
        }
    }
}

#pragma mark -微信

// 微信支付
- (void)startWXPayWithAppid:(NSString *)appID
                  partnerID:(NSString *)partnerID
                   prepayID:(NSString *)prepayID
                   nonceStr:(NSString *)nonceStr
                  timeStamp:(int)timeStamp
                    package:(NSString *)package
                       sign:(NSString *)sign
                 isAppAgree:(BOOL)isAppAgree
                 paySuccess:(DLOtherPayCompleteBlock)paySuccessBlock
                  payFailed:(DLOtherPayCompleteBlock)payFailedBlock
{
    self.wxPaySuccessBlock = paySuccessBlock;
    self.wxPayFailedBlock = payFailedBlock;
    [self startWXPayWithAppid:appID
                    partnerID:partnerID
                     prepayID:prepayID
                     nonceStr:nonceStr
                    timeStamp:timeStamp
                      package:package
                         sign:sign
                   isAppAgree:isAppAgree];
}
// 调起微信SDK支付(新)
- (void)startWXPayWithAppid:(NSString *)appID
                  partnerID:(NSString *)partnerID
                   prepayID:(NSString *)prepayID
                   nonceStr:(NSString *)nonceStr
                  timeStamp:(int)timeStamp
                    package:(NSString *)package
                       sign:(NSString *)sign
                 isAppAgree:(BOOL)isAppAgree

{
    if (![WXApi isWXAppInstalled]) {
        if (isAppAgree) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"请安装微信客户端"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alert.rac_buttonClickedSignal subscribeNext:^(id x) {
                if ([x integerValue] == 0) {
                    // 去下载微信
                    NSString *downLoadUrl = [WXApi getWXAppInstallUrl];
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:downLoadUrl]];
                }
            }];
            [alert show];
        }else{
            [DLLoading DLToolTipInWindow:@"未安装微信客户端"];
        }
        return;
    }
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = partnerID;
    req.prepayId            = prepayID;
    req.nonceStr            = nonceStr;
    req.timeStamp           = timeStamp;
    req.package             = package;
    req.sign = sign;
    
    [WXApi sendReq:req];
}

// 是否从微信支付打开应用
- (BOOL)isUrlFromWXPay:(NSURL *)url
{
    if ([[url absoluteString] hasPrefix:[NSString stringWithFormat:@"%@%@",self.wxAppID,@"://pay"]]) {
        return YES;
    }
    return NO;
}

// 处理微信支付结果
- (BOOL)processUrlFromWXPay:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}
// 微信支付的回调
- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayResp class]])
    {
        if (resp.errCode == WXSuccess) {
            [DLLoading DLToolTipInWindow:@"支付成功"];
            if (self.wxPaySuccessBlock) {
                self.wxPaySuccessBlock();
            }
        }else if (resp.errCode == WXErrCodeUserCancel){
            [DLLoading DLToolTipInWindow:@"已取消支付!"];
            if (self.wxPayFailedBlock) {
                self.wxPayFailedBlock();
            }
        }else{
            [DLLoading DLToolTipInWindow:@"支付失败!"];
            if (self.wxPayFailedBlock) {
                self.wxPayFailedBlock();
            }
        }
    }
}

#pragma mark -银联
// 开始银联支付
- (void)startUnionSDKPayWithTranNumber:(NSString *)tranNum
                        viewController:(UIViewController *)viewController
                            paySuccess:(DLOtherPayCompleteBlock)successBlock
                             payFailed:(DLOtherPayCompleteBlock)failedBlock
{
    self.unionPaySuccessBlock = successBlock;
    self.unionPayFailedBlock = failedBlock;
    [self startUnionSDKPayWithTranNumber:tranNum
                          viewController:viewController];
}
// 调起银联支付SDK
- (void)startUnionSDKPayWithTranNumber:(NSString *)tranNum
                        viewController:(UIViewController *)viewController
{
    NSString *tranMode  = @"00";
//#ifdef DEBUG
//    // 测试环境
//    tranMode  = @"01";
//#endif
    
    [[UPPaymentControl defaultControl] startPay:tranNum
                                     fromScheme:self.unionPayAppScheme
                                           mode:tranMode
                                 viewController:viewController];
}

// 判断Url是否来自于银联支付
- (BOOL)isUrlFromUnionPay:(NSURL *)url
{
    if ([url.absoluteString hasPrefix:[NSString stringWithFormat:@"%@://uppayresult",self.unionPayAppScheme]]) {
        return YES;
    }
    return NO;
}

// 处理银联支付结果
- (BOOL)dealUnionPayResultWithUrl:(NSURL *)url
{
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        if([code isEqualToString:@"success"]) {
            // 交易成功
            @weakify(self);
            [DLLoading DLToolTipInWindow:@"支付成功"];
            [[[RACSignal interval:1.0 onScheduler:[RACScheduler currentScheduler]] take:1] subscribeNext:^(id x) {
                @strongify(self);
                if (self.unionPaySuccessBlock) {
                    self.unionPaySuccessBlock();
                }
            }];
        }
        else if([code isEqualToString:@"fail"]) {
            // 交易失败
            [DLLoading DLToolTipInWindow:@"支付失败"];
            if (self.unionPayFailedBlock) {
                self.unionPayFailedBlock();
            }
        }
        else if([code isEqualToString:@"cancel"]) {
            // 交易取消
            [DLLoading DLToolTipInWindow:@"已取消支付!"];
            if (self.unionPayFailedBlock) {
                self.unionPayFailedBlock();
            }
        }
    }];
    return YES;
}

@end
