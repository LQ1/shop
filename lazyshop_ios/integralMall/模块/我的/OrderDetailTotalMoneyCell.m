//
//  ComfirmDetailTotalMoneyCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailTotalMoneyCell.h"

#import "OrderDetailTotalMoneyCellViewModel.h"

@interface OrderDetailTotalMoneyCell()

@property (nonatomic,strong)UILabel *payMoneyLabel;

@end

@implementation OrderDetailTotalMoneyCell

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
    self.contentView.backgroundColor = [UIColor whiteColor];
    // 需付款
    UILabel *payTipLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                    textAlignment:0
                                                        textColor:@"#333333"
                                                     adjustsWidth:NO
                                                     cornerRadius:0
                                                             text:@"需付款"];
    [payTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    self.payMoneyLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:APP_MainColor
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(payTipLabel);
    }];
}

- (void)bindViewModel:(OrderDetailTotalMoneyCellViewModel *)vm
{
    self.payMoneyLabel.text = vm.payMoney;
}

@end
