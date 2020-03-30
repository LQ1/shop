//
//  HomeScoreCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeHoriScrollBaseViewModel.h"

@interface HomeScoreCellViewModel : HomeHoriScrollBaseViewModel

@property (nonatomic, copy) NSString *scoreSingleImgUrl;

- (instancetype)initWithItemModels:(NSArray *)itemModels
                 scoreSingleImgUrl:(NSString *)scoreSingleImgUrl;

@end
