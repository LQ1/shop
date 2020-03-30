//
//  LYUpImgDownTxtView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LYUpImgDownTxtViewClickBlock) (void);

@interface LYUpImgDownTxtView : UIView

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;

- (instancetype)initWithImageName:(NSString *)imageName
                            title:(NSString *)title
                       titleColor:(NSString *)titleColor
                       clickBlock:(LYUpImgDownTxtViewClickBlock)clickBlock;

/*
 *  设置角标
 */
- (void)setRoundNumber:(NSInteger)roundNumber;

@end
