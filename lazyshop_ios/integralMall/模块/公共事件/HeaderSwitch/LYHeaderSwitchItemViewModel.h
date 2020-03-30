//
//  LYHeaderSwitchItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface LYHeaderSwitchItemViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy  ) NSString *title;
@property (nonatomic,assign) int itemType;
@property (nonatomic,assign) BOOL selected;

@end
