//
//  IssueCommentViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "IssueCommentViewModel.h"

#import "CommentCenterService.h"

@interface IssueCommentViewModel()

@property (nonatomic,copy)NSString *order_detail_id;
@property (nonatomic,copy)NSString *goods_title;
@property (nonatomic,copy)NSString *goods_thumb;
@property (nonatomic,strong)CommentCenterService *service;

@end

@implementation IssueCommentViewModel

#pragma mark -init
- (instancetype)initWithOrder_detail_id:(NSString *)order_detail_id
                            goods_title:(NSString *)goods_title
                            goods_thumb:(NSString *)goods_thumb
{
    self = [super init];
    if (self) {
        self.service = [CommentCenterService new];
        self.order_detail_id = order_detail_id;
        self.goods_title = goods_title;
        self.goods_thumb = goods_thumb;
    }
    return self;
}

#pragma mark -submit
- (void)submit
{
    @weakify(self);
    [DLLoading DLLoadingInWindow:@"提交评价中,请稍候..."
                           close:^{
                               @strongify(self);
                               [self dispose];
                           }];
    if (self.imgs.count) {
        // 先上传图片
        [[PublicEventManager shareInstance] uploadImages:self.imgs
                                                complete:^(NSArray *imgUrls) {
                                                    @strongify(self);
                                                    [self addCommentWithImgUrls:imgUrls];
                                                } fail:^(NSString *msg) {
                                                    [DLLoading DLToolTipInWindow:msg];
                                                }];
    }else{
        // 添加评价
        [self addCommentWithImgUrls:nil];
    }
}
// 添加评价
- (void)addCommentWithImgUrls:(NSArray *)imgUrls
{
    @weakify(self);
    RACDisposable *disPos = [[self.service addCommentWithOrder_detail_id:self.order_detail_id
                                                                 content:self.submitContent
                                                                   image:[imgUrls JSONString]] subscribeNext:^(id x) {
        @strongify(self);
        [self.updatedContentSignal sendNext:nil];
    } error:^(NSError *error) {
        [DLLoading DLToolTipInWindow:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}

@end
