//
//  ScoreSignInViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

#import "ScoreSignInCalendarViewModel.h"

@interface ScoreSignInViewModel : LYBaseViewModel

@property (nonatomic, strong) ScoreSignInCalendarViewModel *signInCalendarViewModel;

@property (nonatomic, assign) NSInteger continueSignDays;
@property (nonatomic, assign) NSInteger wholeSignDays;
@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, assign) BOOL todaySigned;

- (void)signIn;

@end
