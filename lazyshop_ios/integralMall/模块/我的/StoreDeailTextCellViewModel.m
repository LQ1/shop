//
//  StoreDeailTextCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "StoreDeailTextCellViewModel.h"

@implementation StoreDeailTextCellViewModel

- (CGFloat)cellHeight
{
    return 28.0f+[CommUtls getContentSize:self.rightTitle
                                     font:[UIFont systemFontOfSize:SMALL_FONT_SIZE] size:CGSizeMake(KScreenWidth-120-15, CGFLOAT_MAX)].height;
}

@end
