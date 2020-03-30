//
//  ModifiMessageViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "NavigationBarController.h"

typedef void (^saveClickBlock)(NSString *text);

@interface ModifiMessageViewController : NavigationBarController

- (instancetype)initWithNavTitle:(NSString *)navTitle
                         oldText:(NSString *)oldText
                        inputTip:(NSString *)inputTip
                  saveClickBlock:(saveClickBlock)block;

@end
