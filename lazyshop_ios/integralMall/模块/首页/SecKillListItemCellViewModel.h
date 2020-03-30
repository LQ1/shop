//
//  SecKillListItemCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductRowBaseCellViewModel.h"

@interface SecKillListItemCellViewModel : ProductRowBaseCellViewModel

@property (nonatomic,assign) NSInteger remainNumber;
@property (nonatomic,copy)NSString *activity_flash_id;
@property (nonatomic,assign) BOOL isEnd;

@end
