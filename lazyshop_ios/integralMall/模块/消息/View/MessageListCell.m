//
//  MessageListCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageListCell.h"

#import "MessageListCellViewModel.h"
#import "LYRedRoundLabel.h"

@interface MessageListCell()

@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *detailLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)LYRedRoundLabel *roundLabel;

@end

@implementation MessageListCell

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
    self.iconView = [self.contentView addImageViewWithImageName:nil
                                                    cornerRadius:3];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(49);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.titleLabel = [self.contentView addLabelWithFontSize:LARGE_FONT_SIZE
                                               textAlignment:0
                                                   textColor:@"#000000"
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.right).offset(10);
        make.top.mas_equalTo(self.iconView.top).offset(5);
    }];
    
    self.detailLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                textAlignment:0
                                                    textColor:@"#666666"
                                                 adjustsWidth:NO
                                                 cornerRadius:0
                                                         text:nil];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.bottom).offset(10);
        make.right.mas_equalTo(-15);
    }];
    
    self.timeLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                              textAlignment:NSTextAlignmentRight
                                                  textColor:@"#666666"
                                               adjustsWidth:NO
                                               cornerRadius:0
                                                       text:nil];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.titleLabel);
    }];
    
    // 角标
    self.roundLabel = [[LYRedRoundLabel alloc] init];
    self.roundLabel.layer.borderWidth = 1.;
    self.roundLabel.layer.borderColor = [CommUtls colorWithHexString:@"#ffffff"].CGColor;
    [self.contentView addSubview:self.roundLabel];
    [self.roundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(LYRedRoundLabelHeight);
        make.centerX.mas_equalTo(self.iconView.right);
        make.centerY.mas_equalTo(self.iconView.top);
    }];
    self.roundLabel.hidden = YES;

}

#pragma mark -bind
- (void)bindViewModel:(MessageListCellViewModel *)vm
{
    self.iconView.image = [UIImage imageNamed:vm.imageName];
    self.titleLabel.text = vm.title;
    self.detailLabel.text = vm.detailTitle;
    self.timeLabel.text = vm.time;
    if ([vm.msgCount integerValue]>0) {
        self.roundLabel.hidden = NO;
        if ([vm.msgCount integerValue]>9) {
            self.roundLabel.text = @"9+";
        }else{
            self.roundLabel.text = vm.msgCount;
        }
    }else{
        self.roundLabel.hidden = YES;
    }
}

@end
