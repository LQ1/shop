//
//  HomeSelectedRecomItemModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface HomeSelectedRecomItemModel : BaseModel

@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, assign) NSInteger goods_id;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, assign) NSInteger goods_cat_id;
@property (nonatomic, copy) NSString *price;

@end
