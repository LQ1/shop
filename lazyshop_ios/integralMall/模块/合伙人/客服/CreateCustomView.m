//
//  CreateCustomView.m
//  integralMall
//
//  Created by liu on 2018/12/30.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import "CreateCustomView.h"
#import "UIColor+YYAdd.h"
#import "DataViewModel.h"
#import "Utility.h"

@implementation CreateCustomView

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *view = [super hitTest:point withEvent:event];
    CGPoint ptCustom = [_imgCustom convertPoint:point fromView:self];
    if ([_imgCustom pointInside:ptCustom withEvent:event]) {
        return _imgCustom;
    }
    if (_tableView) {
        CGPoint ptTabView = [_tableView convertPoint:point fromView:self];
        if ([_tableView pointInside:ptTabView withEvent:event]) {
            return _tableView;
        }
    }
    
    if (_isShowing) {
        _isShowing = NO;
        [_tableView removeFromSuperview];
        _tableView = nil;
    }
    
    return view;
}

- (void)initView:(UIView*)viewParent{

    _viewParent = viewParent;
    
    CGRect rc = {0};
    rc.size.width = rc.size.height = 48;
    rc.origin.x = KScreenWidth - rc.size.width - 16;
    rc.origin.y = KScreenHeight - rc.size.height - 100;
    _imgCustom = [[UIImageView alloc] initWithFrame:rc];
    _imgCustom.image = [UIImage imageNamed:@"客服.png"];
    _imgCustom.layer.cornerRadius = rc.size.width*0.5f;
    _imgCustom.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *gesture_custom = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_custom_onClicked:)];
    _imgCustom.userInteractionEnabled = YES;
    [_imgCustom addGestureRecognizer:gesture_custom];
    
    [self addSubview:_imgCustom];
    //查询客服列表
    [self performSelectorInBackground:@selector(thread_queryCustom) withObject:nil];
}

- (void)createTableView{
    
    CGRect rc = {0};
    rc.size.width = 217;
    rc.size.height = 270;
    rc.origin.x = KScreenWidth - rc.size.width - 16;
    rc.origin.y = _imgCustom.frame.origin.y - rc.size.height;
    _tableView = [[UITableView alloc] initWithFrame:rc];
    _tableView.layer.borderColor = [UIColor colorWithHexString:@"#F4F5F6"].CGColor;
    _tableView.layer.borderWidth = 1.0f;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [Utility setExtraCellLineHidden:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CustomCell class])];
    [self addSubview:_tableView];
    
    if (nil == customInfos || customInfos.service_list == nil) {
        //查询客服列表
        [self performSelectorInBackground:@selector(thread_queryCustom) withObject:nil];
    }
    
    _isShowing = YES;
}

//客服头像点击
- (void)gesture_custom_onClicked:(id)sender{
    if (_isShowing) {
        [_tableView removeFromSuperview];
        _tableView = nil;
        _isShowing = NO;
    }else{
        [self createTableView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!customInfos) {
        return 0;
    }
    return customInfos.service_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 91;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomInfoListModel *model = [customInfos.service_list objectAtIndex:indexPath.row];
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomCell class])];
    [cell loadData:model];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


//查询客服
- (void)thread_queryCustom{
    if (!customInfos) {
        customInfos = [[DataViewModel getInstance] customerList];
        dispatch_async(dispatch_get_main_queue(), ^{
           [ImageLoadingUtils loadImage:_imgCustom withURL:customInfos.service_img];
            [_tableView reloadData];
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
             [ImageLoadingUtils loadImage:_imgCustom withURL:customInfos.service_img];
        });
    }
}

@end
