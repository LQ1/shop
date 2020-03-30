//
//  LoginBaseInputView.h
//  NetSchool
//
//  Created by LY on 2017/4/7.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LoginInputHeight 50

@interface LoginBaseInputView : UIView

@property (nonatomic, strong) UILabel     *tipLabel;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) BOOL isTrue;


/**
 *  初始化
 *
 *  @param placeHolder 输入框默认文字
 *  @param tipTitle    输入框提示文字
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithPlaceHolder:(NSString *)placeHolder
                           tipTitle:(NSString *)tipTitle;

/**
 *  添加输入框 子类必须重写
 */
- (void)initTextField;

/**
 *  设置公共属性
 */
- (void)setUpCommonView;

@end
