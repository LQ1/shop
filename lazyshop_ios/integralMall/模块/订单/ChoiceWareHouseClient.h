//
//  ChoiceWareHouseClient.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChoiceWareHouseClient : NSObject

#pragma mark -获取货仓列表
- (RACSignal *)getStoreHouseList;

@end
