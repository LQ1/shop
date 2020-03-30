//
//  HomeAllActivityDetailView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeAllActivityDetailView.h"

#import "HomeAllActivityCellViewModel.h"

#import "HomeSecKillCell.h"
#import "HomeSecKillCellViewModel.h"
#import "HomeGroupBuyCell.h"
#import "HomeGroupByCellViewModel.h"
#import "HomeBargainCell.h"
#import "HomeBargainCellViewModel.h"

@implementation HomeAllActivityDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gotoActivityListSignal = [[RACSubject subject] setNameWithFormat:@"%@ gotoActivityListSignal", self.class];
        _gotoGoodsDetailSignal = [[RACSubject subject] setNameWithFormat:@"%@ gotoGoodsDetailSignal", self.class];
        self.backgroundColor = [UIColor whiteColor];
        // 阴影
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(2.5,2.5);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 2.5;
    }
    return self;
}

#pragma mark -Reload
- (void)reloadDataWithViewModel:(HomeAllActivityCellViewModel *)viewModel
{
    // 移除旧视图
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    // 添加新视图
    id selectedAcVM = viewModel.selectedActivityCellVM;
    if (selectedAcVM) {
        HomeActivityBaseCell *cell = nil;
        if ([selectedAcVM isKindOfClass:[HomeSecKillCellViewModel class]]) {
            cell = [[HomeSecKillCell alloc] init];
        }else if ([selectedAcVM isKindOfClass:[HomeGroupByCellViewModel class]]) {
            cell = [[HomeGroupBuyCell alloc] init];
        }else if ([selectedAcVM isKindOfClass:[HomeBargainCellViewModel class]]) {
            cell = [[HomeBargainCell alloc] init];
        }else{
            [self DLLoadingDoneInSelf:CDELLoadingDone
                                title:@"暂无此类活动"];
        }
        [self addSubview:cell];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [cell bindViewModel:selectedAcVM];
        @weakify(self);
        // cell header点击
        [cell.clickSignal subscribeNext:^(id x) {
            @strongify(self);
            if ([selectedAcVM isKindOfClass:[HomeSecKillCellViewModel class]]) {
                // 跳转秒杀列表
                [self.gotoActivityListSignal sendNext:@(HomeAllActivityGoMoreType_SecKillList)];
            }else if ([selectedAcVM isKindOfClass:[HomeGroupByCellViewModel class]]) {
                // 跳转拼团列表
                [self.gotoActivityListSignal sendNext:@(HomeAllActivityGoMoreType_GroupBuyList)];
            }else if ([selectedAcVM isKindOfClass:[HomeBargainCellViewModel class]]) {
                // 跳转砍价列表
                [self.gotoActivityListSignal sendNext:@(HomeAllActivityGoMoreType_BargainList)];
            }
        }];
        // cell 内某一项的点击事件
        [cell.baseClickSignal subscribeNext:^(id x) {
            @strongify(self);
            [self.gotoGoodsDetailSignal sendNext:x];
        }];
    }else{
        [self DLLoadingDoneInSelf:CDELLoadingDone
                            title:@"暂无此类活动"];
    }
}

@end
