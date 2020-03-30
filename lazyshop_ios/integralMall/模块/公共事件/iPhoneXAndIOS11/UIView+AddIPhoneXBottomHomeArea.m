//
//  UIView+AddIPhoneXBottomHomeArea.m
//  NetSchool
//
//  Created by LiYang on 2017/11/15.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "UIView+AddIPhoneXBottomHomeArea.h"

#import "UIView+Separator.h"

@implementation UIView (AddIPhoneXBottomHomeArea)

- (void)addIPhoneXHomeAreaUnderView:(UIView *)view
                    backGroundColor:(UIColor *)backGroundColor
                        showTopLine:(BOOL)showTopLine
{
    if (iPhoneX) {
        UIView *homeAreaView = [UIView new];
        // 背景
        if (!backGroundColor) {
            backGroundColor = [UIColor whiteColor];
        }
        homeAreaView.backgroundColor = backGroundColor;
        // 顶部线
        if (showTopLine) {
            [homeAreaView addTopLine];
        }
        // 布局
        [self addSubview:homeAreaView];
        [homeAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            if (view) {
                make.top.mas_equalTo(view.bottom);
            }else{
                make.height.mas_equalTo(HOME_BAR_HEIGHT);
            }
        }];
    }
}

@end
