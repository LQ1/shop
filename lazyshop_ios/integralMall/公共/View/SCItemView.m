//
//  ItemView.m
//  MobileClassPhone
//
//  Created by zln on 16/4/22.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import "SCItemView.h"

@implementation SCItemView

- (instancetype)init {
    if (self = [super init]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    UILabel *label = [UILabel new];
    label.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE - 2];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    @weakify(self);
    [label makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(15);
        make.right.equalTo(self.right).offset(-15);
    }];
    
    UIButton *btn = [UIButton new];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.isSelected = !self.isSelected;
    }];
    [self addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.left.bottom.right.equalTo(self);
    }];
    
    _siftConditionLb = label;
    _touchBtn = btn;
}

- (void)dealloc {
    CLog(@"dealloc === %@",[self class]);
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    _siftConditionLb.textColor = _isSelected ? [CommUtls colorWithHexString:APP_MainColor] : [UIColor whiteColor];
}

@end
