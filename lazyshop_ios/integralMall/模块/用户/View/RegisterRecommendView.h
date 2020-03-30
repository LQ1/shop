//
//  RegisterRecommendView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/29.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, choiceRecommederType) {
    choiceRecommederType_None = 0,
    choiceRecommederType_Seller = 3,
    choiceRecommederType_User = 2,
};

@interface RegisterRecommendView : UIView

@property (nonatomic, readonly) choiceRecommederType recommederType;
@property (nonatomic, readonly) NSString *recommenderPhone;

- (CGFloat)fetchHeight;

- (void)endEdit;

@end
