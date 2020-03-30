//
//  SettingViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SettingViewModel.h"

#import "SetPasswordViewModel.h"
#import "LawProtocolViewModel.h"

@interface SettingViewModel()

@property (nonatomic,assign)SettingViewModel_Signal_Type currentSignalType;

@end

@implementation SettingViewModel

#pragma mark -事件
- (void)gotoModifyPassword
{
    if (SignInUser.isInitPassword) {
        self.currentSignalType = SettingViewModel_Signal_Type_GotoModifyPassword;
        [self.updatedContentSignal sendNext:nil];
    }else{
        self.currentSignalType = SettingViewModel_Signal_Type_GotoSetPassword;
        SetPasswordViewModel *setPwdVM = [[SetPasswordViewModel alloc] initWithPhoneNumber:SignInUser.mobilePhone];
        [self.updatedContentSignal sendNext:setPwdVM];
    }
}

- (void)gotoLaw
{
    LawProtocolViewModel *vm = [[LawProtocolViewModel alloc] initWithContentID:@"2"];
    self.currentSignalType = SettingViewModel_Signal_Type_GotoLaw;
    [self.updatedContentSignal sendNext:vm];
}

- (void)gotoFeedBack
{
    self.currentSignalType = SettingViewModel_Signal_Type_GotoFeedBack;
    [self.updatedContentSignal sendNext:nil];
}

- (void)gotoAboutUs
{
    self.currentSignalType = SettingViewModel_Signal_Type_GotoAboutUs;
    [self.updatedContentSignal sendNext:nil];
}

- (void)logOut
{
    LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                    message:@"确认退出当前登录账户"
                                                     titles:@[@"取消",@"确定"]
                                                      click:^(NSInteger index) {
                                                          if (index == 1) {
                                                              [[AccountService shareInstance] logOut:nil];
                                                          }
                                                      }];
    [alert show];
}

@end
