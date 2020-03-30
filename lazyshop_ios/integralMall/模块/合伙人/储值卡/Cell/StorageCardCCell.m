//
//  StorageCardCCell.m
//  integralMall
//
//  Created by liu on 2018/10/14.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "StorageCardCCell.h"
#import "ImageLoadingUtils.h"

@implementation StorageCardCCell

- (void)loadData:(StorageCardModel*)data{
    self.clipsToBounds = YES;
    
    self.lblMoney.text = [NSString stringWithFormat:@"￥%.2f",data.money];
    self.lblTitle.text = data.title;
    
    self.imgBackground.layer.masksToBounds = YES;
    self.imgBackground.layer.cornerRadius = 8.0f;
    
    
    
    [ImageLoadingUtils loadImageWithOriScaleType:self.imgBackground withURL:data.store_card_thumb];
}

@end
