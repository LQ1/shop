//
//  ImageUtils.h
//  LifeServer
//
//  Created by liu on 17/1/20.
//  Copyright © 2017年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ImageUtils : NSObject

+ (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size;

@end
