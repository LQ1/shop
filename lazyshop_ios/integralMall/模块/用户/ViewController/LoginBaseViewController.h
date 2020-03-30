//
//  LoginBaseViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "NavWhiteViewController.h"

#import "LYMainColorButton.h"
#import "LYTextColorButton.h"

@interface LoginBaseViewController : NavWhiteViewController

@property (nonatomic,strong)LYMainColorButton *loginButton;
@property (nonatomic,strong)LYTextColorButton *registerButton;

@end
