//
//  ProductListHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductListHeaderView.h"

#import "ProductListViewModel.h"

#define ProductListHeaderViewItemWidth (KScreenWidth/4.0)

@interface ProductListHeaderView()

@property (nonatomic,assign)BOOL priceOrderDesc;
@property (nonatomic,strong)UIButton *priceOrderBtn;

@end

@implementation ProductListHeaderView

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
    // 背景
    self.backgroundColor = [UIColor whiteColor];
    
    // 综合
    UIButton *button1 = [UIButton new];
    [button1 setTitle:@"综合" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    [button1 setTitleColor:[CommUtls colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [button1 setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateSelected];
    [self addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(ProductListHeaderViewItemWidth);
    }];
    // 销量
    UIButton *button2 = [UIButton new];
    [button2 setTitle:@"销量" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    [button2 setTitleColor:[CommUtls colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [button2 setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateSelected];
    [self addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(button1.right);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(ProductListHeaderViewItemWidth);
    }];
    // 价格
    UIButton *button3 = [UIButton new];
    self.priceOrderBtn = button3;
    button3.titleLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    [button3 setImage:[UIImage imageNamed:@"排序-(1)"] forState:UIControlStateNormal];
    [button3 setTitleColor:[CommUtls colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [button3 setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateSelected];
    
    [button3 setTitleEdgeInsets:UIEdgeInsetsMake(0, ProductListHeaderViewItemWidth/2.0-35, 0, ProductListHeaderViewItemWidth/2.0)];
    [button3 setImageEdgeInsets:UIEdgeInsetsMake(0, ProductListHeaderViewItemWidth/2.0, 0,ProductListHeaderViewItemWidth/2.0-15)];
    [self addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(button2.right);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(ProductListHeaderViewItemWidth);
    }];
    
    @weakify(self);
    button1.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (!button1.selected) {
            button1.selected = YES;
            button2.selected = NO;
            button3.selected = NO;
            [self.clickSignal sendNext:@(ProductListHeaderViewClickType_OrderByDefault)];
        }
        return [RACSignal empty];
    }];
    button2.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (!button2.selected) {
            button1.selected = NO;
            button2.selected = YES;
            button3.selected = NO;
            [self.clickSignal sendNext:@(ProductListHeaderViewClickType_OrderBySales)];
        }
        return [RACSignal empty];
    }];
    button3.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (!button3.selected) {
            button1.selected = NO;
            button2.selected = NO;
            button3.selected = YES;
            [self.clickSignal sendNext:@(ProductListHeaderViewClickType_OrderByPrice)];
        }else{
            self.priceOrderDesc = !self.priceOrderDesc;
            if (self.priceOrderDesc) {
                [self.clickSignal sendNext:@(ProductListHeaderViewClickType_OrderByPriceDesc)];
            }else{
                [self.clickSignal sendNext:@(ProductListHeaderViewClickType_OrderByPrice)];
            }
        }
        return [RACSignal empty];
    }];
    
    button1.selected = YES;
    
    // 筛选
    UIButton *button4 = [UIButton new];
    [button4 setTitle:@"筛选" forState:UIControlStateNormal];
    button4.titleLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    [button4 setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
    [button4 setTitleColor:[CommUtls colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [button4 setTitleEdgeInsets:UIEdgeInsetsMake(0, ProductListHeaderViewItemWidth/2.0-35, 0, ProductListHeaderViewItemWidth/2.0)];
    [button4 setImageEdgeInsets:UIEdgeInsetsMake(0, ProductListHeaderViewItemWidth/2.0, 0,ProductListHeaderViewItemWidth/2.0-15)];
    [self addSubview:button4];
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(button3.right);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(ProductListHeaderViewItemWidth);
    }];
    
    button4.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:@(ProductListHeaderViewClickType_Sift)];
        return [RACSignal empty];
    }];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(ProductListViewModel *)viewModel
{
    if (viewModel.cartType == 0) {
        [self.priceOrderBtn setTitle:@"价格" forState:UIControlStateNormal];
    }else{
        [self.priceOrderBtn setTitle:@"积分" forState:UIControlStateNormal];
    }
}

@end
