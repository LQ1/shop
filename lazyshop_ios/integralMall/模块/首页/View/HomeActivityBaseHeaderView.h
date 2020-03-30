//
//  HomeActivityBaseHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HomeActivityBaseHeaderViewHeight 82.5f

@interface HomeActivityBaseHeaderView : UIView

@property (nonatomic,readonly) RACSubject *clickSignal;

@property (nonatomic,strong)UILabel *leftTipLabel;

/*
 *  刷新标题
 */
- (void)resetTitle:(NSString *)title;

@end
