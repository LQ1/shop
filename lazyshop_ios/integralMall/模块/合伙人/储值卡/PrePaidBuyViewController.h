//
//  PrePaidBuyViewController.h
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePartnerViewController.h"
#import "ViewPartnerScrollArea.h"

NS_ASSUME_NONNULL_BEGIN

@interface PrePaidBuyViewController : BasePartnerViewController{
    int _nPageNum;
    NSMutableArray *_arrayDatas;
    ViewPartnerScrollArea *_viewScrollArea;
}
@property (weak, nonatomic) IBOutlet UIView *viewPartner;
@property (weak, nonatomic) IBOutlet UICollectionView *cvStoragecard;

@end

NS_ASSUME_NONNULL_END
