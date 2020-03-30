//
//  AboutUsViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "AboutUsViewController.h"

#import "LYMainColorButton.h"

#import "CheckUpdateManager.h"

@interface AboutUsViewController ()

@property (nonatomic, strong) UILabel *checkUpdateLabel;

@end

@implementation AboutUsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViews];
}

#pragma mark -ui
- (void)addViews
{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *display_Name = [infoDict objectForKey:@"CFBundleDisplayName"];
    NSString *app_Version = [infoDict objectForKey:@"CFBundleShortVersionString"];

    // 背景
    self.view.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    // 导航
    self.navigationBarView.titleLabel.text = [NSString stringWithFormat:@"关于%@",display_Name];
    
    // logo
    UIImage *logoImage = [UIImage imageNamed:@"about_us_logo"];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:logoImage];
    [self.view addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.bottom).offset(68);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(logoImage.size.width);
        make.height.mas_equalTo(logoImage.size.height);
    }];
    // 版本
    UILabel *versionLabel = [self.view addLabelWithFontSize:MIDDLE_FONT_SIZE
                                              textAlignment:NSTextAlignmentCenter
                                                  textColor:@"#000000"
                                               adjustsWidth:NO
                                               cornerRadius:0
                                                       text:nil];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoView.bottom).offset(13.5);
        make.centerX.mas_equalTo(logoView);
    }];
    NSString *verTipStr = [@"V" stringByAppendingString:app_Version];
    NSString *verAllStr = [display_Name stringByAppendingString:verTipStr];
    versionLabel.attributedText = [CommUtls changeText:verTipStr
                                               content:verAllStr
                                        changeTextFont:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                              textFont:[UIFont boldSystemFontOfSize:MAX_LARGE_FONT_SIZE]
                                       changeTextColor:[CommUtls colorWithHexString:@"#000000"]
                                             textColor:[CommUtls colorWithHexString:@"#000000"]];
    // slogan
    LYMainColorButton *sloganBtn = [[LYMainColorButton alloc] initWithTitle:[NSString stringWithFormat:@"上%@乐享精彩生活",display_Name]
                                                             buttonFontSize:SMALL_FONT_SIZE
                                                               cornerRadius:12.5];
    [self.view addSubview:sloganBtn];
    [sloganBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(25);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(versionLabel.bottom).offset(18);
    }];
    // 检查更新
    UIView *checkUpdateView = [UIView new];
    checkUpdateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:checkUpdateView];
    [checkUpdateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(sloganBtn.bottom).offset(iPhone4?30:68);
    }];
    //
    UILabel *titleLabel = [checkUpdateView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                   textAlignment:0
                                       textColor:@"#000000"
                                    adjustsWidth:NO
                                    cornerRadius:0
                                            text:@"检查更新"];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(checkUpdateView);
    }];
    //
    UIImage *rightArrowImage = [UIImage imageNamed:@"编辑收货地址箭头"];
    UIImageView *rightArrowView = [[UIImageView alloc] initWithImage:rightArrowImage];
    [checkUpdateView addSubview:rightArrowView];
    [rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(checkUpdateView);
        make.width.mas_equalTo(rightArrowImage.size.width);
        make.height.mas_equalTo(rightArrowImage.size.height);
    }];
    //
    UILabel *checkUpdateLabel = [checkUpdateView addLabelWithFontSize:SMALL_FONT_SIZE
                                         textAlignment:NSTextAlignmentRight
                                             textColor:@"#666666"
                                          adjustsWidth:NO
                                          cornerRadius:0
                                                  text:[NSString stringWithFormat:@"V%@",app_Version]];
    self.checkUpdateLabel = checkUpdateLabel;
    [checkUpdateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightArrowView.left).offset(-12.5);
        make.centerY.mas_equalTo(checkUpdateView);
    }];
    //
    UIButton *clickBtn = [UIButton new];
    [checkUpdateView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [[CheckUpdateManager shareInstance] checkAppUpdateWithNoUpdate:^{
            @strongify(self);
            self.checkUpdateLabel.text = @"已是最新版本";
            clickBtn.enabled = NO;
        } loading:YES];
        return [RACSignal empty];
    }];
    // 审核时不显示检查更新
    if (![LYAppCheckManager shareInstance].isAppAgree) {
        checkUpdateView.hidden = YES;
    }
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
