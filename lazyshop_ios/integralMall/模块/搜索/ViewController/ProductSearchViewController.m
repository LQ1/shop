//
//  ProductSearchViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductSearchViewController.h"

#import "ProductSearchNavView.h"
#import "ProductSearchViewModel.h"
#import "ProductSearchView.h"

#import "ProductListViewController.h"

@interface ProductSearchViewController ()

@property (nonatomic,strong ) ProductSearchNavView *searchView;
@property (nonatomic,strong ) ProductSearchView *mainView;
@property (nonatomic,copy   ) searchTitleBackBlock searchBackBlock;

@end

@implementation ProductSearchViewController

- (instancetype)initWithSearchBackBlock:(searchTitleBackBlock)block
{
    self = [super init];
    if (self) {
        self.searchBackBlock = block;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
    [self getData];
    // Do any additional setup after loading the view.
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
    // 导航
    self.navigationBarView.navagationBarStyle = Left_right_button_show;
    self.navigationBarView.rightLabel.text = @"搜索";
    // 搜索框
    ProductSearchNavView *searchView = [[ProductSearchNavView alloc] initWithInputEnabled:YES
                                                                                 tipTitle:@"搜索商品名称"
                                                                        ProductSearchFrom:ProductSearchFrom_None
                                                                     searchTitleBackBlock:nil];
    self.searchView = searchView;
    [self.navigationBarView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-48);
        make.height.mas_equalTo(33);
        make.centerY.mas_equalTo(self.navigationBarView).offset(10);
    }];
    // 主界面
    self.mainView = [ProductSearchView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

- (void)rightButtonClick
{
    UITextField *searchTextfiled = self.searchView.searchTextfield;
    
    [searchTextfiled resignFirstResponder];
    
    if (searchTextfiled.text.length) {
        [self.viewModel startToSearchKeyword:searchTextfiled.text];
    }else{
        [DLLoading DLToolTipInWindow:@"请输入关键字"];
    }
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case ProductSearchViewModel_Signal_Type_ExsitsHistory:
            {
                // 获取成功
                self.mainView.hidden = NO;
                [self.view DLLoadingHideInSelf];
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case ProductSearchViewModel_Signal_Type_NoHistory:
            {
                // 获取失败
                self.mainView.hidden = YES;
                [self.view DLLoadingCustomInSelf:@"没有搜索记录"
                                            code:DLDataEmpty
                                           title:@"您没有搜索记录呢"
                                           cycle:nil
                                     buttonTitle:nil];
            }
                break;
            case ProductSearchViewModel_Signal_Type_GotoProductList:
            {
                // 跳转商品列表
                ProductListViewController *vc = [ProductListViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ProductSearchViewModel_Signal_Type_BackSearchTitle:
            {
                // 回传搜索字段
                if (self.searchBackBlock) {
                    self.searchBackBlock(x);
                }
                [self.navigationController popViewControllerAnimated:YES];
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
