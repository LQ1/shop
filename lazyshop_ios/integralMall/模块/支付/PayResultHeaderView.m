//
//  PayResultHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PayResultHeaderView.h"

#import "LYTextColorButton.h"
#import "PayResultViewModel.h"

@interface PayResultHeaderView()

@property (nonatomic, strong) UIImageView *resultTipView;
@property (nonatomic, strong) UILabel *payMentLabel;
@property (nonatomic, strong) UILabel *payValueLabel;
@property (nonatomic, strong) LYTextColorButton *checkOrderBtn;
@property (nonatomic, strong) PayResultViewModel *viewModel;

@end

@implementation PayResultHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat tipWidth = 68.0f;
    self.resultTipView = [self addImageViewWithImageName:nil
                                            cornerRadius:0];
    [self.resultTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(tipWidth);
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(57);
    }];
    
    UILabel *paymentTipLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                            textAlignment:0
                                                textColor:@"#000000"
                                             adjustsWidth:NO
                                             cornerRadius:0
                                                     text:@"支付方式:"];
    [paymentTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.resultTipView.right).offset(40);
        make.bottom.mas_equalTo(self.resultTipView.centerY).offset(-15);
        make.width.mas_equalTo(75);
    }];
    self.payMentLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                     textAlignment:0
                                         textColor:APP_MainColor
                                      adjustsWidth:NO
                                      cornerRadius:0
                                              text:nil];
    self.payMentLabel.font = [UIFont boldSystemFontOfSize:LARGE_FONT_SIZE];
    [self.payMentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(paymentTipLabel.right);
        make.centerY.mas_equalTo(paymentTipLabel);
    }];
    
    UILabel *payValueLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                          textAlignment:0
                                              textColor:@"#000000"
                                           adjustsWidth:NO
                                           cornerRadius:0
                                                   text:@"订单金额:"];
    [payValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.resultTipView.right).offset(40);
        make.top.mas_equalTo(self.resultTipView.centerY).offset(15);
        make.width.mas_equalTo(75);
    }];
    self.payValueLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                     textAlignment:0
                                         textColor:APP_MainColor
                                      adjustsWidth:NO
                                      cornerRadius:0
                                              text:nil];
    self.payValueLabel.font = [UIFont boldSystemFontOfSize:LARGE_FONT_SIZE];
    [self.payValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(payValueLabel.right);
        make.centerY.mas_equalTo(payValueLabel);
    }];
    
    self.checkOrderBtn = [[LYTextColorButton alloc] initWithTitle:nil
                                                   buttonFontSize:LARGE_FONT_SIZE
                                                     cornerRadius:0];
    [self addSubview:self.checkOrderBtn];
    [self.checkOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-25);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(45);
        make.centerX.mas_equalTo(self);
    }];
    
    @weakify(self);
    self.checkOrderBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self checkOrder];
        return [RACSignal empty];
    }];
}

- (void)checkOrder
{
    [self.viewModel checkBtnClick];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(PayResultViewModel *)viewModel
{
    self.viewModel = viewModel;
    if (viewModel.paySuccess) {
        self.resultTipView.image = [UIImage imageNamed:@"支付成功-(2)"];
        [self.checkOrderBtn setTitle:@"查看订单"
                            forState:UIControlStateNormal];
    }else{
        self.resultTipView.image = [UIImage imageNamed:@"支付失败-(1)"];
        [self.checkOrderBtn setTitle:@"重新支付"
                            forState:UIControlStateNormal];
    }
    switch (viewModel.payMentType) {
        case PayMentType_WXPay:
        {
            self.payMentLabel.text = @"微信支付";
        }
            break;
        case PayMentType_AliPay:
        {
            self.payMentLabel.text = @"支付宝支付";
        }
            break;
        case PayMentType_UnionPay:
        {
            self.payMentLabel.text = @"银联支付";
        }
            break;
        case PayMentType_ShopPay:
        {
            self.payMentLabel.text = @"到店支付";
        }
            break;
        case PayMentType_Score:
        {
            self.payMentLabel.text = @"积分支付";
        }
            break;
            
        default:
            break;
    }
    self.payValueLabel.text = viewModel.payValue;
}

@end
