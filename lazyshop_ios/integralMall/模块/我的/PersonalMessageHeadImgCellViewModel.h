//
//  PersonalMessageHeadImgCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface PersonalMessageHeadImgCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *imgUrl;

- (instancetype)initWithTitle:(NSString *)title
                       imgUrl:(NSString *)imgUrl;

@end
