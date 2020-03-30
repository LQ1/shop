//
//  CommentListViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentListViewModel.h"

#import "CommentService.h"
#import "CommentRowItemViewModel.h"
#import "GoodsCommentModel.h"

@interface CommentListViewModel()

@property (nonatomic,assign)CommentType commentType;
@property (nonatomic,copy)NSString *order_detail_id;
@property (nonatomic,copy)NSString *goods_id;
@property (nonatomic,strong)CommentService *service;
@property (nonatomic,strong)NSArray *dataArray;

@end

@implementation CommentListViewModel

- (instancetype)initWithCommentType:(CommentType)commentType
                           goods_id:(NSString *)goods_id
                    order_detail_id:(NSString *)order_detail_id
{
    self = [super init];
    if (self) {
        self.service = [CommentService new];
        self.commentType = commentType;
        self.goods_id = goods_id;
        self.order_detail_id = order_detail_id;
    }
    return self;
}

- (void)getData
{
    RACSignal *signal = nil;
    switch (self.commentType) {
        case CommentType_GoodsDetail:
        {
            signal = [self.service getGoodsCommentWithGoods_id:self.goods_id];
        }
            break;
        case CommentType_OrderDetail:
        {
            signal = [self.service getOrderCommentWithOrder_detail_id:self.order_detail_id];
        }
            break;
            
        default:
            break;
    }
    @weakify(self);
    RACDisposable *disPos = [signal subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *resultArray = [NSMutableArray array];
        [x enumerateObjectsUsingBlock:^(GoodsCommentModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            CommentRowItemViewModel *itemVM = [[CommentRowItemViewModel alloc] initWithHeaderImgUrl:model.avatar userName:model.nickname commentDetail:model.content commentImageUrls:model.image created_at:model.created_at];
            [resultArray addObject:itemVM];
        }];
        self.dataArray = [NSArray arrayWithArray:resultArray];
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.errorSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -list
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CommentRowItemViewModel *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

@end
