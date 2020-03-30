//
//  ShoppingCartProductAdderView.h
//  NetSchool
//
//  Created by LY on 2017/4/28.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LYQuantityAdderViewHeight    22.0f
#define LYQuantityAdderViewTextWidth    26.0f
#define LYQuantityAdderViewWidth    (LYQuantityAdderViewHeight*2+LYQuantityAdderViewTextWidth)

typedef void (^makeQuantityChangeBlock)(void);

typedef void (^addRequestBlock)(NSInteger quantity,makeQuantityChangeBlock block);


@interface LYQuantityAdderView : UIView

@property (nonatomic,assign)BOOL addRequestBlockEffectShouldEditting;

/**
 *  加数器的数量
 */
@property (nonatomic,readonly)NSInteger adderQuantity;

/**
 *  设置数量值
 */
- (void)setQuantityNumber:(NSInteger)quantity;

/**
 *  设置+-之前的请求
 */
- (void)setAddRequestBlock:(addRequestBlock)block;

@end
