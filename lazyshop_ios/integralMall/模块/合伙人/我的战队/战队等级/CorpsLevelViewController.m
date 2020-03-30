//
//  CorpsLevelViewController.m
//  integralMall
//
//  Created by liu on 2018/10/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "CorpsLevelViewController.h"

@interface CorpsLevelViewController ()

@end

@implementation CorpsLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"战队等级";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    self.lblNextCon.layer.cornerRadius = 10;
    self.lblNextCon.layer.masksToBounds = YES;
    _viewScrollArea = [[ViewPartnerScrollArea alloc] initWithParentView:self.viewPartner];
    self.webView.backgroundColor = [UIColor clearColor];
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_query) withObject:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    if (_viewScrollArea) {
        [_viewScrollArea startAnimationNotice];
    }
}

//查询
- (void)thread_query{
    PartnerLevelModel *model = [[DataViewModel getInstance] partnerLevel];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        
        if (model) {
            self.lblPartner.text = model.team_title;
            self.lblHasRecommend.text = [NSString stringWithFormat:@"已推荐合伙人:%d人",model.team_num];
            self.lblNextCon.text = model.next_level_text;
            [ImageLoadingUtils loadImage:self.imgTeam withURL:model.team_image];
            [self.webView loadHTMLString:model.team_content baseURL:nil];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

@end
