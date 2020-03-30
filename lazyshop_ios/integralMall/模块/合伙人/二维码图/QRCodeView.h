//
//  QRCodeView.h
//  integralMall
//
//  Created by liu on 2018/12/29.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageLoadingUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface QRCodeView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgClose;
@property (weak, nonatomic) IBOutlet UIImageView *imgRQCode;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

- (void)initEvent;

- (void)loadImage:(NSString*)szURL;

@end

NS_ASSUME_NONNULL_END
