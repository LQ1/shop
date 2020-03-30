//
//  ShippingAddressSelectViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressSelectViewController.h"

#import "ShippingAddressSelectViewModel.h"
#import "ShippingAddressSelectView.h"

#import "ShippingAddressManageViewController.h"
#import "ShippingAddressEidtViewController.h"

#import "LYMainColorButton.h"

@interface ShippingAddressSelectViewController ()

@end

@implementation ShippingAddressSelectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -主界面
- (void)addViews
{
    self.view.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    self.loadingFailedImageName = @"没有收货地址";
    // 导航
    self.navigationBarView.titleLabel.text = @"选择收货地址";
    self.navigationBarView.navagationBarStyle = Left_right_button_show;
    self.navigationBarView.rightLabel.text = @"管理";
    // 底部栏
    LYMainColorButton *bottomBtn = [[LYMainColorButton alloc] initWithTitle:@"新建收货地址"
                                                             buttonFontSize:MIDDLE_FONT_SIZE
                                                               cornerRadius:0];
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    @weakify(self);
    bottomBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [(ShippingAddressSelectViewModel *)self.viewModel addAddress];
        return [RACSignal empty];
    }];
    // 主视图
    ShippingAddressSelectView *mainView = [ShippingAddressSelectView new];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navigationBarView.bottom);
        make.bottom.mas_equalTo(bottomBtn.top);
    }];
}

- (void)rightButtonClick
{
    self.hasAppeard = NO;
    ShippingAddressManageViewController *vc = [ShippingAddressManageViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case ShippingAddressSelectViewModel_Signal_Type_ReloadData:
            {
                // 刷新
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case ShippingAddressSelectViewModel_Signal_Type_SelectAddressSuccess:
            {
                // 选择收货地址成功
                if (self.selectSuccessBlock) {
                    self.selectSuccessBlock(x);
                }
                [self leftButtonClick];
            }
                break;
            case ShippingAddressSelectViewModel_Signal_Type_GotoAddAddress:
            {
                self.hasAppeard = NO;
                // 新建收货地址
                ShippingAddressEidtViewController *vc = [ShippingAddressEidtViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
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
