//
//  HomeAllActivityCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseCell.h"

@interface HomeAllActivityCell : LYItemUIBaseCell

@property (nonatomic, readonly) RACSubject *reloadHomeListSignal;
@property (nonatomic, readonly) RACSubject *gotoMoreListSignal;

+ (CGFloat)fetchCellHeight;

@end
