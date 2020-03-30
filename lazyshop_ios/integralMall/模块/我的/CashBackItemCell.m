//
//  CashBackItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CashBackItemCell.h"

#import "CashBackItemViewModel.h"

@interface CashBackItemCell()

@property (nonatomic,strong)UIView *backContentView;
@property (nonatomic,strong)UIView *downContentView;

@property (nonatomic,strong)UILabel *issueNumberLabel;
@property (nonatomic,strong)UILabel *cashBackMoneyLabel;
@property (nonatomic,strong)UILabel *cashBackCodeLabel;
@property (nonatomic,strong)UILabel *cashBackStateLabel;
@property (nonatomic,strong)UIView  *cashBackStateLeftLine;
@property (nonatomic,strong)UILabel *cashBackDateLabel;
@property (nonatomic,strong)UILabel *cashBackTimeLabel;
@property (nonatomic,strong)UILabel *cashBackTipLabel;

@end

@implementation CashBackItemCell

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
    self.backgroundColor = [UIColor clearColor];
    
    UIView *backContentView = [UIView new];
    self.backContentView = backContentView;
    backContentView.backgroundColor = [CommUtls colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:backContentView];
    [backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(0);
    }];
    // 上
    UIView *upContentView = [UIView new];
    upContentView.backgroundColor = [UIColor clearColor];
    [backContentView addSubview:upContentView];
    [upContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(CashBackItemCellUpHeight);
    }];
    [upContentView addBottomLineWithColorString:@"#ffffff"];
    // 下
    self.downContentView = [UIView new];
    self.downContentView.backgroundColor = [UIColor clearColor];
    [backContentView addSubview:self.downContentView];
    [self.downContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(upContentView.bottom);
    }];

    // 期数
    self.issueNumberLabel = [upContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#ffffff"
                                                   adjustsWidth:YES
                                                   cornerRadius:0
                                                           text:nil];
    [self.issueNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(12.5);
        make.width.mas_equalTo(MIDDLE_FONT_SIZE*4);
    }];
    // 返现状态
    self.cashBackStateLabel = [upContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                    textAlignment:NSTextAlignmentCenter
                                                        textColor:@"#ffffff"
                                                     adjustsWidth:NO
                                                     cornerRadius:0
                                                             text:nil];
    [self.cashBackStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    self.cashBackStateLeftLine = [self.cashBackStateLabel addLeftLineWithColorString:@"#ffffff"];
    // 返现码
    self.cashBackCodeLabel = [upContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                   textAlignment:0
                                                       textColor:@"#ffffff"
                                                    adjustsWidth:NO
                                                    cornerRadius:0
                                                            text:nil];
    self.cashBackCodeLabel.adjustsFontSizeToFitWidth = YES;
    [self.cashBackCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.issueNumberLabel);
        make.bottom.mas_equalTo(-12.5);
        make.right.mas_equalTo(self.cashBackStateLabel.left).offset(-12.5);
    }];
    // 返利金额
    self.cashBackMoneyLabel = [upContentView addLabelWithFontSize:25
                                                    textAlignment:NSTextAlignmentRight
                                                        textColor:@"#ffffff"
                                                     adjustsWidth:YES
                                                     cornerRadius:0
                                                             text:nil];
    self.cashBackMoneyLabel.font = [UIFont boldSystemFontOfSize:25];
    [self.cashBackMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cashBackStateLabel.left).offset(-24);
        make.top.mas_equalTo(self.issueNumberLabel).offset(-5);
        make.left.mas_equalTo(self.issueNumberLabel.right);
    }];
    
    // 返利日期
    self.cashBackDateLabel = [self.downContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                          textAlignment:0
                                                              textColor:@"#ffffff"
                                                           adjustsWidth:NO
                                                           cornerRadius:0
                                                                   text:nil];
    [self.cashBackDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.downContentView);
        make.width.mas_equalTo(100);
    }];
    // 返利时间
    self.cashBackTimeLabel = [self.downContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                          textAlignment:0
                                                              textColor:@"#ffffff"
                                                           adjustsWidth:NO
                                                           cornerRadius:0
                                                                   text:nil];
    [self.cashBackTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cashBackDateLabel.right).offset(13);
        make.centerY.mas_equalTo(self.cashBackDateLabel);
        make.width.mas_equalTo(50);
    }];
    // 返利说明
    self.cashBackTipLabel = [self.downContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                         textAlignment:0
                                                             textColor:@"#ffffff"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:nil];
    [self.cashBackTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cashBackTimeLabel.right).offset(14);
        make.centerY.mas_equalTo(self.cashBackTimeLabel);
    }];
}

#pragma mark -reload
- (void)bindViewModel:(CashBackItemViewModel *)vm
{
    if (vm.isHistoryItem) {
        self.downContentView.hidden = NO;
        self.backContentView.layer.cornerRadius = 3;
        self.backContentView.layer.masksToBounds = YES;
    }else{
        self.downContentView.hidden = YES;
    }
    
    switch (vm.state) {
        case CashBackState_Invalid:
        {
            self.cashBackStateLabel.text = @"不可用";
            
            self.backContentView.backgroundColor = [CommUtls colorWithHexString:@"#cccccc"];
            self.cashBackStateLeftLine.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];
            
            self.issueNumberLabel.textColor = [CommUtls colorWithHexString:@"#ffffff"];
            self.cashBackMoneyLabel.textColor = [CommUtls colorWithHexString:@"#ffffff"];
            self.cashBackStateLabel.textColor = [CommUtls colorWithHexString:@"#ffffff"];
            self.cashBackCodeLabel.textColor = [CommUtls colorWithHexString:@"#ffffff"];
        }
            break;
        case CashBackState_NotUse:
        {
            self.cashBackStateLabel.text = @"未使用";
            
            self.backContentView.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];
            self.cashBackStateLeftLine.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];

            self.issueNumberLabel.textColor = [CommUtls colorWithHexString:@"#333333"];
            self.cashBackMoneyLabel.textColor = [CommUtls colorWithHexString:APP_MainColor];
            self.cashBackStateLabel.textColor = [CommUtls colorWithHexString:@"#333333"];
            self.cashBackCodeLabel.textColor = [CommUtls colorWithHexString:@"#333333"];

        }
            break;
        case CashBackState_Used:
        {
            self.cashBackStateLabel.text = @"已使用";
            
            self.backContentView.backgroundColor = [CommUtls colorWithHexString:@"#cccccc"];
            self.cashBackStateLeftLine.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];

            self.issueNumberLabel.textColor = [CommUtls colorWithHexString:@"#ffffff"];
            self.cashBackMoneyLabel.textColor = [CommUtls colorWithHexString:@"#ffffff"];
            self.cashBackStateLabel.textColor = [CommUtls colorWithHexString:@"#ffffff"];
            self.cashBackCodeLabel.textColor = [CommUtls colorWithHexString:@"#ffffff"];
        }
            break;
            
        default:
            break;
    }
    self.issueNumberLabel.text = vm.cashBackIssue;
    self.cashBackMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",vm.cashBackMoney];
    self.cashBackCodeLabel.text = vm.cashBackCode;
    
    self.cashBackDateLabel.text = vm.cashBackDate;
    self.cashBackTimeLabel.text = vm.cashBackTime;
    self.cashBackTipLabel.text = vm.cashBackTip;
}

@end
