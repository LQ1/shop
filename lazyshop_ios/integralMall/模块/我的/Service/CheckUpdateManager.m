//
//  CheckUpdateManager.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CheckUpdateManager.h"

#import <DLUtls/CommUtls+OpenSystem.h>
#import "EDSemver.h"

#import "MineService.h"
#import "UpdateMsgModel.h"

@interface CheckUpdateManager()

@property (nonatomic, strong) MineService *service;
@property (nonatomic, copy) dispatch_block_t noUpdateBlock;

@end

@implementation CheckUpdateManager

#pragma mark -单例
+ (instancetype)shareInstance
{
    static CheckUpdateManager *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [super allocWithZone:NULL];
        shareInstance.service = [MineService new];
    });
    return shareInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [CheckUpdateManager shareInstance];
}

+ (id)copy
{
    return [CheckUpdateManager shareInstance];
}

#pragma mark -检查更新
- (void)checkAppUpdateWithNoUpdate:(dispatch_block_t)noUpdateBlock
                           loading:(BOOL)loading
{
    if (![LYAppCheckManager shareInstance].isAppAgree) {
        return;
    }
    self.noUpdateBlock = noUpdateBlock;
    // 检查更新
    @weakify(self);
    if (loading) {
        [DLLoading DLLoadingInWindow:@"检查版本更新中,请稍候" close:nil];
    }
    [[[self.service fetchAppVersion] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(UpdateMsgModel *model) {
        @strongify(self);
        if (loading) {
            [DLLoading DLHideInWindow];
        }
        [self checkAppVersionWithNowVersion:model
                                    loading:loading];
    } error:^(NSError *error) {
        if (loading) {
            [DLLoading DLToolTipInWindow:AppErrorParsing(error)];
        }
    }];
}
// 校验是否最新版本
- (void)checkAppVersionWithNowVersion:(UpdateMsgModel *)model
                              loading:(BOOL)loading
{
    NSString *serverVersion = model.version;
    NSString *localVersion = [CommUtls getSoftShowVersion];
    EDSemver *sv = [[EDSemver alloc] initWithString:serverVersion];
    EDSemver *lv = [[EDSemver alloc] initWithString:localVersion];
    if ([sv isGreaterThan:lv]) {
        NSString *tip = [NSString stringWithFormat:@"检测到新版本V%@",serverVersion];
        if ([model.is_must_update integerValue] == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:tip
                                                            message:model.update_description
                                                           delegate:nil
                                                  cancelButtonTitle:@"升级"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert.rac_buttonClickedSignal subscribeNext:^(id x) {
                // 打开
                [CommUtls goToAppStoreHomePage:[model.app_store_id integerValue]];
            }];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:tip
                                                            message:model.update_description
                                                           delegate:nil
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"升级", nil];
            [alert show];
            [alert.rac_buttonClickedSignal subscribeNext:^(id x) {
                if ([x integerValue] == 1) {
                    // 打开
                    [CommUtls goToAppStoreHomePage:[model.app_store_id integerValue]];
                }
            }];
        }
    }
    else
    {
        //当前是最新版本
        if (loading) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"当前是最新版本"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        if (self.noUpdateBlock) {
            self.noUpdateBlock();
        }
    }
}

@end
