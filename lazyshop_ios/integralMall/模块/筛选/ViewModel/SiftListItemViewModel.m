//
//  SiftListItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SiftListItemViewModel.h"

@implementation SiftListItemViewModel

- (instancetype)initWithCategorySecondID:(NSString *)categoryID
                      categorySecondName:(NSString *)categoryName
                                selected:(BOOL)selected
{
    self = [super init];
    if (self) {
        self.categorySecondID = categoryID;
        self.categorySecondName = categoryName;
        self.selected = selected;
        self.UIHeight = 34.0f;
    }
    return self;
}

@end
