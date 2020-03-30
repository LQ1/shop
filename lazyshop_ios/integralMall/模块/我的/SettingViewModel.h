//
//  SettingViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

typedef NS_ENUM(NSInteger,SettingViewModel_Signal_Type)
{
    SettingViewModel_Signal_Type_GotoModifyPassword = 0,
    SettingViewModel_Signal_Type_GotoSetPassword,
    SettingViewModel_Signal_Type_GotoLaw,
    SettingViewModel_Signal_Type_GotoFeedBack,
    SettingViewModel_Signal_Type_GotoAboutUs
};

@interface SettingViewModel : BaseViewModel

@property (nonatomic,readonly)SettingViewModel_Signal_Type currentSignalType;

- (void)gotoModifyPassword;
- (void)gotoLaw;
- (void)gotoFeedBack;
- (void)gotoAboutUs;

- (void)logOut;

@end
