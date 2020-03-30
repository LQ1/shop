//
//  PersonalMessageViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PersonalMessageViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "PersonalMessageView.h"
#import "PersonalMessageViewModel.h"

#import "ModifiMessageViewController.h"

#import "BRPickerView.h"

#define SelfViewModel ((PersonalMessageViewModel *)self.viewModel)

@interface PersonalMessageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation PersonalMessageViewController

- (void)viewDidLoad
{
    self.viewModel = [PersonalMessageViewModel new];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    // 导航
    self.navigationBarView.titleLabel.text = @"个人信息";
    // mainView
    self.mainView = [PersonalMessageView new];
    [self.view addSubview:self.mainView];
    [self nearByNavigationBarView:self.mainView isShowBottom:NO];
}

- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case PersonalMessageViewModelSignalType_ClickHeader:
            {
                // 头像
                [self headerClick];
            }
                break;
            case PersonalMessageViewModelSignalType_ClickNick:
            {
                // 昵称
                [self nickClick];
            }
                break;
            case PersonalMessageViewModelSignalType_ClickSex:
            {
                // 性别
                [self sexClick];
            }
                break;
            case PersonalMessageViewModelSignalType_ClickBirthDay:
            {
                // 出生日期
                [self birthDayClick];
            }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark -更换头像
// 点击头像修改
- (void)headerClick
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheet showInView:self.view];
    @weakify(self);
    [sheet.rac_buttonClickedSignal subscribeNext:^(id x) {
        @strongify(self);
        [self gotoCameraWithClick:[x integerValue]];
    }];
}
// 跳转相机
- (void)gotoCameraWithClick:(NSInteger)index
{
    if (index == 2) {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    if (index == 0) {
        // 拍照
#if !TARGET_IPHONE_SIMULATOR
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return;
        }
        if (![self hasAppCameraPermission]) {
            return;
        }
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
#else
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#endif
    }
    else {
        // 相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:picker animated:YES completion:nil];
}
// 判断app是否有相机权限
- (BOOL)hasAppCameraPermission
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        //弹出打开用户相机权限的提示
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        // Attempt to find a name for this application
        NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        if (!appName) {
            appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
        }
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-相机”中，允许%@访问你的相机",appName] delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
        [al show];
        return NO;
    }
    return YES;
}
// 获取照片成功
- (void)pickMediaWithInfo:(NSMutableDictionary *)mediaInfo
{
    UIImage *image = [mediaInfo objectForKey:UIImagePickerControllerEditedImage];
    CGSize imageSize = CGSizeMake(image.size.width,image.size.height);
    UIImage *sendImg = [CommUtls image:image fitInsize:imageSize];
    // 开始上传照片
    [DLLoading DLLoadingInWindow:@"正在上传头像..." close:nil];
    @weakify(self);
    [[PublicEventManager shareInstance] uploadImages:@[sendImg]
                                            complete:^(NSArray *imgUrls) {
                                                @strongify(self);
                                                [SelfViewModel updateUserInfoField_name:@"avatar"
                                                                 field_value:imgUrls.linq_firstOrNil];
                                            } fail:^(NSString *msg) {
                                                [DLLoading DLToolTipInWindow:msg];
                                            }];
}

#pragma mark -imagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSMutableDictionary *mediaInfo = [[NSMutableDictionary alloc] initWithDictionary:info];
    [self performSelector:@selector(pickMediaWithInfo:) withObject:mediaInfo afterDelay:0.0f];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -修改昵称
- (void)nickClick
{
    @weakify(self);
    ModifiMessageViewController *vc = [[ModifiMessageViewController alloc] initWithNavTitle:@"修改昵称" oldText:SignInUser.nickName inputTip:@"昵称请保持在1-10个字之间" saveClickBlock:^(NSString *text) {
        @strongify(self);
        [SelfViewModel updateUserInfoField_name:@"nickname"
                                    field_value:text];

    }];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -更换性别
- (void)sexClick
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"男",@"女", nil];
    [sheet showInView:self.view];
    @weakify(self);
    [sheet.rac_buttonClickedSignal subscribeNext:^(id x) {
        @strongify(self);
        if ([x integerValue]<2) {
            NSString *sexStr = [x integerValue]==0?@"1":@"0";
            [SelfViewModel updateUserInfoField_name:@"sex"
                                        field_value:sexStr];
        }
    }];
}

#pragma mark -修改出生日期
- (void)birthDayClick
{
    @weakify(self);
    [BRDatePickerView showDatePickerWithTitle:@"出生日期"
                                     dateType:UIDatePickerModeDate
                              defaultSelValue:nil
                                   minDateStr:nil
                                   maxDateStr:nil
                                 isAutoSelect:NO
                                  resultBlock:^(NSString *selectValue) {
                                      @strongify(self);
                                      [SelfViewModel updateUserInfoField_name:@"birthday"
                                                                  field_value:[CommUtls encodeTime:[CommUtls dencodeTime:selectValue format:@"yyyy-MM-dd"]]];
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
