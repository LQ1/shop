//
//  GoodsDetailIntroduceViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailIntroduceViewModel.h"

#import "GoodsDetailService.h"
#import "GoodsDetailIntroduceModel.h"
#import "LYHeaderSwitchItemViewModel.h"
#import "GoodsDetailIntroParmsCellViewModel.h"
#import "GoodsDetailIntroTagCellViewModel.h"

@interface GoodsDetailIntroduceViewModel()

@property (nonatomic,strong)GoodsDetailService *service;
@property (nonatomic,copy)NSString *goods_id;
@property (nonatomic,strong)GoodsDetailIntroduceModel *model;

@end

@implementation GoodsDetailIntroduceViewModel

- (instancetype)initWithGoods_id:(NSString *)goods_id
{
    self = [super init];
    if (self) {
        self.goods_id = goods_id;
        self.service = [GoodsDetailService new];
    }
    return self;
}

#pragma mark -头标题
- (NSArray *)fetchHeaderSwitchVMs
{
    LYHeaderSwitchItemViewModel *item1 = [LYHeaderSwitchItemViewModel new];
    item1.title = @"商品介绍";
    item1.itemType = 0;
    item1.selected = YES;
    
    LYHeaderSwitchItemViewModel *item2 = [LYHeaderSwitchItemViewModel new];
    item2.title = @"规格参数";
    item2.itemType = 1;
    
    LYHeaderSwitchItemViewModel *item3 = [LYHeaderSwitchItemViewModel new];
    item3.title = @"包装售后";
    item3.itemType = 2;

    return @[item1,item2,item3];
}

#pragma mark -getdata
- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service fetchGoodsIntroduceWithGoods_id:self.goods_id] subscribeNext:^(id x) {
        @strongify(self);
        self.model = x;
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.errorSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -获取网页html
- (NSString *)fetchIntroduceHtmlString
{
    return self.model.detail;
}

#pragma mark -获取参数vms
- (NSArray *)fetchParmsItemVMs
{
    NSMutableArray *resultArray = [NSMutableArray array];
    [self.model.parameter enumerateObjectsUsingBlock:^(GoodsDetailIntroParmModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GoodsDetailIntroParmsCellViewModel *itemVM = [[GoodsDetailIntroParmsCellViewModel alloc] initWithModel:obj];
        if (idx==0) {
            itemVM.showTopLine = YES;
        }
        [resultArray addObject:itemVM];
    }];
    return resultArray;
}

#pragma mark -获取包装售后vms
- (NSArray *)fetchTagVMs
{
    GoodsDetailIntroTagCellViewModel *itemVM1 = [[GoodsDetailIntroTagCellViewModel alloc] initWithTagName:@"包装清单" tagValue:self.model.packing_list];
    GoodsDetailIntroTagCellViewModel *itemVM2 = [[GoodsDetailIntroTagCellViewModel alloc] initWithTagName:@"售后服务" tagValue:self.model.after_service];
    GoodsDetailIntroTagCellViewModel *itemVM3 = [[GoodsDetailIntroTagCellViewModel alloc] initWithTagName:@"商品说明" tagValue:self.model.illustration];
    
    return @[itemVM1,itemVM2,itemVM3];
}

@end
