//
//  MyRecommendCell.m
//  integralMall
//
//  Created by liu on 2018/10/14.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyRecommendCell.h"
#import "ImageLoadingUtils.h"

@implementation MyRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData:(RecommendInfoModel*)data{
    self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.size.width*0.5f;
    self.imgAvatar.layer.masksToBounds = YES;
    
    [ImageLoadingUtils loadImage:self.imgAvatar withURL:data.avatar];
    self.lblNickName.text = data.nickname;
}

@end
