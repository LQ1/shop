//
//  ChoiceWareHouseViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/31.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYNavigationBarViewController.h"

#import "ChoiceWareHouseItemModel.h"

typedef void (^WareHouseSelectSuccessBlock)(ChoiceWareHouseItemModel *addressModel);

@interface ChoiceWareHouseViewController : LYNavigationBarViewController

@property (nonatomic,copy) WareHouseSelectSuccessBlock selectSuccessBlock;

@end
