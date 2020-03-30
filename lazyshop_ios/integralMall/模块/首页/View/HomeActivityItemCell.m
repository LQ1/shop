//
//  HomeSecKillItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeActivityItemCell.h"

#import "HomeActivityBaseModel.h"
#import "LYSloganView.h"

@interface HomeActivityItemCell()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)LYSloganView *sloganView;

@end

@implementation HomeActivityItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 图
    self.imageView = [self.contentView addImageViewWithImageName:nil
                                                    cornerRadius:3.];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(HomeActivityImageWidth);
        make.height.mas_equalTo(HomeActivityImageHeight);
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self.contentView);
    }];
}

- (void)reloadDataWithModel:(HomeActivityBaseModel *)itemModel
{
    [self.imageView ly_showMinImg:itemModel.thumb];
}


@end
