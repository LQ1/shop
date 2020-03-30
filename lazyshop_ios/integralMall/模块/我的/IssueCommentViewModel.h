//
//  IssueCommentViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface IssueCommentViewModel : BaseViewModel

@property (nonatomic,readonly)NSString *goods_title;
@property (nonatomic,readonly)NSString *goods_thumb;

/**
 *  评价内容
 */
@property (nonatomic, strong) NSString * submitContent;
/*
 *  评价图片
 */
@property (nonatomic, strong) NSArray * imgs;

/*
 *  初始化
 */
- (instancetype)initWithOrder_detail_id:(NSString *)order_detail_id
                            goods_title:(NSString *)goods_title
                            goods_thumb:(NSString *)goods_thumb;

/**
 *  提交评价
 */
- (void)submit;


@end
