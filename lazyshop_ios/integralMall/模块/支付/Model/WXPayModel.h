//
//  WXPayModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface WXPayModel : BaseStringProModel

@property (nonatomic,copy) NSString *appid;
@property (nonatomic,copy) NSString *noncestr;
@property (nonatomic,copy) NSString *package;
@property (nonatomic,copy) NSString *partnerid;
@property (nonatomic,copy) NSString *prepayid;
@property (nonatomic,copy) NSString *timestamp;
@property (nonatomic,copy) NSString *sign;

@end
