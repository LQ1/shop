//
//  GoodsDetailAudioVideoView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/18.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GoodsDetailAudioVideoViewWidth 63.5f
#define GoodsDetailAudioVideoViewHeight 22.0f

@interface GoodsDetailAudioVideoView : UIView

@property (nonatomic,readonly)RACSubject *clickSignal;

- (instancetype)initWithAudio:(BOOL)audio;

- (void)setText:(NSString *)text;

@end
