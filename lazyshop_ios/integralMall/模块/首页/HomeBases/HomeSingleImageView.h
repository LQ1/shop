//
//  HomeSingleImageView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSingleImageView : UIView

@property (nonatomic, readonly) RACSubject *clickSignal;
@property (nonatomic, readonly) CGFloat viewHeight;

- (instancetype)initWithHWScale:(CGFloat)hwScale
                   leftRightGap:(CGFloat)leftRightGap;

- (void)reloadWithImageUrl:(NSString *)imgUrl;

+ (CGFloat)fetchHeightWithHWScale:(CGFloat)hwScale
                     leftRightGap:(CGFloat)leftRightGap;

@end
