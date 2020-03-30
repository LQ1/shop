//
//  MessageItemTextCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageItemBaseViewModel.h"

@interface MessageItemTextCellViewModel : MessageItemBaseViewModel

@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) BOOL hideRightArrow;

@property (nonatomic,copy) NSString *linkUrl;
@property (nonatomic,copy) NSString *order_id;
@property (nonatomic,copy) NSString *app_message_record_id;

- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content
               hideRightArrow:(BOOL)hideRightArrow;

@end
