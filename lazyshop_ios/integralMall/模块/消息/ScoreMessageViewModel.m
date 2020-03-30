//
//  ScoreMessageViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ScoreMessageViewModel.h"

#import "ScoreMessageCellViewModel.h"

#import "MessageService.h"
#import "ScoreMessageModel.h"

@interface ScoreMessageViewModel()

@property (nonatomic,strong)MessageService *service;

@end

@implementation ScoreMessageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [MessageService new];
    }
    return self;
}

- (void)getData:(BOOL)refresh
{
    NSString *page = @"1";
    if (!refresh) {
        page = [PublicEventManager getPageNumberWithCount:self.dataArray.count];
    }

    @weakify(self);
    RACDisposable *disPos = [[self.service getScoreMessageWithPage:page] subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [x enumerateObjectsUsingBlock:^(ScoreMessageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ScoreMessageCellViewModel *itemVM = [ScoreMessageCellViewModel new];
            itemVM.changeValue = obj.change_score;
            itemVM.inCrease = [obj.change_type isEqualToString:@"+"]?YES:NO;
            itemVM.changeDate = obj.created_at;
            itemVM.title = obj.title;
            [resultArray addObject:itemVM];
        }];
        
        // 重新获取消息数量
        [[MessageService shareInstance] fetchUnreadMessageCount];
        
        if (refresh) {
            self.dataArray = [NSArray arrayWithArray:resultArray];
        }else{
            self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:resultArray];
        }
        [self.fetchListSuccessSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -list
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (id)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

@end
