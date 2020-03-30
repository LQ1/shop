//
//  ConfirmOrderListCouponCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/27.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListCouponCell.h"

#import "ConfirmOrderListCouponCellViewModel.h"

@interface ConfirmOrderListCouponCell()

@property (nonatomic,strong)UILabel *validNumberLabel;

@end

@implementation ConfirmOrderListCouponCell

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
    // 优惠券
    UILabel *tipLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:@"#333333"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:@"优惠券"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.validNumberLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                     textAlignment:NSTextAlignmentRight
                                                         textColor:@"#ffffff"
                                                      adjustsWidth:NO
                                                      cornerRadius:3
                                                              text:nil];
    self.validNumberLabel.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    [self.validNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightArrowView.left).offset(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addBottomLine];
}

#pragma mark -reload
- (void)bindViewModel:(ConfirmOrderListCouponCellViewModel *)vm
{
    if (vm.validCouponNumber>0) {
        if (vm.currentUseCouponID.length) {
            self.validNumberLabel.text = @"已使用";
        }else{
            self.validNumberLabel.text = [NSString stringWithFormat:@"%ld个可用",(long)vm.validCouponNumber];
        }
    }else{
        self.validNumberLabel.text = @"无可用";
    }
}

@end
