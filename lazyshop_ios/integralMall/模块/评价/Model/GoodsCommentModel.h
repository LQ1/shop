//
//  GoodsCommentModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface GoodsCommentModel : BaseStringProModel

@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,strong) NSArray *image;
@property (nonatomic,copy) NSString *avatar;

@end
