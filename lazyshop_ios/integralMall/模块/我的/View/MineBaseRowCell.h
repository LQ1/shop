//
//  MineBaseRowCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseCell.h"

#define MineBaseRowCellHeight 44.0f

@interface MineBaseRowCell : LYItemUIBaseCell

@property (nonatomic,strong) UIView *backContentView;
@property (nonatomic,strong) UIImageView *rowImageView;
@property (nonatomic,strong) UILabel *rowTitleLabel;

- (void)fillTopCorner;
- (void)fillBottomCorner;

@end
