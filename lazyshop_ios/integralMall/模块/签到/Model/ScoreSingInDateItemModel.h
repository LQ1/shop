//
//  ScoreSingInDateItemModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface ScoreSingInDateItemModel : BaseModel

@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;

@property (nonatomic,strong) NSString *sign_in_time;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *titleColorString;
@property (nonatomic,assign) BOOL hideRightLine;
@property (nonatomic,assign) BOOL hasSignIn;

@end
