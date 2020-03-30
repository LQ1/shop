//
//  LYAppCheckClient.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYAppCheckClient : NSObject

/*
 *  获取是否审核中
 */
- (RACSignal *)getAppCheckWithVersion:(NSString *)version;

@end
