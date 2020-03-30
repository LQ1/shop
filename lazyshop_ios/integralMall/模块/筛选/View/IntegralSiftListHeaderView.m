//
//  IntegralSiftListHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "IntegralSiftListHeaderView.h"

#import "SiftListViewModel.h"

@interface IntegralSiftListHeaderView()

@property (nonatomic, strong) UIImageView *selectedTipView;
@property (nonatomic, strong) UIView *scoreContentView;
@property (nonatomic, strong) UILabel *allCategroyTipLabel;
@property (nonatomic, strong) UITextField *minScoreInputView;
@property (nonatomic, strong) UITextField *maxScoreInputView;

@end

@implementation IntegralSiftListHeaderView

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
    // 全部商品/全部分类
    UIView *bottomContentView = [UIView new];
    bottomContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomContentView];
    [bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(IntegralSiftListHeaderViewBaseHeight);
    }];
    // 标题
    UILabel *titleLabel = [bottomContentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                    textAlignment:0
                                                        textColor:@"#000000"
                                                     adjustsWidth:NO
                                                     cornerRadius:0
                                                             text:nil];
    self.allCategroyTipLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(bottomContentView);
    }];
    [bottomContentView addBottomLineWithColorString:@"#eaeaea"];
    // 选中标志
    self.selectedTipView  = [self addImageViewWithImageName:@"筛选对勾"
                                               cornerRadius:0];
    [self.selectedTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(bottomContentView);
    }];
    self.selectedTipView.hidden = YES;
    // 全铺按钮
    UIButton *clickBtn = [UIButton new];
    [bottomContentView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:nil];
        return [RACSignal empty];
    }];
    
    // 积分商品特有
    self.scoreContentView = [UIView new];
    self.scoreContentView.backgroundColor = [CommUtls colorWithHexString:@"#eaeaea"];
    [self addSubview:self.scoreContentView];
    [self.scoreContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomContentView.top);
    }];
    // 分类
    UIView *categoryTipView = [UIView new];
    categoryTipView.backgroundColor = [UIColor whiteColor];
    [self.scoreContentView addSubview:categoryTipView];
    [categoryTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_equalTo(0);
        make.height.mas_equalTo(IntegralSiftListHeaderViewBaseHeight);
    }];
    [categoryTipView addBottomLineWithColorString:@"#eaeaea"];
    UILabel *categoryTipLabel = [categoryTipView addLabelWithFontSize:SMALL_FONT_SIZE
                                                        textAlignment:0
                                                            textColor:@"#000000"
                                                         adjustsWidth:NO
                                                         cornerRadius:0
                                                                 text:@"分类"];
    [categoryTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(categoryTipView);
    }];
    // 积分区间
    UIView *scoreScopeContentView = [UIView new];
    scoreScopeContentView.backgroundColor = [UIColor whiteColor];
    [self.scoreContentView addSubview:scoreScopeContentView];
    [scoreScopeContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(categoryTipView.top).offset(-5);
    }];
    //  提示文字
    UILabel *scoreScopeTipLabel = [scoreScopeContentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                                textAlignment:0
                                                                    textColor:@"#000000"
                                                                 adjustsWidth:NO
                                                                 cornerRadius:0
                                                                         text:@"积分区间"];
    [scoreScopeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(11);
    }];
    // 最小积分
    UIView *minScoreView = [UIView new];
    minScoreView.backgroundColor = [CommUtls colorWithHexString:@"#f0f3f5"];
    minScoreView.layer.cornerRadius = 5;
    minScoreView.layer.masksToBounds = YES;
    [scoreScopeContentView addSubview:minScoreView];
    [minScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(scoreScopeContentView.centerX).offset(-15);
        make.bottom.mas_equalTo(-11);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(28);
    }];
    UITextField *minScoreInputView = [UITextField new];
    self.minScoreInputView = minScoreInputView;
    minScoreInputView.placeholder = @"输入积分";
    minScoreInputView.keyboardType = UIKeyboardTypeNumberPad;
    minScoreInputView.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    minScoreInputView.textColor = [CommUtls colorWithHexString:@"#000000"];
    minScoreInputView.textAlignment = NSTextAlignmentCenter;
    [minScoreView addSubview:minScoreInputView];
    [minScoreInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
        make.center.mas_equalTo(minScoreView);
    }];
    // -
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [CommUtls colorWithHexString:@"#000000"];
    [scoreScopeContentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(10);
        make.centerX.mas_equalTo(scoreScopeContentView);
        make.centerY.mas_equalTo(minScoreInputView);
    }];
    // 最大积分
    UIView *maxScoreView = [UIView new];
    maxScoreView.backgroundColor = [CommUtls colorWithHexString:@"#f0f3f5"];
    maxScoreView.layer.cornerRadius = 5;
    maxScoreView.layer.masksToBounds = YES;
    [scoreScopeContentView addSubview:maxScoreView];
    [maxScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scoreScopeContentView.centerX).offset(15);
        make.bottom.width.height.mas_equalTo(minScoreView);
    }];
    UITextField *maxScoreInputView = [UITextField new];
    self.maxScoreInputView = maxScoreInputView;
    maxScoreInputView.placeholder = @"输入积分";
    maxScoreInputView.keyboardType = UIKeyboardTypeNumberPad;
    maxScoreInputView.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    maxScoreInputView.textColor = [CommUtls colorWithHexString:@"#000000"];
    maxScoreInputView.textAlignment = NSTextAlignmentCenter;
    [maxScoreView addSubview:maxScoreInputView];
    [maxScoreInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(minScoreInputView);
        make.center.mas_equalTo(maxScoreView);
    }];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(SiftListViewModel *)viewModel
{
    if ([viewModel.cartType integerValue] == 0) {
        // 储值
        self.scoreContentView.hidden = YES;
        self.allCategroyTipLabel.text = @"全部商品";
        _headerHeight = IntegralSiftListHeaderViewBaseHeight;
    }else{
        // 积分
        self.scoreContentView.hidden = NO;
        self.allCategroyTipLabel.text = @"全部分类";
        _headerHeight = IntegralSiftListHeaderViewWholeHeight;
    }
    // 是否选中全部
    if ([viewModel.goods_cart_id integerValue]>0) {
        self.selectedTipView.hidden = YES;
    }else{
        self.selectedTipView.hidden = NO;
    }
}

#pragma mark -结束编辑
- (void)endInputEditting
{
    [self.minScoreInputView resignFirstResponder];
    [self.maxScoreInputView resignFirstResponder];
}

@end
