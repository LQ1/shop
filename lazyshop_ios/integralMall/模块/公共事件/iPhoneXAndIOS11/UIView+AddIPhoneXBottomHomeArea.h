//
//  UIView+AddIPhoneXBottomHomeArea.h
//  NetSchool
//
//  Created by LiYang on 2017/11/15.
//  Copyright © 2017年 CDEL. All rights reserved.
//



@interface UIView (AddIPhoneXBottomHomeArea)


/**
 iPhoneX添加底部homeBar区域视图
 !要保证调用此方法的UIView的底部是居屏幕底部的

 @param view homeBar以上的view
 @param backGroundColor homeBar视图颜色
 @param showTopLine homeBar视图是否显示顶部线
 */
- (void)addIPhoneXHomeAreaUnderView:(UIView *)view
                    backGroundColor:(UIColor *)backGroundColor
                        showTopLine:(BOOL)showTopLine;

@end
