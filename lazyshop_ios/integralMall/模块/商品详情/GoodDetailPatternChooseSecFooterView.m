//
//  GoodDetailPatternChooseSecFooterView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodDetailPatternChooseSecFooterView.h"

#import "LYQuantityAdderView.h"
#import "GoodsDetailPramsDetailViewModel.h"

@interface GoodDetailPatternChooseSecFooterView()

@property (nonatomic,strong)LYQuantityAdderView *adderView;
@property (nonatomic,strong)GoodsDetailPramsDetailViewModel *viewModel;

@end

@implementation GoodDetailPatternChooseSecFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(47.5);
        make.centerY.mas_equalTo(self);
    }];
    // 数量
    UILabel *tipLabel = [topView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                        textAlignment:0
                                            textColor:@"#666666"
                                         adjustsWidth:NO
                                         cornerRadius:0
                                                 text:@"数量"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(topView);
    }];
    // 加数器
    self.adderView = [LYQuantityAdderView new];
    self.adderView.addRequestBlockEffectShouldEditting = YES;
    [topView addSubview:self.adderView];
    [self.adderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LYQuantityAdderViewWidth);
        make.height.mas_equalTo(LYQuantityAdderViewHeight);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(topView);
    }];
    @weakify(self);
    [self.adderView setAddRequestBlock:^(NSInteger quantity, makeQuantityChangeBlock block) {
        @strongify(self);
        [self changeQuantity:quantity
                 changeBlock:block];
    }];
    [topView addTopLine];
    [topView addBottomLine];
}

#pragma mark -数量变化
- (void)changeQuantity:(NSInteger)quantity
           changeBlock:(makeQuantityChangeBlock)block
{
    if (![self.viewModel hasSelectedSku]) {
        if ([self.viewModel isAllAttrHasSelectedItem]) {
            [DLLoading DLToolTipInWindow:@"所选商品样式无货,请选择其他"];
        }else{
            [DLLoading DLToolTipInWindow:@"请选择商品样式"];
        }
    }
    //else if (quantity>self.viewModel.currentSkuStock) {
      //  [DLLoading DLToolTipInWindow:@"库存不足"];
    //}
    else{
        self.viewModel.quantity = quantity;
        if (block) {
            block();
        }
    }
}

#pragma mark -bindVM
- (void)bindViewModel:(GoodsDetailPramsDetailViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.adderView setQuantityNumber:viewModel.quantity];
}

@end
