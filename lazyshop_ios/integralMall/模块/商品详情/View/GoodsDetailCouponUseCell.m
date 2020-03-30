//
//  GoodsDetailCouponUseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailCouponUseCell.h"

#import "GoodsDetailDiscountItemViewModel.h"

@implementation GoodsDetailCouponUseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 懒店优惠券
    UILabel *redTipLabel = [self.contentView addLabelWithFontSize:MIN_FONT_SIZE
                                        textAlignment:NSTextAlignmentCenter
                                            textColor:@"#ffffff"
                                         adjustsWidth:NO
                                         cornerRadius:3
                                                 text:@"懒店优惠券"];
    redTipLabel.backgroundColor = [CommUtls colorWithHexString:@"#ff1600"];
    [redTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(self.leftTitleLabel.right).offset(12.5);
        make.centerY.mas_equalTo(self.contentView);
    }];
//    // 懒店全现金商品通用 // 去掉 文字是变化的 接口没返回
//    UILabel *tipLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
//                                                 textAlignment:0
//                                                     textColor:@"#333333"
//                                                  adjustsWidth:YES
//                                                  cornerRadius:0
//                                                          text:@"懒店全现金商品通用"];
//    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(redTipLabel.right).offset(7);
//        make.centerY.mas_equalTo(self.contentView);
//    }];
}

- (void)bindViewModel:(GoodsDetailDiscountItemViewModel *)vm
{
    self.leftTitleLabel.text = vm.title;
}

@end
