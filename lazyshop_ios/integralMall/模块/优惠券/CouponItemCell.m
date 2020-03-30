//
//  GoodsDetailCouponItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CouponItemCell.h"

#import "CouponItemViewModel.h"

#define CouponStateBtnWidth 90.0f

@interface CouponItemCell()

@property (nonatomic,strong)UIImageView *backContentView;
@property (nonatomic,strong)UILabel *moneyValueLabel;
@property (nonatomic,strong)UILabel *tipMessageLabel1;
@property (nonatomic,strong)UILabel *tipMessageLabel2;
@property (nonatomic,strong)UILabel *validTimeLabel;
@property (nonatomic,strong)UIButton *couponStateBtn;

@end

@implementation CouponItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
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
    
    // stateButton
    self.couponStateBtn = [UIButton new];
    self.couponStateBtn.titleLabel.font = [UIFont boldSystemFontOfSize:LARGE_FONT_SIZE];
    [self.backContentView addSubview:self.couponStateBtn];
    [self.couponStateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(CouponStateBtnWidth);
    }];
    @weakify(self);
    self.couponStateBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:nil];
        return [RACSignal empty];
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
        make.width.mas_equalTo((KScreenWidth-15*3-CouponStateBtnWidth)/47.*17.);
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
        make.right.mas_equalTo(self.couponStateBtn.left).offset(-5);
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

- (void)bindViewModel:(CouponItemViewModel *)vm
{
    // 基础属性
    self.moneyValueLabel.text = [NSString stringWithFormat:@"¥ %@",vm.moneyValue];
    self.tipMessageLabel1.text = vm.tipMsg1;
    self.tipMessageLabel2.text = vm.tipMsg2;
    self.validTimeLabel.text = vm.validTime;
    
    UIEdgeInsets edge=UIEdgeInsetsMake(50, 50, 50, 150);
    // 按钮风格
    if (vm.checkBoxStyle) {
        // 右复选框风格
        self.couponStateBtn.hidden = YES;
        if (vm.selected) {
            self.backContentView.image = [[UIImage imageNamed:@"优惠券选中"] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
        }else{
            self.backContentView.image = [[UIImage imageNamed:@"优惠券未选中"] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
        }
    }else{
        // 右使用状态风格
        self.couponStateBtn.hidden = NO;
        // 状态
        switch (vm.couponState) {
            case GoodsDetailCouponState_CanReceive:
            {
                self.backContentView.image = [[UIImage imageNamed:@"优惠券可用"] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
                [self.couponStateBtn setTitle:@"立即领取" forState:UIControlStateNormal];
                self.couponStateBtn.enabled = YES;
            }
                break;
            case GoodsDetailCouponState_Received:
            {
                self.backContentView.image = [[UIImage imageNamed:@"优惠券可用"] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
                [self.couponStateBtn setTitle:@"已领取" forState:UIControlStateNormal];
                self.couponStateBtn.enabled = NO;
            }
                break;
            case GoodsDetailCouponState_NoneToReceive:
            {
                self.backContentView.image = [[UIImage imageNamed:@"优惠券不可用"] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
                [self.couponStateBtn setTitle:@"已领完" forState:UIControlStateNormal];
                self.couponStateBtn.enabled = NO;
            }
                break;
            case GoodsDetailCouponState_CanBeUsed:
            {
                self.backContentView.image = [[UIImage imageNamed:@"优惠券可用"] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
                [self.couponStateBtn setTitle:@"立即使用" forState:UIControlStateNormal];
                self.couponStateBtn.enabled = YES;
            }
                break;
            case GoodsDetailCouponState_Overdue:
            {
                self.backContentView.image = [[UIImage imageNamed:@"优惠券不可用"] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
                [self.couponStateBtn setTitle:@"已过期" forState:UIControlStateNormal];
                self.couponStateBtn.enabled = NO;
            }
                break;
            case GoodsDetailCouponState_Used:
            {
                self.backContentView.image = [[UIImage imageNamed:@"优惠券不可用"] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
                [self.couponStateBtn setTitle:@"已使用" forState:UIControlStateNormal];
                self.couponStateBtn.enabled = NO;
            }
                break;
                
            default:
                break;
        }
    }
    if (vm.couponState==GoodsDetailCouponState_Overdue || vm.couponState==GoodsDetailCouponState_CanBeUsed || vm.couponState == GoodsDetailCouponState_Used) {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
