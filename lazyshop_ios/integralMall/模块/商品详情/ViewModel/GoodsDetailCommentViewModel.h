//
//  GoodsDetailCommentViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface GoodsDetailCommentViewModel : LYItemUIBaseViewModel

@property (nonatomic,assign)NSInteger commentCount;

- (instancetype)initWithCommentCount:(NSInteger)count
                      commentDetails:(NSArray *)commentDetails;

@end
