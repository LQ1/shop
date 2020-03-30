//
//  ModifiMessageViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ModifiMessageViewController.h"

@interface ModifiMessageViewController ()

@property (nonatomic,copy)NSString *navTitle;
@property (nonatomic,copy)NSString *oldText;
@property (nonatomic,copy)NSString *inputTip;

@property (nonatomic,strong)UITextField *inputView;
@property (nonatomic,copy)saveClickBlock saveBlock;

@end

@implementation ModifiMessageViewController

- (instancetype)initWithNavTitle:(NSString *)navTitle
                         oldText:(NSString *)oldText
                        inputTip:(NSString *)inputTip
                  saveClickBlock:(saveClickBlock)block
{
    self = [super init];
    if (self) {
        self.navTitle = navTitle;
        self.oldText = oldText;
        self.inputTip = inputTip;
        self.saveBlock = block;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViews];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = self.navTitle;
    self.navigationBarView.navagationBarStyle = Left_right_button_show;
    self.navigationBarView.rightLabel.text = @"保存";
    // 背景
    self.view.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    // 输入框
    UIView *inputContent = [UIView new];
    inputContent.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputContent];
    [inputContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navigationBarView.bottom).offset(12.5);
        make.height.mas_equalTo(50);
    }];
    
    UITextField *inputView = [UITextField new];
    self.inputView = inputView;
    inputView.text = self.oldText;
    inputView.textColor = [CommUtls colorWithHexString:@"#999999"];
    [inputContent addSubview:inputView];
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.5);
        make.right.mas_equalTo(-12.5);
        make.top.bottom.mas_equalTo(0);
    }];
    // 提示
    UILabel *tipLabel = [self.view addLabelWithFontSize:SMALL_FONT_SIZE
                                          textAlignment:0
                                              textColor:@"#000000"
                                           adjustsWidth:NO
                                           cornerRadius:0
                                                   text:self.inputTip];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.5);
        make.top.mas_equalTo(self.inputView.bottom).offset(10);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.inputView becomeFirstResponder];
}

- (void)rightButtonClick
{
    if (!self.inputView.text.length) {
        [DLLoading DLToolTipInWindow:@"未输入"];
        return;
    }else{
        if (self.saveBlock) {
            self.saveBlock(self.inputView.text);
        }
        if (self.inputView.isEditing) {
            [self.inputView resignFirstResponder];
            [[[RACSignal interval:.67 onScheduler:[RACScheduler currentScheduler]] take:1] subscribeNext:^(id x) {
                [super leftButtonClick];
            }];
        }else{
            [super leftButtonClick];
        }
    }
}

- (void)leftButtonClick
{
    if (self.inputView.isEditing) {
        [self.inputView resignFirstResponder];
        [[[RACSignal interval:.67 onScheduler:[RACScheduler currentScheduler]] take:1] subscribeNext:^(id x) {
            [super leftButtonClick];
        }];
    }else{
        [super leftButtonClick];
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
