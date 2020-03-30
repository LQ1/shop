//
//  PersonalMessageViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@class LYItemUIBaseViewModel;

typedef NS_ENUM(NSInteger,PersonalMessageViewModelSignalType)
{
    PersonalMessageViewModelSignalType_ClickHeader = 1,
    PersonalMessageViewModelSignalType_ClickNick,
    PersonalMessageViewModelSignalType_ClickSex,
    PersonalMessageViewModelSignalType_ClickBirthDay
};

@interface PersonalMessageViewModel : LYBaseViewModel

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (LYItemUIBaseViewModel *)cellViewModelAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)updateUserInfoField_name:(NSString *)field_name
                     field_value:(NSString *)field_value;

@end
