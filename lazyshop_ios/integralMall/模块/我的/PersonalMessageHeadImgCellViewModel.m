//
//  PersonalMessageHeadImgCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PersonalMessageHeadImgCellViewModel.h"

#import "PersonalMessageHeadImgCell.h"

@implementation PersonalMessageHeadImgCellViewModel

- (instancetype)initWithTitle:(NSString *)title
                       imgUrl:(NSString *)imgUrl
{
    if (self = [super init]) {
        self.title = title;
        self.imgUrl = imgUrl;
        
        self.UIHeight = PersonalMessageHeadImgCellHeight;
        self.UIClassName = NSStringFromClass([PersonalMessageHeadImgCell class]);
        self.UIReuseID = self.UIClassName;
    }
    return self;
}

@end
