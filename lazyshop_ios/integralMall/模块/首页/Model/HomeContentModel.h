//
//  HomeContentModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

#import "HomeCycleItemModel.h"
#import "HomeCategoryItemModel.h"
#import "HomeScoreScrollItemModel.h"
#import "HomeSecKillItemModel.h"
#import "HomeGroupByItemModel.h"
#import "HomeBargainItemModel.h"
#import "HomeSelectedScrollItemModel.h"
#import "HomeSelectedRecomModel.h"
#import "HomeSelectedRecomItemModel.h"
#import "PartnerModel.h"

@interface HomeContentModel : BaseModel

// 轮询图
@property (nonatomic,strong) NSArray *banner;
// 分类
@property (nonatomic,strong) NSArray *navcat;
//合伙人
@property (nonatomic,strong) PartnerModel *partner;
// 积分商城
@property (nonatomic,strong) NSArray *integralCat;
@property (nonatomic,copy) NSString *integralThumb;
// 休闲娱乐
@property (nonatomic,strong) NSArray *leisure;
// 秒团砍
@property (nonatomic,strong) NSArray *group;
@property (nonatomic,copy) NSString *group_slogan;
@property (nonatomic,strong) NSArray *flash;
@property (nonatomic,copy) NSString *flash_slogan;
@property (nonatomic,strong) NSArray *bargain;
@property (nonatomic,copy) NSString *bargain_slogan;
// 懒店精选
@property (nonatomic,strong) NSArray *selected;
@property (nonatomic,strong) HomeSelectedRecomModel *brandRecommend;
// 懒店推荐
@property (nonatomic,strong) NSArray *foot_banner;

@end
