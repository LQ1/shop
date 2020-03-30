//
//  GoodsDetailIntroParmsCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class GoodsDetailIntroParmModel;

@interface GoodsDetailIntroParmsCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *param_name;
@property (nonatomic,copy) NSString *param_value;
@property (nonatomic,assign) BOOL showTopLine;

- (instancetype)initWithModel:(GoodsDetailIntroParmModel *)model;

@end
