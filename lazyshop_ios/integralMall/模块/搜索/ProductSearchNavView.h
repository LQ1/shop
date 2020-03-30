//
//  ProductSearchNavView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProductSearchMacro.h"

@interface ProductSearchNavView : UIView

@property (nonatomic,readonly) UILabel *searchTipLabel;
@property (nonatomic,readonly) UITextField *searchTextfield;

- (instancetype)initWithInputEnabled:(BOOL)inputEnabled
                            tipTitle:(NSString *)tipTitle
                   ProductSearchFrom:(ProductSearchFrom)from
                searchTitleBackBlock:(searchTitleBackBlock)block;

@end
