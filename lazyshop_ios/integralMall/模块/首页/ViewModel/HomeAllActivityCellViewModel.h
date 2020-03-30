//
//  HomeAllActivityCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

#import "HomeAllActivityHeaderView.h"

@interface HomeAllActivityCellViewModel : LYItemUIBaseViewModel

@property (nonatomic, readonly) id selectedActivityCellVM;

- (instancetype)initWithActivityCellVMS:(NSArray *)dataArray;

- (void)changeToClickType:(HomeAllActivityHeaderViewClickType)cellType;

@end
