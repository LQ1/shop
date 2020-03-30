//
//  GoodsDetailBottomView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailBottomView.h"

#import "GoodsDetailViewModel.h"

@interface GoodsDetailBottomView()

@property (nonatomic,strong)GoodsDetailViewModel *viewModel;

@end

@implementation GoodsDetailBottomView

- (instancetype)initWithViewModel:(GoodsDetailViewModel *)viewModel
{
    self = [super init];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        self.viewModel = viewModel;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 加入购物车
    UIButton *addToCartBtn = [UIButton new];
    [addToCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addToCartBtn setBackgroundColor:[CommUtls colorWithHexString:@"#ff790d"]];
    addToCartBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
    [self addSubview:addToCartBtn];
    [addToCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.centerX);
    }];
    @weakify(self);
    addToCartBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (self.clickBlock) {
            self.clickBlock(GoodsDetailBottomViewClickType_AddCart);
        }else{
            [self.viewModel addToCart];
        }
        return [RACSignal empty];
    }];
    // 立即购买
    UIButton *payBtn = [UIButton new];
    [payBtn setBackgroundColor:[CommUtls colorWithHexString:@"#e43b3d"]];
    payBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
    [self addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(addToCartBtn);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(self.centerX);
    }];
    payBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (self.clickBlock) {
            self.clickBlock(GoodsDetailBottomViewClickType_Pay);
        }else{
            [self.viewModel immediatelyAction];
        }
        return [RACSignal empty];
    }];
    
    // 按钮布局
    if (self.viewModel.detailType!=GoodsDetailType_Normal) {
        addToCartBtn.hidden = YES;
        [payBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    // 按钮名称
    if (self.viewModel.detailType == GoodsDetailType_GroupBy) {
        [payBtn setTitle:@"立即拼单" forState:UIControlStateNormal];
    }else if (self.viewModel.detailType == GoodsDetailType_Bargain){
        [payBtn setTitle:@"立即砍价" forState:UIControlStateNormal];
    }else{
        [payBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    }
}

@end
