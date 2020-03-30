//
//  GoodsDetailRightMoreCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailLeftTitleBaseCell.h"

/*
 左灰标题+右更多按钮
 */

@interface GoodsDetailRightMoreBaseCell : GoodsDetailLeftTitleBaseCell

@property (nonatomic,readonly)RACSubject *moreBtnClickSignal;

@property (nonatomic,strong) UIButton *rightMoreBtn;

@end
