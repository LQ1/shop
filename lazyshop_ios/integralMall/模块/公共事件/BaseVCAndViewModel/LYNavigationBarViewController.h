//
//  LYNavigationBarViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "NavigationBarController.h"

@class LYBaseViewModel;
@class LYMainView;

@interface LYNavigationBarViewController : NavigationBarController

@property (nonatomic,strong)LYBaseViewModel *viewModel;
@property (nonatomic,strong)LYMainView *mainView;
@property (nonatomic,copy)NSString *loadingFailedImageName;

/*
 *  获取数据
 */
- (void)getData;

/*
 *  添加主视图
 */
- (void)addViews;

/*
 *  绑定信号
 */
- (void)bindSignal;

@end
