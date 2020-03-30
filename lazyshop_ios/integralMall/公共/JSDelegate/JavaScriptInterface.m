//
//  JavaScriptInterface.m
//  MobileClassPhone
//
//  Created by LY on 16/12/16.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import "JavaScriptInterface.h"

#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcJavaScriptInterfaceDelegate <JSExport>

// 跳转首页
- (void)goToHomePage;
// 跳转帮忙拼团
- (void)helpGroupBuy;
// 跳转帮忙砍价
- (void)helpBargain;

@end

@interface JavaScriptInterface ()<JSObjcJavaScriptInterfaceDelegate>

@end

@implementation JavaScriptInterface

#pragma mark - 单例

static JavaScriptInterface *jsInstance = nil;

+ (JavaScriptInterface *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jsInstance = [[super allocWithZone:NULL] init];
        jsInstance->_noPramPushSignal = [[RACSubject subject] setNameWithFormat:@"%@ noPramPushSignal", jsInstance.class];
    });
    
    return jsInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [JavaScriptInterface sharedInstance];
}

+ (id)copy
{
    return [JavaScriptInterface sharedInstance];
}

#pragma mark -JSObjcJavaScriptInterfaceDelegate

// 跳转首页
- (void)goToHomePage
{
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        // !在主线程中执行
        CLog(@"goToHomePage");
        @strongify(self);
        [self.noPramPushSignal sendNext:@(JSPushType_HomePage)];
    });
}
// 跳转帮忙拼团
- (void)helpGroupBuy
{
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        // !在主线程中执行
        CLog(@"helpGroupBuy");
        @strongify(self);
        [self.noPramPushSignal sendNext:@(JSPushType_HelpGroupBuy)];
    });
}
// 跳转帮忙砍价
- (void)helpBargain
{
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        // !在主线程中执行
        CLog(@"helpBargain");
        @strongify(self);
        [self.noPramPushSignal sendNext:@(JSPushType_HelpBargain)];
    });
}

@end
