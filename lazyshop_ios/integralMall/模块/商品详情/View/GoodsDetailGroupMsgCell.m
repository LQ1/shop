//
//  GoodsDetailGroupMsgCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailGroupMsgCell.h"

#import "GoodsDetailGroupMsgViewModel.h"

@interface GoodsDetailGroupMsgCell()

@property (nonatomic,strong)UILabel *missNumLabel;
@property (nonatomic,strong)UILabel *leftTimeLabel;

@end

@implementation GoodsDetailGroupMsgCell

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
    self.leftTitleLabel.text = @"拼团";
    
    self.missNumLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:@"#000000"
                                                  adjustsWidth:YES
                                                  cornerRadius:0
                                                          text:nil];
    [self.missNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTitleLabel.right);
        make.width.mas_equalTo(60);
        make.centerY.mas_equalTo(self.leftTitleLabel);
    }];
    
    self.leftTimeLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#000000"
                                                   adjustsWidth:YES
                                                   cornerRadius:0
                                                           text:nil];
    [self.leftTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.missNumLabel.right).offset(3);
        make.centerY.mas_equalTo(self.missNumLabel);
    }];
}

#pragma mark -bind
- (void)bindViewModel:(GoodsDetailGroupMsgViewModel *)vm
{
    self.missNumLabel.text = [NSString stringWithFormat:@"还差%@人",vm.missingNum];
    @weakify(self);
    [[[RACObserve(vm, leftTime) takeUntil:self.rac_prepareForReuseSignal] distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self);
        self.leftTimeLabel.text = [NSString stringWithFormat:@"剩余%@",x];
    }];
}

@end
