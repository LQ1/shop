//
//  ImageLoadingUtils.m
//  LifeServer
//
//  Created by liu on 16/11/13.
//  Copyright (c) 2016年 liu. All rights reserved.
//

#import "ImageLoadingUtils.h"
#import "GlobalSetting.h"


@implementation ImageLoadingUtils


//加载图片 没有加载缓存图并且保持图片的mode不变
+ (void)loadImageWithOriScaleWithOutPlaceHolderImg:(UIImageView*)imageView withURL:(NSString*)szURL{
    if (szURL == nil || [szURL isKindOfClass:[NSNull class]] || [szURL isEqualToString:@""]) {
        return;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:szURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
};
//加载图片 没有加载缓存图 使图片的mode适合显示
+ (void)loadImageWithOutPlaceHolderImg:(UIImageView*)imageView withURL:(NSString*)szURL{
    if (szURL == nil || [szURL isKindOfClass:[NSNull class]] || [szURL isEqualToString:@""]) {
        return;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:szURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
        }
    }];
};

//加载图片 有缓存图 使图片显示为合适的方式
+ (void)loadImage:(UIImageView*)imageView withURL:(NSString*)szURL{
    if (szURL == nil || [szURL isKindOfClass:[NSNull class]] || [szURL isEqualToString:@""]) {
        return;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:szURL] placeholderImage:[UIImage imageNamed:@"首页"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
        }
    }];
}

// 获取mp4文件1秒的图片
+ (UIImage*)getVideoPreViewImage:(NSURL *)path {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 60);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return videoImage;
}

//加载图片有缓存 图  不改变图片的显示方式
+ (void)loadImageWithOriScaleType:(UIImageView*)imageView withURL:(NSString*)szURL{
    if (szURL == nil || [szURL isKindOfClass:[NSNull class]] || [szURL isEqualToString:@""]) {
        return;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:szURL] placeholderImage:[UIImage imageNamed:@"首页"]];
}


//加载带有定义好的 地址前缀
+ (void)loadImage:(UIImageView*)imageView withNetPrefixURL:(NSString*)szURL{
    if (szURL == nil || [szURL isEqualToString:@""]) {
        return;
    }
    szURL = [NSString stringWithFormat:@"%@%@",[GlobalSetting getThis].NET_IMAGE_PREFIX,szURL];
    [imageView sd_setImageWithURL:[NSURL URLWithString:szURL] placeholderImage:[UIImage imageNamed:@"image_loading"]];
}


//获取缓存大小
+ (NSInteger)getCacheSize{
    return [[SDImageCache sharedImageCache] getSize];
}

//清空缓存
+ (void)clearCache{
    [[SDImageCache sharedImageCache] clearDisk];
}

@end
