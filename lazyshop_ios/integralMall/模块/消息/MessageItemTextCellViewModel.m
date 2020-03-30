//
//  MessageItemTextCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageItemTextCellViewModel.h"

#import "MessageItemTextCell.h"

@implementation MessageItemTextCellViewModel

- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content
               hideRightArrow:(BOOL)hideRightArrow
{
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
        self.hideRightArrow = hideRightArrow;
        self.UIHeight = MessageItemBaseCellHeight + [CommUtls getContentSize:content
                                                                        font:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                                                        size:CGSizeMake(KScreenWidth-38.5-15, CGFLOAT_MAX)].height;
    }
    return self;
}

@end
