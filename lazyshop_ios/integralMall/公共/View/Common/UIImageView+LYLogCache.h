//
//  UIImageView+LYLogCache.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LYLogCache)

- (void)ly_showMaxImg:(NSString *)url;
- (void)ly_showMidImg:(NSString *)url;
- (void)ly_showMinImg:(NSString *)url;

- (void)ly_customDefaultImg:(NSString *)defaultImg
                        url:(NSString *)url;

@end
