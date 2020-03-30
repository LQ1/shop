//
//  CashBackViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

typedef NS_ENUM(NSInteger,CashBackViewModel_Signal_Type)
{
    CashBackViewModel_Signal_Type_GotoOrderDetail = 0,
    CashBackViewModel_Signal_Type_GotoBindShop
};

@interface CashBackViewModel : LYBaseViewModel

- (NSInteger)numberOfSections;
- (id)sectionViewModelInSection:(NSInteger)section;
- (void)clickFooterInSection:(NSInteger)section;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)gotoOrderDetailWithVM:(id)vm;
- (void)gotoBindShopWithVM:(id)vm;

@end
