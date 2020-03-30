//
//  OrderMessageCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderMessageCell.h"

#import "OrderMessageCellViewModel.h"

@interface OrderMessageCell()

@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIImageView *thumbView;

@end


@implementation OrderMessageCell

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
    // 图片
    self.thumbView = [self.contentView addImageViewWithImageName:nil
                                                    cornerRadius:0];
    [self.thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(70);
        make.top.mas_equalTo(self.titleLabel.bottom).offset(10);
    }];
    // 内容
    self.contentLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:@"#999999"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:nil];
    self.contentLabel.numberOfLines = 4;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.thumbView.right).offset(10);
        make.top.mas_equalTo(self.thumbView);
        make.right.mas_equalTo(-38.5);
    }];
}

#pragma mark -bind
- (void)bindViewModel:(OrderMessageCellViewModel *)vm
{
    [super bindViewModel:vm];
    self.contentLabel.text = vm.content;
    [self.thumbView ly_showMidImg:vm.thumb];
}


@end
