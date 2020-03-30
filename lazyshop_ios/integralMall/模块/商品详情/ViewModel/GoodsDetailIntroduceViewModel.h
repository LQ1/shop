//
//  GoodsDetailIntroduceViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface GoodsDetailIntroduceViewModel : LYItemUIBaseViewModel

- (instancetype)initWithGoods_id:(NSString *)goods_id;

- (NSArray *)fetchHeaderSwitchVMs;

- (void)getData;

- (NSString *)fetchIntroduceHtmlString;
- (NSArray *)fetchParmsItemVMs;
- (NSArray *)fetchTagVMs;

@end
