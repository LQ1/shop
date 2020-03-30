//
//  CustomCell.h
//  integralMall
//
//  Created by liu on 2018/12/30.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityModel.h"
#import "ImageLoadingUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomCell : UITableViewCell{
    CustomInfoListModel *_data;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblWx;
@property (weak, nonatomic) IBOutlet UIView *containerView;

- (void)loadData:(CustomInfoListModel*)data;

@end

NS_ASSUME_NONNULL_END
