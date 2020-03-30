//
//  ImageLoadingUtils.h
//  LifeServer
//
//  Created by liu on 16/11/13.
//  Copyright (c) 2016年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"

@interface ImageLoadingUtils : NSObject

+ (void)loadImage:(UIImageView*)imageView withURL:(NSString*)szURL;
+ (void)loadImageWithOriScaleType:(UIImageView*)imageView withURL:(NSString*)szURL;

+ (void)loadImageWithOutPlaceHolderImg:(UIImageView*)imageView withURL:(NSString*)szURL;
+ (void)loadImageWithOriScaleWithOutPlaceHolderImg:(UIImageView*)imageView withURL:(NSString*)szURL;

+ (void)loadImage:(UIImageView*)imageView withNetPrefixURL:(NSString*)szURL;

+ (UIImage*)getVideoPreViewImage:(NSURL *)path;

+ (NSInteger)getCacheSize;
+ (void)clearCache;
@end
