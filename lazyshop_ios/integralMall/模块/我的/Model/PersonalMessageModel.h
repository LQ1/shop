//
//  PersonalMessageModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface PersonalMessageModel : BaseStringProModel

@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,assign) NSInteger is_complete;

@end
