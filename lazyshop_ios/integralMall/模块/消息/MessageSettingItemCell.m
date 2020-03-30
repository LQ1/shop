//
//  MessageSettingItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageSettingItemCell.h"

#import "MessageSettingItemCellViewModel.h"

@interface MessageSettingItemCell()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UISwitch *switchBtn;
@property (nonatomic,strong)UIView *bottomLine;

@end

@implementation MessageSettingItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 文字
    self.titleLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                               textAlignment:0
                                                   textColor:@"#333333"
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    // 开关
    self.switchBtn = [UISwitch new];
    self.switchBtn.onTintColor = [CommUtls colorWithHexString:APP_MainColor];
    self.switchBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:self.switchBtn];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    // 下划线
    self.bottomLine = [self.contentView addBottomLine];
}

#pragma mark -bind
- (void)bindViewModel:(MessageSettingItemCellViewModel *)vm
{
    self.titleLabel.text = vm.title;
    self.switchBtn.on = !vm.isOff;
    self.bottomLine.hidden = vm.hiddenBottomLine;
}

@end
