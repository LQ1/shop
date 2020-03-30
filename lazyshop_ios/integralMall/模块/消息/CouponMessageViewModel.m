//
//  CouponMessageViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CouponMessageViewModel.h"

#import "MessageDateSectionViewModel.h"
#import "MessageItemTextCellViewModel.h"

#import "MessageService.h"
#import "MessageModel.h"

#import "MyCouponsViewModel.h"

@interface CouponMessageViewModel()

@property (nonatomic,strong)MessageService *service;

@end

@implementation CouponMessageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gotoCouponListSignal = [[RACSubject subject] setNameWithFormat:@"%@ gotoCouponListSignal", self.class];
        self.service = [MessageService new];
    }
    return self;
}

- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getCouponMessage] subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [x enumerateObjectsUsingBlock:^(MessageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MessageDateSectionViewModel *secVM = [MessageDateSectionViewModel new];
            secVM.dateTime = [CommUtls encodeTime:[CommUtls dencodeTime:obj.created_at] format:@"yyyy年MM月dd日 hh:mm:ss"];
            MessageItemTextCellViewModel *itemVM = [[MessageItemTextCellViewModel alloc] initWithTitle:obj.msg_title content:obj.msg_content hideRightArrow:NO];
            itemVM.app_message_record_id = obj.app_message_record_id;
            secVM.childViewModels = @[itemVM];
            [resultArray addObject:secVM];
        }];
        
        // 重新获取消息数量
        [[MessageService shareInstance] fetchUnreadMessageCount];
        
        self.dataArray = [NSArray arrayWithArray:resultArray];
        [self.fetchListSuccessSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -list
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (id)sectionVMInSection:(NSInteger)section
{
    return [self.dataArray objectAtIndex:section];
}

- (id)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *secVM = [self sectionVMInSection:indexPath.section];
    return [secVM.childViewModels objectAtIndex:indexPath.row];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCouponsViewModel *vm = [[MyCouponsViewModel alloc] initWithInValidSelected:NO];
    [self.gotoCouponListSignal sendNext:vm];
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self);
    MessageItemTextCellViewModel *itemVM = [self cellVMForRowAtIndexPath:indexPath];
    self.loading = YES;
    RACDisposable *disPos = [[self.service deleteMessageWithApp_message_record_id:itemVM.app_message_record_id] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:@"删除成功"];
        [self getData];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

@end
