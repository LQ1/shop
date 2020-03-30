//
//  GoodsDetailIntroduceModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

#import "GoodsDetailIntroParmModel.h"

@interface GoodsDetailIntroduceModel : BaseStringProModel

@property (nonatomic,copy) NSString *detail;
@property (nonatomic,strong) NSArray *parameter;
@property (nonatomic,copy) NSString *packing_list;
@property (nonatomic,copy) NSString *after_service;
@property (nonatomic,copy) NSString *illustration;
@property (nonatomic,copy) NSString *goods_detail_id;
@property (nonatomic,copy) NSString *goods_id;

@end
