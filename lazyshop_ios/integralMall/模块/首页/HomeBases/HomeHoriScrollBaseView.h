//
//  HomeHoriScrollBaseView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BindVMProtocol.h"
#import "HomeHoriScrollBaseViewModel.h"

@interface HomeHoriScrollBaseView : UIView <BindVMProtocol>

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat itemGap;
@property (nonatomic, assign) CGFloat leftRightGap;
@property (nonatomic, assign) Class itemCellClass;
@property (nonatomic, assign) CGFloat viewHeight;

@property (nonatomic, readonly) RACSubject *itemClickSignal;

@property (nonatomic, strong) HomeHoriScrollBaseViewModel *viewModel;


- (instancetype)initWithItemWidth:(CGFloat)itemWidth
                       itemHeight:(CGFloat)itemHeight
                          itemGap:(CGFloat)itemGap
                     leftRightGap:(CGFloat)leftRightGap
                    itemCellClass:(Class)itemCellClass;

@end
