//
//  FeedBackTypeItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "FeedBackTypeItemCell.h"

#import "LYTextColorButton.h"
#import "FeedBackTypeItemCellViewModel.h"

@interface FeedBackTypeItemCell()

@property(nonatomic,strong) LYTextColorButton *textColorBtn;

@end

@implementation FeedBackTypeItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.textColorBtn = [[LYTextColorButton alloc] initWithTitle:nil
                                                  buttonFontSize:MIDDLE_FONT_SIZE
                                                    cornerRadius:2];
    [self.contentView addSubview:self.textColorBtn];
    self.textColorBtn.userInteractionEnabled = NO;
    [self.textColorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(1);
        make.bottom.right.mas_equalTo(-1);
    }];
}

#pragma mark -bind
- (void)bindViewModel:(FeedBackTypeItemCellViewModel *)vm
{
    if (vm.selected) {
        self.textColorBtn.layer.borderColor = [CommUtls colorWithHexString:APP_MainColor].CGColor;
        [self.textColorBtn setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateNormal];
    }else{
        self.textColorBtn.layer.borderColor = [CommUtls colorWithHexString:@"#999999"].CGColor;
        [self.textColorBtn setTitleColor:[CommUtls colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    }
    [self.textColorBtn setTitle:vm.title forState:UIControlStateNormal];
}

@end
