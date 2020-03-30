//
//  ShippingAddressManageViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressManageViewController.h"

#import "ShippingAddressManageView.h"
#import "ShippingAddressManageViewModel.h"

#import "ShippingAddressEidtViewController.h"

#import "LYMainColorButton.h"

@interface ShippingAddressManageViewController ()

@end

@implementation ShippingAddressManageViewController

- (void)viewDidLoad {
    self.viewModel = [ShippingAddressManageViewModel new];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -主界面
- (void)addViews
{
    self.view.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    self.loadingFailedImageName = @"没有收货地址";
    // 导航
    self.navigationBarView.titleLabel.text = @"地址管理";
    self.navigationBarView.navagationBarStyle = Left_button_Show;
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
        [(ShippingAddressManageViewModel *)self.viewModel addAddress];
        return [RACSignal empty];
    }];
    // 主视图
    ShippingAddressManageView *mainView = [ShippingAddressManageView new];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navigationBarView.bottom);
        make.bottom.mas_equalTo(bottomBtn.top);
    }];
}

#pragma mark -信号绑定
- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case ShippingAddressManageViewModel_Singal_Type_GotoAddAddress:
            {
                // 新建收货地址
                self.hasAppeard = NO;
                ShippingAddressEidtViewController *vc = [ShippingAddressEidtViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ShippingAddressManageViewModel_Singal_Type_GetData:
            {
                // 重新获取数据
                [self getData];
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
