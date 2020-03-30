//
//  MoreMenuItemView.h
//  NetSchool
//
//  Created by LY on 2017/9/13.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "SCItemView.h"

@class SiftModel;

@interface MoreMenuItemView : SCItemView

- (void)reloadDataWithSiftModel:(SiftModel *)siftModel;

@end
