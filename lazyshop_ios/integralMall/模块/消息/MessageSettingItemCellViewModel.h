//
//  MessageSettingItemCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface MessageSettingItemCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) MessageType type;
@property (nonatomic,assign) BOOL isOff;
@property (nonatomic,assign) BOOL hiddenBottomLine;

@end
