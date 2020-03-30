//
//  MyScoreDetailSegementView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyScoreDetailSegementView.h"

@interface MyScoreDetailSegementView ()

@property (nonatomic, strong) UIButton *allRecordButton;
@property (nonatomic, strong) UIButton *inComeButton;
@property (nonatomic, strong) UIButton *outComeButton;
@property (nonatomic, copy )  MyScoreDetailSegementClickBlock clickBlock;

@end

@implementation MyScoreDetailSegementView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
        [self bindCommand];
    }
    return self;
}

- (void)addViews
{
    CGFloat lineWidth = 1.0f;
    CGFloat btnWidth = (MyScoreDetailSegementViewWidth-lineWidth*2)/3.;
    // 全部记录
    self.allRecordButton = [self fetchButtonWithTitle:@"全部记录"];
    [self addSubview:self.allRecordButton];
    [self.allRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(btnWidth);
    }];
    // line1
    UIView *line1 = [UIView new];
    line1.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.allRecordButton.right);
        make.width.mas_equalTo(lineWidth);
    }];
    // 收入记录
    self.inComeButton = [self fetchButtonWithTitle:@"收入记录"];
    [self addSubview:self.inComeButton];
    [self.inComeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(btnWidth);
        make.left.mas_equalTo(line1.right);
    }];
    // line2
    UIView *line2 = [UIView new];
    line2.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.inComeButton.right);
        make.width.mas_equalTo(lineWidth);
    }];
    // 支出记录
    self.outComeButton = [self fetchButtonWithTitle:@"支出记录"];
    [self addSubview:self.outComeButton];
    [self.outComeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(btnWidth);
        make.left.mas_equalTo(line2.right);
    }];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [CommUtls colorWithHexString:APP_MainColor].CGColor;
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    
    [self changeToClickType:MyScoreDetailSegementViewClickType_All];
}

- (UIButton *)fetchButtonWithTitle:(NSString *)title
{
    UIButton *btn = [UIButton new];
    btn.titleLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    return btn;
}

- (void)bindCommand
{
    @weakify(self);
    // 点击事件
    self.allRecordButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self changeToClickType:MyScoreDetailSegementViewClickType_All];
        return [RACSignal empty];
    }];
    self.inComeButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self changeToClickType:MyScoreDetailSegementViewClickType_Income];
        return [RACSignal empty];
    }];
    self.outComeButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self changeToClickType:MyScoreDetailSegementViewClickType_Outcome];
        return [RACSignal empty];
    }];
}
// 使切换
- (void)changeToClickType:(MyScoreDetailSegementViewClickType)cellType
{
    switch (cellType) {
        case MyScoreDetailSegementViewClickType_All:
        {
            if (!self.allRecordButton.selected) {
                // 全部记录
                [self changeUIToClickType:MyScoreDetailSegementViewClickType_All];
                if (self.clickBlock) {
                    self.clickBlock(MyScoreDetailSegementViewClickType_All);
                }
            }
        }
            break;
        case MyScoreDetailSegementViewClickType_Income:
        {
            if (!self.inComeButton.selected) {
                // 收入记录
                [self changeUIToClickType:MyScoreDetailSegementViewClickType_Income];
                if (self.clickBlock) {
                    self.clickBlock(MyScoreDetailSegementViewClickType_Income);
                }
            }
        }
            break;
        case MyScoreDetailSegementViewClickType_Outcome:
        {
            if (!self.outComeButton.selected) {
                // 支出记录
                [self changeUIToClickType:MyScoreDetailSegementViewClickType_Outcome];
                if (self.clickBlock) {
                    self.clickBlock(MyScoreDetailSegementViewClickType_Outcome);
                }
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -设置类型切换的回调
- (void)setChangeClickBlock:(MyScoreDetailSegementClickBlock)block
{
    self.clickBlock = block;
}

#pragma mark -设置UI显示
- (void)changeUIToClickType:(MyScoreDetailSegementViewClickType)cellType
{
    switch (cellType) {
        case MyScoreDetailSegementViewClickType_All:
        {
            if (!self.allRecordButton.selected) {
                // 全部记录
                self.allRecordButton.selected = YES;
                self.inComeButton.selected = NO;
                self.outComeButton.selected = NO;
                self.allRecordButton.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
                self.inComeButton.backgroundColor = [UIColor whiteColor];
                self.outComeButton.backgroundColor = [UIColor whiteColor];
            }
        }
            break;
        case MyScoreDetailSegementViewClickType_Income:
        {
            if (!self.inComeButton.selected) {
                // 收入记录
                self.allRecordButton.selected = NO;
                self.inComeButton.selected = YES;
                self.outComeButton.selected = NO;
                self.allRecordButton.backgroundColor = [UIColor whiteColor];
                self.inComeButton.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
                self.outComeButton.backgroundColor = [UIColor whiteColor];
            }
        }
            break;
        case MyScoreDetailSegementViewClickType_Outcome:
        {
            if (!self.outComeButton.selected) {
                // 支出记录
                self.allRecordButton.selected = NO;
                self.inComeButton.selected = NO;
                self.outComeButton.selected = YES;
                self.allRecordButton.backgroundColor = [UIColor whiteColor];
                self.inComeButton.backgroundColor = [UIColor whiteColor];
                self.outComeButton.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
