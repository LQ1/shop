//
//  DLBasePickerViewController.m
//  MobileClassPhone
//
//  Created by yangjie on 16/11/7.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import "DLBasePickerViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "DLEncodeUtil.h"
#import "ZYQAssetPickerController.h"
#import <DLUtls/CommUtls+Time.h>
#import <DLUtls/CommUtls+File.h>

@interface DLBasePickerViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate>
{
    void(^_imageArrayBlock)(NSMutableArray *);
}

/**
 *  获取到的图片数据
 */
@property (nonatomic,strong) NSMutableArray * imageDataArray;

/**
 *  照相时是否编辑照片
 */
@property (nonatomic,assign) BOOL allowsEditing;

/**
 *  设置最大获取推按张数
 */
@property (nonatomic,assign) NSInteger maxNumber;

/**
 *  设置图片最大占用空间
 */
@property (nonatomic,assign) CGFloat maxKb;

@end

@implementation DLBasePickerViewController

- (void)initWithTakePhoneActionSheet:(BOOL)allowsEditing
                           maxNumber:(NSInteger)maxNumber
                               maxKb:(CGFloat)maxKb{
    
    self.allowsEditing = allowsEditing;
    self.maxNumber = maxNumber;
    self.maxKb = maxKb;
    
    //清除缓存
    UIActionSheet * actionSheetView=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionSheetView showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//零是拍照
        [self XiangJiPaiZhao];
    } else if (buttonIndex == 1) {//1是相册选择
        [self XiTongXiangCe];
    }
}

/**
 *  获取相机照相图片
 */
- (void)initWithTakePhoneCamera:(BOOL)allowsEditing
                      maxNumber:(NSInteger)maxNumber
                          maxKb:(CGFloat)maxKb{
    self.allowsEditing = allowsEditing;
    self.maxNumber = maxNumber;
    self.maxKb = maxKb;
    
    [self XiangJiPaiZhao];
}

/**
 *  获取手机相册照片
 */
- (void)initWithTakePhoneAlbum:(NSInteger)maxNumber
                         maxKb:(CGFloat)maxKb{
    self.maxNumber = maxNumber;
    self.maxKb = maxKb;
    
    [self XiTongXiangCe];
}

#pragma mark - 获取照片 -- ZYQAssetPickerController
- (void)XiTongXiangCe{
    
    self.imageDataArray = [[NSMutableArray alloc]init];
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = self.maxNumber;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings)
                              {
                                  if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
                                  {
                                      NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                                      
                                      return duration >= 5;
                                  } else {
                                      return YES;
                                  }
                              }];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker{
    
    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"最多可选择 %ld 照片", (long)self.maxNumber] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - ZYQAssetPickerController Delegate
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    [self setImageMethod:assets];
}

#pragma mark - 返回获取的照片
- (void)setImageArrayBlock:(void(^)(NSMutableArray * imageArray))imageArrayBlock{
    _imageArrayBlock = imageArrayBlock;
}

- (void)setImageMethod:(NSArray *)imageDataArray{
    
    for (int i = 0; i < imageDataArray.count; i++) {
        ALAsset *asset = imageDataArray[i];
        UIImage *baseImage = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
        //压缩照片处理
        UIImage * tempImage = [self compressImage:baseImage PixelCompress:YES MaxPixel:[UIScreen mainScreen].bounds.size.width JPEGCompress:YES MaxSize_KB:self.maxKb];
        [self.imageDataArray addObject:baseImage];
    }
    
    if (_imageArrayBlock) {
        _imageArrayBlock(self.imageDataArray);
    }
}

#pragma mark - 获取相机照片处理
- (void)XiangJiPaiZhao{
    self.imageDataArray = [[NSMutableArray alloc]init];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = self.allowsEditing;//是否可编辑  （选择全图或者正方形的图）
    picker.delegate = self;
    
#if !TARGET_IPHONE_SIMULATOR
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    if (![self hasAppCameraPermission]) {
        return;
    }
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
#else
    [self XiTongXiangCe];
#endif
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSMutableDictionary *mediaInfo = [[NSMutableDictionary alloc] initWithDictionary:info];
    [self performSelector:@selector(pickMediaWithInfo:) withObject:mediaInfo afterDelay:0.0f];
}

- (void)pickMediaWithInfo:(NSMutableDictionary *)mediaInfo{
    UIImage *image;
    if (self.allowsEditing) {
        image = [mediaInfo objectForKey:UIImagePickerControllerEditedImage];
    } else {
        image = [mediaInfo objectForKey:UIImagePickerControllerOriginalImage];
    }
    UIImage * tempImage = [self compressImage:image PixelCompress:NO MaxPixel:640 JPEGCompress:YES MaxSize_KB:self.maxKb];
    
    self.imageDataArray = [NSMutableArray arrayWithObject:tempImage];
    
    if (_imageArrayBlock) {
        _imageArrayBlock(self.imageDataArray);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -判断app是否有相机权限
- (BOOL)hasAppCameraPermission{
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

#pragma mark - 压缩image
- (UIImage *)compressImage:(UIImage*)originImage
             PixelCompress:(BOOL)pc
                  MaxPixel:(CGFloat)maxPixel
              JPEGCompress:(BOOL)jc
                MaxSize_KB:(CGFloat)maxKB{
    /*
     压缩策略： 支持最多921600个像素点
     像素压缩：（调整像素点个数）
     当图片长宽比小于3:1 or 1:3时，图片长和宽最多为maxPixel像素；
     当图片长宽比在3:1 和 1:3之间时，会保证图片像素压缩到921600像素以内；
     JPEG压缩：（调整每个像素点的存储体积）
     默认压缩比0.99;
     如果压缩后的数据仍大于IMAGE_MAX_BYTES，那么将调整压缩比将图片压缩至IMAGE_MAX_BYTES以下。
     策略调整：
     不进行像素压缩，或者增大maxPixel，像素损失越小。
     使用无损压缩，或者增大IMAGE_MAX_BYTES.
     注意：
     jepg压缩比为0.99时，图像体积就能压缩到原来的0.40倍了。
     */
    UIImage * scopedImage = nil;
    
    if (originImage == nil) {
        return nil;
    }
    
    //像素压缩
    scopedImage = [self compressImagePixel:originImage isPc:pc maxPixel:maxPixel];
    
    //JPEG压缩
    scopedImage = [self compressImageJPEGRepresentation:originImage isJc:jc maxSize_KB:maxKB];
    
    return scopedImage;
    
}

//像素压缩
- (UIImage *)compressImagePixel:(UIImage *)scopedImage isPc:(BOOL)isPc maxPixel:(CGFloat)maxPixel{
    
    if (!isPc) {    //不进行像素压缩
        return scopedImage;
    } else {          //像素压缩
        // 像素数最多为maxPixel*maxPixel个
        CGFloat photoRatio = scopedImage.size.height / scopedImage.size.width;
        if ( photoRatio < 0.3333f ) {         //解决宽长图的问题
            CGFloat FinalWidth = sqrt ( maxPixel*maxPixel/photoRatio );
            scopedImage = [DLEncodeUtil convertImage:scopedImage scope:MAX(FinalWidth, maxPixel)];
        } else if ( photoRatio <= 3.0f ) {    //解决高长图问题
            scopedImage = [DLEncodeUtil convertImage:scopedImage scope: maxPixel];
        } else {                              //一般图片
            CGFloat FinalHeight = sqrt ( maxPixel*maxPixel*photoRatio );
            scopedImage = [DLEncodeUtil convertImage:scopedImage scope:MAX(FinalHeight, maxPixel)];
        }
        return scopedImage;
    }
}

//JPEG压缩
- (UIImage *)compressImageJPEGRepresentation:(UIImage *)scopedImage isJc:(BOOL)isJc maxSize_KB:(CGFloat)maxKB{
    
    NSData * data = nil;
    
    if (!isJc) {
        data = UIImageJPEGRepresentation(scopedImage, 1.0);
    } else {
        data = UIImageJPEGRepresentation(scopedImage, 1.0);
        if (maxKB < data.length/1024) {     //JPEG压缩
            int number = 1;
            while (maxKB < data.length/1024) {
                CGFloat scale = 1-number*0.1;
                if (scale <= 0) {
                    scale = 0.1;
                }
                data = UIImageJPEGRepresentation(scopedImage, scale);
                number ++;
                
                /*
                data = UIImageJPEGRepresentation(scopedImage, 1-number*0.1);
                number ++;
                if (number >= 7) {
                    return nil;
                }
                 */
            }
            //        NSLog(@"data compress with ratio (0.9) : %f MB", sqrt (data.length/1024));
        } else {
            data = UIImageJPEGRepresentation(scopedImage, 1.0);
            //        NSLog(@"data compress : %f MB", sqrt (data.length/1024));
        }
    }
    return [UIImage imageWithData:data];;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
 
 
 //#define HOME_FILE [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"home"]
 //#define DY_ASK_SUBMIT_IMAGE_TEMP [HOME_FILE stringByAppendingPathComponent:@"ImageTemp"]
 
 //    //创建存储图片和音频的文件夹
 //    NSFileManager *filemanager=[NSFileManager defaultManager];
 //    if (![filemanager fileExistsAtPath:DY_ASK_SUBMIT_IMAGE_TEMP]) {
 //        [filemanager createDirectoryAtPath:DY_ASK_SUBMIT_IMAGE_TEMP withIntermediateDirectories:YES attributes:nil error:nil];
 //        [CommUtls addSkipBackupAttributeToItemAtURL:[NSURL URLWithString:DY_ASK_SUBMIT_IMAGE_TEMP]];
 //    }
 
 //NSString * imageName=[[CommUtls encodeTime:[NSDate date] format:@"yyyyMMDDhhmmss"] stringByAppendingString:@".png"];
 //NSString * fullPath=[DY_ASK_SUBMIT_IMAGE_TEMP stringByAppendingPathComponent:imageName];
 //
 //if ([self saveImage:baseImage withName:imageName]) {
 //
 //}else{
 //
 //}
 ////将图片写入到沙河指定目录中，返回bool值
 //- (BOOL)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
 //{
 //    CGSize imageSize = CGSizeMake(currentImage.size.width,currentImage.size.height);
 //    UIImage * image=[CommUtls image:currentImage fitInsize:imageSize];
 //
 //    NSData * imageData = UIImageJPEGRepresentation(image, 1.0);
 //
 //    if (imageData == nil) {
 //        [DLLoading DLToolTipInWindow:@"获取照片失败"];
 //        return NO;
 //    }
 //
 //    NSString * fullPath=[DY_ASK_SUBMIT_IMAGE_TEMP stringByAppendingPathComponent:imageName];
 //    return [imageData writeToFile:fullPath atomically:NO];
 //}
 
*/

@end
