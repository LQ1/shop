//
//  BargainListViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@interface BargainListViewModel : LYBaseViewModel

typedef NS_ENUM(NSInteger, BargainListViewModel_Signal_Type)
{
    BargainListViewModel_Signal_Type_GotoGoodsDetail = 0
};

- (void)getData:(BOOL)refresh;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
