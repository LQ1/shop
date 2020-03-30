//
//  ScoreMessageCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface ScoreMessageCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *changeValue;
@property (nonatomic,assign) BOOL inCrease;
@property (nonatomic,copy) NSString *changeDate;

@end
