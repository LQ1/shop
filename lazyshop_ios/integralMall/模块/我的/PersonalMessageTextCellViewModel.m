//
//  PersonalMessageTextCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PersonalMessageTextCellViewModel.h"

#import "PersonalMessageTextCell.h"

@implementation PersonalMessageTextCellViewModel

- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                    hideArrow:(BOOL)hideArrow
{
    self = [super init];
    if (self) {
        self.title = title;
        self.detail = detail;
        self.hideArrow = hideArrow;
        
        self.UIHeight = PersonalMessageTextCellHeight;
        self.UIClassName = NSStringFromClass([PersonalMessageTextCell class]);
        self.UIReuseID = self.UIClassName;
    }
    return self;
}

@end
