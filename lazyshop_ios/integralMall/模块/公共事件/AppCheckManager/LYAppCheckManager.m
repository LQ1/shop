//
//  LYAppCheckManager.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYAppCheckManager.h"

#import "LYAppCheckClient.h"

@interface LYAppCheckManager()

@property (nonatomic, assign) BOOL isAppAgree;
@property (nonatomic, strong) LYAppCheckClient *client;

@end

@implementation LYAppCheckManager

#pragma mark -单例
+ (instancetype)shareInstance
{
    static LYAppCheckManager *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [super allocWithZone:NULL];
        shareInstance.client = [LYAppCheckClient new];
    });
    return shareInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [LYAppCheckManager shareInstance];
}

+ (id)copy
{
    return [LYAppCheckManager shareInstance];
}

#pragma mark -获取是否通过审核
- (RACSignal *)checkIsAppAgree
{
    if ([self hasReleased]) {
        self.isAppAgree = YES;
        return [RACSignal return:@(YES)];
    }
    // 请求接口
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    @weakify(self);
    return [[self.client getAppCheckWithVersion:version] doNext:^(NSDictionary *dict) {
        @strongify(self);
        self.isAppAgree = ![dict[@"data"][@"is_check"] boolValue];
        [self configAppState:[[NSNumber numberWithBool:self.isAppAgree] stringValue]];
    }];
}
// 是否本地已记录通过审核
- (BOOL)hasReleased
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *judge = [defaults objectForKey:@"app_release"];
    if (!judge || judge.length == 0) {
        return NO;
    } else {
        if ([judge hasPrefix:[CommUtls getSoftShowVersion]]) {
            BOOL isReleased = [[judge componentsSeparatedByString:@"/"].lastObject boolValue];
            return isReleased;
        } else {
            return NO;
        }
    }
}
// 记录审核状态
- (void)configAppState:(NSString *)state
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [defaults setObject:[NSString stringWithFormat:@"%@/%@", version, state] forKey:@"app_release"];
}

@end
