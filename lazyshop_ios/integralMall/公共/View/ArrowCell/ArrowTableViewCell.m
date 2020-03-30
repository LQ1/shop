//
//  ArrowTableViewCell.m
//  MobileClassPhone
//
//  Created by SL on 15/5/7.
//  Copyright (c) 2015年 CDEL. All rights reserved.
//

#import "ArrowTableViewCell.h"

@implementation ArrowTableViewCell

- (void)dealloc{
    CLog(@"dealloc -- %@",self.class);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.arrowImageView =[UIImageView new];
        [_arrowImageView setImage:[UIImage imageNamed:@"list_btn_into"]];
        [_arrowImageView sizeToFit];
        [self.contentView addSubview:_arrowImageView];
        
        CGFloat arrowWidth = _arrowImageView.frame.size.width;
        CGFloat arrowHeight = _arrowImageView.frame.size.height;
        
        @weakify(self);
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.contentView.right).offset(-14);
            make.centerY.equalTo(self.contentView.centerY);
            make.width.equalTo(arrowWidth);
            make.height.equalTo(arrowHeight);
        }];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.arrowImageView =[UIImageView new];
    [_arrowImageView setImage:[UIImage imageNamed:@"list_btn_into"]];
    [_arrowImageView sizeToFit];
    [self.contentView addSubview:_arrowImageView];
    
    CGFloat arrowWidth = _arrowImageView.frame.size.width;
    CGFloat arrowHeight = _arrowImageView.frame.size.height;
    
    @weakify(self);
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.contentView.right).offset(-14);
        make.centerY.equalTo(self.contentView.centerY);
        make.width.equalTo(arrowWidth);
        make.height.equalTo(arrowHeight);
    }];
}

@end
