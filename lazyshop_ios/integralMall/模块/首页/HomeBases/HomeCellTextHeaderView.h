//
//  HomeCellTextHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HomeCellTextHeaderViewListHeight 83.0f

@interface HomeCellTextHeaderView : UIView

@property (nonatomic, readonly) UILabel *titleTipLabel;

- (instancetype)initWithTitle:(NSString *)title;

@end
