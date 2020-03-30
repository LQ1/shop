//
//  ChoiceWareHouseItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/31.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ChoiceWareHouseItemCell.h"

#import <DLUIKit/CheckBoxButton.h>

#import "ChoiceWareHouseItemViewModel.h"

@interface ChoiceWareHouseItemCell()

@property (nonatomic, strong)CheckBoxButton *checkBox;
@property (nonatomic, strong)UILabel *nameLabel;

@end

@implementation ChoiceWareHouseItemCell

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
    // 背景
    self.contentView.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    
    // 白色载体
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(8);
    }];
    // 复选
    self.checkBox = [[CheckBoxButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)
                                            checkImgeWith:[UIImage imageNamed:@"选择收货地址未选中"]
                                          checkedImgeWith:[UIImage imageNamed:@"默认地址选中"] selectCheckedWith:NO];
    self.checkBox.userInteractionEnabled = NO;
    [contentView addSubview:self.checkBox];
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(17);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(contentView);
    }];
    // 标题
    UILabel *nameLabel = [UILabel new];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    nameLabel.textColor = [CommUtls colorWithHexString:@"#000000"];
    [contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.checkBox);
    }];
}

- (void)bindViewModel:(ChoiceWareHouseItemViewModel *)vm
{
    self.checkBox.checked = vm.checked;
    self.nameLabel.text = vm.itemName;
}

@end
