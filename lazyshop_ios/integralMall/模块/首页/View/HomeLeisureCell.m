//
//  HomeLeisureCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeLeisureCell.h"

#import "HomeCellTextHeaderView.h"

#import "HomeLeisureItemView.h"
#import "HomeLeisureCellViewModel.h"

#define block1Height ((KScreenWidth-15*2)*200./345.)
#define block4Width (KScreenWidth-15*2)
#define block4Height (block4Width*160./345.)

@interface HomeLeisureCell ()

@property (nonatomic, strong) HomeLeisureItemView *itemView1;
@property (nonatomic, strong) HomeLeisureItemView *itemView2;
@property (nonatomic, strong) HomeLeisureItemView *itemView3;
@property (nonatomic, strong) HomeLeisureItemView *itemView4;

@end

@implementation HomeLeisureCell

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
    HomeCellTextHeaderView *header = [[HomeCellTextHeaderView alloc] initWithTitle:@"休 闲 娱 乐"];
    [self.contentView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(HomeCellTextHeaderViewListHeight);
    }];
    // 块1
    CGFloat block1Width  = (KScreenWidth-15*2-10)*294./(294.+375);
    self.itemView1 = [[HomeLeisureItemView alloc] initWithTitleStyle:NO
                                                           titleFont:MIDDLE_FONT_SIZE];
    [self.contentView addSubview:self.itemView1];
    [self.itemView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(header.bottom);
        make.width.mas_equalTo(block1Width);
        make.height.mas_equalTo(block1Height);
    }];
    // 块2
    CGFloat block2Width = KScreenWidth-15*2-10-block1Width;
    CGFloat block2Height = (block1Height-10.)/2.;
    self.itemView2 = [[HomeLeisureItemView alloc] initWithTitleStyle:NO
                                                           titleFont:SMALL_FONT_SIZE];
    [self.contentView addSubview:self.itemView2];
    [self.itemView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.itemView1.right).offset(10);
        make.top.mas_equalTo(self.itemView1);
        make.width.mas_equalTo(block2Width);
        make.height.mas_equalTo(block2Height);
    }];
    // 块3
    self.itemView3 = [[HomeLeisureItemView alloc] initWithTitleStyle:NO
                                                           titleFont:SMALL_FONT_SIZE];
    [self.contentView addSubview:self.itemView3];
    [self.itemView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.mas_equalTo(self.itemView2);
        make.top.mas_equalTo(self.itemView2.bottom).offset(10);
    }];
    // 块4
    self.itemView4 = [[HomeLeisureItemView alloc] initWithTitleStyle:YES
                                                           titleFont:SMALL_FONT_SIZE];
    [self.contentView addSubview:self.itemView4];
    [self.itemView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.itemView1.bottom).offset(10);
        make.height.mas_equalTo(block4Height);
    }];
}

#pragma mark -reload
- (void)bindViewModel:(HomeLeisureCellViewModel *)vm
{
    if (vm.childViewModels.count>0) {
        [self.itemView1 reloadWithModel:vm.childViewModels[0]];
    }
    if (vm.childViewModels.count>1) {
        [self.itemView2 reloadWithModel:vm.childViewModels[1]];
    }
    if (vm.childViewModels.count>2) {
        [self.itemView3 reloadWithModel:vm.childViewModels[2]];
    }
    if (vm.childViewModels.count>3) {
        [self.itemView4 reloadWithModel:vm.childViewModels[3]];
    }
}

#pragma mark -cellHeight
+ (CGFloat)cellHeight
{
    return HomeCellTextHeaderViewListHeight+block1Height+10+block4Height+35;
}

@end
