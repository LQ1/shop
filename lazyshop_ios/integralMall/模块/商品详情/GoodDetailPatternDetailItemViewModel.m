//
//  GoodDetailPatternDetailItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodDetailPatternDetailItemViewModel.h"

#import "GoodDetailPatternChooseItemCell.h"

@interface GoodDetailPatternDetailItemViewModel()

@end

@implementation GoodDetailPatternDetailItemViewModel

- (instancetype)initWithPatternDetailName:(NSString *)detailName
                          patternDetailID:(NSString *)detailID
{
    self = [super init];
    if (self) {
        self.patternDetailName = detailName;
        self.patternDetailID = detailID;

        self.UIClassName = NSStringFromClass([GoodDetailPatternChooseItemCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 27.5f;
        self.UIWidth = [CommUtls getContentSize:detailName font:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE] size:CGSizeMake(CGFLOAT_MAX, self.UIHeight)].width+30;
    }
    return self;
}

@end
