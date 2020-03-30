//
//  CommentCenterModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface CommentCenterModel : BaseStringProModel

@property (nonatomic,copy) NSString *order_detail_id;
@property (nonatomic,copy) NSString *goods_title;
@property (nonatomic,copy) NSString *attr_values;
@property (nonatomic,copy) NSString *goods_thumb;
@property (nonatomic,copy) NSString *price;

@end
