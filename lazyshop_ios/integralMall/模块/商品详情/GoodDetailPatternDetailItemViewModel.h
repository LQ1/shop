//
//  GoodDetailPatternDetailItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface GoodDetailPatternDetailItemViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy)NSString *patternDetailName;
@property (nonatomic,copy)NSString *patternDetailID;

@property (nonatomic,assign)BOOL selected;
@property (nonatomic,assign)BOOL invalid;

- (instancetype)initWithPatternDetailName:(NSString *)detailName
                          patternDetailID:(NSString *)detailID;

@end
