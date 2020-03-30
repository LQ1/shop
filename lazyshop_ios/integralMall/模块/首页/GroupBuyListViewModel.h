//
//  GroupBuyListViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

typedef NS_ENUM(NSInteger, GroupBuyListViewModel_Signal_Type)
{
    GroupBuyListViewModel_Signal_Type_GotoGoodsDetail = 0
};

@interface GroupBuyListViewModel : LYBaseViewModel

- (void)getData:(BOOL)refresh;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
