//
//  HomeLinkModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

#import "HomeLinkNativeModel.h"

@interface HomeLinkModel : BaseStringProModel

@property (nonatomic,copy) NSString *mode;
@property (nonatomic,strong) HomeLinkNativeModel *options;
@property (nonatomic,copy) NSString *page;

@end
