//
//  MessageModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

@interface MessageModel : BaseStringProModel

@property (nonatomic,copy) NSString *msg_title;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *msg_content;
@property (nonatomic,copy) NSString *app_message_id;
@property (nonatomic,copy) NSString *msg_type;
@property (nonatomic,copy) NSString *app_message_record_id;

@property (nonatomic,copy) NSString *link_url;

@property (nonatomic,copy) NSString *order_id;

@end
