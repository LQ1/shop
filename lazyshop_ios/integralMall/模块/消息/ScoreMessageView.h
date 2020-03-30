//
//  ScoreMessageView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AutoTableView.h"

@class ScoreMessageViewModel;

@interface ScoreMessageView : AutoTableView

- (void)reloadDataWithViewModel:(ScoreMessageViewModel *)viewModel;

@end
