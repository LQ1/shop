//
//  RelateStoreViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

typedef NS_ENUM(NSInteger,RelateStoreViewModel_Signal_Type)
{
    RelateStoreViewModel_Signal_Type_GotoStoreDetail = 0,
    RelateStoreViewModel_Signal_Type_GotoScan
};

@interface RelateStoreViewModel : LYBaseViewModel

@property (nonatomic,readonly)RACSubject *showToScanSignal;

- (NSInteger)numberOfSections;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
