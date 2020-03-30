//
//  ChoiceWareHouseViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/31.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

typedef NS_ENUM(NSInteger, ChoiceWareHouseViewModel_Signal_Type)
{
    ChoiceWareHouseViewModel_Signal_Type_ReloadData,
    ChoiceWareHouseViewModel_Signal_Type_SelectHouseSuccess
};

@interface ChoiceWareHouseViewModel : LYBaseViewModel

- (instancetype)initWithWareHouseID:(NSString *)wareHouseID;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)itemViewModelAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
