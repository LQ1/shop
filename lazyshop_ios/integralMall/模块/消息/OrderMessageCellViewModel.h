//
//  OrderMessageCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageItemBaseViewModel.h"

@interface OrderMessageCellViewModel : MessageItemBaseViewModel

@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *thumb;
@property (nonatomic,copy) NSString *app_message_record_id;

@end
