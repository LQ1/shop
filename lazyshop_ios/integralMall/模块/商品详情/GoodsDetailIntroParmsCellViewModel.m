//
//  GoodsDetailIntroParmsCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailIntroParmsCellViewModel.h"

#import "GoodsDetailIntroParmModel.h"

#import "GoodsDetailIntroParmsCell.h"

@implementation GoodsDetailIntroParmsCellViewModel

- (instancetype)initWithModel:(GoodsDetailIntroParmModel *)model
{
    self = [super init];
    if (self) {
        self.param_name = model.param_name;
        self.param_value = model.param_value;
        self.UIHeight = GoodsDetailIntroParmsCellBaseheight + [CommUtls getContentSize:model.param_value font:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE] size:CGSizeMake(KScreenWidth-15*2-3-125, CGFLOAT_MAX)].height;
    }
    return self;
}

@end
