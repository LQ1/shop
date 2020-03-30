//
//  HZPhotoBrowserView.h
//  HZPhotoBrowser
//
//  Created by huangzhenyu on 15/5/7.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYPhotoBrowserView : UIView
@property (nonatomic,strong) UIScrollView *scrollview;
@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) BOOL beginLoadingImage;
@property (nonatomic, strong) void (^singleTapBlock)(UITapGestureRecognizer *recognizer);
@property (nonatomic,strong) void (^longTabBlock)(UILongPressGestureRecognizer *recognizer);
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

//后添加的方法
- (void)setImageWithName:(NSString*)imageName;
@end
