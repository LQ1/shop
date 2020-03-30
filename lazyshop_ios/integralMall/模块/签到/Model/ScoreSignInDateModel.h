//
//  ScoreSignInDateModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface ScoreSignInDateModel : BaseModel

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, strong) NSArray *signinlist;
@property (nonatomic, assign) NSInteger userscore;
@property (nonatomic, assign) NSInteger totaldate;
@property (nonatomic, assign) NSInteger continuous;

@end
