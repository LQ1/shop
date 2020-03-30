//
//  ShoppingCartItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShoppingCartItemCell.h"

#import <DLUIKit/CheckBoxButton.h>

#import "LYQuantityAdderView.h"
#import "ShoppingCartItemViewModel.h"

@interface ShoppingCartItemCell()

@property (nonatomic,strong) CheckBoxButton *checkButton;
@property (nonatomic,strong) LYQuantityAdderView *adderView;
@property (nonatomic,strong) UILabel *invalidTipLabel;

@end

@implementation ShoppingCartItemCell

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
    self.checkButton = [[CheckBoxButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)
                                               checkImgeWith:[UIImage imageNamed:@"选择收货地址未选中"]
                                             checkedImgeWith:[UIImage imageNamed:@"默认地址选中"] selectCheckedWith:NO];
    self.checkButton.userInteractionEnabled = NO;
    [self.contentView addSubview:self.checkButton];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(17);
        make.left.mas_equalTo(self.contentView).offset(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.productImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.checkButton.right).offset(15);
        make.width.height.mas_equalTo(80);
        make.centerY.mas_equalTo(self.contentView);
    }];
    // 已下架、已售空等标志
    self.invalidTipLabel = [self.productImgView addLabelWithFontSize:SMALL_FONT_SIZE
                                        textAlignment:NSTextAlignmentCenter
                                            textColor:@"#ffffff"
                                         adjustsWidth:NO
                                         cornerRadius:0
                                                 text:nil];
    self.invalidTipLabel.backgroundColor = [CommUtls colorWithHexString:@"#595959"];
    [self.invalidTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
    self.invalidTipLabel.hidden = YES;
    
    self.adderView = [LYQuantityAdderView new];
    [self.contentView addSubview:self.adderView];
    [self.adderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-15);
        make.width.mas_equalTo(LYQuantityAdderViewWidth);
        make.height.mas_equalTo(LYQuantityAdderViewHeight);
    }];
    
    [self.productSkuLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productNameLabel);
        make.top.mas_equalTo(self.productNameLabel.bottom).offset(3);
        make.bottom.mas_equalTo(self.productPriceLabel.top).offset(-3);
        make.right.mas_equalTo(self.adderView.left).offset(-5);
    }];
    
    // 点击事件
    UIButton *clickBoxBtn = [UIButton new];
    [self.contentView addSubview:clickBoxBtn];
    [clickBoxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(0);
        make.right.mas_equalTo(self.productImgView.left);
    }];
    @weakify(self);
    clickBoxBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.baseClickSignal sendNext:@(ShoppingCartItemCellClickType_CheckBox)];
        return [RACSignal empty];
    }];
    
    UIButton *clickDetailBtn = [UIButton new];
    [self.contentView addSubview:clickDetailBtn];
    [clickDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.productSkuLabel);
        make.left.mas_equalTo(self.productImgView);
    }];
    clickDetailBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.baseClickSignal sendNext:@(ShoppingCartItemCellClickType_GoodsDetail)];
        return [RACSignal empty];
    }];
}

- (void)bindViewModel:(ShoppingCartItemViewModel *)vm
{
    [super bindViewModel:vm];
    if (vm.editting) {
        self.checkButton.checked = vm.editSelected;
    }else{
        self.checkButton.checked = vm.paySelected;
    }
    
    // 已下架、已售空
    if (vm.underCart) {
        self.invalidTipLabel.hidden = NO;
        self.invalidTipLabel.text = @"已下架";
    }else{
        if (vm.outStock) {
            self.invalidTipLabel.hidden = NO;
            self.invalidTipLabel.text = @"已售空";
        }else{
            self.invalidTipLabel.hidden = YES;
        }
    }
        
    // 商品数量变化
    [self.adderView setQuantityNumber:vm.productQuantity];
    @weakify(vm);
    [[[RACObserve(self.adderView, adderQuantity) distinctUntilChanged] takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(vm);
        vm.productQuantity = [x integerValue];
    }];
    
}

@end
