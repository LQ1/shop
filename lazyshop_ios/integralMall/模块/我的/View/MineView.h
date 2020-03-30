//
//  MineView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MineViewModel;

@interface MineView : UIView

- (void)reloadDataWithViewModel:(MineViewModel *)viewModel;

@end
