//
//  LYTextView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTextView : UITextView

- (instancetype)initWithPlaceHolder:(NSString *)placeHolder;

- (void)checkPlaceHolder;

@end
