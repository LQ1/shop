//
//  ScoreItemModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/29.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface ScoreItemModel : BaseStringProModel

@property (nonatomic,copy) NSString *shop_user_id;
@property (nonatomic,copy) NSString *shop_id;
@property (nonatomic,copy) NSString *shop_name;
@property (nonatomic,copy) NSString *shop_describe;
@property (nonatomic,copy) NSString *thumb_image;

@property (nonatomic,strong) NSArray *shop_address;
@property (nonatomic,copy) NSString *user_rank;

@end
