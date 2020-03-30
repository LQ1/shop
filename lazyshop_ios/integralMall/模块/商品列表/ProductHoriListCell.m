//
//  ProductHoriListCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductHoriListCell.h"

#import "ProductListItemViewModel.h"

@interface ProductHoriListCell()

@property (nonatomic,strong)UIImageView *productImageView;
@property (nonatomic,strong)UILabel *productNameLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *sloganLabel;
@property (nonatomic,strong)UILabel *ticketLabel;

@end

@implementation ProductHoriListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 背景
    self.contentView.backgroundColor = [UIColor whiteColor];
    // 图
    self.productImageView = [self.contentView addImageViewWithImageName:nil
                                                    cornerRadius:0];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(ProductHoriListCellHeight);
    }];
    // 产品名称
    self.productNameLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                     textAlignment:0
                                                         textColor:@"#262626"
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:nil];
    self.productNameLabel.numberOfLines = 2;
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(self.productImageView.right).offset(15);
    }];
    // 价格
    self.priceLabel = [self.contentView addLabelWithFontSize:20
                                               textAlignment:0
                                                   textColor:@"#FF1600"
                                                adjustsWidth:YES
                                                cornerRadius:0
                                                        text:nil];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productNameLabel);
        make.bottom.mas_equalTo(-23);
    }];
    // 可配置文案
    self.sloganLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                textAlignment:NSTextAlignmentCenter
                                                    textColor:APP_MainColor
                                                 adjustsWidth:YES
                                                 cornerRadius:3
                                                         text:nil];
    self.sloganLabel.layer.borderColor = [CommUtls colorWithHexString:APP_MainColor].CGColor;
    self.sloganLabel.layer.borderWidth = 1;
    [self.sloganLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.right).offset(3);
        make.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self.priceLabel);
    }];
    // 券
    CGFloat width = 15.0f;
    self.ticketLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                textAlignment:NSTextAlignmentCenter
                                                    textColor:@"#ffffff"
                                                 adjustsWidth:NO
                                                 cornerRadius:width/2.
                                                         text:@"券"];
    self.ticketLabel.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    [self.ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(width);
        make.left.mas_equalTo(self.sloganLabel.right).offset(3);
        make.centerY.mas_equalTo(self.sloganLabel);
    }];
    
    [self.contentView addBottomLine];
}

- (void)bindViewModel:(ProductListItemViewModel *)vm
{
    [self.productImageView ly_showMidImg:vm.imgUrl];
    self.productNameLabel.text = vm.productName;
    if (vm.cartType == 0) {
        vm.price = [CommUtls shortPrice:vm.price];
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@",vm.price];
    }else{
        self.priceLabel.text = [NSString stringWithFormat:@"%@积分",vm.score];
    }
    if (vm.slogan.length&&[LYAppCheckManager shareInstance].isAppAgree) {
        self.sloganLabel.text = [NSString stringWithFormat:@" %@ ",vm.slogan];
    }else{
        self.sloganLabel.text = nil;
    }
    self.ticketLabel.hidden = !vm.is_coupon;
}

@end
