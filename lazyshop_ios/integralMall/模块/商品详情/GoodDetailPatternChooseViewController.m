//
//  GoodDetailPatternChooseViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodDetailPatternChooseViewController.h"

#import "GoodsDetailPramsDetailViewModel.h"
#import "GoodDetailPatternChooseView.h"
#import "GoodsDetailViewModel.h"

@interface GoodDetailPatternChooseViewController ()

@property (nonatomic,strong)GoodDetailPatternChooseView *mainView;

@end

@implementation GoodDetailPatternChooseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.hasAppeard) {
        [self getData];
        self.hasAppeard = YES;
    }
}

// 获取数据
- (void)getData
{
    self.mainView.hidden = YES;
    [self.view DLLoadingInSelf];
    [self.viewModel getData];
}

#pragma mark -主界面
- (void)addViews
{
    GoodDetailPatternChooseView *mainView = [[GoodDetailPatternChooseView alloc] initWithGoodsDetailViewModel:self.goodsDetailViewModel];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark -信号绑定
- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        self.mainView.hidden = NO;
        [self.view DLLoadingHideInSelf];
        [self.mainView reloadDataWithViewModel:self.viewModel];
    }];
    [self.viewModel.errorSignal subscribeNext:^(NSError *error) {
        @strongify(self);
        self.mainView.hidden = YES;
        [self.view DLLoadingCycleInSelf:^{
            @strongify(self);
            [self getData];
        } code:error.code title:AppErrorParsing(error) buttonTitle:LOAD_FAILED_RETRY];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
