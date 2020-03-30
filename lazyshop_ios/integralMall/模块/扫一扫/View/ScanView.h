//
//  ScanView.h
//  BookForDream
//
//  Created by song on 14-10-9.
//  Copyright (c) 2014年 Gl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ScanViewDelegate <NSObject>

/**
 *  扫描成功代理
 */
- (void)scanSucessMethod:(NSString *)resultText;

/**
 *  开灯
 */
- (void)scanLightOn;


@end

@interface ScanView : UIView

@property (nonatomic, assign) id<ScanViewDelegate> scanViewDelegate;
@property (nonatomic, strong) UIImageView *scanStrip;
@property (nonatomic, assign) CGFloat orginY;

- (void)beginScanAnimation;
- (void)endScanAnimation;

@end
