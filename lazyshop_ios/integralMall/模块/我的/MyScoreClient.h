//
//  MyScoreClient.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyScoreClient : NSObject

#pragma mark -获取用户成长值详情
- (RACSignal *)getUserGrowthDetail;
#pragma mark -获取用户积分流水列表
- (RACSignal *)getUserScoreListWithChange_type:(NSString *)change_type
                                          page:(NSString *)page;

@end
