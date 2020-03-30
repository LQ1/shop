//
//  QRCodeView.m
//  integralMall
//
//  Created by liu on 2018/12/29.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import "QRCodeView.h"

@implementation QRCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initEvent{
    self.viewContainer.layer.cornerRadius = 6;
    self.viewContainer.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *gesture_close = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_close_onClicked:)];
    self.imgClose.userInteractionEnabled = YES;
    [self.imgClose addGestureRecognizer:gesture_close];
}

//保存到本地
- (IBAction)btnSaveToLocal:(id)sender {
    [self saveImage:self.imgRQCode.image];
}

- (void)loadImage:(NSString*)szURL{
    [ImageLoadingUtils loadImage:self.imgRQCode withURL:szURL];
}

- (void)gesture_close_onClicked:(id)sender{
    [self removeFromSuperview];
}



//image是要保存的图片
- (void) saveImage:(UIImage *)image{
    if (image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
        
    };
}
//保存完成后调用的方法
- (void) savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        NSLog(@"保存图片出错%@", error.localizedDescription);
        [DLLoading DLToolTipInWindow:@"保存失败!"];
    }
    else {
        NSLog(@"保存图片成功");
        [DLLoading DLToolTipInWindow:@"保存图片成功!"];
    }
}

@end
