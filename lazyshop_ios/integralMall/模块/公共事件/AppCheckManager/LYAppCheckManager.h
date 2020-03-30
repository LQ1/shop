//
//  LYAppCheckManager.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYAppCheckManager : NSObject


@property (nonatomic, readonly) BOOL isAppAgree;

/*
 *  单例
 */
+ (instancetype)shareInstance;

/*
 *  是否通过审核
 */
- (RACSignal *)checkIsAppAgree;

@end
