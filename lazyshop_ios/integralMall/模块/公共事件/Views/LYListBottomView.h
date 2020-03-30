//
//  LYListBottomView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LYListBottomViewClickBlock)(int clickIndex);

@interface LYListBottomView : UIView

- (instancetype)initWithTitles:(NSArray *)titles
              backColorStrings:(NSArray *)backColorStrings
              textColorStrings:(NSArray *)textColorStrings
                       leftPro:(CGFloat)leftPro
                    clickBlock:(LYListBottomViewClickBlock)block;

@end
