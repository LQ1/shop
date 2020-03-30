//
//  HomeAllActivityHeaderItemView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeAllActivityHeaderItemView : UIView

@property (nonatomic, assign) BOOL checked;

@property (nonatomic, readonly) RACSubject *clickSignal;

- (instancetype)initWithTitle:(NSString *)title;

@end
