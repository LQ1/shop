//
//  GoodDetailPatternChooseHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodDetailPatternChooseHeaderView.h"

#import "GoodsDetailPramsDetailViewModel.h"

@interface GoodDetailPatternChooseHeaderView()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *priceLabel;


@end

@implementation GoodDetailPatternChooseHeaderView

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
    // 图
    self.imageView = [self addImageViewWithImageName:nil
                                        cornerRadius:5];
    self.imageView.layer.borderColor = [CommUtls colorWithHexString:@"#e2e6ea"].CGColor;
    self.imageView.layer.borderWidth = 1.0f;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(100);
        make.bottom.mas_equalTo(-12.5);
    }];
    
    // 请选择商品样式
    UILabel *tipLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                     textAlignment:0
                                         textColor:@"#333333"
                                      adjustsWidth:NO
                                      cornerRadius:0
                                              text:@"请选择商品样式"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.right).offset(15);
        make.bottom.mas_equalTo(self.imageView);
    }];
    
    // 价格
    self.priceLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                   textAlignment:0
                                       textColor:@"#e4393c"
                                    adjustsWidth:NO
                                    cornerRadius:0
                                            text:nil];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:LARGE_FONT_SIZE];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipLabel);
        make.bottom.mas_equalTo(tipLabel.top).offset(-10);
    }];
    
    // 关闭按钮
    UIButton *closeBtn = [UIButton new];
    [closeBtn setImage:[UIImage imageNamed:@"叉"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(12.5);
    }];
    closeBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [DLAlertShowAnimate disappear];
        return [RACSignal empty];
    }];
    
    [self addBottomLine];
}

#pragma mark -刷新
- (void)reloadDataWithViewModel:(GoodsDetailPramsDetailViewModel *)viewModel
{
    [self.imageView ly_showMidImg:viewModel.productImgUrl];
    if (viewModel.cartType == 1) {
        self.priceLabel.text = [NSString stringWithFormat:@"%@积分",viewModel.score.length?viewModel.score:@""];
    }else{
        self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",viewModel.productPrice.length?viewModel.productPrice:@""];
    }
}

@end
