//
//  SiftModel.h
//  MobileClassPhone
//
//  Created by zln on 16/5/4.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SiftModel : NSObject

@property (nonatomic, copy) NSString *siftName;   // 筛选名称
@property (nonatomic, copy) NSString *siftImgName;   // 筛选图片名称
@property (nonatomic, copy) NSString *siftId;     // 筛选ID
@property (nonatomic, assign) BOOL hasBottomLine;     // 是否要底部线

@end
