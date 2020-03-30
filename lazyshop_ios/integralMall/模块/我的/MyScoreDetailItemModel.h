//
//  MyScoreDetailItemModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface MyScoreDetailItemModel : BaseModel

@property (nonatomic, assign) NSInteger change_score;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, assign) NSInteger change_type;

@end
