//
//  MyScoreGrowthDetailModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface MyScoreGrowthDetailModel : BaseModel

@property (nonatomic, assign) int level;
@property (nonatomic, assign) int growth;
@property (nonatomic, assign) int residue;
@property (nonatomic, copy) NSString *notice;

@end
