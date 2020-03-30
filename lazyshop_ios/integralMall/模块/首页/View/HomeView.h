//
//  HomeView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewModel;

@interface HomeView : UIView

@property (nonatomic,strong)UITableView *mainTable;

/*
 *  初始化
 */
- (instancetype)initWithViewModel:(HomeViewModel *)viewModel;

@end
