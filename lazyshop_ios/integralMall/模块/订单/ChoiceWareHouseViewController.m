//
//  ChoiceWareHouseViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/31.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ChoiceWareHouseViewController.h"

#import "ChoiceWareHouseView.h"
#import "ChoiceWareHouseViewModel.h"

@interface ChoiceWareHouseViewController ()

@end

@implementation ChoiceWareHouseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark -主界面
- (void)addViews
{
    self.view.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    // 导航
    self.navigationBarView.titleLabel.text = @"取货仓";
    // 主视图
    ChoiceWareHouseView *mainView = [ChoiceWareHouseView new];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    [self nearByNavigationBarView:mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case ChoiceWareHouseViewModel_Signal_Type_ReloadData:
            {
                // 刷新
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case ChoiceWareHouseViewModel_Signal_Type_SelectHouseSuccess:
            {
                // 选择收货地址成功
                if (self.selectSuccessBlock) {
                    self.selectSuccessBlock(x);
                }
                [self leftButtonClick];
            }
                break;
                
            default:
                break;
        }
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
