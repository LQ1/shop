//
//  CashBackFooterView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/10.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CashBackFooterView.h"

#import "CashBackSectionViewModel.h"

#import "UIView+FillCorner.h"

@interface CashBackFooterView()

@property (nonatomic,strong)UIButton *clickBtn;

@end

@implementation CashBackFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 背景
    UIView *backView = [UIView new];
    backView.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    // 载体
    UIView *backContentView = [UIView new];
    backContentView.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];
    [backView addSubview:backContentView];
    [backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    backContentView.layer.cornerRadius = 5;
    backContentView.layer.masksToBounds = YES;
    
    [backContentView lyFillTopCornerWithWidth:5
                                  colorString:@"#ffffff"];
    
    // 文字
    UIButton *clickBtn = [UIButton new];
    self.clickBtn = clickBtn;
    clickBtn.titleLabel.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    [clickBtn setTitleColor:[CommUtls colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [clickBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [backContentView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:nil];
        return [RACSignal empty];
    }];
    
    [self addTopLine];
}

#pragma mark -reload
- (void)bindViewModel:(CashBackSectionViewModel *)vm
{
    if (vm.unfold) {
        [self.clickBtn setTitle:@"收起" forState:UIControlStateNormal];
    }else{
        [self.clickBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    }
}

@end
