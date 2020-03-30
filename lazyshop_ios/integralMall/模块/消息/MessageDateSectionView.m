//
//  MessageDateSectionView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageDateSectionView.h"

#import "MessageDateSectionViewModel.h"

@interface MessageDateSectionView()

@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation MessageDateSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.titleLabel = [backView addLabelWithFontSize:SMALL_FONT_SIZE
                                       textAlignment:NSTextAlignmentCenter
                                           textColor:@"#999999"
                                        adjustsWidth:NO
                                        cornerRadius:0
                                                text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addBottomLine];
}

#pragma mark -bind
- (void)bindViewModel:(MessageDateSectionViewModel *)vm
{
    self.titleLabel.text = vm.dateTime;
}

@end
