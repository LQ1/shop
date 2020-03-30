//
//  BasePartnerViewController.h
//  integralMall
//
//  Created by liu on 2018/12/30.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYNavigationBarViewController.h"
#import "CreateCustomView.h"
#import "Include.h"


NS_ASSUME_NONNULL_BEGIN



@interface BasePartnerViewController : LYNavigationBarViewController

//创建客服头像
- (void)createCustom;

- (void)setBtnDisable:(UIButton*)btn;
- (void)setBtnEnable:(UIButton*)btn;

@end

NS_ASSUME_NONNULL_END
