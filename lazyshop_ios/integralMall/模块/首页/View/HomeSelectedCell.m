//
//  HomeSelectedCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeSelectedCell.h"

#import "HomeCellTextHeaderView.h"
#import "HomeHoriScrollBaseView.h"
#import "HomeSelectedScrollItemCell.h"
#import "HomeSelectedCellViewModel.h"
#import "HomeSelectedFiledItemView.h"

#import "HomeSelectedRecomItemModel.h"

#define HomeSelectedCellScrollHeight 218.0f
#define HomeSelectedCellScrollBottomGap 38.0f
#define HomeSelectedCellItemHeight ((KScreenWidth-25*2-15)/2.)

@interface HomeSelectedCell ()

@property (nonatomic, strong) HomeHoriScrollBaseView *scrollView;
@property (nonatomic, strong) HomeSelectedFiledItemView *itemView1;
@property (nonatomic, strong) HomeSelectedFiledItemView *itemView2;
@property (nonatomic, strong) HomeSelectedFiledItemView *itemView3;
@property (nonatomic, strong) HomeSelectedFiledItemView *moreItemView;

@end

@implementation HomeSelectedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // header
    HomeCellTextHeaderView *header = [[HomeCellTextHeaderView alloc] initWithTitle:@"懒 店 精 选"];
    [self.contentView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    // scroll
    HomeHoriScrollBaseView *scrollView = [[HomeHoriScrollBaseView alloc] initWithItemWidth:HomeSelectedCellScrollHeight
                                                                                itemHeight:HomeSelectedCellScrollHeight
                                                                                   itemGap:18
                                                                              leftRightGap:15
                                                                             itemCellClass:[HomeSelectedScrollItemCell class]];
    self.scrollView = scrollView;
    [self.contentView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(header.bottom);
        make.height.mas_equalTo(scrollView.viewHeight);
    }];
    @weakify(self);
    [scrollView.itemClickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.itemClickSignal sendNext:x];
    }];
    // item1
    self.itemView1 = [[HomeSelectedFiledItemView alloc] initWithMore:NO];
    [self.contentView addSubview:self.itemView1];
    [self.itemView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(HomeSelectedCellItemHeight);
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(self.scrollView.bottom).offset(HomeSelectedCellScrollBottomGap);
    }];
    // item2
    self.itemView2 = [[HomeSelectedFiledItemView alloc] initWithMore:NO];
    [self.contentView addSubview:self.itemView2];
    [self.itemView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.itemView1);
        make.width.height.mas_equalTo(HomeSelectedCellItemHeight);
        make.left.mas_equalTo(self.itemView1.right).offset(15);
    }];
    // item3
    self.itemView3 = [[HomeSelectedFiledItemView alloc] initWithMore:NO];
    [self.contentView addSubview:self.itemView3];
    [self.itemView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(HomeSelectedCellItemHeight);
        make.left.mas_equalTo(self.itemView1);
        make.top.mas_equalTo(self.itemView1.bottom).offset(9);
    }];
    // moreItem
    self.moreItemView = [[HomeSelectedFiledItemView alloc] initWithMore:YES];
    [self.contentView addSubview:self.moreItemView];
    [self.moreItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(HomeSelectedCellItemHeight);
        make.left.mas_equalTo(self.itemView2);
        make.top.mas_equalTo(self.itemView3);
    }];

}

#pragma mark -height
+ (CGFloat)fetchCellHeight
{
    return 100+HomeSelectedCellScrollHeight+HomeSelectedCellScrollBottomGap+9+HomeSelectedCellItemHeight*2+2;
}

#pragma mark -bind
- (void)bindViewModel:(HomeSelectedCellViewModel *)vm
{
    [self.scrollView bindViewModel:vm];
    
    HomeSelectedRecomItemModel *model1 = [vm recommedModelAtIndex:0];
    [self.itemView1 reloadWithGoodsID:model1.goods_id
                           goodsThumb:model1.thumb];
    
    HomeSelectedRecomItemModel *model2 = [vm recommedModelAtIndex:1];
    [self.itemView2 reloadWithGoodsID:model2.goods_id
                           goodsThumb:model2.thumb];

    HomeSelectedRecomItemModel *model3 = [vm recommedModelAtIndex:2];
    [self.itemView3 reloadWithGoodsID:model3.goods_id
                           goodsThumb:model3.thumb];

    [self.moreItemView reloadWithMoreDesc:vm.model.slogan
                                moreCatID:vm.model.recommend_cat_id
                                  catType:@"0"];
}

@end
