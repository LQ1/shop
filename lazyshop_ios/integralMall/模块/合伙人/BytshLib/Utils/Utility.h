//
//  Utility.h
//  EcologicalMgr
//
//  Created by haitao liu on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "SFHFKeychainUtils.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//设置页
typedef enum{
    ST_VERSION,
    ST_UPDATEPWD,
}SettingTypeEnum;

//TableView子项
@interface FixTableViewCellSub : NSObject{
    NSString *_szSubDesc;
    int _enumType;
}

@property(strong, nonatomic)NSString *szSubDesc;
@property int enumType;

@end
//
@interface FixTableViewCell : NSObject{
    UIImage *_img;
    NSString *_szDesc;
    NSMutableArray *_arrayRows;
    int _enumType;
    id _obj;
    id _obj1;
    id _obj2;
}
@property(strong, nonatomic) UIImage *img;
@property(strong, nonatomic) NSString *szDesc;
@property(strong, nonatomic) NSMutableArray *arrayRows;
@property int enumType;
@property id obj;
@property id obj1;
@property id obj2;
@property BOOL isOn;

- (id)init;
- (void)addSubRow:(NSString*)szRowDesc withMenuType:(SettingTypeEnum)settingEnum;

@end


#define STORE_NAME_PWD @"pwd"

//页标题的高度
#define PAGE_TITLE_HEIGHT 60

//进度栏高度
#define PROGRESS_TITLE_HEIGHT 0.3f

//返回的数据对象Key
#define RESULTOBJECT @"ResultObject"
//Row
#define ROWS    @"Rows"

//当没有更多数据时的执行延迟
#define DELAYTIME_NOMOREDATA .4f

//菜单宽度
#define MENU_WIDTH 65

@interface Utility : NSObject

+ (void)showMessage:(NSString *)szContent;

/////////////////字符串相关//////////////////////
+ (NSString*)getGuid;

+ (CGRect)getFontSize:(NSString*)szStr withCGSize:(CGSize)size withFont:(UIFont*)font;
+ (BOOL)stringContainSubStr:(NSString*)szStr withSubStr:(NSString*)szSubStr;
+ (NSString*)EncodingToUTF8:(NSString*)szStr;
+ (int)getSafeInt:(id)str;
//获取安全字符串
+ (NSString*)getSafeString:(id)str;
+ (BOOL)isStringEmptyOrNull:(NSString*)szMsg;
+ (BOOL)isPhoneNum:(NSString*)szPhoneNum;
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;

+ (NSString*)getMd5String:(NSString*)szStr;

//复制 字节
+ (void)bytesToBytes:(Byte*)destBytes withDestStart:(int)iDestStart withSourceBytes:(Byte*)sourceBytes withSourceStart:(int)iSourceStart withSourceCopyLen:(int)iSourceCopyLen;


////////////////系统相关////////////////////////
+ (BOOL)isVersion7Plus;
+ (NSInteger)getScreenHeight;
+ (NSInteger)getScreenWidth;
//IOS7的系统中状态无状态栏高度
+ (NSInteger)getStateBarHeight;
+ (NSInteger)getScreenHeightStateBar;
+ (NSString*)getAppVersion;
+ (NSString*)getDeviceInfo;

//////////////TableView 模拟 TreeView 显示
//+ (void)getNodeAllChildsCount:(Node*)node withArrays:(NSMutableArray*)arrays withCount:(int*)nChildCount;
//+ (void)getNodeAllChildIds:(NSMutableArray *)arrayIds withArrays:(NSMutableArray*)arrays withId:(NSString *)szParentId;


///////////View相关////////////////////////
//隐藏TableView中多余的分隔线
+ (UITableViewCell*)getUITableViewCell:(Class)classCell withOwner:(id)owner;
+ (void)setExtraCellLineHidden:(UITableView*)tableView;
+ (void)hiddenKeyboard:(UIView*)view;
//计算TableView应显示的行数
+ (NSInteger)getPageSize:(CGFloat)fHeight withRowHeight:(CGFloat)rowHeight;
//获取字体，用以设置TableView显示
+ (UIFont*)getDefaultFont;
+ (FixTableViewCell*)getFixCellFromEnum:(NSMutableArray*)arrayFixCells withTypeEnum:(NSInteger)typeEnum;
+ (int)getTableViewCellHeight;
+ (void)setCircleImage:(UIImageView*)imgView;
+ (void)setCircleImage:(UIImageView *)imgView withColor:(UIColor*)color;
+ (void)setCircleImageNoBorder:(UIImageView*)imgView;
+ (void)setCircleView:(UIView*)view;
+ (void)replaceController:(UIViewController *)viewController oldViewController:(UIViewController*)oldController newController:(UIViewController *)newController;

///////////////////文件相关///////////////////
//获取沙箱文档 路径
+ (NSString*)getDocumentDir;

//+ (NSString*)getRegionCodePartPath:(NSString*)szRegionCode;
//创建目录
+ (void)createDir:(NSString*)szDir;
//删除文件
+ (BOOL)deleteFile:(NSString*)szPath;
//判断文件是否存在
+ (BOOL)fileIsExist:(NSString*)szPath;
//获取可作为文件名的本地时间
+ (NSString*)getLocalDateForFileName;
//由文件全路径 获取文件名
// isContainExt 为 true表示包括文件扩展名
+ (NSString*)getFileNameByFilePath:(NSString*)szFileFullPath withContainExt:(BOOL)isContainExt;
//获取文件名称，不包含扩展名
+ (NSString*)getFileNameByFileExpName:(NSString*)szFileNameExt;
//由文件全路径获取文件大小
+ (long)getFileSize:(NSString*)szFileFullPath;
//由文件路径获取文件扩展名--不包括.
+ (NSString*)getFileExtends:(NSString*)szFileName;

+ (NSString*)getDownloadsDir;

//+ (NSMutableArray*)getCoordinatesFromXML:(NSString *)szXMLName;

/////////////////颜色相关/////////////////////////
+ (UIColor *)getColor:(NSString*)hexColor withAlpha:(CGFloat)fAlpha;
+ (UIColor*)getBarSelectedColor;
+ (UIColor*)getBarNoSelectedColor;
+ (UIColor*)getTitleBarColor;
+ (UIColor*)getImgColorByImgName:(NSString*)szImgName;

////////////////图片相关///////////////////////////
+ (UIImage*)getVideoThumbnailImage:(NSString*)szVideoPath;


///////////////日期相关///////////////////////////
+ (NSString*)getDateFromDateTime:(NSString*)szDtTime;
+ (NSDate*)dateFromNSString:(NSString*)szDate;


///////////////local///////////////
+ (NSString*)getFileNameByFilePath:(NSString*)szFileFullPath;
+ (NSString*)getFileNameByFileExtName:(NSString*)szFileNameExt;


///////////////数字相关////////////
+ (int)getRandomNum:(int)nFrom withTo:(int)nTo;


//////////////密码/////////////////
+ (BOOL)savePwdToKeyChain:(NSString*)szPwd;

+ (NSString*)getPwdFromKeyChain;



@end

