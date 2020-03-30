//
//  StudyCell.m
//  integralMall
//
//  Created by liu on 2019/3/12.
//  Copyright © 2019 Eggache_Yang. All rights reserved.
//

#import "StudyCell.h"

@implementation StudyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadData:(StudyModel*)model{
    //[ImageLoadingUtils loadImage:self.imgThumb withURL:model.thumb];
    [self setVideoPreViewImage:model];
    self.lblTitle.text = model.title;
    self.lblAuthor.text = model.writer;
}

- (void)setVideoPreViewImage:(StudyModel*)model {
    if (model.videoImage != nil) {
        self.imgThumb.image = model.videoImage;
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (model.videoImage == nil) {
            NSURL *path = [NSURL URLWithString:model.thumb];
            UIImage *videoImage = [ImageLoadingUtils getVideoPreViewImage:path];
            model.videoImage = videoImage;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (videoImage != nil) {
                    self.imgThumb.image = videoImage;
                }
            });
        }
    });
}

@end
