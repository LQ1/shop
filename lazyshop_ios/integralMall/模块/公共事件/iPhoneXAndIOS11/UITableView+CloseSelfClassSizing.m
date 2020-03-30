//
//  UITableView+CloseSelfClassSizing.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/8/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "UITableView+CloseSelfClassSizing.h"

@implementation UITableView (CloseSelfClassSizing)

- (void)closeSelfClassSizing
{
    if (IsIOS11) {
        // iOS11需要关闭Self-Sizing 避免加载更多时因contentOffSet有问题会造成tableView闪动、获取2次数据等问题
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
}

@end
