//
//  MyGroupBuyViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyGroupBuyViewModel.h"

#import "MyBargainItemViewModel.h"

#import "MineService.h"
#import "MyGroupBuyModel.h"

@interface MyGroupBuyViewModel()

@property (nonatomic,strong)MineService *service;

@end

@implementation MyGroupBuyViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [MineService new];
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
    RACDisposable *disPos = [[self.service getMineGroupWithPage:page] subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [x enumerateObjectsUsingBlock:^(MyGroupBuyModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MyBargainItemViewModel *itemVM = [MyBargainItemViewModel new];
            itemVM.productImgUrl = obj.thumb;
            itemVM.productName = obj.goods_title;
            itemVM.productPrice = obj.price;
            itemVM.productSkuString = obj.attr_values;
            itemVM.quantity = obj.total_quantity;
            itemVM.pay_total_price = obj.pay_total_price;
            itemVM.delivery_price = obj.delivery_price;
            itemVM.group_url = obj.group_url;
            itemVM.order_id = obj.order_id;
            [resultArray addObject:itemVM];
        }];
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
- (NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (id)itemViewModelInSection:(NSInteger)section
{
    return [self.dataArray objectAtIndex:section];
}

- (id)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.section];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self);
    MyBargainItemViewModel *itemVM = [self cellVMForRowAtIndexPath:indexPath];
    
    dispatch_block_t inviteBlock = ^{
        @strongify(self);
        [self inviteFriendsAtSection:indexPath.section];
    };
    
    self.currentSignalType = MyGroupBuyViewModel_Signal_Type_GotoGroupDetail;
    [self.updatedContentSignal sendNext:@[itemVM.group_url.length?itemVM.group_url:@"",inviteBlock]];
}

#pragma mark -邀请好友
- (void)inviteFriendsAtSection:(NSInteger)section
{
    @weakify(self);
    self.loading = YES;
    MyBargainItemViewModel *itemVM = [self.dataArray objectAtIndex:section];
    RACDisposable *disPos = [[self.service fetchGroupShareInfo] subscribeNext:^(NSDictionary *dict) {
        @strongify(self);
        self.loading = NO;
        // 分享
        NSString *shareTitle = [dict[@"title"] stringByReplacingOccurrencesOfString:@"{goods_title}" withString:itemVM.productName];
        [PublicEventManager shareWithAlertTitle:@"邀朋友来帮忙拼团"
                                          title:shareTitle
                                    detailTitle:dict[@"description"]
                                          image:[NSURL URLWithString:itemVM.productImgUrl]
                                     htmlString:itemVM.group_url];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        // 分享
        [PublicEventManager shareWithAlertTitle:@"邀朋友来帮忙拼团"
                                          title:[NSString stringWithFormat:@"快来和我拼团购买%@，你想不到的低价！",itemVM.productName]
                                    detailTitle:@"还在等什么，拼多欢乐多！"
                                          image:[NSURL URLWithString:itemVM.productImgUrl]
                                     htmlString:itemVM.group_url];
    }];
    [self addDisposeSignal:disPos];
}

@end
