//
//  BaseTableViewController.m
//  netcomment
//
//  Created by liu on 2018/3/16.
//  Copyright © 2018年 xtkj. All rights reserved.
//

#import "UIBaseTableViewController.h"

@interface UIBaseTableViewController ()

@end

@implementation UIBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackTitle];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _viewAnimation = [UIViewAnimation new];

    [Utility setExtraCellLineHidden:self.tableView];
    
    [self initControl];
    [self initData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initControl{
    
}

- (void)initData{
    
}

//设置返回汉字
- (void)setBackTitle{
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] init];
    btnBack.title = @"返回";
    self.navigationItem.backBarButtonItem = btnBack;
}

//初始化中间带标题的
- (void)initNavBar:(NSString *)szTitle{
    self.navigationItem.title = szTitle;
}

- (void)initNavBar:(NSString *)szTitle withBackBlock:(BackReturnBlock)backReturnBlock{
    
}

//初始化右键
- (void)initNavBarRightBtn:(NSString*)szRightText withClicked:(SEL)btnClicked{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:szRightText style:UIBarButtonItemStylePlain target:self action:btnClicked];
    [self.navigationItem setRightBarButtonItem:right];
}

//初始化右键-->图片
- (void)initNavBarRightImg:(UIImage*)image withClicked:(SEL)btnClicked{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:btnClicked];
    right.imageInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [self.navigationItem setRightBarButtonItem:right];
}

//初始化 中间带加载进度条
- (void)initNavBarWithTitleIndicator{
    UIView *viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 22)];
    //viewTitle.backgroundColor = [UIColor redColor];
    UIActivityIndicatorView *actIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [actIndicatorView startAnimating];
    [viewTitle addSubview:actIndicatorView];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(actIndicatorView.frame.size.width+4, 0, 80, 22)];
    lblTitle.textAlignment = NSTextAlignmentLeft;
    lblTitle.font = [UIFont fontWithName:@"Arial" size:14.0f];
    lblTitle.text = @"加载中...";
    [viewTitle addSubview:lblTitle];
    
    self.navigationItem.titleView = viewTitle;
}


- (void)presentViewController:(UIViewController *)viewController{
    [self presentViewController:viewController withAnimationType:Push];
}
- (void)presentViewController:(UIViewController *)viewController withAnimationType:(AnimationType)aniType{
    if (self.navigationController) {
        BOOL bNav = self.navigationController.navigationBarHidden;
        self.hidesBottomBarWhenPushed = YES;//隐藏底部的
        [self.navigationController pushViewController:viewController animated:YES];
        self.hidesBottomBarWhenPushed = !bNav;//如果没有这句，返回的时候底部不会出现
    }else{
        [_viewAnimation showViewAnimation:aniType withSelfView:self.view];
        [self presentViewController:viewController animated:NO completion:nil];
    }
}

- (void)initProgress{
    if (self.progressView == nil) {
        CGRect rc = {0};
        if (self.navigationItem) {
            //有标题栏
            rc.origin.y = 66;
        }
        rc.size.height = SCREEN_HEIGHT;
        rc.size.width = SCREEN_WIDTH;
        self.progressView = [[ProgressView alloc] initActivWithViewAndFrame:self.view withFrame:rc];
    }
}

//显示加载显示
- (void)showProgressLoadingIndicator:(NSString*)szTips{
    [self initProgress];
    [self.progressView showActivityIndicatorView:szTips];
}
- (void)showProgressLoadingIndicatorWithoutAutoClose:(NSString*)szTips{
    [self initProgress];
    [self.progressView showActivityIndicatorViewWithoutAutoClose:szTips];
}
//关闭加载显示
- (void)closeProgressLoadingIndicator{
    [self.progressView closeActivityIndicator];
}

/////////////////////////////////////show tips//////////////////////
- (void)showTipWithDismissWindow:(NSString*)szTips{
    [self showTipCenter:szTips];
    //3s后关闭窗体
    [self performSelector:@selector(dismissThisViewController) withObject:nil afterDelay:3];
}

- (void)dismissThisViewController{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)showTipWithDismiss:(NSString*)szTipsMsg{
    [self performSelectorOnMainThread:@selector(showTipWithDismissWindow:) withObject:szTipsMsg waitUntilDone:NO];
}

//在主线程显示提示
- (void)showTipInCenter:(NSString*)szTipMsg{
    [self performSelectorOnMainThread:@selector(showTipCenter:) withObject:szTipMsg waitUntilDone:NO];
}

- (void)showTipCenter:(NSString*)szTipMsg{
    [self initProgress];
    [self.progressView showTip:szTipMsg];
}

- (void)showTipBottom:(NSString*)szTipMsg{
    [self initProgress];
    [self.progressView showTipInBottom:szTipMsg];
}

//在主线程显示提示
- (void)showTipInBottom:(NSString*)szTipMsg{
    [self performSelectorOnMainThread:@selector(showTipBottom:) withObject:szTipMsg waitUntilDone:NO];
}
/////////////////////////////////////end//////////////////////

- (void)showHUDProgressLoadingIndicator:(NSString*)szTips{
    //[MBProgressHUD wj_showActivityLoading:szTips toView:self.view];
}

- (void)showHUDSuccessInMain:(NSString *)szMsg{
    //[MBProgressHUD wj_showSuccess:szMsg];
}
- (void)showHUDSuccess:(NSString*)szMsg{
    [self performSelectorOnMainThread:@selector(showHUDSuccessInMain:) withObject:szMsg waitUntilDone:NO];
}

- (void)showHUDFailInMain:(NSString *)szMsg{
    //[MBProgressHUD wj_showError:szMsg];
}
- (void)showHUDFail:(NSString*)szMsg{
    [self performSelectorOnMainThread:@selector(showHUDFailInMain:) withObject:szMsg waitUntilDone:NO];
}

- (void)closeHUDInMain{
    //[MBProgressHUD wj_hideHUDForView:self.view];
}
- (void)closeHUD{
    [self performSelectorOnMainThread:@selector(closeHUDInMain) withObject:nil waitUntilDone:NO];
}

#pragma mark - Table view data source



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
