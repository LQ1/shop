//
//  JoinUsCell.h
//  integralMall
//
//  Created by liu on 2018/10/8.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYItemUIBaseCell.h"
#import "HomeContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JoinUsCell : LYItemUIBaseCell{
    PartnerModel *_partnerModel;
    BOOL _isPageMine;
}

- (void)reload:(BOOL)isPageMine;

@end

NS_ASSUME_NONNULL_END
