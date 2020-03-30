//
//  CommentCenterListViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentCenterListViewModel.h"

#import "LYHeaderSwitchItemViewModel.h"

#import "CommentCenterService.h"

#import "CommentCenterListItemViewModel.h"

#import "CommentListViewModel.h"
#import "IssueCommentViewModel.h"

@interface CommentCenterListViewModel()

@property (nonatomic,strong) CommentCenterService *service;
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation CommentCenterListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [CommentCenterService new];
    }
    return self;
}

#pragma mark -获取头部显示
- (NSArray *)fetchHeadSwitchViewModels
{
    LYHeaderSwitchItemViewModel *item1 = [LYHeaderSwitchItemViewModel new];
    item1.title = @"待评价";
    item1.itemType = 0;
    item1.selected = YES;
    
    LYHeaderSwitchItemViewModel *item2 = [LYHeaderSwitchItemViewModel new];
    item2.title = @"已评价";
    item2.itemType = 1;
    
    NSArray *headers = @[item1,item2];
    
    return headers;
}

#pragma mark -getdata
- (void)getData:(BOOL)refresh
{
    if (refresh) {
        [self getDataWithPage:@"1"];
    }else{
        [self getDataWithPage:[PublicEventManager getPageNumberWithCount:self.dataArray.count]];
    }
}

- (void)getDataWithPage:(NSString *)page
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getCommentListWithIs_comment:self.isComment?@"1":@"0"
                                                                   page:page] subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [x enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CommentCenterListItemViewModel *itemVM = [[CommentCenterListItemViewModel alloc] initWithModel:obj isComment:self.isComment];
            [resultArray addObject:itemVM];
        }];
        if ([page integerValue]==1) {
            self.dataArray = [NSArray arrayWithArray:resultArray];
        }else{
            self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:resultArray];
        }
        self.currentSignalType = CommentCenterListViewModel_Signal_Type_FetchListSuccess;
        [self.updatedContentSignal sendNext:self.dataArray];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = CommentCenterListViewModell_Signal_Type_FetchListFailed;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -list
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *itemVM = [self.dataArray objectAtIndex:indexPath.section];
    return itemVM;
}

- (void)clickCommentForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCenterListItemViewModel *itemVM = [self cellViewModelForRowAtIndexPath:indexPath];
    if (self.isComment) {
        // 评价详情
        CommentListViewModel *vm = [[CommentListViewModel alloc] initWithCommentType:CommentType_OrderDetail
                                                                            goods_id:nil
                                                                     order_detail_id:itemVM.order_detail_id];
        self.currentSignalType = CommentCenterListViewModell_Signal_Type_GotoCommentDetail;
        [self.updatedContentSignal sendNext:vm];
    }else{
        // 发表评价
        IssueCommentViewModel *vm = [[IssueCommentViewModel alloc] initWithOrder_detail_id:itemVM.order_detail_id goods_title:itemVM.productName goods_thumb:itemVM.productImgUrl];
        self.currentSignalType = CommentCenterListViewModell_Signal_Type_GotoSendComment;
        [self.updatedContentSignal sendNext:vm];
    }
}

@end
