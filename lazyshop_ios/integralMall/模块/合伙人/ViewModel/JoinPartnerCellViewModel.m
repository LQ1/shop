//
//  JoinPartnerViewModel.m
//  integralMall
//
//  Created by liu on 2018/10/8.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "JoinPartnerCellViewModel.h"
#import "JoinUsCell.h"


@implementation JoinPartnerCellViewModel

- (instancetype)initWithItemModels:(PartnerModel*)model{
    self = [super init];
    
    self.childViewModels = [NSArray arrayWithObjects:model, nil];
    // 共有属性
    self.UIClassName = NSStringFromClass([JoinUsCell class]);
    self.UIReuseID = self.UIClassName;
    self.UIHeight = (KScreenWidth-32)*model.picImage.size.height/model.picImage.size.width + 30 + 18; //176;
    
    //[self initCell];
    
    return self;
}

- (void)initCell{
    
}

@end
