//
//  GoodDetailPatternChooseFooterView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodDetailPatternChooseFooterView.h"

#import "LYQuantityAdderView.h"

#import "GoodsDetailPramsDetailViewModel.h"

#import "GoodsDetailViewModel.h"
#import "GoodsDetailBottomView.h"

@interface GoodDetailPatternChooseFooterView()

@property (nonatomic,strong)GoodsDetailViewModel *detailViewModel;
@property (nonatomic,strong)GoodsDetailPramsDetailViewModel *viewModel;

@property (nonatomic,strong)GoodsDetailBottomView *bottomView;
@property (nonatomic,strong)UIButton *confrimBtn;

@end

@implementation GoodDetailPatternChooseFooterView

- (instancetype)initWithGoodsDetailViewModel:(GoodsDetailViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.detailViewModel = viewModel;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    @weakify(self);
    // 确定
    UIButton *confrimBtn = [UIButton new];
    self.confrimBtn = confrimBtn;
    [confrimBtn setBackgroundColor:[CommUtls colorWithHexString:APP_MainColor]];
    confrimBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
    [confrimBtn setTitle:@"确定"
                forState:UIControlStateNormal];
    [self addSubview:confrimBtn];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    confrimBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (![self.viewModel hasSelectedSku]) {
            if ([self.viewModel isAllAttrHasSelectedItem]) {
                [DLLoading DLToolTipInWindow:@"所选商品样式无货,请选择其他"];
            }else{
                [DLLoading DLToolTipInWindow:@"请选择商品样式"];
            }
        }else{
            [self confrimAction];
            [DLAlertShowAnimate disappear];
        }
        return [RACSignal empty];
    }];
    // 加入购物车/立即购买
    GoodsDetailBottomView *bottomView = [[GoodsDetailBottomView alloc] initWithViewModel:self.detailViewModel];
    bottomView.clickBlock = ^(GoodsDetailBottomViewClickType clickType) {
        @strongify(self);
        if (![self.viewModel hasSelectedSku]) {
            if ([self.viewModel isAllAttrHasSelectedItem]) {
                [DLLoading DLToolTipInWindow:@"所选商品样式无货,请选择其他"];
            }else{
                [DLLoading DLToolTipInWindow:@"请选择商品样式"];
            }
        }else{
            [DLAlertShowAnimate disappear];
            switch (clickType) {
                case GoodsDetailBottomViewClickType_AddCart:
                {
                    [self.detailViewModel addToCart];
                }
                    break;
                case GoodsDetailBottomViewClickType_Pay:
                {
                    [self.detailViewModel immediatelyAction];
                }
                    break;
                    
                default:
                    break;
            }
        }
    };
    self.bottomView = bottomView;
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

// 点击确定
- (void)confrimAction
{
    if (self.viewModel.confirmAction == GoodsPramsConfirmAction_AddToCart) {
        // 加入购物车
        [self.detailViewModel addToCart];
    }else if (self.viewModel.confirmAction == GoodsPramsConfirmAction_ImediatelyPay) {
        // 立即购买
        [self.detailViewModel immediatelyAction];
    }
}

#pragma mark -刷新
- (void)reloadDataWithViewModel:(GoodsDetailPramsDetailViewModel *)viewModel
{
    self.viewModel = viewModel;
    // 底部按钮显示
    if (self.viewModel.confirmStyle) {
        self.bottomView.hidden = YES;
        self.confrimBtn.hidden = NO;
    }else{
        self.bottomView.hidden = NO;
        self.confrimBtn.hidden = YES;
    }
}

@end
