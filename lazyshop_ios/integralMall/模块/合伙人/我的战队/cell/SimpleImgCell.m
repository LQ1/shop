//
//  SimpleImgCell.m
//  integralMall
//
//  Created by liu on 2018/12/28.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import "SimpleImgCell.h"

@implementation SimpleImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData:(PartnerMyPageFooterModel*)data  withHasBtn:(BOOL)btnVisible{
    self.btnBuy.layer.cornerRadius = 16;
    self.btnBuy.layer.masksToBounds = YES;
    [ImageLoadingUtils loadImage:self.imgBackground withURL:data.image];
    self.btnBuy.hidden = !btnVisible;
}

@end
