//
//  ProductRowBaseCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseCell.h"

#define ProductRowBaseCellHeight 110.0f

@interface ProductRowBaseCell : LYItemUIBaseCell

@property (nonatomic,strong) UIImageView *productImageView;
@property (nonatomic,strong) UILabel *productNameLabel;
@property (nonatomic,strong) UILabel *productPriceLabel;
@property (nonatomic,strong) UILabel *sloganLabel;
@property (nonatomic,strong ) UIButton *panicBuyButton;

@property (nonatomic,readonly) RACSubject *clickSignal;

@end
