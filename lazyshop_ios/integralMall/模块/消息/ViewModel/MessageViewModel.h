//
//  MessageViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

typedef NS_ENUM(NSInteger,MessageViewModel_Signal_Type)
{
    MineViewModel_Signal_Type_GotoSystemMsg = 0,
    MineViewModel_Signal_Type_GotoCouponMsg,
    MineViewModel_Signal_Type_GotoScoreMsg,
    MineViewModel_Signal_Type_GotoOrderMsg
};

@interface MessageViewModel : LYBaseViewModel

- (NSInteger)numberOfSections;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
