//
//  LYImageCheckBox.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/29.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYImageCheckBox.h"

@interface LYImageCheckBox()

@property (nonatomic, copy) NSString *checkedImageName;
@property (nonatomic, copy) NSString *unCheckedImageName;
@property (nonatomic, strong) UIImageView *tickImageView;

@end

@implementation LYImageCheckBox

- (instancetype)initWithCheckedImageName:(NSString *)checkedImageName
                      unCheckedImageName:(NSString *)unCheckedImageName
                               bordColor:(UIColor *)bordColor
                               bordWidth:(CGFloat)bordWidth
{
    self = [super init];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        if (bordColor && bordWidth>0) {
            self.layer.borderColor = bordColor.CGColor;
            self.layer.borderWidth = bordWidth;
        }
        self.checkedImageName = checkedImageName;
        self.unCheckedImageName = unCheckedImageName;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 对勾
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.unCheckedImageName]];
    self.tickImageView = imgView;
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    // 点击事件
    UIButton *clickBtn = [UIButton new];
    [self addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:nil];
        return [RACSignal empty];
    }];
}

#pragma mark -设置选中
- (void)setChecked:(BOOL)checked
{
    _checked = checked;
    if (checked) {
        self.tickImageView.image = [UIImage imageNamed:self.checkedImageName];
    }else{
        self.tickImageView.image = [UIImage imageNamed:self.unCheckedImageName];
    }
}

@end
