//
//  RootViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "RootViewController.h"

#import "LYHttpHelper.h"
#import "ClassTableBarViewController.h"
#import "InfoHelper.h"
#import "DLGuidScrollPresenter.h"

@interface RootViewController ()

@property (nonatomic, strong) UIView                *launchView;
@property (nonatomic, strong) DLGuidScrollPresenter *guidPresenter;
@property (nonatomic, assign) BOOL                  autoLoginFinish;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 启动图
    [self addLaunchScreen];
    // 引导页
    [self addGuidView];
    // 检测版本发布 并自动登录
    [self checkAppRelease];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark -启动图
// 添加
- (void)addLaunchScreen
{
    @weakify(self);
    _launchView = [self fetchLauchView];
    [self.view addSubview:self.launchView];
    [self.launchView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view);
    }];
}
// 获取启动图片
- (UIView *)fetchLauchView
{
    UIView *tempLauchView;
    
    NSString *imageName;
    
    CGSize windowSize = [[UIApplication sharedApplication].delegate window].bounds.size;
    CLog(@"window size test : %f %f",windowSize.width,windowSize.height);
    NSString *orientation = @"Portrait";
    NSArray *imageDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dic in imageDict) {
        CGSize imageSize = CGSizeFromString(dic[@"UILaunchImageSize"]);
        CLog(@"image size test : %f %f",imageSize.width,imageSize.height);
        
        if (CGSizeEqualToSize(windowSize, imageSize) && [orientation isEqualToString:dic[@"UILaunchImageOrientation"]]) {
            imageName = dic[@"UILaunchImageName"];
        }
    }
    
    tempLauchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    
    // 旋转菊花
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingView.hidesWhenStopped = YES;
    [loadingView startAnimating];
    [tempLauchView addSubview:loadingView];
    [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(25);
        make.center.equalTo(tempLauchView);
    }];
    
    return tempLauchView;
}
// 删除
- (void)removeLaunchScreen
{
    [self.launchView removeFromSuperview];
    self.launchView = nil;
}

#pragma mark -引导页
// 引导图
- (void)addGuidView
{
    // 判断引导图版本号
    NSInteger guidVersion = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"GuidVersion"] integerValue];
    NSInteger localGuidVersion = [InfoHelper guidVersion];
    if (localGuidVersion >= guidVersion) {
        return;
    } else {
        [InfoHelper recordGuidVersion:guidVersion];
    }
    @weakify(self);
    _guidPresenter = [DLGuidScrollPresenter new];
    [self.view addSubview:_guidPresenter];
    [_guidPresenter mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    // 引导页图片
    NSString *imageSuffix = @"";
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        if (iPhone4) {
            imageSuffix = @"1";
        }else{
            imageSuffix = @"2";
        }
    }else if ([UIScreen mainScreen].bounds.size.width == 375){
        if (iPhoneX) {
            imageSuffix = @"5";
        }else{
            imageSuffix = @"3";
        }
    }else {
        imageSuffix = @"4";
    }
    
    [_guidPresenter setupViewsWithArray:@[[[DLGuidPage alloc] initWithTopImageName:nil
                                                                   bottomImageName:nil
                                                                     backImageName:[NSString stringWithFormat:@"引导页第一页%@",imageSuffix]]
                                          , [[DLGuidPage alloc] initWithTopImageName:nil
                                                                     bottomImageName:nil
                                                                       backImageName:[NSString stringWithFormat:@"引导页第二页%@",imageSuffix]]
                                          , [[DLGuidPage alloc] initWithTopImageName:nil
                                                                     bottomImageName:nil
                                                                       backImageName:[NSString stringWithFormat:@"引导页第三页%@",imageSuffix]]]];
    [_guidPresenter guidViewClose:^{
        @strongify(self);
        [self judgeToClassTabBarVC];
    }];
}

#pragma mark -检测版本发布、自动登录
- (void)checkAppRelease
{
    @weakify(self);
    [[[LYAppCheckManager shareInstance] checkIsAppAgree] subscribeNext:^(id x) {
        @strongify(self);
        [self autoLogin];
    } error:^(NSError *error) {
        @strongify(self);
        [self autoLogin];
    }];
}
- (void)autoLogin
{
    @weakify(self);
    [[[AccountService shareInstance] autoLogin] subscribeNext:^(id x) {
        @strongify(self);
        self.autoLoginFinish = YES;
        [self judgeToClassTabBarVC];
    } error:^(NSError *error) {
        @strongify(self);
        self.autoLoginFinish = YES;
        [self judgeToClassTabBarVC];
    }];
}

#pragma mark -跳转tabbar
- (void)judgeToClassTabBarVC
{
    if (!_guidPresenter.superview && self.autoLoginFinish) {
        [self removeLaunchScreen];
        ClassTableBarViewController *tabbarVC = [ClassTableBarViewController new];
        LYAppDelegate.tabBarController = tabbarVC;
        [self.navigationController pushViewController:tabbarVC animated:NO];
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
