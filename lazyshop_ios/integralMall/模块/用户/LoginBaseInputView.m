//
//  LoginBaseInputView.m
//  NetSchool
//
//  Created by LY on 2017/4/7.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "LoginBaseInputView.h"


#import "UIView+Separator.h"

@interface LoginBaseInputView ()

@property (nonatomic,copy   ) NSString *placeHolder;
@property (nonatomic,copy   ) NSString *tipTitle;
@property (nonatomic, strong) UIView   *bottomLineView;
@property (nonatomic, strong) UIColor  *defaultLineColor;

@end

@implementation LoginBaseInputView

#pragma mark -初始化
- (instancetype)initWithPlaceHolder:(NSString *)placeHolder
                           tipTitle:(NSString *)tipTitle
{
    if (self = [super init]) {
        self.placeHolder = placeHolder;
        self.tipTitle = tipTitle;
        [self initTextField];
        [self setUpCommonView];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initTextField];
        [self setUpCommonView];
    }
    return self;
}

#pragma mark -添加文本框
- (void)initTextField
{
    
}

#pragma mark -设置公有属性
- (void)setUpCommonView
{
    // 提示语
    self.tipLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                     textAlignment:0
                                         textColor:@"#000000"
                                      adjustsWidth:NO
                                      cornerRadius:0
                                              text:self.tipTitle];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(70);
    }];
    // textField公有属性
    if (self.placeHolder.length) {
        _textField.placeholder = self.placeHolder;
    }
    _textField.clearButtonMode          = UITextFieldViewModeWhileEditing;
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.font                     = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    [self addSubview:_textField];
    
    @weakify(self);
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.tipLabel.right);
        make.right.mas_equalTo(0);
    }];
    
    // 底部线
    self.bottomLineView                 = [self addBottomLine];
    self.bottomLineView.backgroundColor = [CommUtls colorWithHexString:@"#cccccc"];
    self.defaultLineColor               = self.bottomLineView.backgroundColor;
    
    RACSignal *isEditingSignal                = [RACSignal merge:@[
                                                                   [[self.textField rac_signalForControlEvents:UIControlEventEditingDidBegin] mapReplace:@YES],
                                                                   [[self.textField rac_signalForControlEvents:UIControlEventEditingDidEnd] mapReplace:@NO]
                                                                   ]];
    RAC(self.bottomLineView, backgroundColor) = [isEditingSignal map:^id (id isEditing) {
        @strongify(self);
        return [isEditing boolValue] ? [CommUtls colorWithHexString:APP_MainColor] : self.defaultLineColor;
    }];
}

- (void)dealloc
{
    CLog(@"dealloc----%@",self.class);
}

@end
