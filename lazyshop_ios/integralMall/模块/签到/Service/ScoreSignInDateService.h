//
//  ScoreSignInDateService.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreSignInDateService : NSObject

/*
 *  签到
 */
- (RACSignal *)signIn;

/*
 *  获取签到列表
 */
- (RACSignal *)fetchSignInList;

@end
