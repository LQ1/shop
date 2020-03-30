//
//  UIImageView+LYLogCache.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "UIImageView+LYLogCache.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageManager.h>

@implementation UIImageView (LYLogCache)

- (void)ly_showMaxImg:(NSString *)url
{
    [self showImg:url placeholderImage:@"首页"];
}

- (void)ly_showMidImg:(NSString *)url
{
    [self showImg:url placeholderImage:@"商品"];
}

- (void)ly_showMinImg:(NSString *)url
{
    [self showImg:url placeholderImage:@"分类占位"];
}

- (void)ly_customDefaultImg:(NSString *)defaultImg
                        url:(NSString *)url
{
    [self showImg:url placeholderImage:defaultImg];
}

- (void)showImg:(NSString *)url placeholderImage:(NSString *)imageName
{
    NSURL *string = [NSURL URLWithString:url];
    if (!self.clipsToBounds) {
        self.clipsToBounds = YES;
    }
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:string]) {
        if (self.contentMode != UIViewContentModeScaleAspectFill) {
            self.image = nil;
            self.backgroundColor = [UIColor whiteColor];
            self.contentMode = UIViewContentModeScaleAspectFill;
        }
        [self sd_setImageWithURL:string];
    } else {
        if (self.contentMode != UIViewContentModeCenter) {
            self.backgroundColor = [CommUtls colorWithHexString:APP_GapColor];
            self.contentMode = UIViewContentModeCenter;
        }
        [self sd_setImageWithURL:string
                placeholderImage:[UIImage imageNamed:imageName]
                         options:SDWebImageRetryFailed
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           if (image) {
                               if (self.contentMode != UIViewContentModeScaleAspectFill) {
                                   self.backgroundColor = [UIColor whiteColor];
                                   self.contentMode = UIViewContentModeScaleAspectFill;
                               }
                           }
                       }];
    }
}

@end
