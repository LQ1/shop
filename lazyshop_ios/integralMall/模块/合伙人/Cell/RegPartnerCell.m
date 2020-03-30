//
//  RegPartnerCell.m
//  integralMall
//
//  Created by liu on 2018/10/9.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "RegPartnerCell.h"

@implementation RegPartnerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imgChk = [UIImage imageNamed:@"默认地址选中.png"];
    _imgUnChk = [UIImage imageNamed:@"未勾选.png"];
    
    [self initEvent];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initEvent{
    UITapGestureRecognizer *gestureA = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_selected:)];
    self.viewA.userInteractionEnabled = YES;
    [self.viewA addGestureRecognizer:gestureA];
    
    UITapGestureRecognizer *gestureB = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_selected:)];
    self.viewB.userInteractionEnabled = YES;
    [self.viewB addGestureRecognizer:gestureB];
    
    UITapGestureRecognizer *gestureC = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_selected:)];
    self.viewC.userInteractionEnabled = YES;
    [self.viewC addGestureRecognizer:gestureC];
    
    UITapGestureRecognizer *gestureD = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_selected:)];
    self.viewD.userInteractionEnabled = YES;
    [self.viewD addGestureRecognizer:gestureD];
}

- (void)gesture_selected:(UITapGestureRecognizer*)sender{
    UIImageView *imgA = [self.viewA.subviews objectAtIndex:0];
    UIImageView *imgB = [self.viewB.subviews objectAtIndex:0];
    UIImageView *imgC = [self.viewC.subviews objectAtIndex:0];
    UIImageView *imgD = [self.viewD.subviews objectAtIndex:0];
    imgA.image = imgB.image = imgC.image = imgD.image = _imgUnChk;
    
    UIImageView *img = [sender.view.subviews objectAtIndex:0];
    img.image = _imgChk;
    _data.option_id = (int)sender.view.tag;
    if (_onItemClicked) {
        _onItemClicked();
    }
}

- (void)loadData:(JoinPartnerQuestion*)data withBlockItemClicked:(void (^)())onItemClicked{
    _data = data;
    _onItemClicked = onItemClicked;
    
    self.lblQuestNo.text = [NSString stringWithFormat:@"问题%d",data.question_no];
    self.lblQuestionTitle.text = data.question_title;
    if (data.options) {
        if (data.options.count>0) {
            self.lblA.text = [NSString stringWithFormat:@"%@",[data.options objectAtIndex:0]];
        }
        if (data.options.count>1) {
            self.lblB.text = [NSString stringWithFormat:@"%@",[data.options objectAtIndex:1]];
        }
        if (data.options.count>2) {
            self.lblC.text = [NSString stringWithFormat:@"%@",[data.options objectAtIndex:2]];
        }
        if (data.options.count>3) {
            self.lblD.text = [NSString stringWithFormat:@"%@",[data.options objectAtIndex:3]];
        }
    }
    //默认选中
    NSDictionary *dctValue = @{@(1):self.viewA,@(2):self.viewB,@(3):self.viewC,@(4):self.viewD};
    UIView *viewCur = [dctValue objectForKey:[NSNumber numberWithInt:data.option_id]];
    UIImageView *img = [viewCur.subviews objectAtIndex:0];
    img.image = _imgChk;
    
}

@end
