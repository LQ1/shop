//
//  UncaughtExceptionHandler.h
//  
//
//  Created by liu on 16/4/22.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UncaughtExceptionHandler : NSObject{
    BOOL bDismissed;
}

@end


void HandleException(NSException *exception);

void SignalHandle(int signal);

void InstallUncaughtExceptionHandler(void);