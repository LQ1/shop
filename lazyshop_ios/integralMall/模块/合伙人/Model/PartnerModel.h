//
//  PartnerModel.h
//  integralMall
//
//  Created by liu on 2018/10/8.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>
#import "BaseStringProModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PartnerModel : BaseStringProModel

@property(nonatomic) int link_type;

@property(nonatomic) int advert_id;

@property(nonatomic) int placeholder_id;

@property(nonatomic,copy) NSString *image;

@property (nonatomic,strong) UIImage *picImage;

@end

NS_ASSUME_NONNULL_END
