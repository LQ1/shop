//
//  CashBackHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CashBackHeaderView.h"

#import "CashBackSectionViewModel.h"

#import "UIView+FillCorner.h"

#import "OrderDetailViewModel.h"
#import "SelectStoreViewModel.h"

@interface CashBackHeaderView()

@property (nonatomic,strong)UILabel *productNameLabel;
@property (nonatomic,strong)UILabel *storeNameLabel;
@property (nonatomic,strong)UIImageView *storeNameArrowView;

@property (nonatomic,strong)CashBackSectionViewModel *viewModel;

@end

@implementation CashBackHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _gotoOrderDetailSignal = [[RACSubject subject] setNameWithFormat:@"%@ gotoOrderDetailSignal", self.class];
        _gotoBindShopSignal = [[RACSubject subject] setNameWithFormat:@"%@ gotoBindShopSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 背景
    UIView *backView = [UIView new];
    backView.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    // 载体
    UIView *backContentView = [UIView new];
    backContentView.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];
    [backView addSubview:backContentView];
    [backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(7.5);
        make.bottom.mas_equalTo(0);
    }];
    backContentView.layer.cornerRadius = 5;
    backContentView.layer.masksToBounds = YES;
    
    [backContentView lyFillBottomCornerWithWidth:5
                                     colorString:@"#ffffff"];
    
    // 上 载体
    UIView *upContentView = [UIView new];
    [backContentView addSubview:upContentView];
    [upContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [upContentView addBottomLine];
    // 商品名称
    UILabel *productTipLabel = [upContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                     textAlignment:0
                                                         textColor:@"#333333"
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:@"商品名称:"];
    [productTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(upContentView);
        make.width.mas_equalTo(MIDDLE_FONT_SIZE*5);
    }];
    
    UIImage *rightArrowImage = [UIImage imageNamed:@"编辑收货地址箭头"];
    UIImageView *productNameArrowView = [[UIImageView alloc] initWithImage:rightArrowImage];
    [upContentView addSubview:productNameArrowView];
    [productNameArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(upContentView);
        make.width.mas_equalTo(rightArrowImage.size.width);
        make.height.mas_equalTo(rightArrowImage.size.height);
    }];
    
    self.productNameLabel = [upContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:NSTextAlignmentRight
                                                      textColor:@"#333333"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productTipLabel.right).offset(3);
        make.right.mas_equalTo(productNameArrowView.left).offset(-20);
        make.centerY.mas_equalTo(productTipLabel);
    }];
    // 点击事件
    UIButton *productClickBtn = [UIButton new];
    [upContentView addSubview:productClickBtn];
    [productClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    productClickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self productClick];
        return [RACSignal empty];
    }];
    
    // 下 载体
    UIView *downContentView = [UIView new];
    [backContentView addSubview:downContentView];
    [downContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(upContentView.bottom);
    }];
    // 店铺名称
    UILabel *storeTipLabel = [downContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                     textAlignment:0
                                                         textColor:@"#333333"
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:@"选择店铺:"];
    [storeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(downContentView);
        make.width.mas_equalTo(MIDDLE_FONT_SIZE*5);
    }];
    
    UIImageView *storeNameArrowView = [[UIImageView alloc] initWithImage:rightArrowImage];
    self.storeNameArrowView = storeNameArrowView;
    [downContentView addSubview:storeNameArrowView];
    [storeNameArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(downContentView);
        make.width.mas_equalTo(rightArrowImage.size.width);
        make.height.mas_equalTo(rightArrowImage.size.height);
    }];
    
    self.storeNameLabel = [downContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:NSTextAlignmentRight
                                                      textColor:@"#666666"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(storeTipLabel.right).offset(3);
        make.right.mas_equalTo(storeNameArrowView.left).offset(-20);
        make.centerY.mas_equalTo(storeTipLabel);
    }];
    // 点击事件
    UIButton *storeClickBtn = [UIButton new];
    [downContentView addSubview:storeClickBtn];
    [storeClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    storeClickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self storeClick];
        return [RACSignal empty];
    }];
    
    [self addBottomLine];
}

#pragma mark -点击事件
- (void)productClick
{
    OrderDetailViewModel *orderDetailVM = [[OrderDetailViewModel alloc] initWithOrderID:self.viewModel.order_id orderTitle:nil];
    [self.gotoOrderDetailSignal sendNext:orderDetailVM];
}

- (void)storeClick
{
    if ([self.viewModel.storeID integerValue]<=0) {
        SelectStoreViewModel *selectVM = [[SelectStoreViewModel alloc] initWithOrder_detail_id:self.viewModel.order_detail_id];
        [self.gotoBindShopSignal sendNext:selectVM];
    }
}

#pragma mark -reload
- (void)bindViewModel:(CashBackSectionViewModel *)vm
{
    self.viewModel = vm;
    
    self.productNameLabel.text = vm.productName;
    // 改成了根据订单商品的货仓自动确定返现货仓
    //if ([vm.storeID integerValue]>0) {
        self.storeNameArrowView.hidden = YES;
        [self.storeNameLabel updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.storeNameLabel.superview.right).offset(-15);
        }];
        self.storeNameLabel.text = vm.storeName;
    //}else{
      //  self.storeNameArrowView.hidden = NO;
        //[self.storeNameLabel updateConstraints:^(MASConstraintMaker *make) {
          //  make.right.mas_equalTo(self.storeNameArrowView.left).offset(-20);
        //}];
        //self.storeNameLabel.text = @"未选择";
    //}
}

@end
