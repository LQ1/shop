
//
//  DLEncodeUtil.h
//  DLImagePickerView
//
//  Created by yangjie on 16/9/27.
//  Copyright © 2016年 yangjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DLEncodeUtil : NSObject

+ (NSString *)getMD5ForStr:(NSString *)str;
+ (UIImage *)convertImage:(UIImage *)origImage scope:(CGFloat)scope;

@end
