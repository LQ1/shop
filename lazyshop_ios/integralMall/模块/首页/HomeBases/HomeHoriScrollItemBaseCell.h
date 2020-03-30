//
//  HomeHoriScrollItemBaseCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHoriScrollItemBaseCell : UICollectionViewCell

@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) UIImageView *imageView;

- (void)reloadDataWithModel:(id)itemModel;

@end
