//
//  RegPartnerViewController.m
//  integralMall
//
//  Created by liu on 2018/10/9.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "RegPartnerViewController.h"
#import "RegPartnerTableViewController.h"

@interface RegPartnerViewController ()

@end

@implementation RegPartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initControl];
}

- (void)initControl{
    self.navigationBarView.titleLabel.text = @"注册";
    //self.navigationBarView.navagationBarStyle = Left_right_button_show;
    
    UITableView *tableView = [self.viewContainer.subviews objectAtIndex:0];
    RegPartnerTableViewController *regPartnerTabViewCtrl = (RegPartnerTableViewController*)tableView.dataSource;
    regPartnerTabViewCtrl.propertyRefUsrId = self.propertyRefUsrId;
    regPartnerTabViewCtrl.propertyRegPartnerViewCtrl = self;
}


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (IBAction)btnNext:(id)sender {
}
@end
