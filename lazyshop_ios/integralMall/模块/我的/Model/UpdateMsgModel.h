//
//  UpdateMsgModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface UpdateMsgModel : BaseStringProModel

@property (nonatomic,copy) NSString *version;
@property (nonatomic,copy) NSString *update_description;
@property (nonatomic,copy) NSString *is_must_update;
@property (nonatomic,copy) NSString *app_store_id;
@property (nonatomic,copy) NSString *update_at;

@end
