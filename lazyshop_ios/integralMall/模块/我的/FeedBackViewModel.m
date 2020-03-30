//
//  FeedBackViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "FeedBackViewModel.h"

#import "FeedBackTypeItemCellViewModel.h"

#import "FeedBackService.h"

@interface FeedBackViewModel()

@property (nonatomic,strong)FeedBackService *service;
@property (nonatomic,strong)NSArray *feedBackTypes;

@end

@implementation FeedBackViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [FeedBackService new];
        [self initSwithViewModels];
    }
    return self;
}

#pragma mark -设置数据源
- (void)initSwithViewModels
{
    FeedBackTypeItemCellViewModel *itemVM1 = [FeedBackTypeItemCellViewModel new];
    itemVM1.selected = YES;
    itemVM1.title = @"功能异常";
    itemVM1.itemType = 0;
    
    FeedBackTypeItemCellViewModel *itemVM2 = [FeedBackTypeItemCellViewModel new];
    itemVM2.selected = NO;
    itemVM2.title = @"体验问题";
    itemVM2.itemType = 1;
    
    FeedBackTypeItemCellViewModel *itemVM3 = [FeedBackTypeItemCellViewModel new];
    itemVM3.selected = NO;
    itemVM3.title = @"功能建议";
    itemVM3.itemType = 2;
    
    FeedBackTypeItemCellViewModel *itemVM4 = [FeedBackTypeItemCellViewModel new];
    itemVM4.selected = NO;
    itemVM4.title = @"其他";
    itemVM4.itemType = 3;
    
    self.feedBackTypes = @[itemVM1,itemVM2,itemVM3,itemVM4];
}

- (NSArray *)fetchSwitchViewModels
{
    return self.feedBackTypes;
}

#pragma mark -submit
- (void)submitFeedBack
{
    @weakify(self);
    self.loading = YES;
    
    FeedBackTypeItemCellViewModel *selectedItem = [self.feedBackTypes linq_where:^BOOL(FeedBackTypeItemCellViewModel *item) {
        return item.selected == YES;
    }].linq_firstOrNil;
    
    RACDisposable *disPos = [[self.service submitFeedBackWithType:[NSString stringWithFormat:@"%ld",(long)selectedItem.itemType]
                                                          content:self.content
                                                           mobile:self.phoneNumber] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.errorSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

@end
