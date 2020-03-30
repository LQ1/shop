//
//  FeedBackService.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "FeedBackService.h"

#import "FeedBackClient.h"

@interface FeedBackService()

@property (nonatomic,strong)FeedBackClient *client;

@end

@implementation FeedBackService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [FeedBackClient new];
    }
    return self;
}

- (RACSignal *)submitFeedBackWithType:(NSString *)type
                              content:(NSString *)content
                               mobile:(NSString *)mobile
{
    return [[self.client submitFeedBackWithType:type
                                       content:content
                                        mobile:mobile] map:^id(id value) {
        return @(YES);
    }];
}

@end
