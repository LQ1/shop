//
//  CategoryViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryViewController.h"

#import "CategorySegmentView.h"
#import "CategroyViewModel.h"
#import "CategoryView.h"

#import "ProductListViewController.h"

@interface CategoryViewController ()

@property (nonatomic,strong)CategorySegmentView *navSegmentView;
@property (nonatomic,strong)CategroyViewModel *viewModel;
@property (nonatomic,strong)CategoryView *mainView;

@end

@implementation CategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewModel = [CategroyViewModel new];
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
    // 导航
    if (self.isEnterFromMakeMoney) {
        self.navigationBarView.navagationBarStyle = Left_right_button_show;
    }else{
        self.navigationBarView.navagationBarStyle = Right_button_show;
    }
    
    
    self.navigationBarView.rightButton.enabled = NO;
    UIButton *messageBtn = [[PublicEventManager shareInstance] fetchMessageButtonWithNavigationController:self.navigationController];
    [self.navigationBarView addSubview:messageBtn];
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.navigationBarView).offset(10);
        make.centerX.mas_equalTo(self.navigationBarView.right).offset(-24);
    }];

    self.navSegmentView = [CategorySegmentView new];
    [self.navigationBarView addSubview:self.navSegmentView];
    [self.navSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(25);
        make.centerX.mas_equalTo(self.navigationBarView);
        make.centerY.mas_equalTo(self.navigationBarView.centerY).offset(10);
    }];
    // 主视图
    self.mainView = [CategoryView new];
    [self.view addSubview:self.mainView];
    if (self.isEnterFromMakeMoney) {
        [self nearByNavigationBarView:self.mainView isShowBottom:NO];
    }else{
        [self nearByNavigationBarView:self.mainView isShowBottom:YES];
    }
    
}

#pragma mark -信号绑定
- (void)bindSignal
{
    @weakify(self);
    // 导航栏点击
    [self.navSegmentView setChangeClickBlock:^(CategorySegmentViewClickType clickType) {
        @strongify(self);
        switch (clickType) {
            case CategorySegmentViewClickTypeStore:
            {
                self.viewModel.currentCategoryType = CategroyDataType_Store;
            }
                break;
            case CategorySegmentViewClickTypeIntegral:
            {
                self.viewModel.currentCategoryType = CategroyDataType_Integral;
            }
                break;
                
            default:
                break;
        }
        [self getData];
    }];
    
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case CategroyViewModel_Signal_Type_GetDataSuccess:
            {
                // 获取数据成功
                self.mainView.hidden = NO;
                [self.view DLLoadingHideInSelf];
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case CategroyViewModel_Signal_Type_GotoProductlist:
            {
                // 商品列表
                ProductListViewController *vc = [ProductListViewController new];
                vc.propertyIsEnterFromMakeMoney = self.isEnterFromMakeMoney;
                vc.hidesBottomBarWhenPushed = YES;
                vc.viewModel = x;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark -视图切换
- (void)changeToViewWithGoods_cat_type:(NSString *)goods_cat_type
                          goods_cat_id:(NSString *)goods_cat_id
{
    if ([goods_cat_type integerValue] == 1) {
        // 积分商城
        [self.navSegmentView changeUIToClickType:CategorySegmentViewClickTypeIntegral];
        self.viewModel.currentCategoryType = CategroyDataType_Integral;
        [self getData];
    }else{
        // 储值商城某一类
        [self.navSegmentView changeUIToClickType:CategorySegmentViewClickTypeStore];
        self.viewModel.currentCategoryType = CategroyDataType_Store;
        self.viewModel.currentStoreGoodsCartID = goods_cat_id;
        [self getData];
    }
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
