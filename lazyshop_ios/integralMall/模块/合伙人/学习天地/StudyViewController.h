//
//  StudyViewController.h
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePartnerViewController.h"
#import "ViewPartnerScrollArea.h"

NS_ASSUME_NONNULL_BEGIN

@interface StudyViewController : BasePartnerViewController{
    NSMutableArray *_arrayDatas;
    ViewPartnerScrollArea *_viewScrollArea;
    int _nPageNum;
}
@property (weak, nonatomic) IBOutlet UIView *viewPartner;
@property (weak, nonatomic) IBOutlet UIImageView *imgKF;
@property (weak, nonatomic) IBOutlet UICollectionView *cvStudy;

@end

NS_ASSUME_NONNULL_END
