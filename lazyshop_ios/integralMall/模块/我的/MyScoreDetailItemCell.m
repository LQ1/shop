//
//  MyScoreDetailItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyScoreDetailItemCell.h"

#import "MyScoreDetailItemModel.h"

@interface MyScoreDetailItemCell ()

@property (nonatomic, strong) UILabel *msgNameLabel;
@property (nonatomic, strong) UILabel *msgDateLabel;
@property (nonatomic, strong) UILabel *msgValueLabel;

@end

@implementation MyScoreDetailItemCell

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
    self.msgNameLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:App_TxtBColor
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:nil];
    [self.msgNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
    }];
    
    self.msgDateLabel = [self.contentView addLabelWithFontSize:MIN_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:@"#cccccc"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:nil];
    [self.msgDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.msgNameLabel.bottom).offset(8);
    }];
    
    self.msgValueLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:APP_MainColor
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:nil];
    [self.msgValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-27);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addBottomLine];
}

- (void)bindViewModel:(MyScoreDetailItemModel *)model
{
    self.msgNameLabel.text = model.reason;
    self.msgDateLabel.text = model.time;
    if (model.change_type == 1) {
        self.msgValueLabel.text = [NSString stringWithFormat:@"+%ld",(long)model.change_score];
    }else{
        self.msgValueLabel.text = [NSString stringWithFormat:@"-%ld",(long)model.change_score];
    }
}

@end
