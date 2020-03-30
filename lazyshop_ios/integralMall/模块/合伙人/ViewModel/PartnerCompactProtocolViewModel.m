//
//  PartnerCompactProtocolViewModel.m
//  integralMall
//
//  Created by lc on 2019/10/26.
//  Copyright © 2019 Eggache_Yang. All rights reserved.
//

#import "PartnerCompactProtocolViewModel.h"
#import "DataViewModel.h"

@implementation PartnerCompactProtocolViewModel

- (void)getData {
    NSString *szPayStr = [[DataViewModel getInstance] getParterCompactProtocol];
    
    
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
