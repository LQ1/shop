//
//  ShoppingCartProductAdderView.m
//  NetSchool
//
//  Created by LY on 2017/4/28.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "LYQuantityAdderView.h"

@interface LYQuantityAdderView()<UITextFieldDelegate>

@property (nonatomic,assign)NSInteger adderQuantity;
@property (nonatomic,copy)addRequestBlock addBlock;
@property (nonatomic,copy)NSString *oldText;

@end

@implementation LYQuantityAdderView

- (instancetype)init
{
    if (self = [super init]) {
        self.adderQuantity = 1;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 数量
    UITextField *productCountFiled              = [UITextField new];
    productCountFiled.font                      = [UIFont systemFontOfSize:MIN_FONT_SIZE];
    productCountFiled.textAlignment             = NSTextAlignmentCenter;
    productCountFiled.textColor                 = [CommUtls colorWithHexString:@"#333333"];
    productCountFiled.adjustsFontSizeToFitWidth = YES;
    productCountFiled.delegate                  = self;
    productCountFiled.keyboardType              = UIKeyboardTypeNumberPad;
    [self addSubview:productCountFiled];
    @weakify(self);
    [productCountFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.mas_equalTo(LYQuantityAdderViewTextWidth);
        make.top.bottom.centerX.mas_equalTo(self);
    }];
    
    RAC(productCountFiled,text) = [RACObserve(self, adderQuantity) map:^id(id value) {
        return [value stringValue];
    }];
    
    // 分割线
    UIColor *lineColor = [CommUtls colorWithHexString:@"#aaaaaa"];
    CGFloat lineWidth = 1.0;
    self.layer.borderColor = lineColor.CGColor;
    self.layer.borderWidth = lineWidth;
    
    UIView *leftMidLine = [UIView new];
    leftMidLine.backgroundColor = lineColor;
    [self addSubview:leftMidLine];
    [leftMidLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(productCountFiled);
        make.width.mas_equalTo(lineWidth);
        make.right.mas_equalTo(productCountFiled.left);
    }];
    
    UIView *rightMidLine = [UIView new];
    rightMidLine.backgroundColor = lineColor;
    [self addSubview:rightMidLine];
    [rightMidLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(productCountFiled);
        make.width.mas_equalTo(lineWidth);
        make.left.mas_equalTo(productCountFiled.right);
    }];
    
    // +
    UIButton *addCountBtn = [UIButton new];
    [addCountBtn setTitle:@"+" forState:UIControlStateNormal];
    [addCountBtn setTitleColor:[CommUtls colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    addCountBtn.titleLabel.font = [UIFont systemFontOfSize:LARGE_FONT_SIZE];
    [self addSubview:addCountBtn];
    [addCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(rightMidLine.right);
    }];
    addCountBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [productCountFiled resignFirstResponder];
        if (self.addBlock) {
            self.addBlock(self.adderQuantity+1,^{
                @strongify(self);
                self.adderQuantity++;
            });
        }else{
            self.adderQuantity++;
        }
        return [RACSignal empty];
    }];
    
    // -
    UIButton *minusCountBtn = [UIButton new];
    [minusCountBtn setTitle:@"-" forState:UIControlStateNormal];
    [minusCountBtn setTitleColor:[CommUtls colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    minusCountBtn.titleLabel.font = [UIFont systemFontOfSize:LARGE_FONT_SIZE];
    [self addSubview:minusCountBtn];
    [minusCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(productCountFiled.left);
    }];
    minusCountBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [productCountFiled resignFirstResponder];
        if (self.adderQuantity>1) {
            if (self.addBlock) {
                self.addBlock(self.adderQuantity-1,^{
                    @strongify(self);
                    self.adderQuantity--;
                });
            }else{
                self.adderQuantity--;
            }
        }
        return [RACSignal empty];
    }];
}

#pragma mark -设置数量
- (void)setQuantityNumber:(NSInteger)quantity
{
    self.adderQuantity = quantity;
}

#pragma mark -输入框代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.oldText = textField.text;
    
    if (self.addRequestBlockEffectShouldEditting) {
        __block BOOL isShould = NO;
        NSInteger quantity = [textField.text integerValue];
        if (self.addBlock) {
            self.addBlock(quantity,^{
                isShould = YES;
            });
        }
        return isShould;
    }else{
        return YES;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    @weakify(self);
    __block BOOL isShould = NO;
    NSInteger quantity = [textField.text integerValue];
    if (quantity == 0) {
        quantity = 1;
    }
    if (self.addBlock) {
        self.addBlock(quantity,^{
            @strongify(self);
            self.adderQuantity = quantity;
            isShould = YES;
        });
    }else{
        self.adderQuantity = quantity;
        isShould = YES;
    }
    if (!isShould) {
        textField.text = self.oldText;
    }
    return YES;
}

#pragma mark -设置加入到购物车请求的回调
- (void)setAddRequestBlock:(addRequestBlock)block
{
    self.addBlock = block;
}

- (void)dealloc
{
    CLog(@"dealloc----%@",self.class);
}

@end
