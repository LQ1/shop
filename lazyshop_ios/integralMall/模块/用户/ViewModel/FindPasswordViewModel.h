//
//  FindPasswordViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LoginBaseViewModel.h"

@interface FindPasswordViewModel : LoginBaseViewModel

/*
 *  下一步按钮是否可用
 */
- (RACSignal *)nextButtonValidSignal;

/*
 *  获取VM
 */
- (id)fetchPhoneAndVerifyCodeInputViewModel;

/*
 *  下一步
 */
- (void)nextClick;

@end
