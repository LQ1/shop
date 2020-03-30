//
//  GroupBuyProgressViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GroupBuyProgressViewController.h"

#import "JavaScriptInterface.h"

@interface GroupBuyProgressViewController ()

@end

@implementation GroupBuyProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self bindSignal];
}

- (void)bindSignal
{
    @weakify(self);
    [[[JavaScriptInterface sharedInstance].noPramPushSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        switch ([x integerValue]) {
            case JSPushType_HomePage:
            {
                // 跳转首页
                [self.navigationController popToRootViewControllerAnimated:YES];
                [[[RACSignal interval:.66 onScheduler:[RACScheduler currentScheduler]] take:1] subscribeNext:^(id x) {
                    [LYAppDelegate.tabBarController changeToTab:ClassTableBarType_HomePage];
                }];
            }
                break;
            case JSPushType_HelpGroupBuy:
            {
                // 邀请好友拼团
                if (self.inviteFriendsBlock) {
                    self.inviteFriendsBlock();
                }
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
