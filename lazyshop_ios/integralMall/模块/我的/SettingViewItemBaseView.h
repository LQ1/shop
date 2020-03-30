//
//  SettingViewItemBaseView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SettingViewItemBaseViewHeight 50.0f

@interface SettingViewItemBaseView : UIView

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *rightArrowView;

@property (nonatomic,readonly) RACSubject *clickSignal;

@end
