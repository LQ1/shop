//
//  MessageListCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface MessageListCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *detailTitle;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *msgCount;
@property (nonatomic,assign) MessageType type;

- (instancetype)initWithImageName:(NSString *)imageName
                            title:(NSString *)title
                      detailTitle:(NSString *)detailTitle
                             time:(NSString *)time
                         msgCount:(NSString *)msgCount
                             type:(MessageType)type;

@end
