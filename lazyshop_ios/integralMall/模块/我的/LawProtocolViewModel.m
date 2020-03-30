//
//  LawProtocolViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LawProtocolViewModel.h"

#import "MineService.h"
#import "LawContentModel.h"

@interface LawProtocolViewModel()

@property (nonatomic, strong) MineService *service;
@property (nonatomic, copy) NSString *contentID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end

@implementation LawProtocolViewModel

- (instancetype)initWithContentID:(NSString *)contentID
{
    self = [super init];
    if (self) {
        self.service = [MineService new];
        self.contentID = contentID;
    }
    return self;
}

- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service fetchLawContentWithContent_id:self.contentID] subscribeNext:^(LawContentModel *model) {
        @strongify(self);
        self.title = model.title;
        NSRange styleRange = [model.content rangeOfString:@"<style"];
        if (styleRange.location == NSNotFound) {
            NSString *styleStr = @" <style type=\"text/css\"> img{ width: 100%; height: auto; display: block; } </style> ";
            model.content = [styleStr stringByAppendingString:model.content];
        }
        self.content = model.content;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.errorSignal sendNext:nil];
    }];
    [self addDisposeSignal:disPos];

}

@end
