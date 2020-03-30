//
//  ProductListItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductListItemCell.h"

#import "ProductlistItemMacro.h"
#import "ProductListItemViewModel.h"

#define ProductPriceFont 20

@interface ProductListItemCell()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *productNameLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UIView *sloganContentView;
@property (nonatomic,strong)UILabel *sloganLabel;
@property (nonatomic,strong)UILabel *ticketLabel;

@end

@implementation ProductListItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 背景
    self.contentView.backgroundColor = [UIColor whiteColor];
    // 图
    self.imageView = [self.contentView addImageViewWithImageName:nil
                                                    cornerRadius:0];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ProductListItemItemWidth);
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
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.imageView.bottom).offset(5);
    }];
    // 价格
    self.priceLabel = [self.contentView addLabelWithFontSize:ProductPriceFont
                                               textAlignment:0
                                                   textColor:@"#FF1600"
                                                adjustsWidth:YES
                                                cornerRadius:0
                                                        text:nil];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:ProductPriceFont];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productNameLabel);
        make.top.mas_equalTo(self.imageView.bottom).mas_offset(ProductListItemItemTitleHeight);
        make.height.mas_equalTo(ProductListItemItemPriceHeight);
    }];
    // 可配置文案
    UIView *sloganContentView = [UIView new];
    self.sloganContentView = sloganContentView;
    sloganContentView.layer.borderColor = [CommUtls colorWithHexString:APP_MainColor].CGColor;
    sloganContentView.layer.borderWidth = 1;
    sloganContentView.layer.cornerRadius = 3;
    sloganContentView.layer.masksToBounds = YES;
    [self.contentView addSubview:sloganContentView];
    [sloganContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.right).offset(3);
        make.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self.priceLabel);
    }];

    self.sloganLabel = [sloganContentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                textAlignment:NSTextAlignmentCenter
                                                    textColor:APP_MainColor
                                                 adjustsWidth:YES
                                                 cornerRadius:0
                                                         text:nil];
    [self.sloganLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
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
}

- (void)bindViewModel:(ProductListItemViewModel *)vm
{
    [self.imageView ly_showMidImg:vm.imgUrl];
    self.productNameLabel.text = vm.productName;
    // 价格显示处理
    vm.price = [CommUtls shortPrice:vm.price];
    
    if (vm.cartType == 0) {
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@",vm.price];
    }else{
        self.priceLabel.text = [NSString stringWithFormat:@"%@积分",vm.score];
    }

    if (vm.slogan.length&&[LYAppCheckManager shareInstance].isAppAgree) {
        self.sloganLabel.text = [NSString stringWithFormat:@" %@ ",vm.slogan];
    }else{
        self.sloganLabel.text = nil;
    }
    
    // 计算文案宽度
    CGFloat syWidth =  ProductListItemItemWidth - 5*2 - [CommUtls getContentSize:self.priceLabel.text font:[UIFont boldSystemFontOfSize:ProductPriceFont] size:CGSizeMake(CGFLOAT_MAX, ProductPriceFont+3)].width - 3 -3 - 15;
    CGFloat sloganWith = [CommUtls getContentSize:self.sloganLabel.text font:[UIFont systemFontOfSize:SMALL_FONT_SIZE] size:CGSizeMake(CGFLOAT_MAX, SMALL_FONT_SIZE+3)].width;
    if (syWidth<sloganWith) {
        [self.sloganContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.priceLabel.right).offset(3);
            make.height.mas_equalTo(16);
            make.centerY.mas_equalTo(self.priceLabel);
            make.width.mas_equalTo(syWidth);
        }];
    }else{
        [self.sloganContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.priceLabel.right).offset(3);
            make.height.mas_equalTo(16);
            make.centerY.mas_equalTo(self.priceLabel);
        }];
    }
    
    self.ticketLabel.hidden = !vm.is_coupon;
}

@end
