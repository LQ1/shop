//
//  StoreDeailTextCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface StoreDeailTextCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy)NSString *leftTitle;
@property (nonatomic,copy)NSString *rightTitle;
@property (nonatomic,copy)NSString *rightTitleColor;

- (CGFloat)cellHeight;

@end
