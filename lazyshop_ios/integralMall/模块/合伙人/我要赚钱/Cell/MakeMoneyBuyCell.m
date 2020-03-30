//
//  MakeMoneyBuyCell.m
//  integralMall
//
//  Created by liu on 2018/10/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MakeMoneyBuyCell.h"

@implementation MakeMoneyBuyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData:(MakeMoneyBuyInfoModel*)data{
    self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.size.width*0.5f;
    self.imgAvatar.layer.masksToBounds = YES;
    
    [ImageLoadingUtils loadImage:self.imgAvatar withURL:data.avatar];
    self.lblNickName.text = [Utility getSafeString:data.nickname];
    self.lblBuyText.text = [Utility getSafeString:data.buy_text];
    self.lblEndDT.text = [Utility getSafeString:data.end_at];
}

@end
