//
//  ScoreMessageModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface ScoreMessageModel : BaseStringProModel

@property (nonatomic,copy) NSString *change_type;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *change_score;
@property (nonatomic,copy) NSString *created_at;

@end
