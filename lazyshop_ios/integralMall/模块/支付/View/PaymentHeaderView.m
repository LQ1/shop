//
//  PaymentHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/30.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PaymentHeaderView.h"

#import "PaymentViewModel.h"

@interface PaymentHeaderView()

@property (nonatomic,strong)UILabel *payMoneyLabel;

@end

@implementation PaymentHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView *firstContentView = [UIView new];
    firstContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:firstContentView];
    [firstContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(8);
        make.height.mas_equalTo(40);
    }];
    
    self.payMoneyLabel = [UILabel new];
    self.payMoneyLabel.textAlignment = NSTextAlignmentRight;
    [firstContentView addSubview:self.payMoneyLabel];
    [self.payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(firstContentView);
    }];
    
    UIView *secondContentView = [UIView new];
    secondContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:secondContentView];
    [secondContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(36);
        make.bottom.mas_equalTo(0);
    }];

    UILabel *tipLabel = [secondContentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#000000"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:@"支付方式"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(secondContentView);
    }];
    
    [self addBottomLine];
}

- (void)realodDataWithViewModel:(PaymentViewModel *)viewModel
{
    NSString *tipString = @"需支付: ";
    NSString *payMoneyString = [NSString stringWithFormat:@"%@元",viewModel.orderMoney];
    NSString *contentString = [tipString stringByAppendingString:payMoneyString];
    
    self.payMoneyLabel.attributedText = [CommUtls changeText:payMoneyString
                                                     content:contentString
                                              changeTextFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                                    textFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                             changeTextColor:[CommUtls colorWithHexString:APP_MainColor]
                                                   textColor:[CommUtls colorWithHexString:@"#000000"]];
}

@end
