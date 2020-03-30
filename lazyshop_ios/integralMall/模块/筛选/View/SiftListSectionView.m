//
//  SiftListSectionView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SiftListSectionView.h"

#import "SiftListSectionViewModel.h"

@interface SiftListSectionView()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *unfoldTipView;

@end

@implementation SiftListSectionView

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
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 标题
    self.titleLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                               textAlignment:0
                                                   textColor:@"#000000"
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    // 展开标志
    self.unfoldTipView  = [self.contentView addImageViewWithImageName:@"筛选向上箭头"
                                                         cornerRadius:0];
    [self.unfoldTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addBottomLineWithColorString:@"#eaeaea"];
    
    // 全铺按钮
    UIButton *clickBtn = [UIButton new];
    [self.contentView addSubview:clickBtn];
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

- (void)bindViewModel:(SiftListSectionViewModel *)vm
{
    self.titleLabel.text = vm.categoryFirstName;
    if (vm.unfolded) {
        self.unfoldTipView.image = [UIImage imageNamed:@"筛选向上箭头"];
    }else{
        self.unfoldTipView.image = [UIImage imageNamed:@"筛选向下箭头"];
    }
}

@end
