//
//  HomeHoriScrollItemBaseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeHoriScrollItemBaseCell.h"

@interface HomeHoriScrollItemBaseCell()

@end

@implementation HomeHoriScrollItemBaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        // 阴影
        UIView *shadowView = [UIView new];
        self.shadowView = shadowView;
        shadowView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:shadowView];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(4);
            make.right.mas_equalTo(-4);
            make.left.mas_equalTo(2);
            make.bottom.mas_equalTo(-2);
        }];
        shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        shadowView.layer.shadowOffset = CGSizeMake(1.5,-1.5);
        shadowView.layer.shadowOpacity = 0.1;
        shadowView.layer.shadowRadius = 1.5;
        // 图
        self.imageView = [self.shadowView addImageViewWithImageName:nil
                                                       cornerRadius:1.5];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)reloadDataWithModel:(id)itemModel
{

}

@end
