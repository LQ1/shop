//
//  ConfirmOrderListShippingCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListShippingCell.h"

#import "ConfirmOrderListShippingCellViewModel.h"

@interface ConfirmOrderListShippingCell()

@property (nonatomic,strong)UILabel *shippingMoneyLabel;

@end

@implementation ConfirmOrderListShippingCell

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
    // 运费
    UILabel *tipLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:@"#333333"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:@"运费"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.shippingMoneyLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                       textAlignment:NSTextAlignmentRight
                                                           textColor:APP_MainColor
                                                        adjustsWidth:NO
                                                        cornerRadius:0
                                                                text:nil];
    [self.shippingMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addBottomLine];
}

#pragma mark -reload
- (void)bindViewModel:(ConfirmOrderListShippingCellViewModel *)vm
{
    self.shippingMoneyLabel.text = [NSString stringWithFormat:@"+¥ %@",vm.shippingMoneyValue];
}

@end
