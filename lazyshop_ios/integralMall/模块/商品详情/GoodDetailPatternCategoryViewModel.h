//
//  GoodDetailPatternCategoryViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface GoodDetailPatternCategoryViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy)NSString *patternCategoryName;
@property (nonatomic,copy)NSString *patternCategoryID;

- (instancetype)initWithCategoryName:(NSString *)categoryName
                          categoryID:(NSString *)categoryID
                      patternDetails:(NSArray *)patternDetails;

@end
