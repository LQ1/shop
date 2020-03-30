//
//  SiftListViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SiftListViewController.h"

#import "SiftListViewModel.h"
#import "SiftListView.h"

@interface SiftListViewController ()

@property (nonatomic,strong)SiftListView *mainView;
@property (nonatomic,copy)siftCompleteBlock completeBlock;

@end

@implementation SiftListViewController

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

- (void)addViews
{
    self.view.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];
    // 导航
    UIView *navLine = [UIView new];
    navLine.backgroundColor = [CommUtls colorWithHexString:@"#eaeaea"];
    [self.view addSubview:navLine];
    [navLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATIONBAR_HEIGHT);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1./[UIScreen mainScreen].scale);
    }];
    
    UILabel *navTitleLabel = [self.view addLabelWithFontSize:LARGE_FONT_SIZE
                                               textAlignment:NSTextAlignmentCenter
                                                   textColor:@"#000000"
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:@"筛选"];
    navTitleLabel.font = [UIFont boldSystemFontOfSize:LARGE_FONT_SIZE];
    [navTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(navLine.top).offset(-16);
    }];
    
    // 主视图
    SiftListView *mainView = [SiftListView new];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(navLine.bottom);
    }];
}

- (void)bindSignal
{
    // 双向绑定积分输入框
    RACChannelTerminal *modelValue1Terminal = RACChannelTo(self.viewModel,min_store);
    RACChannelTerminal *fieldValue1Terminal = [self.mainView.headerView.minScoreInputView rac_newTextChannel];
    [modelValue1Terminal subscribe:fieldValue1Terminal];
    [fieldValue1Terminal subscribe:modelValue1Terminal];
    
    RACChannelTerminal *modelValue2Terminal = RACChannelTo(self.viewModel,max_store);
    RACChannelTerminal *fieldValue2Terminal = [self.mainView.headerView.maxScoreInputView rac_newTextChannel];
    [modelValue2Terminal subscribe:fieldValue2Terminal];
    [fieldValue2Terminal subscribe:modelValue2Terminal];

    
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case SiftListViewModelSignalType_TipLoading:
            {
                // 弹框
                [DLLoading DLToolTipInWindow:x];
            }
                break;
            case SiftListViewModelSignalType_FetchDataSuccess:
            {
                // 获取成功
                self.mainView.hidden = NO;
                [self.view DLLoadingHideInSelf];
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case SiftListViewModelSignalType_FetchDataFailed:
            {
                // 获取失败
                NSError *error = x;
                NSString *title = AppErrorParsing(error);
                [self.view DLLoadingCycleInSelf:^{
                    @strongify(self);
                    [self getData];
                } code:error.code title:title buttonTitle:LOAD_FAILED_RETRY];
            }
                break;
            case SiftListViewModelSignalType_CompleteSift:
            {
                // 重新获取数据
                if (self.completeBlock) {
                    self.completeBlock(x,self.viewModel.min_store,self.viewModel.max_store);
                }
                [DLAlertShowAnimate disappear];
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)setSiftCompleteBlock:(siftCompleteBlock)block
{
    self.completeBlock = block;
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
