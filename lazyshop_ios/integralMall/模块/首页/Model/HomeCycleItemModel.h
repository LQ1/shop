//
//  HomeCycleItemModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

#import "HomeLinkModel.h"

@interface HomeCycleItemModel : BaseStringProModel

@property (nonatomic,copy)NSString *placeholder_id;
@property (nonatomic,strong)HomeLinkModel *link;
@property (nonatomic,copy)NSString *link_type;
@property (nonatomic,copy)NSString *advert_id;
@property (nonatomic,copy)NSString *image;

@end
