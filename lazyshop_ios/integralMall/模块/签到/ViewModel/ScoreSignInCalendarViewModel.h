//
//  ScoreSignInCalendarViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@interface ScoreSignInCalendarViewModel : LYBaseViewModel

@property (nonatomic, readonly) NSInteger currentYear;
@property (nonatomic, readonly) NSInteger currentMonth;
@property (nonatomic, readonly) NSInteger currentDay;
@property (nonatomic, readonly) BOOL todaySigned;

- (void)reloadSignedMsgWithModels:(NSArray *)signedModels;

@end
