//
//  SiftListSectionViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SiftListSectionViewModel.h"

@implementation SiftListSectionViewModel

- (instancetype)initWithCategoryFirstID:(NSString *)categoryFirstID
                      categoryFirstName:(NSString *)categoryFirstName
                               unfolded:(BOOL)unfolded
                         itemViewModels:(NSArray *)itemViewModels
{
    self = [super init];
    if (self) {
        self.categoryFirstID = categoryFirstID;
        self.categoryFirstName = categoryFirstName;
        self.unfolded = unfolded;
        self.childViewModels = itemViewModels;
        self.UIHeight = 34.0f;
    }
    return self;
}

@end
