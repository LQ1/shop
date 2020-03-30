//
//  GoodDetailPatternCategoryViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodDetailPatternCategoryViewModel.h"

#import "GoodDetailPatternChooseSectionView.h"

@implementation GoodDetailPatternCategoryViewModel

- (instancetype)initWithCategoryName:(NSString *)categoryName
                          categoryID:(NSString *)categoryID
                      patternDetails:(NSArray *)patternDetails

{
    self = [super init];
    if (self) {
        self.patternCategoryName = categoryName;
        self.patternCategoryID = categoryID;
        self.childViewModels = patternDetails;
        self.UIClassName = NSStringFromClass([GoodDetailPatternChooseSectionView class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = GoodDetailPatternChooseSectionViewHeight;
    }
    return self;
}

@end
