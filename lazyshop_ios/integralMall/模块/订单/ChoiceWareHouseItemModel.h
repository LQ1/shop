//
//  ChoiceWareHouseItemModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/31.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface ChoiceWareHouseItemModel : BaseModel

@property (nonatomic, assign) NSInteger storehouse_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL sellerPost;

@end
