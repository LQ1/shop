//
//  ConfirmDetailHeaderCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailHeaderCell.h"

#import "OrderDetailHeaderCellViewModel.h"

@interface OrderDetailHeaderCell()

@property (nonatomic,strong)UIImageView *clockIconView;
@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UILabel *timeLabel;

@end

@implementation OrderDetailHeaderCell

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
    // 背景
    UIImageView *backView = [self.contentView addImageViewWithImageName:@"订单详情背景"
                                                           cornerRadius:0];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(1);
    }];
    // 时钟logo
    self.clockIconView = [self.contentView addImageViewWithImageName:nil
                                                        cornerRadius:0];
    [self.clockIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(25);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    // 状态
    self.statusLabel = [self.contentView addLabelWithFontSize:LARGE_FONT_SIZE
                                                textAlignment:0
                                                    textColor:@"#ffffff"
                                                 adjustsWidth:NO
                                                 cornerRadius:0
                                                         text:nil];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(48);
        make.centerY.mas_equalTo(self.contentView);
    }];
    // 时间
    self.timeLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                              textAlignment:NSTextAlignmentRight
                                                  textColor:@"#ffffff"
                                               adjustsWidth:NO
                                               cornerRadius:0
                                                       text:nil];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark -reload
- (void)bindViewModel:(OrderDetailHeaderCellViewModel *)vm
{
    switch (vm.orderStatus) {
        case OrderStatus_ToPay:
        {
            // 待支付
            self.clockIconView.hidden = NO;
            self.clockIconView.image = [UIImage imageNamed:@"订单详情时间图标"];
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"等待买家付款";
            self.timeLabel.hidden = NO;
            self.timeLabel.text = vm.timeTip;
        }
            break;
        case OrderStatus_NotSend:
        {
            // 待发货
            self.clockIconView.hidden = NO;
            self.clockIconView.image = [UIImage imageNamed:@"订单详情时间图标"];
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"商家未发货";
            self.timeLabel.hidden = YES;
        }
            break;
        case OrderStatus_ToReceive:
        {
            // 待收货
            self.clockIconView.hidden = NO;
            self.clockIconView.image = [UIImage imageNamed:@"订单详情时间图标"];
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"商家已发货";
            self.timeLabel.hidden = NO;
            self.timeLabel.text = vm.timeTip;
        }
            break;
        case OrderStatus_ToBecameGroup:
        {
            // 待成团
            self.clockIconView.hidden = NO;
            self.clockIconView.image = [UIImage imageNamed:@"订单详情时间图标"];
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"拼单还未成功";
            self.timeLabel.hidden = NO;
            self.timeLabel.text = @"让朋友们都来拼单吧";
        }
            break;
        case OrderStatus_Complete:
        {
            // 已完成
            self.clockIconView.hidden = NO;
            self.clockIconView.image = [UIImage imageNamed:@"订单详情成功"];
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"交易成功";
            self.timeLabel.hidden = YES;
        }
            break;
        case OrderStatus_Cancel:
        {
            // 已取消
            self.clockIconView.hidden = NO;
            self.clockIconView.image = [UIImage imageNamed:@"订单详情交易关闭"];
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"交易关闭";
            self.timeLabel.hidden = YES;
        }
            break;
        case OrderStatus_ToGroupRefound:
        {
            // 拼团失败-待退款
            self.clockIconView.hidden = NO;
            self.clockIconView.image = [UIImage imageNamed:@"订单详情时间图标"];
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"拼团失败-待退款";
            self.timeLabel.hidden = YES;
        }
            break;
        case OrderStatus_HaveRefounded:
        {
            // 已退款
            self.clockIconView.hidden = NO;
            self.clockIconView.image = [UIImage imageNamed:@"订单详情交易关闭"];
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"已退款";
            self.timeLabel.hidden = YES;
        }
            break;
        case OrderStatus_GroupHaveRefounded:
        {
            // 拼团失败-已退款
            self.clockIconView.hidden = NO;
            self.clockIconView.image = [UIImage imageNamed:@"订单详情交易关闭"];
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"拼团失败-已退款";
            self.timeLabel.hidden = YES;
        }
            break;
        case OrderStatus_GroupComplete:
        {
            // 拼团订单-已完成
            self.clockIconView.hidden = NO;
            self.clockIconView.image = [UIImage imageNamed:@"订单详情成功"];
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"拼团订单-已完成";
            self.timeLabel.hidden = YES;
        }
            break;
        case OrderStatus_WaitStorePay:
        {
            // 等待商家线下收款
            self.clockIconView.hidden = NO;
            self.clockIconView.image = [UIImage imageNamed:@"订单详情时间图标"];
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"等待到店支付中...";
            self.timeLabel.hidden = NO;
            self.timeLabel.text = vm.timeTip;
        }
            break;
            
        default:
            break;
    }
}

@end
