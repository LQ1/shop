//
//  StoreToRelateViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "StoreToRelateViewController.h"

#import "StoreToRelateViewModel.h"
#import "StoreToRelateView.h"

@interface StoreToRelateViewController ()

@end

@implementation StoreToRelateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"店铺详情";
    self.loadingFailedImageName = @"没有关联店铺";
    // 主视图
    self.mainView = [StoreToRelateView new];
    self.mainView.hidden = YES;
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

- (void)bindSignal
{
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        switch (self.viewModel.currentSignalType) {
            case StoreToRelateViewModel_Signal_Type_RelateSuccess:
            {
                // 关联店铺成功
                [DLLoading DLToolTipInWindow:@"店铺关联成功"];
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3] animated:YES];
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
