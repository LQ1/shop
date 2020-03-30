//
//  RegisterViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LoginBaseViewModel.h"

#import "RegisterRecommendView.h"

@interface RegisterViewModel : LoginBaseViewModel

@property (nonatomic, assign) choiceRecommederType recommederType;
@property (nonatomic, copy) NSString *recommenderPhone;

/*
 *  注册按钮是否可用
 */
- (RACSignal *)registerButtonValidSignal;

/*
 *  获取VM
 */
- (id)fetchPhoneAndVerifyCodeInputViewModel;

/*
 *  开始注册
 */
- (void)registerClick;

@end
