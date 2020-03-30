//
//  GoodsDetailIntroTagCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface GoodsDetailIntroTagCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy)NSString *tagName;
@property (nonatomic,copy)NSString *tagValue;

- (instancetype)initWithTagName:(NSString *)tagName
                       tagValue:(NSString *)tagValue;

@end
