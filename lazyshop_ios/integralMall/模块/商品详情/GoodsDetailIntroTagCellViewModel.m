//
//  GoodsDetailIntroTagCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailIntroTagCellViewModel.h"

#import "GoodsDetailIntroTagCell.h"

@implementation GoodsDetailIntroTagCellViewModel

- (instancetype)initWithTagName:(NSString *)tagName
                       tagValue:(NSString *)tagValue
{
    self = [super init];
    if (self) {
        if (!tagValue.length) {
            tagValue = @"暂无";
        }
        self.tagName = tagName;
        self.tagValue = tagValue;
        self.UIHeight = GoodsDetailIntroTagCellBaseHeight + [CommUtls getContentSize:tagValue
                                                                                font:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE
                                                                                      ] size:CGSizeMake(KScreenWidth-15*2, CGFLOAT_MAX)].height;
    }
    return self;
}

@end
