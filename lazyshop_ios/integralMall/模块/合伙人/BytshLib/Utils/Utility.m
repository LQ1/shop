//
//  Utility.m
//  EcologicalMgr
//
//  Created by haitao liu on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"
#import <CommonCrypto/CommonDigest.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/////////////////////////////////////
@implementation FixTableViewCellSub

@synthesize szSubDesc = _szSubDesc;
@synthesize enumType = _enumType;

@end

/////////////////////////////////////
@implementation FixTableViewCell

@synthesize img = _img;
@synthesize szDesc = _szDesc;
@synthesize arrayRows = _arrayRows;
@synthesize enumType = _enumType;
@synthesize obj = _obj;
@synthesize obj1 = _obj1;
@synthesize obj2 = _obj2;

- (id)init{
    self = [super init];
    self.arrayRows = [[NSMutableArray alloc] init];
    return self;
}

- (void)addSubRow:(NSString *)szRowDesc withMenuType:(SettingTypeEnum)settingEnum{
    FixTableViewCellSub *fixSub = [[FixTableViewCellSub alloc] init];
    fixSub.szSubDesc = szRowDesc;
    fixSub.enumType = settingEnum;
    [self.arrayRows addObject:fixSub];
}

@end

@implementation Utility

//method
+ (void)showMessage:(NSString*)szContent{
    UIAlertView *pAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:szContent delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [pAlertView show];
}

//获取 字体
+ (UIFont*)getDefaultFont{
    return [UIFont fontWithName:@"Arial" size:14.0];
}

+ (NSString*)getGuid{
    CFUUIDRef uid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *szGuid = (__bridge NSString*)CFUUIDCreateString(nil,uid);
    CFRelease(uid);
    return szGuid;
}

////计算TableView应显示的行数 多加载5条
+ (NSInteger)getPageSize:(CGFloat)fHeight withRowHeight:(CGFloat)rowHeight
{
    if (rowHeight == -1) {
        rowHeight = 44;//ios 8.1下UITableView.rowHeight=-1;
    }
    if (rowHeight != 0) {
        return fHeight/rowHeight + 5;
    }
    return 0;
}

//复制 字节
+ (void)bytesToBytes:(Byte *)destBytes withDestStart:(int)iDestStart withSourceBytes:(Byte *)sourceBytes withSourceStart:(int)iSourceStart withSourceCopyLen:(int)iSourceCopyLen{
    for (int i = 0; i<iSourceCopyLen; i++) {
        destBytes[i+iDestStart] = sourceBytes[i + iSourceStart];
    }
}

//获取文件扩展名，不包括 .
+ (NSString*)getFileExtends:(NSString*)szFileName{
    NSString *szRet= @"";
    if (szFileName) {
        NSArray *pArr = [szFileName componentsSeparatedByString:@"."];
        if (pArr.count > 0) {
            szRet = [pArr objectAtIndex:pArr.count - 1];
        }
    }
    return szRet;
}


+ (NSInteger)getScreenHeight{
    CGRect rect = [UIScreen mainScreen].applicationFrame;
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7) {
        rect = [UIScreen mainScreen].bounds;
    }
    return rect.size.height;
}

+ (NSInteger)getScreenWidth{
    CGRect rect = [UIScreen mainScreen].bounds;
    //UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    return rect.size.width;
}

//系统状态栏高度  如果是ios7系统，默认没有状态栏高度为0,此强制设置为20
+ (NSInteger)getStateBarHeight{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7) {
        CGRect rc = [[UIApplication sharedApplication] statusBarFrame];
        return rc.size.height;
    }
    return 0;
}

//屏幕 高度 去除状态栏
+ (NSInteger)getScreenHeightStateBar{
    return [Utility getScreenHeight] - [Utility getStateBarHeight];
}

//程序版本号
+ (NSString*)getAppVersion{
    NSDictionary *dctInfo = [[NSBundle mainBundle] infoDictionary];
    return [dctInfo objectForKey:@"CFBundleVersion"];
}

//系统信息
+ (NSString*)getDeviceInfo{
    NSString *szDevice = @"{";
    UIDevice *device = [[UIDevice alloc] init];
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [UIScreen mainScreen].scale;
    int fWidth = rect.size.width * scale;
    int fHeight = rect.size.height * scale;
    szDevice = [szDevice stringByAppendingFormat:@"\"name\":\"%@\",",device.name];
    szDevice = [szDevice stringByAppendingFormat:@"\"type\":\"%@\",",device.localizedModel];
    szDevice = [szDevice stringByAppendingFormat:@"\"systemName\":\"%@\",",device.systemName];
    szDevice = [szDevice stringByAppendingFormat:@"\"systemVersion\":\"%@\",",device.systemVersion];
    szDevice = [szDevice stringByAppendingFormat:@"\"screen\":\"%d*%d\"",fWidth,fHeight];
    
    szDevice = [szDevice stringByAppendingString:@"}"];
    return szDevice;
}

+ (UIColor*)getBarSelectedColor
{
    //R   	0.0440406948
    //G	0.809370995
    //B 	0.172950551
    UIColor *color = [UIColor colorWithRed:26/255.0f green:123/255.0f blue:222/255.0f alpha:1];//[[UIColor alloc] initWithRed:0.0440406948 green:0.809370995 blue:0.172950551 alpha:1];
    return color;
}

+ (UIColor*)getBarNoSelectedColor
{
    return [UIColor whiteColor];
}

/*
 *替换控件 
 */
+ (void)replaceController:(UIViewController *)viewController oldViewController:(UIViewController*)oldController newController:(UIViewController *)newController
{
    [viewController addChildViewController:newController];
    [viewController transitionFromViewController:oldController toViewController:newController duration:2.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished)
     {
         if(finished)
         {
             [newController didMoveToParentViewController:viewController];
             [oldController willMoveToParentViewController:nil];
             [oldController removeFromParentViewController];
         }
     }];
}

+ (UITableViewCell*)getUITableViewCell:(Class)classCell withOwner:(id)owner{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(classCell) owner:owner options:nil];
    return [array lastObject];
}


+ (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    /*
     当tableview的dataSource为空时，也就是没有数据可显示时，该方法无效，只能在numberOfRowsInsection函数，通过判断dataSouce的数据个数，如果为零可以将tableview的
     
     separatorStyle设置为UITableViewCellSeparatorStyleNone去掉分割线，然后在大于零时将其设置为
     
     UITableViewCellSeparatorStyleSingleLine
     */
}

//隐藏键盘，只能是在主线程中使用。
+ (void)hiddenKeyboard:(UIView *)view
{
    NSArray *array = view.subviews;
    for (UIView *sView in array) {
        if ([sView isKindOfClass:[UITextField class]]) {
            UITextField *txt = (UITextField*)sView;
            if (txt.isEditing) {
                [txt resignFirstResponder];
                return;
            }
        }
        else {
            if (sView.subviews.count != 0) {
                [self hiddenKeyboard:sView];
            }
        }
    }
}

+ (BOOL)isVersion7Plus
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version >= 7;
}

+ (long)getFileSize:(NSString *)szFileFullPath{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if ([fileMgr fileExistsAtPath:szFileFullPath]) {
        NSDictionary *attribute = [fileMgr attributesOfItemAtPath:szFileFullPath error:nil];
        return [[attribute objectForKey:NSFileSize] longValue];
    }
    return 0;
}

//本地Document路径
+ (NSString*)getLocalDocumentDir
{
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *szDocDir = [arrayPaths objectAtIndex:0];
    return  szDocDir;
}

//获取程序document文件夹路径
+ (NSString*)getDocumentDir{
    NSArray *pArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [pArr objectAtIndex:0];
}


//创建文件夹
+ (void)createDir:(NSString *)szDir
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if (![fileMgr fileExistsAtPath:szDir isDirectory:&isDir]) {
        [fileMgr createDirectoryAtPath:szDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

//删除文件
+ (BOOL)deleteFile:(NSString *)szPath
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSError *error;
    [fileMgr removeItemAtPath:szPath error:&error];
    if (error) {
        [Utility showMessage:error.description];
        return NO;
    }
    return YES;
}

//下载文件路径
+ (NSString*)getDownloadsDir
{
    NSString *szDoc = [self getLocalDocumentDir];
    NSString *szColl = [szDoc stringByAppendingString:@"/Downloads"];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if(![fileMgr fileExistsAtPath:szColl isDirectory:&isDir])
    {
        [fileMgr createDirectoryAtPath:szColl withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return szColl;
}

+ (BOOL)fileIsExist:(NSString *)szPath
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    return [fileMgr fileExistsAtPath:szPath];
}

//获取可作为文件名的本地时间
+ (NSString*)getLocalDateForFileName
{
    NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
    [dtFormat setDateFormat:@"yyyy-MM-dd hh-mm-ss"];
    return [dtFormat stringFromDate:[NSDate date]];
}

//16进制字符串转成颜色
+ (UIColor *)getColor:(NSString*)hexColor withAlpha:(CGFloat)fAlpha
{
    if ([hexColor hasPrefix:@"#"]) {
        hexColor = [hexColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
    }
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location = 2;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location = 4;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:fAlpha];
}

//由集合与枚举类型获取CELL
+ (FixTableViewCell*)getFixCellFromEnum:(NSMutableArray*)arrayFixCells withTypeEnum:(NSInteger)typeEnum
{
    for (FixTableViewCell *fixCell in arrayFixCells) {
        if (fixCell.enumType == typeEnum) {
            return fixCell;
        }
    }
    return nil;
}

//由视频文件路径获取视频缓存
+ (UIImage*)getVideoThumbnailImage:(NSString*)szVideoPath
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:szVideoPath] options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generate.appliesPreferredTrackTransform = YES;
    NSError *error = NULL;
    CMTime time = CMTimeMake(1, 2);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:imgRef];
    return img;
}

+ (NSString*)getFileNameByFilePath:(NSString *)szFileFullPath withContainExt:(BOOL)isContainExt
{
    if (szFileFullPath && ![szFileFullPath isEqualToString:@""]) {
       NSArray *arrays = [szFileFullPath componentsSeparatedByString:@"/"];
        NSString *szFName = [arrays objectAtIndex:arrays.count - 1];
        if (!isContainExt) {
            szFName = [self getFileNameByFileExpName:szFName];
        }
        return szFName;
    }
    return @"";
}

//由纯文件名去除文件扩展名
+ (NSString*)getFileNameByFileExpName:(NSString*)szFileNameExt
{
    NSString *szExt = [self getFileExtends:szFileNameExt];
    NSString *szRet = [szFileNameExt stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",szExt] withString:@""];
    
    return szRet;
}

+ (NSString*)getDateFromDateTime:(NSString *)szDtTime
{
    NSString *szRet = @"";
    if (szDtTime) {
        NSArray *array = [szDtTime componentsSeparatedByString:@" "];
        if (array.count>0) {
            szRet = [array objectAtIndex:0];
        }
    }
    return szRet;
}

+ (UIColor*)getTitleBarColor{
    //ED6D00
    //return [UIColor colorWithRed:57/255.0f green:141/255.0f blue:227/255.0f alpha:1.0f];
    return [UIColor colorWithRed:0xED/255.0f green:0x6D/255.0f blue:0/255.0f alpha:1.0f];//s标题栏主色调
}

//TableView 高度默认42
+ (int)getTableViewCellHeight{
    return 42;
}

//获取图片的UIColor
+ (UIColor*)getImgColorByImgName:(NSString *)szImgName{
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:szImgName]];
    return color;
}

//设置圆角头像
+ (void)setCircleImage:(UIImageView *)imgView{
    [self setCircleImage:imgView withColor:[UIColor whiteColor]];
}

+ (void)setCircleImage:(UIImageView *)imgView withColor:(UIColor*)color{
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = imgView.bounds.size.width*.5;
    imgView.layer.borderWidth = 2.0;
    imgView.layer.borderColor = color.CGColor;
}



+ (void)setCircleImageNoBorder:(UIImageView*)imgView{
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = imgView.bounds.size.width*.5;
    imgView.layer.borderWidth = 0.0;
    imgView.layer.borderColor = [UIColor whiteColor].CGColor;
}

//设置一个View为圆形
+ (void)setCircleView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = view.bounds.size.width*.5;
    view.layer.borderWidth = 0;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
}

+ (CGRect)getFontSize:(NSString*)szStr withCGSize:(CGSize)size withFont:(UIFont*)font{
    CGRect rect = [szStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return rect;
}

+ (BOOL)stringContainSubStr:(NSString*)szStr withSubStr:(NSString*)szSubStr{
    if (szStr && szSubStr) {
        NSRange range = [szStr rangeOfString:szSubStr options:NSCaseInsensitiveSearch];
        if (range.length >0) {
            return YES;
        }
    }
    return NO;
}

+ (NSString*)EncodingToUTF8:(NSString *)szStr{
    NSString *szUTF8 = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)szStr, NULL, NULL, kCFStringEncodingUTF8));
    return szUTF8;
}

+ (int)getSafeInt:(id)str{
    if (str) {
        return [str intValue];
    }
    return 0;
}

+ (NSString*)getSafeString:(id)str{
    if (str == nil || [str isKindOfClass:[NSNull class]]) {
        str = @"";
    }
    return str;
}

//字符串是否为空
+ (BOOL)isStringEmptyOrNull:(NSString*)szMsg{
    return [szMsg isKindOfClass:[NSNull class]] || szMsg == nil || [szMsg isEqualToString:@""];
}

//是否是正确的手机号
+ (BOOL)isPhoneNum:(NSString*)szPhoneNum{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^((13[0-9])|(17[0-9])|(14[0-9])|(15[^4,\\D])|(18[0-9]))\\d{8}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *result = [regex firstMatchInString:szPhoneNum options:0 range:NSMakeRange(0, szPhoneNum.length)];
    return result != nil;
}

//判断身份证
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    if (identityString.length != 18) return NO; // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    //** 开始进行校验 *// //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue]; NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    } else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    } return YES;
}
    
//MD5加密
+ (NSString*)getMd5String:(NSString*)szStr{
    const char *str = [szStr UTF8String];
    unsigned char result[16];
    CC_MD5(str,(unsigned int)strlen(str),result);
    NSMutableString *szRet = [NSMutableString stringWithCapacity:32];
    for (int i=0; i<16; i++) {
        [szRet appendFormat:@"%02X",result[i]];
    }
    return szRet;
}

+ (NSDate*)dateFromNSString:(NSString *)szDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date = nil;
    if (szDate && ![szDate isEqual:[NSNull null]]) {
        date = [dateFormat dateFromString:szDate];
    }
    return date;
}


/////////////////////////////
//本地Document路径

+ (NSString*)getFileNameByFilePath:(NSString *)szFileFullPath
{
    if (szFileFullPath && ![szFileFullPath isEqualToString:@""]) {
        NSArray *arrays = [szFileFullPath componentsSeparatedByString:@"/"];
        return [arrays objectAtIndex:(arrays.count - 1)];
    }
    return @"";
}

//由纯文件名去除文件扩展名
+ (NSString*)getFileNameByFileExtName:(NSString*)szFileNameExt
{
    NSString *szExt = [self getFileExtends:szFileNameExt];
    NSString *szRet = [szFileNameExt stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",szExt] withString:@""];
    
    return szRet;
}

//获取一个随机数，[nFrom,nTo]
+ (int)getRandomNum:(int)nFrom withTo:(int)nTo{
    return (int)(nFrom + (arc4random()%(nTo - nFrom + 1)));
}




////////////////////////////////////////////////////////
+ (BOOL)savePwdToKeyChain:(NSString*)szPwd{
    NSString *szSerName = [[NSBundle mainBundle] bundleIdentifier];
    return [SFHFKeychainUtils storeUsername:STORE_NAME_PWD andPassword:szPwd forServiceName:szSerName updateExisting:YES error:nil];
}

+ (NSString*)getPwdFromKeyChain{
    NSString *szSerName = [[NSBundle mainBundle] bundleIdentifier];
    return [SFHFKeychainUtils getPasswordForUsername:STORE_NAME_PWD andServiceName:szSerName error:nil];
}










@end
