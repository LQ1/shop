//
//  GoodsDetailPostageCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseCell.h"

#define GoodsDetailPostageCellBaseHeight 38.0f

#define GoodsDetailPostageCellRowMax 4

@interface GoodsDetailPostageCell : LYItemUIBaseCell

@property (nonatomic,readonly) RACSubject *clickSignal;

@end
