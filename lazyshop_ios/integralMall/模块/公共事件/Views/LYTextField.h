//
//  LYTextField.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LYTextFieldStyle)
{
    LYTextFieldStyle_Name = 0,
    LYTextFieldStyle_Phone
};

@interface LYTextField : UITextField

/*
 *  初始化
 */
- (instancetype)initWithStyle:(LYTextFieldStyle)style
                  placeHolder:(NSString *)placeHolder;

/*
 *  格式校验是否手机号
 */
- (BOOL)isPhoneNumberTrue;

@end
