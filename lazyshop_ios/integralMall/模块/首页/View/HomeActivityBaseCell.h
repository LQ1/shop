//
//  HomeActivityBaseCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeActivityBaseViewModel;

@interface HomeActivityBaseCell : UIView

@property (nonatomic, readonly) RACSubject *baseClickSignal;
@property (nonatomic,readonly) RACSubject *clickSignal;
@property (nonatomic,readonly)HomeActivityBaseViewModel *viewModel;
@property (nonatomic,readonly)UICollectionView *mainCollectionView;

+ (CGFloat)fetchCellHeight;

- (void)bindViewModel:(HomeActivityBaseViewModel *)viewModel;

@end
