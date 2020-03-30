//
//  HomeLeisureItemView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeLeisureItemModel;

@interface HomeLeisureItemView : UIView

- (instancetype)initWithTitleStyle:(BOOL)verb
                         titleFont:(NSInteger)titleFont;

- (void)reloadWithModel:(HomeLeisureItemModel *)model;

@end
