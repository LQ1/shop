//
//  PublicEventManager.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/14.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProductSearchMacro.h"
#import "EntityModel.h"

@class HomeLinkModel;

typedef void (^PublicEventBaseBlock)(void);

@interface PublicEventManager : NSObject

/*
 *  单例
 */
+ (instancetype)shareInstance;

/*
 *  跳转网页
 */
+ (void)gotoWebDisplayViewControllerWithUrl:(NSString *)url
                       navigationController:(UINavigationController *)navigationController;

/*
 *  跳转原生
 */
+ (void)gotoNativeModuleWithLinkModel:(HomeLinkModel *)linkModel
                 navigationController:(UINavigationController *)navigationController;

/*
 *  合伙人跳转
 */
+ (void)gotoPartnerPageWithNavigationController:(UINavigationController*)navigationController withPartnerMyPageModel:(PartnerMyPageModel*)pmpm withRefUsrId:(NSString*)szRefUsrId;

/*
 *  跳转搜索
 */
+ (void)gotoProductSearchViewControllerWithNavigationController:(UINavigationController *)navigationController
                                              productSearchFrom:(ProductSearchFrom)searchFrom
                                           searchTitleBackBlock:(searchTitleBackBlock)block;

/*
 *  获取导航
 */
+ (UINavigationController *)fetchPushNavigationController:(UINavigationController *)navigationContrller;

/*
 *  pushVC前需要校验登录状态
 */
+ (void)judgeLoginToPushWithNavigationController:(UINavigationController *)navigationContrller
                                       pushBlock:(PublicEventBaseBlock)pushBlock;

/*
 *  获取购物车按钮
 */
- (UIButton *)fetchShoppingCartButtonWithNavigationController:(UINavigationController *)navigationController;

/*
 *  获取消息按钮
 */
- (UIButton *)fetchMessageButtonWithNavigationController:(UINavigationController *)navigationController;

/*
 *  获取分页页数
 */
+ (NSString *)getPageNumberWithCount:(NSInteger)count;

/*
 *  切换分类vc
 */
+ (void)changeToCategoryVCWithGoods_cat_type:(NSString *)goods_cat_type
                                goods_cat_id:(NSString *)goods_cat_id;

/*
 *  调起新闻样式的分享
 */
+ (void)shareWithAlertTitle:(NSString *)alertTitle
                      title:(NSString *)title
                detailTitle:(NSString *)detailTitle
                      image:(id)image
                 htmlString:(NSString *)htmlString;

/*
 *  上传图片（最多支持3张）
 */
- (void)uploadImages:(NSArray *)images
            complete:(void(^)(NSArray *imgUrls))completeBlock
                fail:(void(^)(NSString *msg))failBlock;

/*
 *  使用当前tabbar选中导航推出vc
 */
+ (void)tabbarNavPushViewController:(UIViewController *)viewController;

/**
 *  跳转法律条款等html文字页面
 */
+ (void)pushLawProtocolViewControllerWithContentID:(NSString *)contentID;

@end
