//
//  HomeSelectedRecomModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/18.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface HomeSelectedRecomModel : BaseModel

@property (nonatomic, copy) NSString *recommend_title;
@property (nonatomic, strong) NSArray *brand;
@property (nonatomic, assign) NSInteger recommend_cat_id;
@property (nonatomic, copy) NSString *slogan;

@end
