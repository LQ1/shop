//
//  CustomCell.m
//  integralMall
//
//  Created by liu on 2018/12/30.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization codelblPhone
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self.lblPhone) {
        [self gesture_detail_onClicked:nil];
    }else if(view == self.lblWx){
        [self gesture_copywx_onClicked:nil];
    }
    return nil;
}

- (void)loadData:(CustomInfoListModel*)data{
    _data = data;
    [ImageLoadingUtils loadImage:self.imgHeader withURL:data.headImg];
    self.lblName.text = [NSString stringWithFormat:@"姓名:%@",data.name];
    self.lblPhone.text = [NSString stringWithFormat:@"电话:%@",data.phone];
    self.lblWx.text = [NSString stringWithFormat:@"微信:%@",data.wechat];
    //self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gesture_detail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_detail_onClicked:)];
    self.lblPhone.userInteractionEnabled = YES;
    [self.lblPhone addGestureRecognizer:gesture_detail];

    UITapGestureRecognizer *gesture_copywx = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_copywx_onClicked:)];
    self.lblWx.userInteractionEnabled = YES;
    [self.lblWx addGestureRecognizer:gesture_copywx];
}

//拔打电话
- (void)gesture_detail_onClicked:(id)sender{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_data.phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[self getViewCtrl].view addSubview:callWebview];
}

//复制微信
- (void)gesture_copywx_onClicked:(id)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _data.wechat;
    [DLLoading DLToolTipInWindow:@"微信号已复制到剪切板"];
}

- (UITableView*)tabView{
    UIView *tableView = self.superview;
    
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

- (UIViewController*)getViewCtrl{
    UIResponder *responder = self.nextResponder;
    while (nil != (responder = responder.nextResponder)) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)responder;
        }
    }
    return nil;
}
@end
