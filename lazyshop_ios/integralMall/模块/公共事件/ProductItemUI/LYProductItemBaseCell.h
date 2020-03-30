//
//  LYProductItemBaseCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/27.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseCell.h"

@interface LYProductItemBaseCell : LYItemUIBaseCell

@property (nonatomic,strong) UIImageView *productImgView;
@property (nonatomic,strong) UILabel *productNameLabel;
@property (nonatomic,strong) UILabel *productSkuLabel;
@property (nonatomic,strong) UILabel *productPriceLabel;

@end
