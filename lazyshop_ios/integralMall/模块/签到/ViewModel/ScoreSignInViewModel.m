//
//  ScoreSignInViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ScoreSignInViewModel.h"

#import "ScoreSignInDateService.h"
#import "ScoreSignInDateModel.h"
#import "ScoreSingInDateItemModel.h"


@interface ScoreSignInViewModel ()

@property (nonatomic, strong) ScoreSignInDateService *service;

@end

@implementation ScoreSignInViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [ScoreSignInDateService new];
        self.signInCalendarViewModel = [ScoreSignInCalendarViewModel new];
    }
    return self;
}

- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service fetchSignInList] subscribeNext:^(ScoreSignInDateModel *model) {
        @strongify(self);
        // 基本信息
        self.continueSignDays = model.continuous;
        self.wholeSignDays = model.totaldate;
        SignInUser.integralTotalNumber = model.userscore;
        // 日历签到信息
        [self.signInCalendarViewModel reloadSignedMsgWithModels:model.signinlist];
        self.todaySigned = self.signInCalendarViewModel.todaySigned;
        [self.fetchListSuccessSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
        [self.fetchListSuccessSignal sendNext:nil];
    }];
    [self addDisposeSignal:disPos];

}

- (void)signIn
{
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service signIn] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:@"签到成功"];
        [self getData];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

@end
