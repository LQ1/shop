//
//  SettingItemModifyPwdView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SettingItemModifyPwdView.h"

@implementation SettingItemModifyPwdView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    @weakify(self);
    [[[RACObserve(SignInUser, isInitPassword) distinctUntilChanged] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            self.titleLabel.text = @"修改登录密码";
        }else{
            self.titleLabel.text = @"设置登录密码";
        }
    }];
}

@end
