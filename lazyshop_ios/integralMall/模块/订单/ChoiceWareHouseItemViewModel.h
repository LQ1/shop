//
//  ChoiceWareHouseItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/31.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class ChoiceWareHouseItemModel;

@interface ChoiceWareHouseItemViewModel : LYItemUIBaseViewModel

@property (nonatomic, copy) NSString *wareHouseID;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, assign) BOOL sellerPost;
@property (nonatomic, assign) BOOL checked;

@property (nonatomic,strong)ChoiceWareHouseItemModel *model;


- (instancetype)initWithChoiceWareHouseItemModel:(ChoiceWareHouseItemModel *)model;

@end
