//
//  LYItemUIBaseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseCell.h"

@implementation LYItemUIBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _baseClickSignal = [[RACSubject subject] setNameWithFormat:@"%@ baseClickSignal", self.class];
        _itemClickSignal = [[RACSubject subject] setNameWithFormat:@"%@ itemClickSignal", self.class];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)bindViewModel:(id)vm
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
