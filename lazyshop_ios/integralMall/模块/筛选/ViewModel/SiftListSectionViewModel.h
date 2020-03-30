//
//  SiftListSectionViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface SiftListSectionViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *categoryFirstID;
@property (nonatomic,copy) NSString *categoryFirstName;
@property (nonatomic,assign) BOOL unfolded;

- (instancetype)initWithCategoryFirstID:(NSString *)categoryFirstID
                      categoryFirstName:(NSString *)categoryFirstName
                               unfolded:(BOOL)unfolded
                         itemViewModels:(NSArray *)itemViewModels;

@end
