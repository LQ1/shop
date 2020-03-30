//
//  SystemMessageViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@interface SystemMessageViewModel : LYBaseViewModel

- (NSInteger)numberOfSections;
- (id)sectionVMInSection:(NSInteger)section;
- (id)cellVMForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath;

@end
