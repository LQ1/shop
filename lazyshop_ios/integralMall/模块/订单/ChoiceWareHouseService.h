//
//  ChoiceWareHouseService.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/31.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChoiceWareHouseService : NSObject

- (RACSignal *)getWareHouseList;

@end
