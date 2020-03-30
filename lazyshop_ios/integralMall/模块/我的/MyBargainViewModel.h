//
//  MyBargainViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

typedef NS_ENUM(NSInteger,MyBargainViewModel_Signal_Type)
{
    MyBargainViewModel_Signal_Type_GotoBargainDetail = 0,
    MyBargainViewModel_Signal_Type_GotoConfirmOrder
};


@interface MyBargainViewModel : LYBaseViewModel

- (void)getData:(BOOL)refresh;

- (NSInteger)numberOfSections;
- (id)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)inviteFriendsAtSection:(NSInteger)section;
- (id)itemViewModelInSection:(NSInteger)section;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)immediatelyBuyAtSection:(NSInteger)section;

@end
