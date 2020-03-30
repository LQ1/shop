//
//  MyBargainViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyBargainViewModel.h"

#import "MyBargainItemViewModel.h"

#import "MineService.h"
#import "MyBargainModel.h"

#import "ConfirmOrderViewModel.h"

@interface MyBargainViewModel()

@property (nonatomic,strong)MineService *service;

@end

@implementation MyBargainViewModel

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
    RACDisposable *disPos = [[self.service getMineBargainWithPage:page] subscribeNext:^(id x) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [x enumerateObjectsUsingBlock:^(MyBargainModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MyBargainItemViewModel *itemVM = [MyBargainItemViewModel new];
            itemVM.productImgUrl = obj.thumb;
            itemVM.productName = obj.goods_title;
            itemVM.productPrice = obj.bargain_before_price;
            itemVM.productSkuString = obj.attr_values;
            itemVM.quantity = @"1";
            itemVM.bargain_price = obj.bargain_price;
            itemVM.bargain_url = obj.bargain_url;
            itemVM.goods_id = obj.goods_id;
            itemVM.activity_bargain_id = obj.activity_bargain_id;
            itemVM.bargain_open_id = obj.bargain_open_id;
            itemVM.storehouse_id = [obj.storehouse_id lyStringValue];
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
    self.currentSignalType = MyBargainViewModel_Signal_Type_GotoBargainDetail;
    [self.updatedContentSignal sendNext:@[itemVM.bargain_url.length?itemVM.bargain_url:@"",inviteBlock]];
}

#pragma mark -邀请好友
- (void)inviteFriendsAtSection:(NSInteger)section
{
    @weakify(self);
    self.loading = YES;
    MyBargainItemViewModel *itemVM = [self.dataArray objectAtIndex:section];
    RACDisposable *disPos = [[self.service fetchBargainShareInfo] subscribeNext:^(NSDictionary *dict) {
        @strongify(self);
        self.loading = NO;
        // 分享
        NSString *shareTitle = [dict[@"title"] stringByReplacingOccurrencesOfString:@"{goods_title}" withString:itemVM.productName];
        [PublicEventManager shareWithAlertTitle:@"邀朋友来帮忙砍价"
                                          title:shareTitle
                                    detailTitle:dict[@"description"]
                                          image:[NSURL URLWithString:itemVM.productImgUrl]
                                     htmlString:itemVM.bargain_url];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        // 分享
        [PublicEventManager shareWithAlertTitle:@"邀朋友来帮忙砍价"
                                          title:[NSString stringWithFormat:@"%@大砍价，人多力量大！",itemVM.productName]
                                    detailTitle:@"砍价就要野蛮，动口不如动手！"
                                          image:[NSURL URLWithString:itemVM.productImgUrl]
                                     htmlString:itemVM.bargain_url];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -立即购买
- (void)immediatelyBuyAtSection:(NSInteger)section
{
    MyBargainItemViewModel *itemVM = [self.dataArray objectAtIndex:section];

    ConfirmOrderViewModel *confirmVM =
    [[ConfirmOrderViewModel alloc] initWithConfirm_order_from:ConfirmOrderFrom_GoodsDetail
                                                   goods_type:GoodsDetailType_Bargain
                                                goods_cart_id:nil
                                                     goods_id:nil
                                                 goods_sku_id:nil
                                                     quantity:@"1"
                                            activity_flash_id:nil
                                            activity_group_id:nil
                                          activity_bargain_id:itemVM.activity_bargain_id bargain_open_id:itemVM.bargain_open_id
                                                storehouse_id:itemVM.storehouse_id];
    
    self.currentSignalType = MyBargainViewModel_Signal_Type_GotoConfirmOrder;
    [self.updatedContentSignal sendNext:confirmVM];
}

@end
