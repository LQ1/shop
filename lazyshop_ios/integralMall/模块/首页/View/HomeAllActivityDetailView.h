//
//  HomeAllActivityDetailView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeAllActivityCellViewModel;

typedef NS_ENUM(NSUInteger, HomeAllActivityGoMoreType) {
    HomeAllActivityGoMoreType_SecKillList,
    HomeAllActivityGoMoreType_GroupBuyList,
    HomeAllActivityGoMoreType_BargainList
};

@interface HomeAllActivityDetailView : UIView

@property (nonatomic, readonly) RACSubject *gotoActivityListSignal;
@property (nonatomic, readonly) RACSubject *gotoGoodsDetailSignal;

- (void)reloadDataWithViewModel:(HomeAllActivityCellViewModel *)viewModel;

@end
