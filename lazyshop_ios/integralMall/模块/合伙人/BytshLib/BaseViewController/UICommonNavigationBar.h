//
//  UICommonNavigationBar.h
//  EcologicalMgr
//
//  Created by yons on 14-10-31.
//
//

#import <UIKit/UIKit.h>
#import "Utility.h"

typedef BOOL (^BackReturnBlock)(void);

@interface UICommonNavigationBar : UIView{
    UIViewController *viewControllerParent;
    
    UINavigationItem *navItem;
    
    UIImage *imgChecked;
    UIImage *imgNoChecked;
}

@property(strong, nonatomic)UINavigationBar *navigationBar;
@property(nonatomic,copy)BackReturnBlock blockBackReturn;

@property SEL selViewControllerMethod;

- (id)initControlWithBackBtn:(UIViewController*)viewController withTitle:(NSString*)szNavItemTitle;
- (id)initControlWithBackBtn:(UIViewController*)viewController withTitle:(NSString*)szNavItemTitle withBackReturnBlock:(BackReturnBlock)backReturnBlock;

- (id)initControlWithLRBtn:(UIViewController*)viewController withTitle:(NSString*)szNavItemTitle withRightBtnTitle:(NSString*)szRBtnTitle withSEL:(SEL)selMethod;
- (id)initControlWithLRCheckBox:(UIViewController*)viewController withTitle:(NSString*)szNavItemTitle withRightBtnTitle:(NSString*)szRBtnTitle withSEL:(SEL)selMethod;

- (void)initControl:(UIViewController*)viewController withTitle:(NSString*)szNavItemTitle;
- (void)initControl:(UIViewController *)viewController withTitle:(NSString *)szNavItemTitle withBackReturnBlock:(BackReturnBlock)backReturnBlock;

- (void)btnBackClicked:(id)sender;


- (void)gestureImgChecked:(UITapGestureRecognizer*)gesture;
@end
