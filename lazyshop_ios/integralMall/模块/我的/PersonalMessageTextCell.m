//
//  PersonalMessageTextCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PersonalMessageTextCell.h"

#import "PersonalMessageTextCellViewModel.h"

@interface PersonalMessageTextCell()

@property (nonatomic,strong)UILabel *rightTitleLabel;

@end

@implementation PersonalMessageTextCell

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
    // 右标题
    self.rightTitleLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                    textAlignment:NSTextAlignmentRight
                                                        textColor:@"#666666"
                                                     adjustsWidth:NO
                                                     cornerRadius:0
                                                             text:nil];
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightArrowView.left).offset(-12.5);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (void)bindViewModel:(PersonalMessageTextCellViewModel *)vm
{
    self.leftTitleLabel.text = vm.title;
    self.rightTitleLabel.text = vm.detail;
    if (vm.hideArrow) {
        self.rightArrowView.hidden = YES;
        [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }else{
        self.rightArrowView.hidden = NO;
        [self.rightTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.rightArrowView.left).offset(-12.5);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
}

@end
