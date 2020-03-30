//
//  MyOrdersSectionFooter.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyOrdersSectionFooter.h"

#import "LYTextColorButton.h"
#import "MyOrderListItemViewModel.h"

@interface MyOrdersSectionFooter()

@property (nonatomic,strong)UILabel *totalCountLabel;
@property (nonatomic,strong)UILabel *totalPriceLabel;
@property (nonatomic,strong)UILabel *orderStatusLabel;
@property (nonatomic,strong)LYTextColorButton *blackBottomButton;
@property (nonatomic,strong)LYTextColorButton *redBottomButton;

@end

@implementation MyOrdersSectionFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    UIView *topContentView = [UIView new];
    topContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topContentView];
    [topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(MyOrdersSectionFooterHeight/2.);
    }];
    [topContentView addBottomLine];
    // 总金额
    UILabel *totalPriceTipLabel = [topContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                           textAlignment:NSTextAlignmentCenter
                                                               textColor:@"#333333"
                                                            adjustsWidth:NO
                                                            cornerRadius:0
                                                                    text:@"总金额:"];
    [totalPriceTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topContentView.centerX).offset(-20);
        make.centerY.mas_equalTo(topContentView);
        make.width.mas_equalTo(MIDDLE_FONT_SIZE*4);
    }];
    // 具体金额
    self.totalPriceLabel = [topContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:nil
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(totalPriceTipLabel.right);
        make.centerY.mas_equalTo(totalPriceTipLabel);
    }];

    // 共多少件商品
    self.totalCountLabel = [topContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:NSTextAlignmentRight
                                                      textColor:@"#333333"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(totalPriceTipLabel.left).offset(-20);
        make.centerY.mas_equalTo(totalPriceTipLabel);
    }];
    
    UIView *bottomContentView = [UIView new];
    bottomContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomContentView];
    [bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(topContentView.bottom);
    }];
    // 订单状态
    self.orderStatusLabel = [bottomContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                      textAlignment:0
                                                          textColor:APP_MainColor
                                                       adjustsWidth:NO
                                                       cornerRadius:0
                                                               text:nil];
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(bottomContentView);
    }];
    // 黑色按钮
    self.blackBottomButton = [[LYTextColorButton alloc] initWithTitle:nil
                                                       buttonFontSize:MIDDLE_FONT_SIZE
                                                         cornerRadius:3];
    self.blackBottomButton.layer.borderColor = [CommUtls colorWithHexString:@"#333333"].CGColor;
    [self.blackBottomButton setTitleColor:[CommUtls colorWithHexString:@"#333333"]
                                 forState:UIControlStateNormal];
    [bottomContentView addSubview:self.blackBottomButton];
    [self.blackBottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(65);
        make.centerY.mas_equalTo(bottomContentView);
    }];
    // 红色按钮
    self.redBottomButton = [[LYTextColorButton alloc] initWithTitle:nil
                                                     buttonFontSize:MIDDLE_FONT_SIZE
                                                       cornerRadius:3];
    [bottomContentView addSubview:self.redBottomButton];
    [self.redBottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(65);
        make.centerY.mas_equalTo(bottomContentView);
    }];
}

#pragma mark -reload
- (void)bindViewModel:(MyOrderListItemViewModel *)vm
{
    // 总个数
    self.totalCountLabel.text = [NSString stringWithFormat:@"共%@件商品",vm.model.total_quantity];
    // 总金额
    NSString *totalMoeny = nil;
    if ([vm.model.order_type integerValue] == OrderType_Score) {
        totalMoeny = [NSString stringWithFormat:@"%@积分",vm.model.pay_total_score];
    }else{
        totalMoeny = [NSString stringWithFormat:@"¥%@",vm.model.pay_total_price];
    }

    NSString *postage = @"";
    if (vm.model.delivery_price.length) {
        postage = [NSString stringWithFormat:@"(含运费¥%@)",vm.model.delivery_price];
    }
    NSString *allMoney = [totalMoeny stringByAppendingString:postage];
    self.totalPriceLabel.attributedText = [CommUtls changeText:postage
                                                       content:allMoney
                                                changeTextFont:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                                      textFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                               changeTextColor:[CommUtls colorWithHexString:@"#5b5b5b"]
                                                     textColor:[CommUtls colorWithHexString:APP_MainColor]];
    // 订单状态
    OrderStatus orderStatus = [vm.model.order_status integerValue];
    @weakify(self);
    switch (orderStatus) {
        case OrderStatus_ToPay:
        {
            // 未支付
            self.orderStatusLabel.hidden = YES;
            self.redBottomButton.hidden = NO;
            [self.redBottomButton setTitle:@"付款" forState:UIControlStateNormal];
            [self.redBottomButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
            }];
            self.redBottomButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                [self.clickSignal sendNext:@(MyOrdersSectionFooter_ClickType_PayOrder)];
                return [RACSignal empty];
            }];
            
            self.blackBottomButton.hidden = NO;
            [self.blackBottomButton setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.blackBottomButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.redBottomButton.left).offset(-10);
            }];
            self.blackBottomButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                                message:@"确认取消"
                                                                 titles:@[@"取消",@"确定"]
                                                                  click:^(NSInteger index) {
                                                                      if (index == 1) {
                                                                          @strongify(self);
                                                                          [self.clickSignal sendNext:@(MyOrdersSectionFooter_ClickType_CancelOrder)];
                                                                      }
                                                                  }];
                [alert show];
                return [RACSignal empty];
            }];
        }
            break;
        case OrderStatus_NotSend:
        {
            // 待发货
            self.orderStatusLabel.hidden = NO;
            self.orderStatusLabel.text = @"待发货";
            self.redBottomButton.hidden = YES;
            self.blackBottomButton.hidden = YES;
        }
            break;
        case OrderStatus_ToReceive:
        {
            // 待收货
            self.orderStatusLabel.hidden = NO;
            self.orderStatusLabel.text = @"待收货";
            self.redBottomButton.hidden = NO;
            [self.redBottomButton setTitle:@"确认收货" forState:UIControlStateNormal];
            [self.redBottomButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
            }];
            self.redBottomButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                                message:@"确认收货"
                                                                 titles:@[@"取消",@"确定"]
                                                                  click:^(NSInteger index) {
                                                                      if (index == 1) {
                                                                          @strongify(self);
                                                                          [self.clickSignal sendNext:@(MyOrdersSectionFooter_ClickType_ConfirmOrder)];
                                                                      }
                                                                  }];
                [alert show];
                return [RACSignal empty];
            }];
            self.blackBottomButton.hidden = YES;
        }
            break;
        case OrderStatus_ToBecameGroup:
        {
            // 待成团
            self.orderStatusLabel.hidden = NO;
            self.orderStatusLabel.text = @"待成团";
            self.redBottomButton.hidden = YES;
            self.blackBottomButton.hidden = YES;
        }
            break;
        case OrderStatus_Complete:
        {
            // 已完成
            self.orderStatusLabel.hidden = NO;
            self.orderStatusLabel.text = @"已完成";
            self.redBottomButton.hidden = YES;
            self.blackBottomButton.hidden = YES;
        }
            break;
        case OrderStatus_Cancel:
        {
            // 已取消
            self.orderStatusLabel.hidden = NO;
            self.orderStatusLabel.text = @"已取消";
            self.redBottomButton.hidden = NO;
            [self.redBottomButton setTitle:@"删除订单" forState:UIControlStateNormal];
            [self.redBottomButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
            }];
            self.redBottomButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                                message:@"确认删除"
                                                                 titles:@[@"取消",@"确定"]
                                                                  click:^(NSInteger index) {
                                                                      if (index == 1) {
                                                                          @strongify(self);
                                                                          [self.clickSignal sendNext:@(MyOrdersSectionFooter_ClickType_DeleteOrder)];
                                                                      }
                                                                  }];
                [alert show];
                return [RACSignal empty];
            }];
            self.blackBottomButton.hidden = YES;
        }
            break;
        case OrderStatus_ToGroupRefound:
        {
            // 拼团失败-待退款
            self.orderStatusLabel.hidden = NO;
            self.orderStatusLabel.text = @"拼团失败-待退款";
            self.redBottomButton.hidden = YES;
            self.blackBottomButton.hidden = YES;
        }
            break;
        case OrderStatus_HaveRefounded:
        {
            // 已退款
            self.orderStatusLabel.hidden = NO;
            self.orderStatusLabel.text = @"已退款";
            self.redBottomButton.hidden = YES;
            self.blackBottomButton.hidden = YES;
        }
            break;
        case OrderStatus_GroupHaveRefounded:
        {
            // 拼团失败-已退款
            self.orderStatusLabel.hidden = NO;
            self.orderStatusLabel.text = @"拼团失败-已退款";
            self.redBottomButton.hidden = YES;
            self.blackBottomButton.hidden = YES;
        }
            break;
        case OrderStatus_GroupComplete:
        {
            // 拼团订单-已完成
            self.orderStatusLabel.hidden = NO;
            self.orderStatusLabel.text = @"拼团订单-已完成";
            self.redBottomButton.hidden = YES;
            self.blackBottomButton.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

@end
