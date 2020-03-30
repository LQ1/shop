//
//  OrderDetailBottomActionView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/5.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailBottomActionView.h"

#import "LYTextColorButton.h"
#import "MyOrderListItemViewModel.h"
#import "OrderDetailViewModel.h"

@interface OrderDetailBottomActionView()

@property (nonatomic,strong)LYTextColorButton *blackBottomButton;
@property (nonatomic,strong)LYTextColorButton *redBottomButton;
@property (nonatomic,strong)OrderDetailViewModel *viewModel;

@end

@implementation OrderDetailBottomActionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];
    // 黑色按钮
    self.blackBottomButton = [[LYTextColorButton alloc] initWithTitle:nil
                                                       buttonFontSize:MIDDLE_FONT_SIZE
                                                         cornerRadius:3];
    self.blackBottomButton.layer.borderColor = [CommUtls colorWithHexString:@"#333333"].CGColor;
    [self.blackBottomButton setTitleColor:[CommUtls colorWithHexString:@"#333333"]
                                 forState:UIControlStateNormal];
    [self addSubview:self.blackBottomButton];
    [self.blackBottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(65);
        make.centerY.mas_equalTo(self);
    }];
    // 红色按钮
    self.redBottomButton = [[LYTextColorButton alloc] initWithTitle:nil
                                                     buttonFontSize:MIDDLE_FONT_SIZE
                                                       cornerRadius:3];
    [self addSubview:self.redBottomButton];
    [self.redBottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(65);
        make.centerY.mas_equalTo(self);
    }];
    
    [self addTopLine];
}

#pragma mark -reload
- (void)bindViewModel:(OrderDetailViewModel *)viewModel
{
    self.viewModel = viewModel;
    @weakify(self);
    switch (self.viewModel.order_status) {
        case OrderStatus_Cancel:
        {
            // 已取消
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
                                                                          [self.clickSignal sendNext:@(OrderDetailBottomActionType_DeleteOrder)];
                                                                      }
                                                                  }];
                [alert show];
                return [RACSignal empty];
            }];
            self.blackBottomButton.hidden = YES;
        }
            break;
        case OrderStatus_ToPay:
        {
            // 未支付
            self.redBottomButton.hidden = NO;
            [self.redBottomButton setTitle:@"付款" forState:UIControlStateNormal];
            [self.redBottomButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
            }];
            self.redBottomButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                [self.clickSignal sendNext:@(OrderDetailBottomActionType_PayOrder)];
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
                                                                          [self.clickSignal sendNext:@(OrderDetailBottomActionType_CancelOrder)];
                                                                      }
                                                                  }];
                [alert show];
                return [RACSignal empty];
            }];
        }
            break;
        case OrderStatus_ToReceive:
        {
            // 已发货
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
                                                                          [self.clickSignal sendNext:@(OrderDetailBottomActionType_ConfirmOrder)];
                                                                      }
                                                                  }];
                [alert show];
                return [RACSignal empty];
            }];
            self.blackBottomButton.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

@end
