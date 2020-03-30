//
//  CreateCustomView.h
//  integralMall
//
//  Created by liu on 2018/12/30.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "EntityModel.h"

NS_ASSUME_NONNULL_BEGIN

static CustomInfoModel *customInfos;

@interface CreateCustomView : UIView<UITableViewDelegate,UITableViewDataSource>{
    UIView *_viewParent;
    BOOL _isShowing;
    UITableView *_tableView;
    UIImageView *_imgCustom;
}

- (void)initView:(UIView*)viewParent;

@end

NS_ASSUME_NONNULL_END
