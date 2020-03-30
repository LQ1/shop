//
//  ConfirmOrderListCashbackCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/27.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListCashbackCell.h"

#import "ConfirmOrderListCashbackCellViewModel.h"

@interface ConfirmOrderListCashbackCell()

@property (nonatomic,strong)UILabel *cashBackLabel;
@property (nonatomic,strong)UILabel *cashMoneyLabel;

@end

@implementation ConfirmOrderListCashbackCell

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
    // 返现
    UILabel *tipLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:@"#333333"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:@"返现"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.cashBackLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#000000"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.cashBackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipLabel.right).offset(20);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
//    self.cashMoneyLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
//                                                   textAlignment:NSTextAlignmentRight
//                                                       textColor:APP_MainColor
//                                                    adjustsWidth:NO
//                                                    cornerRadius:0
//                                                            text:nil];
//    [self.cashMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-15);
//        make.centerY.mas_equalTo(self.contentView);
//    }];
    
    [self.contentView addBottomLine];
}

#pragma mark -reload
- (void)bindViewModel:(ConfirmOrderListCashbackCellViewModel *)vm
{
    self.cashBackLabel.text = [NSString stringWithFormat:@"返现%@%%,分%ld期,每期间隔%ld天",vm.periodPercent,(long)vm.periodNumbers,(long)vm.periodInterval];
//    self.cashMoneyLabel.text = [NSString stringWithFormat:@"x%ld",(long)vm.periodNumbers];
}

@end
