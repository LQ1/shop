//
//  GoodsDetailViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/14.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailViewController.h"

#import "GoodsDetailViewModel.h"

// 菜单
#import "SoCoolMenu.h"
#import "SiftModel.h"
#import "MoreMenuItemView.h"

#import "LYCategoryChangeView.h"
#import "GoodsDetailView.h"
#import "GoodsDetailBottomView.h"

#import "GoodDetailPatternChooseViewController.h"
#import "GoodsDetailCouponChooseViewController.h"
#import "GoodsTagsDetailViewController.h"
#import "ConfirmOrderViewController.h"
#import "MyBargainViewController.h"

#import "MessageService.h"
#import "AppDelegate.h"

// 播放器
#import "JWPlayer.h"

#import "DataViewModel.h"
#import "QRCodeView.h"

@interface GoodsDetailViewController ()<SoCoolMenuDelegate>

@property (nonatomic,strong)LYCategoryChangeView *navChangeView;

@property (strong, nonatomic) SoCoolMenu *menu;
@property (strong, nonatomic) NSArray    *menuDataArray;

@property (nonatomic,strong)GoodsDetailView *mainView;

@property (nonatomic,assign)BOOL hasDisAppered;

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViews];
    [self bindSignal];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hasDisAppered = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.hasDisAppered = YES;
    [self.viewModel stopPlay];
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
    [self.viewModel bindPartner];
    [self.viewModel getData];
}

#pragma mark -主界面
- (void)addViews
{
    @weakify(self);
    // 导航
    LYCategoryChangeView *navChangeView = [[LYCategoryChangeView alloc] initWithTitles:@[@"商品",@"详情",@"评价"]
                                                                           selectBlock:^(NSInteger selectIndex) {
                                                                               @strongify(self);
                                                                               [self changeViewAtIndex:selectIndex];
                                                                           }];
    self.navChangeView = navChangeView;
    [navChangeView showViewIn:self.navigationBarView
                centerYOffSet:10];
    // 更多
    self.navigationBarView.navagationBarStyle = Left_right_button_show;
    UIImage *btnImage = [UIImage imageNamed:@"导航栏查看更多"];
    [self.navigationBarView.rightButton setImage:btnImage forState:UIControlStateNormal];
    [self.navigationBarView.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(30);
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(0);
    }];
    // 消息数量
    CGFloat btnWidth = 15.;
    UILabel *edgeNumberLabel                  = [UILabel new];
    edgeNumberLabel.backgroundColor           = [CommUtls colorWithHexString:@"#ff6262"];
    edgeNumberLabel.font                      = [UIFont systemFontOfSize:MIN_FONT_SIZE];
    edgeNumberLabel.textAlignment             = NSTextAlignmentCenter;
    edgeNumberLabel.textColor                 = [CommUtls colorWithHexString:@"#ffffff"];
    edgeNumberLabel.adjustsFontSizeToFitWidth = YES;
    edgeNumberLabel.layer.cornerRadius        = btnWidth/2.;
    edgeNumberLabel.layer.masksToBounds       = YES;
    edgeNumberLabel.userInteractionEnabled    = YES;
    [self.navigationBarView.rightButton addSubview:edgeNumberLabel];
    [edgeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(btnWidth);
        make.centerX.mas_equalTo(self.navigationBarView.rightButton.centerX).offset(15);
        make.centerY.mas_equalTo(self.navigationBarView.rightButton.centerY).offset(-8);
    }];
    edgeNumberLabel.hidden = YES;
    // 消息数量
    @weakify(edgeNumberLabel);
    [[[RACObserve([MessageService shareInstance], unReadCount) distinctUntilChanged] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(edgeNumberLabel);
        NSString *cartCount = [x stringValue];
        if ([cartCount integerValue]>0) {
            edgeNumberLabel.hidden = NO;
            if ([cartCount integerValue]>9) {
                edgeNumberLabel.text = @"9+";
            }else{
                edgeNumberLabel.text = cartCount;
            }
        }else{
            edgeNumberLabel.hidden = YES;
            edgeNumberLabel.text = cartCount;
        }
    }];
    
    // 购物车
    UIButton *cartBtn = [[PublicEventManager shareInstance] fetchShoppingCartButtonWithNavigationController:self.navigationController];
    [self.navigationBarView addSubview:cartBtn];
    [cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.navigationBarView.rightButton.left);
        make.top.bottom.mas_equalTo(self.navigationBarView.rightButton);
        make.width.mas_equalTo(30);
    }];
    // 菜单
    [self addMenuView];
    
    // 主界面
    self.mainView = [[GoodsDetailView alloc] initWithViewModel:self.viewModel];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
    self.mainView.hidden = YES;
    
    if (self.propertyIsEnterFromMakeMoney) {
        //从r我要赚钱-->推荐单品进入的
        //创建一个二维码
        CGRect rc = {0};
        rc.size.width = rc.size.height = 46;
        rc.origin.x = KScreenWidth - 46 - 16;
        rc.origin.y = STATUS_BAR_HEIGHT + self.navigationController.navigationBar.frame.size.height + 16;
        UIImageView *imgRQCode = [[UIImageView alloc] initWithFrame:rc];
        imgRQCode.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *gesture_imgRQCode = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_imgRQCode_onClicked:)];
        [imgRQCode addGestureRecognizer:gesture_imgRQCode];
        
        imgRQCode.image = [UIImage imageNamed:@"qrcode"];
        [self.view addSubview:imgRQCode];
    }
}

//二维码点击生成商品
- (void)gesture_imgRQCode_onClicked:(id)sender{
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_recomment) withObject:nil];
}

// changeView
- (void)changeViewAtIndex:(NSInteger)index
{
    [self.mainView changeViewAtIndex:index];
}

// 点击更多
- (void)rightButtonClick
{
    [self.menu showMenuInView:self.view];
}

// soolCooLMenu
- (void)addMenuView
{
    // 数据源
    SiftModel *homePageModel = [SiftModel new];
    homePageModel.siftId = @"1";
    homePageModel.siftName = @"首页";
    homePageModel.siftImgName = @"导航栏下拉框首页-";
    homePageModel.hasBottomLine = YES;
    
    SiftModel *messageModel = [SiftModel new];
    messageModel.siftId = @"2";
    messageModel.siftName = @"消息";
    messageModel.siftImgName = @"导航栏下拉框消息";
    
    self.menuDataArray = @[homePageModel,messageModel];
    
    self.menu = [[SoCoolMenu alloc] initWithBgColor:[UIColor blackColor] andCornerType:cornerType_no];
    self.menu.delegate = self;
    self.menu.cacelPartingLine = YES;
    [self.menu loadItems];
}

#pragma mark  SoCoolMenuDelegate
- (NSInteger)numberOfItemsInSoCoolMenu:(SoCoolMenu *)soCoolMenu
{
    return self.menuDataArray.count;
}

- (CGFloat)widthOfItemsInSoCoolMenu:(SoCoolMenu *)soCoolMenu
{
    return 150.f;
}

- (CGFloat)heightOfItemsInSoCoolMenu:(SoCoolMenu *)soCoolMenu
{
    return 42.f;
}

- (CGPoint)pointOfShowPositionInSoCoolMenu:(SoCoolMenu *)soCoolMenu
{
    // 设置弹出菜单的弹出位置
    return CGPointMake([UIScreen mainScreen].bounds.size.width-155, NAVIGATIONBAR_HEIGHT+2.5);
}

- (void)soCoolMenu:(SoCoolMenu *)soCoolMenu didSelectRow:(NSInteger)row
{
    if (row == 0) {
        // 回到首页
        [self gotoHomePage];
    }else{
        // 跳转消息
        CLog(@"跳转消息");
    }
}

- (SCItemView *)soCoolMenu:(SoCoolMenu *)soCoolMenu SCItemViewForRow:(NSInteger)row
{
    SiftModel *sift                    = self.menuDataArray[row];
    MoreMenuItemView *item              = [[MoreMenuItemView alloc] init];
    [item reloadDataWithSiftModel:sift];
    
    return item;
}

#pragma mark -信号绑定
- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case GoodsDetailViewModel_Signal_Type_TipLoading:
            {
                // 弹框
                [DLLoading DLToolTipInWindow:x];
            }
                break;
            case GoodsDetailViewModel_Signal_Type_GetDataSuccess:
            {
                // 商品详情获取成功
                self.mainView.hidden = NO;
                [self.view DLLoadingHideInSelf];
                [self.mainView reloadDataWithViewModel:self.viewModel];
            }
                break;
            case GoodsDetailViewModel_Signal_Type_GetDataFail:
            {
                // 商品详情获取失败
                NSError *error = x;
                NSString *title = AppErrorParsing(error);
                [self.view DLLoadingCycleInSelf:^{
                    @strongify(self);
                    [self getData];
                } code:error.code title:title buttonTitle:LOAD_FAILED_RETRY];
            }
                break;
            case GoodsDetailViewModel_Signal_Type_GotoPattrnChoose:
            {
                // 跳转参数选择
                GoodDetailPatternChooseViewController *vc = [GoodDetailPatternChooseViewController new];
                vc.viewModel = x;
                vc.goodsDetailViewModel = self.viewModel;
                // 需要监听消失
                @weakify(vc);
                [[[[DLAlertShowAnimate sharedInstance] rac_signalForSelector:@selector(disappear)] takeWhileBlock:^BOOL(id x) {
                    @strongify(self);
                    return self.hasDisAppered == NO;
                }] subscribeNext:^(id x) {
                    @strongify(self,vc);
                    [vc removeFromParentViewController];
                    if ([vc isKindOfClass:[GoodDetailPatternChooseViewController class]]) {
                        // 需要刷新参数显示
                        [self.mainView reloadDataWithViewModel:self.viewModel];
                    }
                }];
                [self showVC:vc frame:CGRectMake(0, 200, KScreenWidth, KScreenHeight-200)];
                
            }
                break;
            case GoodsDetailViewModel_Signal_Type_GotoCouponChoose:
            {
                // 跳转优惠券选择--需要登录
                [PublicEventManager judgeLoginToPushWithNavigationController:nil pushBlock:^{
                    GoodsDetailCouponChooseViewController *vc = [GoodsDetailCouponChooseViewController new];
                    vc.viewModel = x;
                    [self showVC:vc frame:CGRectMake(0, 200, KScreenWidth, KScreenHeight-200)];
                }];
            }
                break;
            case GoodsDetailViewModel_Signal_Type_GotoGoodsTagsDetail:
            {
                // 跳转标签详情
                GoodsTagsDetailViewController *vc = [[GoodsTagsDetailViewController alloc] initWithGoodsTagModels:x];
                [self showVC:vc frame:CGRectMake(0, 200, KScreenWidth, KScreenHeight-200)];
            }
                break;
            case GoodsDetailViewModel_Signal_Type_GotoConfirmOrder:
            {
                // 跳转确认订单
                ConfirmOrderViewController *vc = [ConfirmOrderViewController new];
                vc.viewModel = x;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case GoodsDetailViewModel_Signal_Type_ChangeNavViewIndex:
            {
                // 切换导航选中
                [self.navChangeView makeIndexSelected:[x integerValue]];
            }
                break;
            case GoodsDetailViewModel_Signal_Type_GotoMyBargain:
            {
                // 我的砍价
                MyBargainViewController *vc = [MyBargainViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case GoodsDetailViewModel_Signal_Type_PlayVideo:
            {
                // 播放视频
                CGFloat playerHeight = KScreenWidth*9./16.;
                JWPlayer*player=[[JWPlayer alloc] initWithFrame:CGRectMake(0, KScreenHeight*.5-playerHeight*.5, KScreenWidth,playerHeight)];
                [player updatePlayerWith:[NSURL URLWithString:x]];
                [player showInSuperView:self.view andSuperVC:self];
            }
                break;
                
            default:
                break;
        }
    }];
    
    // 监测loading状态
    [RACObserve(self.viewModel, loading) subscribeNext:^(id x) {
        if ([x boolValue]) {
            [DLLoading DLLoadingInWindow:nil close:^{
                @strongify(self);
                [self.viewModel dispose];
            }];
        }else{
            [DLLoading DLHideInWindow];
        }
    }];
    
    // 弹框
    [self.viewModel.tipLoadingSignal subscribeNext:^(id x) {
        [DLLoading DLToolTipInWindow:x];
    }];
}

#pragma mark -界面跳转
// 半屏展示
- (void)showVC:(UIViewController *)vc
         frame:(CGRect)frame

{
    vc.view.frame = frame;
    [self addChildViewController:vc];
    [DLAlertShowAnimate showInView:self.view
                         alertView:vc.view
                         popupMode:View_Popup_Mode_Down
                           bgAlpha:.5
                  outsideDisappear:YES];
}
// 跳转首页
- (void)gotoHomePage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[[RACSignal interval:.66 onScheduler:[RACScheduler currentScheduler]] take:1] subscribeNext:^(id x) {
        [LYAppDelegate.tabBarController changeToTab:ClassTableBarType_HomePage];
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


//一键推荐
- (void)thread_recomment{
    NSString *szQRCodeUrl = [[DataViewModel getInstance] partnerQRCode:3 withGoodsId:self.viewModel.productID];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        
        if (![Utility isStringEmptyOrNull:szQRCodeUrl]) {
            NSArray *arrayViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([QRCodeView class]) owner:nil options:nil];
            QRCodeView *viewQRCode = [arrayViews objectAtIndex:0];
            [viewQRCode setFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
            [viewQRCode initEvent];
            [viewQRCode loadImage:szQRCodeUrl];
            
            CABasicAnimation *aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            aniScale.duration = 0.5f;
            aniScale.fromValue = [NSNumber numberWithFloat:0.1f];
            aniScale.toValue = [NSNumber numberWithFloat:1.0f];
            [viewQRCode.layer addAnimation:aniScale forKey:@"ANI_SCALE"];
            
            [self.view addSubview:viewQRCode];
            
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

@end
