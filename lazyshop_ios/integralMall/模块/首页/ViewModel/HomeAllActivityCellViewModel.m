//
//  HomeAllActivityCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeAllActivityCellViewModel.h"

#import "HomeAllActivityCell.h"

#import "HomeSecKillCellViewModel.h"
#import "HomeGroupByCellViewModel.h"
#import "HomeBargainCellViewModel.h"

@interface HomeAllActivityCellViewModel ()

@property (nonatomic, assign) id selectedActivityCellVM;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HomeAllActivityCellViewModel

- (instancetype)initWithActivityCellVMS:(NSArray *)dataArray
{
    self = [super init];
    if (self) {
        // 共有属性
        self.UIClassName = NSStringFromClass([HomeAllActivityCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = [HomeAllActivityCell fetchCellHeight];
        // 数据源
        self.dataArray = [NSArray arrayWithArray:dataArray];
        // 默认选中秒杀
        self.selectedActivityCellVM = [self.dataArray linq_where:^BOOL(id item) {
            return [item isKindOfClass:[HomeSecKillCellViewModel class]];
        }].linq_firstOrNil;
    }
    return self;
}

- (void)changeToClickType:(HomeAllActivityHeaderViewClickType)cellType
{
    if (cellType == HomeAllActivityHeaderViewClickType_SecKill) {
        self.selectedActivityCellVM = [self.dataArray linq_where:^BOOL(id item) {
            return [item isKindOfClass:[HomeSecKillCellViewModel class]];
        }].linq_firstOrNil;
    }else if (cellType == HomeAllActivityHeaderViewClickType_Group) {
        self.selectedActivityCellVM = [self.dataArray linq_where:^BOOL(id item) {
            return [item isKindOfClass:[HomeGroupByCellViewModel class]];
        }].linq_firstOrNil;
    }else if (cellType == HomeAllActivityHeaderViewClickType_Bargain) {
        self.selectedActivityCellVM = [self.dataArray linq_where:^BOOL(id item) {
            return [item isKindOfClass:[HomeBargainCellViewModel class]];
        }].linq_firstOrNil;
    }
}

@end
