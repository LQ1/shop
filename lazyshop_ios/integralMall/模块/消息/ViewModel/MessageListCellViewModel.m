//
//  MessageListCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageListCellViewModel.h"

@implementation MessageListCellViewModel

- (instancetype)initWithImageName:(NSString *)imageName
                            title:(NSString *)title
                      detailTitle:(NSString *)detailTitle
                             time:(NSString *)time
                         msgCount:(NSString *)msgCount
                             type:(MessageType)type
{
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.title = title;
        self.detailTitle = detailTitle;
        self.time = [CommUtls shortTimeOf:time];
        self.msgCount = msgCount;
        self.type = type;
    }
    return self;
}

@end
