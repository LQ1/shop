//
//  ScoreMessageCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ScoreMessageCell.h"

#import "ScoreMessageCellViewModel.h"

@interface ScoreMessageCell()

@property (nonatomic,strong)UILabel *tipLabel;
@property (nonatomic,strong)UILabel *changeValueLabel;
@property (nonatomic,strong)UILabel *changeDateLabel;

@end

@implementation ScoreMessageCell

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
    UILabel *tipLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:@"#333333"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:@"积分"];
    self.tipLabel = tipLabel;
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.changeValueLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                     textAlignment:NSTextAlignmentRight
                                                         textColor:nil
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:nil];
    [self.changeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.centerX).offset(-22);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.changeDateLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                    textAlignment:NSTextAlignmentRight
                                                        textColor:@"#999999"
                                                     adjustsWidth:NO
                                                     cornerRadius:0
                                                             text:nil];
    [self.changeDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addBottomLine];
}

#pragma mark -bind
- (void)bindViewModel:(ScoreMessageCellViewModel *)vm
{
    self.tipLabel.text = vm.title;
    if (vm.inCrease) {
        self.changeValueLabel.text = [@"+" stringByAppendingString:vm.changeValue];
        self.changeValueLabel.textColor = [CommUtls colorWithHexString:@"#00ce65"];
    }else{
        self.changeValueLabel.text = [@"-" stringByAppendingString:vm.changeValue];
        self.changeValueLabel.textColor = [CommUtls colorWithHexString:@"#e33a3a"];
    }
    self.changeDateLabel.text = vm.changeDate;
}

@end
