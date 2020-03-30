//
//  PersonalMessageTextCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface PersonalMessageTextCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *detail;
@property (nonatomic,assign) BOOL hideArrow;

- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                    hideArrow:(BOOL)hideArrow;

@end
