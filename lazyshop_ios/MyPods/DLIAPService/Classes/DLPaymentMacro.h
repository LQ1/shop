//
//  DLPaymentMacro.h
//  Pods
//
//  Created by LY on 16/11/9.
//
//

#ifndef DLPaymentMacro_h
#define DLPaymentMacro_h

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

// 微信package
#define WXPayPackage @"Sign=WXPay"

// 支付宝sdk版本
#define AliPaySDKVersion @"2.2"

// 对象是否存在
#define DLPayNodeExist(node) (node != nil && ![node isEqual:[NSNull null]])

// 错误信息解析
#define DLPayErrorParsing(__error)    \
({  \
NSString *title = nil;   \
if ([__error isKindOfClass:[NSError class]]) {  \
if ([__error.domain isEqualToString:@"com.zxtech.err"]) {     \
title = __error.userInfo[@"errorInfo"];   \
}   \
if(!title.length){  \
if(__error.code == -999 && __error.userInfo[NSLocalizedDescriptionKey]) {  \
title = @"无网络";    \
}   \
}   \
}   \
if(!title.length){  \
title = @"获取数据失败";    \
}   \
title;  \
})

#define DLPayErrorSetting(__errorName)    \
({  \
NSString *title = @"获取数据失败";   \
if(__errorName){\
title = __errorName;\
}\
[NSError errorWithDomain:@"com.zxtech.err" code:-1000 userInfo:@{@"errorInfo":title}];\
})

#endif /* DLPaymentMacro_h */
