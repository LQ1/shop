//
//  LoginProtocolView.h
//  NetSchool
//
//  Created by LY on 2017/4/7.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LoginProtocolHeight 15

@interface LoginProtocolView : UIView

@property (nonatomic,readonly)RACSubject *clickSignal;

/**
 *  初始化
 *
 *  @param prefixString 《懒店用户服务协议》 之前文字
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithPrefixString:(NSString *)prefixString;

@end
