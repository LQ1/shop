//
//  LYBaseViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface LYBaseViewModel : BaseViewModel

@property (nonatomic,readonly)RACSubject *tipLoadingSignal;
@property (nonatomic,readonly)RACSubject *fetchListSuccessSignal;
@property (nonatomic,readonly)RACSubject *fetchListFailedSignal;
@property (nonatomic,readonly)RACSubject *reloadViewSignal;

@property (nonatomic,assign)int currentSignalType;

@property (nonatomic,strong)NSArray *dataArray;

- (void)getData;

@end
