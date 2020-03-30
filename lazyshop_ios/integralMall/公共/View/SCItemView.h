//
//  ItemView.h
//  MobileClassPhone
//
//  Created by zln on 16/4/22.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCItemView : UIView

@property (nonatomic, strong) UILabel  *siftConditionLb;    // 筛选条件名称Lb
@property (nonatomic, strong) UIButton *touchBtn;           // 底层Button
@property (nonatomic, copy)   NSString *siftId;             // 筛选id
@property (nonatomic, assign) BOOL      isSelected;         // 是否是选中状态

/**
 *  添加界面
 */
- (void)addViews;

@end
