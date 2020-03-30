//
//  PublicEventManager.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/14.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PublicEventManager.h"

#import "AppDelegate.h"
#import "ClassTableBarViewController.h"

// 商品详情
#import "GoodsDetailViewController.h"
#import "GoodsDetailViewModel.h"
// 商品列表
#import "ProductListViewController.h"
#import "ProductListViewModel.h"
// 商品搜索
#import "ProductSearchViewController.h"
#import "ProductSearchViewModel.h"
// 登录
#import "LoginByPasswordViewController.h"
// 购物车
#import "ShoppingCartViewController.h"
// 消息
#import "MessageViewController.h"
#import "MessageService.h"
// 网页
#import "DLWebViewController.h"
// 分类
#import "CategoryViewController.h"
// 分享
#import "DLShareController.h"
#import "LazyShopShareView.h"
// 轮询图跳转
#import "HomeLinkModel.h"
#import "GoodsDetailViewController.h"
#import "GoodsDetailViewModel.h"
// 法律条款等html文字页面
#import "LawProtocolViewController.h"
#import "LawProtocolViewModel.h"

//合伙人
#import "MyCorpsInfoViewController.h"
#import "JoinPaySuccessViewController.h"
#import "PartnerCompactViewController.h"
#import "PartnerSimpleIntroViewController.h"

// 上传图片网址
#define API_UPLOAD_IMAGE @"http://"APP_DOMAIN@"/uploader/image"

@implementation PublicEventManager

#pragma mark -单例
+ (instancetype)shareInstance
{
    static PublicEventManager *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [super allocWithZone:NULL];
    });
    return shareInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [PublicEventManager shareInstance];
}

+ (id)copy
{
    return [PublicEventManager shareInstance];
}

#pragma mark -跳转网页
+ (void)gotoWebDisplayViewControllerWithUrl:(NSString *)url
                       navigationController:(UINavigationController *)navigationController
{
    navigationController = [self fetchPushNavigationController:navigationController];
    DLWebViewController *webVC = [DLWebViewController new];
    webVC.urlString = url;
    webVC.hidesBottomBarWhenPushed = YES;
    [navigationController pushViewController:webVC animated:YES];
}

#pragma mark -跳转原生模块
+ (void)gotoNativeModuleWithLinkModel:(HomeLinkModel *)linkModel
                 navigationController:(UINavigationController *)navigationController

{
    navigationController = [self fetchPushNavigationController:navigationController];
    GoodsDetailViewController *detailVC = [GoodsDetailViewController new];
    detailVC.hidesBottomBarWhenPushed = YES;
    if ([linkModel.page isEqualToString:@"flash_detail"]) {
        // 秒杀详情
        detailVC.viewModel = [[GoodsDetailViewModel alloc] initWithProductID:linkModel.options.linkNativeID
                                                             goodsDetailType:GoodsDetailType_SecKill
                                                           activity_flash_id:linkModel.options.hdID
                                                         activity_bargain_id:nil
                                                           activity_group_id:nil];
        [navigationController pushViewController:detailVC animated:YES];
    }else if ([linkModel.page isEqualToString:@"group_detail"]){
        // 团购详情
        detailVC.viewModel = [[GoodsDetailViewModel alloc] initWithProductID:linkModel.options.linkNativeID
                                                             goodsDetailType:GoodsDetailType_GroupBy
                                                           activity_flash_id:nil
                                                         activity_bargain_id:nil
                                                           activity_group_id:linkModel.options.hdID];
        [navigationController pushViewController:detailVC animated:YES];
    }else if ([linkModel.page isEqualToString:@"bargain_detail"]){
        // 砍价详情
        detailVC.viewModel = [[GoodsDetailViewModel alloc] initWithProductID:linkModel.options.linkNativeID
                                                             goodsDetailType:GoodsDetailType_Bargain
                                                           activity_flash_id:nil
                                                         activity_bargain_id:linkModel.options.hdID
                                                           activity_group_id:nil];
        [navigationController pushViewController:detailVC animated:YES];

    }else if ([linkModel.page isEqualToString:@"goods_detail"]){
        // 需要登录
        if (![AccountService shareInstance].isLogin && [linkModel.options.referee_id length]) {
            [PublicEventManager judgeLoginToPushWithNavigationController:nil
                                                               pushBlock:nil];
            return;
        }
        
        // 商品详情
        NSString *goods_id = [linkModel.options.linkNativeID lyStringValue];
        NSString *goods_sku_id = [linkModel.options.goods_sku_id lyStringValue];
        NSString *attr_values = linkModel.options.attr_values;

        // 跳转商品详情
        detailVC.viewModel = [[GoodsDetailViewModel alloc] initWithProductID:goods_id
                                                       goodsDetailType:GoodsDetailType_Normal
                                                     activity_flash_id:nil
                                                   activity_bargain_id:nil
                                                     activity_group_id:nil];
        if (goods_sku_id.length&&attr_values.length) {
            detailVC.viewModel.fromScan = YES;
            detailVC.viewModel.scan_goods_sku_id = goods_sku_id;
            detailVC.viewModel.scan_attr_values = attr_values;
        }
        detailVC.viewModel.referee_id = linkModel.options.referee_id;
        
        [navigationController pushViewController:detailVC animated:YES];
    }else if ([linkModel.page isEqualToString:@"goods_cat"]){
        // 商品列表
        ProductListViewController *vc = [ProductListViewController new];
        vc.viewModel = [[ProductListViewModel alloc] initWithCartType:@"0"
                                                         goods_cat_id:linkModel.options.linkNativeID
                                                          goods_title:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [navigationController pushViewController:vc animated:YES];
    }else if([linkModel.page isEqualToString:@"partner_index"]){
        //推荐合伙人
        [self judgeLoginToPushWithNavigationController:navigationController pushBlock:^{
            //登录了，去请求partnermy看跳转,如果是跳转到注册页面就带上referee_id
            [DLLoading DLLoadingInWindow:@"请求中..." close:^{
                
            }];
            [self performSelectorInBackground:@selector(thread_partnerMy:) withObject:linkModel.options.referee_id];
        }];
    }
}

//查询 合伙人信息
+ (void)thread_partnerMy:(NSString*)szId{
    PartnerMyPageModel *pmpm = [[DataViewModel getInstance] partnerMy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [DLLoading DLHideInWindow];
        if (pmpm) {
            [PublicEventManager gotoPartnerPageWithNavigationController:nil withPartnerMyPageModel:pmpm withRefUsrId:szId];
        }
    });
}

#pragma mark -合伙人请求跳转
+ (void)gotoPartnerPageWithNavigationController:(UINavigationController*)navigationController withPartnerMyPageModel:(PartnerMyPageModel*)pmpm withRefUsrId:(NSString*)szRefUsrId{
    // tabbar有选中的导航 使用选中导航
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabbar = appDelegate.tabBarController;
    UINavigationController *nav = tabbar.viewControllers[tabbar.selectedIndex];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Partner" bundle:nil];
    UIViewController *viewCtrl = nil;
    
    if (pmpm.go_to_page == 1) {
        //1合伙人功能页面
        MyCorpsInfoViewController *myCorpsInfoViewCtrl = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([MyCorpsInfoViewController class])];
        
        viewCtrl = myCorpsInfoViewCtrl;
    }else if(pmpm.go_to_page == 2){
        //2 支付成功页面
        JoinPaySuccessViewController *joinPayViewCtrl = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([JoinPaySuccessViewController class])];
        
        viewCtrl = joinPayViewCtrl;
    }else if(pmpm.go_to_page == 3){
        //3跳转电子合同页面
        PartnerCompactViewController *partnerCompViewCtrl = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([PartnerCompactViewController class])];
        partnerCompViewCtrl.propertyOrderId = pmpm.partner_order_id;
        
        viewCtrl = partnerCompViewCtrl;
    }else if(pmpm.go_to_page == 4){
        //4注册页面
        PartnerSimpleIntroViewController *partnerSimpleViewCtrl = [storyBoard instantiateViewControllerWithIdentifier: NSStringFromClass([PartnerSimpleIntroViewController class])];
        partnerSimpleViewCtrl.hidesBottomBarWhenPushed = YES;
        partnerSimpleViewCtrl.propertyRefUsrId = szRefUsrId;
        
        viewCtrl = partnerSimpleViewCtrl;
    }
    
    if (viewCtrl && [nav isKindOfClass:[UINavigationController class]]) {
        viewCtrl.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:viewCtrl animated:YES];
    }
}

#pragma mark -跳转商品搜索
+ (void)gotoProductSearchViewControllerWithNavigationController:(UINavigationController *)navigationController
                                              productSearchFrom:(ProductSearchFrom)searchFrom
                                           searchTitleBackBlock:(searchTitleBackBlock)block
{
    ProductSearchViewController *searchVC = [[ProductSearchViewController alloc] initWithSearchBackBlock:block];
    searchVC.viewModel = [[ProductSearchViewModel alloc] initWithProductSearchFrom:searchFrom];
    searchVC.hidesBottomBarWhenPushed = YES;
    [[self fetchPushNavigationController:navigationController] pushViewController:searchVC animated:YES];
}

#pragma mark -若导航为空使用大导航
+ (UINavigationController *)fetchPushNavigationController:(UINavigationController *)navigationContrller
{
    // 传了导航 使用传的导航
    if (navigationContrller) {
        return navigationContrller;
    }
    // tabbar有选中的导航 使用选中导航
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabbar = appDelegate.tabBarController;
    UINavigationController *nav = tabbar.viewControllers[tabbar.selectedIndex];
    if ([nav isKindOfClass:[UINavigationController class]]) {
        return nav;
    }
    // 使用大导航
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.pushNavigationController;
}

#pragma mark -校验登录状态
+ (void)judgeLoginToPushWithNavigationController:(UINavigationController *)navigationContrller
                                       pushBlock:(PublicEventBaseBlock)pushBlock
{
    navigationContrller = [self fetchPushNavigationController:navigationContrller];
    if ([AccountService shareInstance].isLogin) {
        if (pushBlock) {
            pushBlock();
        }
    }else{
        LoginByPasswordViewController *loginVC = [LoginByPasswordViewController new];
        loginVC.hidesBottomBarWhenPushed = YES;
        [navigationContrller pushViewController:loginVC animated:YES];
    }
}

#pragma mark -获取购物车按钮
- (UIButton *)fetchShoppingCartButtonWithNavigationController:(UINavigationController *)navigationController
{
    UIButton *cartBtn = [UIButton new];
    UIImage *btnImage = [UIImage imageNamed:@"导航栏购物车"];
    [cartBtn setImage:btnImage forState:UIControlStateNormal];
    cartBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // 跳转购物车
        ShoppingCartViewController *vc = [ShoppingCartViewController new];
        vc.usedForPush = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [navigationController pushViewController:vc animated:YES];
        return [RACSignal empty];
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
    [cartBtn addSubview:edgeNumberLabel];
    [edgeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(btnWidth);
        make.centerX.mas_equalTo(cartBtn.centerX).offset(btnImage.size.width/2.0);
        make.centerY.mas_equalTo(cartBtn.centerY).offset(-btnImage.size.height/2.0);
    }];
    edgeNumberLabel.hidden = YES;
    
    // 消息数量
    @weakify(edgeNumberLabel);
    [[[RACObserve([ShoppingCartService sharedInstance], cartGoodsCount) distinctUntilChanged] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
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
    
    return cartBtn;
}

#pragma mark -获取消息按钮
- (UIButton *)fetchMessageButtonWithNavigationController:(UINavigationController *)navigationController
{
    if (!navigationController) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        navigationController = delegate.pushNavigationController;
    }

    UIButton *messageBtn = [UIButton new];
    UIImage *btnImage = [UIImage imageNamed:@"导航栏消息"];
    [messageBtn setImage:btnImage forState:UIControlStateNormal];
    messageBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [PublicEventManager judgeLoginToPushWithNavigationController:navigationController pushBlock:^{
            // 跳转消息中心
            MessageViewController *vc = [MessageViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [navigationController pushViewController:vc animated:YES];
        }];
        return [RACSignal empty];
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
    [messageBtn addSubview:edgeNumberLabel];
    [edgeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(btnWidth);
        make.centerX.mas_equalTo(messageBtn.centerX).offset(btnImage.size.width/2.0);
        make.centerY.mas_equalTo(messageBtn.centerY).offset(-btnImage.size.height/2.0);
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
    
    return messageBtn;
}

#pragma mark -获取分页页数
+ (NSString *)getPageNumberWithCount:(NSInteger)count
{
    return [NSString stringWithFormat:@"%ld",(long)(count/PageGetDataNumber+1)];
}

#pragma mark -切换分类
+ (void)changeToCategoryVCWithGoods_cat_type:(NSString *)goods_cat_type
                                goods_cat_id:(NSString *)goods_cat_id
{
    ClassTableBarViewController *tabbarVC = LYAppDelegate.tabBarController;
    CategoryViewController *cateGoryVC = [tabbarVC fetchCategoryViewController];
    [[[cateGoryVC rac_signalForSelector:@selector(viewWillAppear:)] takeUntil:[cateGoryVC rac_signalForSelector:@selector(viewDidDisappear:)]] subscribeNext:^(id x) {
        [cateGoryVC changeToViewWithGoods_cat_type:goods_cat_type
                                      goods_cat_id:goods_cat_id];
    }];
    [tabbarVC changeToTab:ClassTableBarType_Category];
}

#pragma mark -分享
+ (void)shareWithAlertTitle:(NSString *)alertTitle
                      title:(NSString *)title
                detailTitle:(NSString *)detailTitle
                      image:(id)image
                 htmlString:(NSString *)htmlString
{
    alertTitle = alertTitle.length?alertTitle:@"分享到";
    [DLShareController shareInstance].customShareView = [[LazyShopShareView alloc] initWithTitle:alertTitle];
    [[DLShareController shareInstance] displayTitle:title
                                        DetailTitle:detailTitle
                                       previewImage:image
                                            HtmlStr:htmlString
                                         isAppAgree:[LYAppCheckManager shareInstance].isAppAgree
                                         shareStyle:DLShareStyleNews];
}

#pragma mark -上传图片
- (void)uploadImages:(NSArray *)images
            complete:(void(^)(NSArray *imgUrls))completeBlock
                fail:(void(^)(NSString *msg))failBlock;
{
    NSDictionary *params = @{@"token":SignInToken};
    
    // 上传请求
    NSMutableArray *resultArray = [NSMutableArray array];
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL * _Nonnull stop) {
        RACSignal *uploadSignal =  [LYHttpHelper UPLOAD:API_UPLOAD_IMAGE
                                                 params:params
                                                  files:nil
                                               fileData:[CommUtls compressImage:image
                                                                     MaxSize_KB:1024*1.8]
                                               fileName:@"file.png"];
        [resultArray addObject:uploadSignal];
    }];
    
    // 取出服务器返回的相对路径url
    [[RACSignal zip:resultArray] subscribeNext:^(RACTuple *tuple) {
        NSMutableArray *imgUrls = [NSMutableArray array];
        // 1
        NSDictionary *dict1 = tuple.first;
        NSString *fullPath1 = dict1[@"data"][@"relative_path"];
        if (fullPath1.length) {
            [imgUrls addObject:fullPath1];
        }
        // 2
        NSDictionary *dict2 = tuple.second;
        NSString *fullPath2 = dict2[@"data"][@"relative_path"];
        if (fullPath2.length) {
            [imgUrls addObject:fullPath2];
        }
        // 3
        NSDictionary *dict3 = tuple.third;
        NSString *fullPath3 = dict3[@"data"][@"relative_path"];
        if (fullPath3.length) {
            [imgUrls addObject:fullPath3];
        }
        
        if (completeBlock) {
            completeBlock(imgUrls);
        }
    } error:^(NSError *error) {
        if (failBlock) {
            failBlock(AppErrorParsing(error));
        }
    }];
}

#pragma mark -使用当前tabbar选中导航推出vc
+ (void)tabbarNavPushViewController:(UIViewController *)viewController
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabbar = appDelegate.tabBarController;
    UINavigationController *nav = tabbar.viewControllers[tabbar.selectedIndex];
    if ([nav isKindOfClass:[UINavigationController class]]) {
        viewController.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:viewController animated:YES];
    }
}

#pragma mark -跳转法律条款页面
+ (void)pushLawProtocolViewControllerWithContentID:(NSString *)contentID
{
    LawProtocolViewController *vc = [LawProtocolViewController new];
    vc.viewModel = [[LawProtocolViewModel alloc] initWithContentID:contentID];
    [self tabbarNavPushViewController:vc];
}

@end
