//
//  HomeSelectedFiledItemView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSelectedFiledItemView : UIView

- (instancetype)initWithMore:(BOOL)more;

- (void)reloadWithMoreDesc:(NSString *)moreDesc
                 moreCatID:(NSInteger)catID
                   catType:(NSString *)catType;

- (void)reloadWithGoodsID:(NSInteger)goodsID
               goodsThumb:(NSString *)goodsThumb;

@end
