//
//  LYContainChildBaseViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface LYItemUIBaseViewModel : BaseViewModel

@property (nonatomic,copy  ) NSString *UIClassName;
@property (nonatomic,copy  ) NSString *UIReuseID;
@property (nonatomic,assign) CGFloat  UIHeight;
@property (nonatomic,assign) CGFloat  UIWidth;
@property (nonatomic,strong) NSArray  *childViewModels;
@property (nonatomic,assign) int  actionType;

@end
