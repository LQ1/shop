//
//  FeedBackTypeItemCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface FeedBackTypeItemCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,assign) int itemType;

@end
