//
//  SoCoolMenu.h
//  MobileClassPhone
//
//  Created by zln on 16/5/10.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuBgImgView.h"
@class SCItemView;
@class SoCoolMenu;

@protocol SoCoolMenuDelegate <NSObject>

- (NSInteger)numberOfItemsInSoCoolMenu:(SoCoolMenu *)soCoolMenu;

- (CGFloat)widthOfItemsInSoCoolMenu:(SoCoolMenu *)soCoolMenu;

- (CGFloat)heightOfItemsInSoCoolMenu:(SoCoolMenu *)soCoolMenu;

- (CGPoint)pointOfShowPositionInSoCoolMenu:(SoCoolMenu *)soCoolMenu;

- (SCItemView *)soCoolMenu:(SoCoolMenu *)soCoolMenu SCItemViewForRow:(NSInteger)row;

- (void)soCoolMenu:(SoCoolMenu *)soCoolMenu didSelectRow:(NSInteger)row;

@end


@interface SoCoolMenu : NSObject

/**
 *  自动设置vc手势返回 默认自动
 */
@property (nonatomic, assign)BOOL autoSetSwipeReturn;
/**
 *  是否已经打开
 */
@property (nonatomic, assign, readonly) BOOL isOpen;
/**
 *  第一个item是否需要高亮
 */
@property (nonatomic, assign) BOOL needHighLightFirstItem;
/**
 *  是否需要中间分割线
 */
@property (nonatomic, assign)BOOL cacelPartingLine;
/**
 *  是否圆角
 */
@property (nonatomic, assign)BOOL cacelRoundCorner;

@property (nonatomic, assign) NSInteger seletedIndex;

@property (nonatomic, weak) id<SoCoolMenuDelegate> delegate;

/**
 *  构造方法
 *
 *  @param bgColor 弹出菜单的背景颜色，缺省为白色，尖角的位置在右边
 *
 *  @return
 */
- (instancetype)initWithBgColor:(UIColor *)bgColor;

/**
 *  @param type    尖角的指向类型
 */
- (instancetype)initWithBgColor:(UIColor *)bgColor andCornerType:(cornerType)type;

/**
 *  加载下拉菜单
 */
- (void)loadItems;

/**
 *  在父视图中显示
 *
 *  @param parentView 父视图
 */
- (void)showMenuInView:(UIView *)parentView;

@end
