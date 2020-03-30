//
//  ProductSearchHistoryClearView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductSearchHistoryClearView.h"

@implementation ProductSearchHistoryClearView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    UIView *contenView = [UIView new];
    contenView.layer.borderColor = [CommUtls colorWithHexString:@"#666666"].CGColor;
    contenView.layer.borderWidth = 1./[UIScreen mainScreen].scale;
    contenView.layer.cornerRadius = 3;
    contenView.layer.masksToBounds = YES;
    [self addSubview:contenView];
    [contenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(40);
        make.center.mas_equalTo(self);
    }];
    
    UIImageView *clearView = [self addImageViewWithImageName:@"删除历史搜索" cornerRadius:0];
    [contenView addSubview:clearView];
    [clearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(70);
        make.centerY.mas_equalTo(contenView);
    }];
    
    UILabel *clearLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                       textAlignment:0
                                           textColor:@"#666666"
                                        adjustsWidth:NO
                                        cornerRadius:0
                                                text:@"清空历史搜索"];
    [clearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(clearView.right).offset(5);
        make.centerY.mas_equalTo(clearView);
    }];
    
    UIButton *clickBtn = [UIButton new];
    [contenView addSubview:clickBtn];
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

@end
