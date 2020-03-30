//
//  MyGroupBuyViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

typedef NS_ENUM(NSInteger,MyGroupBuyViewModel_Signal_Type)
{
    MyGroupBuyViewModel_Signal_Type_GotoGroupDetail = 0
};

@interface MyGroupBuyViewModel : LYBaseViewModel

- (void)getData:(BOOL)refresh;

- (NSInteger)numberOfSections;
- (id)itemViewModelInSection:(NSInteger)section;
- (id)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)inviteFriendsAtSection:(NSInteger)section;

@end
