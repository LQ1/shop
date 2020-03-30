//
//  ScoreSignInDateService.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ScoreSignInDateService.h"

#import "ScoreSignInDateClient.h"
#import "ScoreSignInDateModel.h"
#import "ScoreSingInDateItemModel.h"

@interface ScoreSignInDateService ()

@property (nonatomic, strong) ScoreSignInDateClient *client;

@end

@implementation ScoreSignInDateService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [ScoreSignInDateClient new];
    }
    return self;
}

/*
 *  签到
 */
- (RACSignal *)signIn
{
    return [[self.client signIn] map:^id(id value) {
        return @(YES);
    }];
}

/*
 *  获取签到列表
 */
- (RACSignal *)fetchSignInList
{
    return [[self.client fetchSignInList] tryMap:^id(NSDictionary *oldDict, NSError *__autoreleasing *errorPtr) {
        ScoreSignInDateModel *signInDateModel = [ScoreSignInDateModel modelFromJSONDictionary:oldDict[@"data"]];
        signInDateModel.signinlist = [ScoreSingInDateItemModel modelsFromJSONArray:signInDateModel.signinlist];
        for (ScoreSingInDateItemModel *dateModel in signInDateModel.signinlist) {
            dateModel.sign_in_time = [NSString stringWithFormat:@"%ld-%02ld-%02ld",dateModel.year,dateModel.month,dateModel.day];
        }
        return signInDateModel;
    }];
}

@end
