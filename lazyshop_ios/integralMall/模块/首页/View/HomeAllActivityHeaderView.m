//
//  HomeAllActivityHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeAllActivityHeaderView.h"

#import "HomeAllActivityHeaderItemView.h"

@interface HomeAllActivityHeaderView ()

@property (nonatomic, strong) HomeAllActivityHeaderItemView *secKillView;
@property (nonatomic, strong) HomeAllActivityHeaderItemView *groupView;
@property (nonatomic, strong) HomeAllActivityHeaderItemView *bargainView;
@property (nonatomic, copy )  HomeAllActivityHeaderViewClickBlock clickBlock;

@end

@implementation HomeAllActivityHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
        [self bindCommand];
    }
    return self;
}

- (void)addViews
{
    CGFloat itemWidth = KScreenWidth/3.0;
    // 懒店秒杀
    self.secKillView = [[HomeAllActivityHeaderItemView alloc] initWithTitle:@"懒店秒杀"];
    [self addSubview:self.secKillView];
    [self.secKillView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(itemWidth);
    }];
    // 懒店拼团
    self.groupView = [[HomeAllActivityHeaderItemView alloc] initWithTitle:@"懒店拼团"];
    [self addSubview:self.groupView];
    [self.groupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(itemWidth);
        make.left.mas_equalTo(self.secKillView.right);
    }];
    // 懒店砍价
    self.bargainView = [[HomeAllActivityHeaderItemView alloc] initWithTitle:@"懒店砍价"];
    [self addSubview:self.bargainView];
    [self.bargainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.groupView.right);
    }];

    // 顶部线路
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [CommUtls colorWithHexString:@"#e6e6e6"];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    // 默认选中秒杀
    [self changeToClickType:HomeAllActivityHeaderViewClickType_SecKill];
}

- (void)bindCommand
{
    @weakify(self);
    // 点击事件
    [self.secKillView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self changeToClickType:HomeAllActivityHeaderViewClickType_SecKill];
    }];
    [self.groupView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self changeToClickType:HomeAllActivityHeaderViewClickType_Group];
    }];
    [self.bargainView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self changeToClickType:HomeAllActivityHeaderViewClickType_Bargain];
    }];
}
// 使切换
- (void)changeToClickType:(HomeAllActivityHeaderViewClickType)cellType
{
    switch (cellType) {
        case HomeAllActivityHeaderViewClickType_SecKill:
        {
            if (!self.secKillView.checked) {
                // 懒店秒杀
                [self changeUIToClickType:HomeAllActivityHeaderViewClickType_SecKill];
                if (self.clickBlock) {
                    self.clickBlock(HomeAllActivityHeaderViewClickType_SecKill);
                }
            }
        }
            break;
        case HomeAllActivityHeaderViewClickType_Group:
        {
            if (!self.groupView.checked) {
                // 懒店拼团
                [self changeUIToClickType:HomeAllActivityHeaderViewClickType_Group];
                if (self.clickBlock) {
                    self.clickBlock(HomeAllActivityHeaderViewClickType_Group);
                }
            }
        }
            break;
        case HomeAllActivityHeaderViewClickType_Bargain:
        {
            if (!self.bargainView.checked) {
                // 懒店砍价
                [self changeUIToClickType:HomeAllActivityHeaderViewClickType_Bargain];
                if (self.clickBlock) {
                    self.clickBlock(HomeAllActivityHeaderViewClickType_Bargain);
                }
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -设置类型切换的回调
- (void)setChangeClickBlock:(HomeAllActivityHeaderViewClickBlock)block
{
    self.clickBlock = block;
}

#pragma mark -设置UI显示
- (void)changeUIToClickType:(HomeAllActivityHeaderViewClickType)cellType
{
    switch (cellType) {
        case HomeAllActivityHeaderViewClickType_SecKill:
        {
            if (!self.secKillView.checked) {
                // 懒店秒杀
                self.secKillView.checked = YES;
                self.groupView.checked = NO;
                self.bargainView.checked = NO;
            }
        }
            break;
        case HomeAllActivityHeaderViewClickType_Group:
        {
            if (!self.groupView.checked) {
                // 懒店拼团
                self.secKillView.checked = NO;
                self.groupView.checked = YES;
                self.bargainView.checked = NO;
            }
        }
            break;
        case HomeAllActivityHeaderViewClickType_Bargain:
        {
            if (!self.bargainView.checked) {
                // 懒店砍价
                self.secKillView.checked = NO;
                self.groupView.checked = NO;
                self.bargainView.checked = YES;
            }
        }
            break;
            
        default:
            break;
    }
}

@end
