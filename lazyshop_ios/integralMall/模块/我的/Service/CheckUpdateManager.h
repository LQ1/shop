//
//  CheckUpdateManager.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CheckUpdateManager : NSObject

/*
 *  单例
 */
+ (instancetype)shareInstance;

/*
 *  检查更新
 */
- (void)checkAppUpdateWithNoUpdate:(dispatch_block_t)noUpdateBlock
                           loading:(BOOL)loading;

@end
