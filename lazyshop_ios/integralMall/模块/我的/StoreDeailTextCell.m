//
//  StoreDeailTextCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "StoreDeailTextCell.h"

#import "StoreDeailTextCellViewModel.h"

@interface StoreDeailTextCell()

@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UILabel *rightLabel;

@end

@implementation StoreDeailTextCell

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
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.leftLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                              textAlignment:0
                                                  textColor:@"#000000"
                                               adjustsWidth:NO
                                               cornerRadius:0
                                                       text:nil];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.rightLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                               textAlignment:0
                                                   textColor:nil
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:nil];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    self.rightLabel.numberOfLines = 0;
    
    [self.contentView addBottomLine];
}

#pragma mark -reload
- (void)bindViewModel:(StoreDeailTextCellViewModel *)vm
{
    self.leftLabel.text = vm.leftTitle;
    self.rightLabel.text = vm.rightTitle;
    if (!vm.rightTitleColor.length) {
        vm.rightTitleColor = @"#666666";
    }
    self.rightLabel.textColor = [CommUtls colorWithHexString:vm.rightTitleColor];
}

@end
