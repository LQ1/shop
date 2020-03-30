//
//  GoodsDetailIntroduceView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailIntroduceView.h"

#import "LYHeaderSwitchView.h"
#import "GoodsDetailIntroduceViewModel.h"

#import "GoodsDetailIntroWebView.h"
#import "GoodsDetailIntroParmsView.h"
#import "GoodsDetailIntroTagsView.h"

@interface GoodsDetailIntroduceView()

@property (nonatomic,strong)GoodsDetailIntroduceViewModel *viewModel;

@property (nonatomic,strong)LYHeaderSwitchView *headerSwitch;

@property (nonatomic,strong)GoodsDetailIntroWebView *introWebView;
@property (nonatomic,strong)GoodsDetailIntroParmsView *introParmsView;
@property (nonatomic,strong)GoodsDetailIntroTagsView *introTagsView;

@end

@implementation GoodsDetailIntroduceView

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
    self.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    // 头部
    LYHeaderSwitchView *headerSwitch = [[LYHeaderSwitchView alloc] initWithHeight:44.0f];
    headerSwitch.divideStyle = YES;
    self.headerSwitch = headerSwitch;
    [self addSubview:headerSwitch];
    [headerSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(44.0f);
    }];
    [headerSwitch.clickSignal subscribeNext:^(id x) {
        switch ([x integerValue]) {
            case 0:
            {
                // 商品介绍
                self.introWebView.hidden = NO;
                self.introParmsView.hidden = YES;
                self.introTagsView.hidden = YES;
            }
                break;
            case 1:
            {
                // 规格参数
                self.introWebView.hidden = YES;
                self.introParmsView.hidden = NO;
                self.introTagsView.hidden = YES;
            }
                break;
            case 2:
            {
                // 包装售后
                self.introWebView.hidden = YES;
                self.introParmsView.hidden = YES;
                self.introTagsView.hidden = NO;
            }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark -绑定VM
- (void)bindViewModel:(GoodsDetailIntroduceViewModel *)viewModel
{
    if (!self.viewModel) {
        self.viewModel = viewModel;
        // 头部显示
        [self.headerSwitch reloadDataWithItemViewModels:[self.viewModel fetchHeaderSwitchVMs]];
        // 获取数据
        [self getData];
        // 信号绑定
        [self bindSignal];
    }
}
// 获取数据
- (void)getData
{
    [self DLLoadingInSelf];
    [self.viewModel getData];
}
// 信号绑定
- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self DLLoadingHideInSelf];
        [self addContents];
    }];
    
    [self.viewModel.errorSignal subscribeNext:^(NSError *error) {
        @strongify(self);
        [self DLLoadingCycleInSelf:^{
            @strongify(self);
            [self getData];
        } code:error.code title:AppErrorParsing(error) buttonTitle:LOAD_FAILED_RETRY];
    }];
}
// 创建视图
- (void)addContents
{
    // html
    self.introWebView = [[GoodsDetailIntroWebView alloc] initWithHtmlString:[self.viewModel fetchIntroduceHtmlString]];
    [self addSubview:self.introWebView];
    [self.introWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerSwitch.bottom).offset(7.5);
    }];
    self.introWebView.hidden = NO;
    // prams
    self.introParmsView = [[GoodsDetailIntroParmsView alloc] initWithPrams:[self.viewModel fetchParmsItemVMs]];
    [self addSubview:self.introParmsView];
    [self.introParmsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerSwitch.bottom);
    }];
    self.introParmsView.hidden = YES;
    // tags
    self.introTagsView = [[GoodsDetailIntroTagsView alloc] initWithTags:[self.viewModel fetchTagVMs]];
    [self addSubview:self.introTagsView];
    [self.introTagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerSwitch.bottom);
    }];
    self.introTagsView.hidden = YES;
}

@end
