//
//  JavaScriptInterface.h
//  MobileClassPhone
//
//  Created by LY on 16/12/16.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,JSPushType)
{
    JSPushType_HomePage = 0,
    JSPushType_HelpBargain,
    JSPushType_HelpGroupBuy
};

@interface JavaScriptInterface : NSObject

/*
 *  无参数跳转
 */
@property (nonatomic,readonly) RACSubject *noPramPushSignal;

/**
 *  单例
 */
+ (JavaScriptInterface *)sharedInstance;

@end
