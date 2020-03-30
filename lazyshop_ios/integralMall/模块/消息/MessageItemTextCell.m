//
//  MessageItemTextCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageItemTextCell.h"

#import "MessageItemTextCellViewModel.h"

@interface MessageItemTextCell()

@property (nonatomic,strong)UILabel *contentLabel;

@end

@implementation MessageItemTextCell

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
    // 内容
    self.contentLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:@"#999999"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:nil];
    self.contentLabel.numberOfLines = 0;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-38.5);
        make.top.mas_equalTo(self.titleLabel.bottom).offset(12);
    }];
}

#pragma mark -bind
- (void)bindViewModel:(MessageItemTextCellViewModel *)vm
{
    [super bindViewModel:vm];
    self.contentLabel.text = vm.content;
    self.rightArrowView.hidden = vm.hideRightArrow;
}

@end
