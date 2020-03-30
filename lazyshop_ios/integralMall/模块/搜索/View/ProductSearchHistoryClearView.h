//
//  ProductSearchHistoryClearView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ProductSearchHistoryClearViewHeight 90.0f

@interface ProductSearchHistoryClearView : UIView

@property (nonatomic,readonly) RACSubject *clickSignal;

@end
