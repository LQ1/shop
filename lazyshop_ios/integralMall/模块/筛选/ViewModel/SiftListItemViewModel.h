//
//  SiftListItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface SiftListItemViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *categorySecondID;
@property (nonatomic,copy) NSString *categorySecondName;
@property (nonatomic,assign) BOOL selected;

- (instancetype)initWithCategorySecondID:(NSString *)categoryID
                      categorySecondName:(NSString *)categoryName
                                selected:(BOOL)selected;

@end
