//
//  HomeService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeService : NSObject

/*
 *  获取首页活动
 */
- (RACSignal *)fetchHomeActivitys;

/*
 *  获取首页商品列表
 */
- (RACSignal *)fetchHomeGoodsListWithPage:(NSString *)page;

/*
 *  获取秒杀时间
 */
- (RACSignal *)fetchSecKillTimes;
/*
 *  获取秒杀列表
 */
- (RACSignal *)fetchSecKillListWithPage:(NSString *)page
                          sell_start_at:(NSString *)sell_start_at;
/*
 *  获取拼团列表
 */
- (RACSignal *)fetchGroupBuyListWithPage:(NSString *)page;
/*
 *  获取砍价列表
 */
- (RACSignal *)fetchBargainListWithPage:(NSString *)page;

/*
 *  扫一扫获取商品信息
 */
- (RACSignal *)fetchGoodsMsgWithScanCode:(NSString *)scanCode;

@end
