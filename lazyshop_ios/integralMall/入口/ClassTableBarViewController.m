//
//  ClassTableBarViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ClassTableBarViewController.h"

#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "ShoppingCartViewController.h"
#import "MineViewController.h"
#import "CheckUpdateManager.h"

@interface ClassTableBarViewController ()

@property (nonatomic,assign)BOOL hasAppered;

@property (nonatomic,strong)CategoryViewController *categoryVC;

@end

@implementation ClassTableBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 创建tabbar布局
    [self createTabBar];
    // 检查更新
    [[CheckUpdateManager shareInstance] checkAppUpdateWithNoUpdate:nil
                                                           loading:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 移除rootVC 避免popToRoot出现问题
    if (!self.hasAppered) {
        NSMutableArray *array                     = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [array removeObjectAtIndex:0];
        self.navigationController.viewControllers = array;
        self.hasAppered                           = YES;
    }
}

#pragma mark -tabBar布局
- (void)createTabBar
{
    UITabBarItem *item1;
    UITabBarItem *item2;
    UITabBarItem *item3;
    UITabBarItem *item4;
    
    item1 = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"首页-图标未选中"] selectedImage:[[UIImage imageNamed:@"首页图标"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item2 = [[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"分类图标未选中"] selectedImage:[[UIImage imageNamed:@"分类图标"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    item3 = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"购物车未选中"] selectedImage:[[UIImage imageNamed:@"购物车图标"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    item4 = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"我的未选中"] selectedImage:[[UIImage imageNamed:@"我的图标"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    
    // 背景
    CGRect bgViewFrame;
    if (iPhoneX) {
        bgViewFrame = CGRectMake(self.tabBar.bounds.origin.x, self.tabBar.bounds.origin.y, self.tabBar.bounds.size.width, self.tabBar.bounds.size.height+HOME_BAR_HEIGHT);
    }else{
        bgViewFrame = self.tabBar.bounds;
    }

    UIView *bgView = [[UIView alloc] initWithFrame:bgViewFrame];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
    [self.tabBar setTintColor:[CommUtls colorWithHexString:APP_MainColor]];
    self.tabBar.barStyle = UIBarStyleBlack;
    
    self.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.tabBar.layer.shadowOffset = CGSizeMake(0,-1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.tabBar.layer.shadowOpacity = 0.05;//阴影透明度，默认0
    self.tabBar.layer.shadowRadius = 1;
    
    // 首页
    HomeViewController *homeVC = [HomeViewController new];
    UINavigationController *navHomeVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    navHomeVC.tabBarItem = item1;
    navHomeVC.navigationBar.hidden = YES;
    // 分类
    CategoryViewController *categoryVC = [CategoryViewController new];
    self.categoryVC = categoryVC;
    UINavigationController *navCategoryVC = [[UINavigationController alloc] initWithRootViewController:categoryVC];
    navCategoryVC.tabBarItem = item2;
    navCategoryVC.navigationBar.hidden = YES;
    // 购物车
    ShoppingCartViewController *cartVC = [ShoppingCartViewController new];
    UINavigationController *navCartVC = [[UINavigationController alloc] initWithRootViewController:cartVC];
    navCartVC.navigationBar.hidden = YES;
    navCartVC.tabBarItem = item3;
    // 我的
    MineViewController *mineVC = [MineViewController new];
    UINavigationController *navMineVC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    navMineVC.navigationBar.hidden = YES;
    navMineVC.tabBarItem = item4;
    
    self.viewControllers = @[navHomeVC, navCategoryVC, navCartVC, navMineVC];
}

#pragma mark -切换选中状态
- (void)changeToTab:(ClassTableBarType)type
{
    self.selectedIndex = type;
}

#pragma mark -获取分类vc
- (CategoryViewController *)fetchCategoryViewController
{
    return self.categoryVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -转屏
- (BOOL)shouldAutorotate
{
    return [[self.viewControllers objectAtIndex:self.selectedIndex] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self.viewControllers objectAtIndex:self.selectedIndex] supportedInterfaceOrientations];
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
