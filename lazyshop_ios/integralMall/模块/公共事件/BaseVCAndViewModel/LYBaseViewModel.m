//
//  LYBaseViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@implementation LYBaseViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tipLoadingSignal = [[RACSubject subject] setNameWithFormat:@"%@ tipLoadingSignal", self.class];
        _fetchListSuccessSignal = [[RACSubject subject] setNameWithFormat:@"%@ fetchListSuccessSignal", self.class];
        _fetchListFailedSignal = [[RACSubject subject] setNameWithFormat:@"%@ fetchListFailedSignal", self.class];
        _reloadViewSignal = [[RACSubject subject] setNameWithFormat:@"%@ reloadViewSignal", self.class];
    }
    return self;
}

- (void)getData
{
    
}

@end
