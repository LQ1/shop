//
//  LYImageCheckBox.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/29.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYImageCheckBox : UIView

@property (nonatomic, assign) BOOL checked;

@property (nonatomic, strong) RACSubject *clickSignal;

- (instancetype)initWithCheckedImageName:(NSString *)checkedImageName
                      unCheckedImageName:(NSString *)unCheckedImageName
                               bordColor:(UIColor *)bordColor
                               bordWidth:(CGFloat)bordWidth;

@end
