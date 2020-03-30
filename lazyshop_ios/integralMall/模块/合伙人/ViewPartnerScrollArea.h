//
//  ViewPartnerScrollArea.h
//  integralMall
//
//  Created by liu on 2018/10/18.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewPartnerScrollArea : NSObject{
    UIView *_viewContainerScrollArea;
}

- (instancetype)initWithParentView:(UIView*)viewParent;

- (void)startAnimationNotice;

@end

NS_ASSUME_NONNULL_END
