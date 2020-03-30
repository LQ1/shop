//
//  LoginBaseViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LoginBaseViewModel.h"

@interface LoginBaseViewModel ()

@property (nonatomic,strong) AccountService *service;

@end

@implementation LoginBaseViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _tipLoadingSignal            = [[RACSubject subject] setNameWithFormat:@"%@ tipLoadingSignal", self.class];
        _loginSuccessSignal = [[RACSubject subject] setNameWithFormat:@"%@ loginSuccessSignal", self.class];
        self.service                 = [AccountService shareInstance];
    }
    return self;
}

@end
