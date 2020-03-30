//
//  ShoppingCartBottomView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShoppingCartBottomView.h"

#import <DLUIKit/CheckBoxButton.h>

#import "ShoppingCartViewModel.h"

@interface ShoppingCartBottomView()

@property (nonatomic,strong)ShoppingCartViewModel *viewModel;

@property (nonatomic,strong)CheckBoxButton *checkButton;

@property (nonatomic,strong)UIView *payStateContentView;
@property (nonatomic,strong)UILabel *payTotalPriceLabel;
@property (nonatomic,strong)UIButton *payButton;

@property (nonatomic,strong)UIButton *editingStateDeleteButton;

@end

@implementation ShoppingCartBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    // 全选
    self.checkButton = [[CheckBoxButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)
                                               checkImgeWith:[UIImage imageNamed:@"选择收货地址未选中"]
                                             checkedImgeWith:[UIImage imageNamed:@"默认地址选中"] selectCheckedWith:NO];
    [self addSubview:self.checkButton];
    self.checkButton.userInteractionEnabled = NO;
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(17);
        make.centerY.mas_equalTo(self);
    }];
    self.checkButton.userInteractionEnabled = NO;
    
    UILabel *allCheckTipLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                             textAlignment:0
                                                 textColor:@"#5d5f6a"
                                              adjustsWidth:NO
                                              cornerRadius:0
                                                      text:@"全选"];
    [allCheckTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.checkButton.right).offset(7.5);
        make.centerY.mas_equalTo(self.checkButton);
    }];
    
    UIButton *clickBtn = [UIButton new];
    [self addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(60);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.checkButton.checked = !self.checkButton.checked;
        [self revalAllCheck];
        return [RACSignal empty];
    }];
    
    // 非编辑
    self.payStateContentView = [UIView new];
    [self addSubview:self.payStateContentView];
    [self.payStateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(allCheckTipLabel.right);
        make.top.bottom.right.mas_equalTo(0);
    }];
    
    UILabel *totalTipLabel = [self.payStateContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                          textAlignment:0
                                              textColor:@"#5d5f6a"
                                           adjustsWidth:NO
                                           cornerRadius:0
                                                   text:@"合计:"];
    [totalTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.centerY.mas_equalTo(self);
    }];
    
    self.payTotalPriceLabel = [self.payStateContentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                               textAlignment:0
                                                                   textColor:@"#5d5d6a"
                                                                adjustsWidth:YES
                                                                cornerRadius:0
                                                                        text:nil];
    [self.payTotalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(totalTipLabel.right).offset(10);
        make.centerY.mas_equalTo(totalTipLabel);
    }];
    
    self.payButton = [UIButton new];
    self.payButton.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    self.payButton.titleLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    [self.payStateContentView addSubview:self.payButton];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(95);
    }];
    self.payButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self gotoPay];
        return [RACSignal empty];
    }];
    
    // 编辑
    self.editingStateDeleteButton = [UIButton new];
    self.editingStateDeleteButton.layer.borderColor = [CommUtls colorWithHexString:@"#e02e24"].CGColor;
    self.editingStateDeleteButton.layer.borderWidth = 1;
    [self.editingStateDeleteButton setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateNormal];
    [self.editingStateDeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    self.editingStateDeleteButton.titleLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    [self addSubview:self.editingStateDeleteButton];
    [self.editingStateDeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(61.5);
        make.height.mas_equalTo(28);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
    }];
    
    self.editingStateDeleteButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self deleteSelects];
        return [RACSignal empty];
    }];
}

#pragma mark -点击事件

- (void)revalAllCheck
{
    [self.viewModel revalAllCheck];
}

- (void)gotoPay
{
    [self.viewModel gotoPay];
}

- (void)deleteSelects
{
    [self.viewModel deleteSelectGoods];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(ShoppingCartViewModel *)viewModel
{
    self.viewModel = viewModel;
    
    // 是否全选
    self.checkButton.checked = [self.viewModel checkAllSelected];
    
    if (self.viewModel.editting) {
        // 编辑状态
        self.editingStateDeleteButton.hidden = NO;
        self.payStateContentView.hidden = YES;
    }else{
        // 非编辑
        self.editingStateDeleteButton.hidden = YES;
        self.payStateContentView.hidden = NO;
        
        self.payTotalPriceLabel.text = [NSString stringWithFormat:@"¥ %@",[viewModel totalPrice]];
        
        NSInteger paySelectNumber = [viewModel selectedGoodsNumber];
        [self.payButton setTitle:[NSString stringWithFormat:@"去结算  (%ld)",(long)paySelectNumber] forState:UIControlStateNormal];
        if (paySelectNumber>0) {
            self.payButton.enabled = YES;
            self.payButton.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
        }else{
            self.payButton.enabled = NO;
            self.payButton.backgroundColor = [CommUtls colorWithHexString:@"#999999"];
        }
    }
}

@end
