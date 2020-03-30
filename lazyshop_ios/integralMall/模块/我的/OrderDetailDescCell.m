//
//  ComfirmDetailDescCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailDescCell.h"

#import "OrderDetailDescCellViewModel.h"

@interface OrderDetailDescCell()

@property (nonatomic,strong)UILabel *goodsTotalPriceLabel;
@property (nonatomic,strong)UILabel *integralDiscountPriceLabel;
@property (nonatomic,strong)UILabel *postageLabel;
@property (nonatomic,strong)UILabel *orderTotalPriceLabel;
@property (nonatomic,strong)UILabel *orderSubPriceLabel;

@end

@implementation OrderDetailDescCell

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
    // 商品总价
    UILabel *goodsTotalTipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                           textAlignment:0
                                                               textColor:@"#999999"
                                                            adjustsWidth:NO
                                                            cornerRadius:0
                                                                    text:@"商品总价"];
    [goodsTotalTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12.5);
    }];
    self.goodsTotalPriceLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                         textAlignment:NSTextAlignmentRight
                                                             textColor:@"#999999"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:nil];
    [self.goodsTotalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(goodsTotalTipLabel);
    }];
    // 积分折扣
    UILabel *integralDiscountTipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                           textAlignment:0
                                                               textColor:@"#333333"
                                                            adjustsWidth:NO
                                                            cornerRadius:0
                                                                    text:@"积分折扣"];
    [integralDiscountTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goodsTotalTipLabel);
        make.top.mas_equalTo(goodsTotalTipLabel.bottom).offset(6.5);
    }];
    self.integralDiscountPriceLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                         textAlignment:NSTextAlignmentRight
                                                             textColor:@"#333333"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:nil];
    [self.integralDiscountPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.goodsTotalPriceLabel);
        make.centerY.mas_equalTo(integralDiscountTipLabel);
    }];
    
    // 运费
    UILabel *postageTipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                           textAlignment:0
                                                               textColor:@"#999999"
                                                            adjustsWidth:NO
                                                            cornerRadius:0
                                                                    text:@"运费"];
    [postageTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(integralDiscountTipLabel);
        make.top.mas_equalTo(integralDiscountTipLabel.bottom).offset(6.5);
    }];
    self.postageLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                         textAlignment:NSTextAlignmentRight
                                                             textColor:@"#999999"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:nil];
    [self.postageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.integralDiscountPriceLabel);
        make.centerY.mas_equalTo(postageTipLabel);
    }];
    // 订单总价
    UILabel *orderTotalPriceTipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                                textAlignment:0
                                                                    textColor:@"#333333"
                                                                 adjustsWidth:NO
                                                                 cornerRadius:0
                                                                         text:@"订单总价"];
    [orderTotalPriceTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(postageTipLabel);
        make.top.mas_equalTo(postageTipLabel.bottom).offset(6.5);
    }];
    self.orderTotalPriceLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                 textAlignment:NSTextAlignmentRight
                                                     textColor:@"#333333"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:nil];
    [self.orderTotalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.postageLabel);
        make.centerY.mas_equalTo(orderTotalPriceTipLabel);
    }];
    // 优惠金额
    UILabel *subPriceTipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                                textAlignment:0
                                                                    textColor:APP_MainColor
                                                                 adjustsWidth:NO
                                                                 cornerRadius:0
                                                                         text:@"优惠金额"];
    [subPriceTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderTotalPriceTipLabel);
        make.top.mas_equalTo(orderTotalPriceTipLabel.bottom).offset(6.5);
    }];
    self.orderSubPriceLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                         textAlignment:NSTextAlignmentRight
                                                             textColor:APP_MainColor
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:nil];
    [self.orderSubPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.orderTotalPriceLabel);
        make.centerY.mas_equalTo(subPriceTipLabel);
    }];
    
    [self addBottomLine];
}

- (void)bindViewModel:(OrderDetailDescCellViewModel *)vm
{
    self.postageLabel.text = [NSString stringWithFormat:@"¥%@",vm.postage];
    self.integralDiscountPriceLabel.text = vm.integralDiscountPrice;
    self.goodsTotalPriceLabel.text = vm.goodsTotalPrice;
    self.orderTotalPriceLabel.text = vm.orderTotalPrice;
    self.orderSubPriceLabel.text = [NSString stringWithFormat:@"-¥%@",vm.subtract_price];
}

@end
