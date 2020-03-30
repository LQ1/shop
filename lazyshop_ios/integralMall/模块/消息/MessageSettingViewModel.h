//
//  MessageSettingViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@interface MessageSettingViewModel : LYBaseViewModel


- (void)getData;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)clearAllMsg;

@end
