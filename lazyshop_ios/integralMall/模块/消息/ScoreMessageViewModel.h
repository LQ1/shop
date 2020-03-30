//
//  ScoreMessageViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@interface ScoreMessageViewModel : LYBaseViewModel

- (void)getData:(BOOL)refresh;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
