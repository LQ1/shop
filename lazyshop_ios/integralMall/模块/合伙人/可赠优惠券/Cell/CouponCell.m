//
//  CouponCell.m
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "CouponCell.h"

#define CouponStateViewWidth 90.0f

@interface CouponCell ()

@property (nonatomic,strong)UIImageView *backContentView;
@property (nonatomic,strong)UILabel *moneyValueLabel;
@property (nonatomic,strong)UILabel *tipMessageLabel1;
@property (nonatomic,strong)UILabel *tipMessageLabel2;
@property (nonatomic,strong)UILabel *validTimeLabel;
@property (nonatomic,strong)UIView *couponStateView;

@end

@implementation CouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    
    return self;
}

#pragma mark -主界面
- (void)addViews {
    // 图
    self.backContentView = [self.contentView addImageViewWithImageName:nil
                                                          cornerRadius:0];
    self.backContentView.userInteractionEnabled = YES;
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    
    // money
    self.moneyValueLabel = [self.backContentView addLabelWithFontSize:23
                                                        textAlignment:0
                                                            textColor:@"#ffffff"
                                                         adjustsWidth:NO
                                                         cornerRadius:0
                                                                 text:nil];
    self.moneyValueLabel.font = [UIFont boldSystemFontOfSize:23];
    [self.moneyValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
    }];
    
    // stateButton
    self.couponStateView = [UIView new];
    [self.couponStateView setBackgroundColor:[UIColor clearColor]];
    [self.backContentView addSubview:self.couponStateView];
    [self.couponStateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(CouponStateViewWidth);
    }];
    
    // tip1
    self.tipMessageLabel1 = [self.backContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                         textAlignment:0
                                                             textColor:@"#ffffff"
                                                          adjustsWidth:YES
                                                          cornerRadius:0
                                                                  text:nil];
    self.tipMessageLabel1.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
    [self.tipMessageLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moneyValueLabel);
        make.top.mas_equalTo(self.moneyValueLabel.bottom).offset(15);
        make.width.mas_equalTo((KScreenWidth-15*3-CouponStateViewWidth)/47.*17.);
    }];
    // tip2
    self.tipMessageLabel2 = [self.backContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                         textAlignment:0
                                                             textColor:@"#ffffff"
                                                          adjustsWidth:YES
                                                          cornerRadius:0
                                                                  text:nil];
    [self.tipMessageLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tipMessageLabel1.right).offset(5);
        make.right.mas_equalTo(self.couponStateView.left).offset(-5);
        make.centerY.mas_equalTo(self.tipMessageLabel1);
    }];
    
    // validTime
    self.validTimeLabel = [self.backContentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                       textAlignment:0
                                                           textColor:@"#ffffff"
                                                        adjustsWidth:YES
                                                        cornerRadius:0
                                                                text:nil];
    [self.validTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tipMessageLabel1);
        make.right.mas_equalTo(self.tipMessageLabel2);
        make.top.mas_equalTo(self.tipMessageLabel1.bottom).offset(10);
    }];
}

- (void)loadData:(CouponListModel*)model{
    // 基础属性
    self.moneyValueLabel.text = [NSString stringWithFormat:@"¥ %@",model.coupon_price];
    self.tipMessageLabel1.text = model.coupon_title;
    self.tipMessageLabel2.text = model.coupon_description;
    self.validTimeLabel.text = [NSString stringWithFormat:@"%@至%@",model.use_start_at,model.use_end_at];
    
    UIEdgeInsets edge = UIEdgeInsetsMake(50, 50, 50, 150);
    if (model.isChecked) {
        self.backContentView.image = [[UIImage imageNamed:@"优惠券选中"] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    } else {
        self.backContentView.image = [[UIImage imageNamed:@"优惠券未选中"] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    }
}

@end
