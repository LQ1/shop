//
//  MyOrdersRefoundFooter.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyOrdersRefoundFooter.h"

#import "MyRefoundItemViewModel.h"

@interface MyOrdersRefoundFooter()

@property (nonatomic,strong)UILabel *refoundStatusLabel;
@property (nonatomic,strong)UILabel *refoundTipLabel;
@property (nonatomic,strong)UILabel *refoundMoneyLabel;

@end

@implementation MyOrdersRefoundFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    UIView *topContentView = [UIView new];
    topContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topContentView];
    [topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    // 售后状态
    self.refoundStatusLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                       textAlignment:0
                                                           textColor:APP_MainColor
                                                        adjustsWidth:NO
                                                        cornerRadius:0
                                                                text:nil];
    [self.refoundStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];

    // 具体金额
    self.refoundMoneyLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#ff1600"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];

    [self.refoundMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    // 退款金额
    UILabel *refoundTipLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                        textAlignment:NSTextAlignmentCenter
                                                            textColor:@"#333333"
                                                         adjustsWidth:NO
                                                         cornerRadius:0
                                                                 text:@"退款金额:"];
    self.refoundTipLabel = refoundTipLabel;
    [refoundTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.refoundMoneyLabel.left).offset(-4);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark -bind
- (void)bindViewModel:(MyRefoundItemViewModel *)vm
{
    self.refoundStatusLabel.text = vm.model.string_status;
    if ([vm.model.order_type integerValue] == OrderType_Score) {
        self.refoundTipLabel.hidden = YES;
        self.refoundMoneyLabel.hidden = YES;
    }else{
        if ([vm.model.apply_type integerValue] == 1) {
            self.refoundTipLabel.hidden = NO;
            self.refoundMoneyLabel.hidden = NO;
            self.refoundMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",vm.model.refund_money];
        }else{
            self.refoundTipLabel.hidden = YES;
            self.refoundMoneyLabel.hidden = YES;
        }
    }
}

@end
