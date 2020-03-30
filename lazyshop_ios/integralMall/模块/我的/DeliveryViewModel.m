//
//  DeliveryViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "DeliveryViewModel.h"

#import "OrderDetailService.h"
#import "DeliveryModel.h"

#import "DeliveryHeaderCellViewModel.h"
#import "OrderDetailGapCellViewModel.h"
#import "DeliveryItemCellViewModel.h"
#import "DeliveryNoStatusCellViewModel.h"

@interface DeliveryViewModel()

@property (nonatomic, strong) OrderDetailService *service;
@property (nonatomic, copy) NSString *deliver_id;
@property (nonatomic, copy) NSString *delivery_no;

@end

@implementation DeliveryViewModel

- (instancetype)initWithDeliver_id:(NSString *)deliver_id
                       delivery_no:(NSString *)delivery_no
{
    self = [super init];
    if (self) {
        self.deliver_id = deliver_id;
        self.delivery_no = delivery_no;
        self.service = [OrderDetailService new];
    }
    return self;
}

- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getDeliverHandleWithDeliver_id:self.deliver_id
                                                              delivery_no:self.delivery_no] subscribeNext:^(DeliveryModel *model) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        // 头视图
        DeliveryHeaderCellViewModel *headerVM = [[DeliveryHeaderCellViewModel alloc] initWithDelivery_no:model.delivery_no delivery_name:model.delivery_name];
        [resultArray addObject:headerVM];
        // 分割
        OrderDetailGapCellViewModel *gapVM = [[OrderDetailGapCellViewModel alloc] init];
        [resultArray addObject:gapVM];
        if (!model.traces.count) {
            // 暂无
            DeliveryNoStatusCellViewModel *noVM = [[DeliveryNoStatusCellViewModel alloc] init];
            [resultArray addObject:noVM];
        }else{
            // 快递追踪
            [model.traces enumerateObjectsUsingBlock:^(DeliveryTrackModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DeliveryItemCellViewModel *trackVM = [[DeliveryItemCellViewModel alloc] initWithAccept_station:obj.accept_station remark:obj.remark accept_time:obj.accept_time];
                [resultArray addObject:trackVM];
            }];
        }
        
        self.dataArray = [NSArray arrayWithArray:resultArray];
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

- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

@end
