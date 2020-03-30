//
//  StorageBuyTableViewController.m
//  integralMall
//
//  Created by lc on 2019/12/4.
//  Copyright © 2019 Eggache_Yang. All rights reserved.
//

#import "StorageBuyTableViewController.h"
#import "ImageLoadingUtils.h"
#import "DataViewModel.h"

@interface StorageBuyTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (nonatomic, assign) CGFloat scaleHeight;

@end

@implementation StorageBuyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置自适应行高
    [self setAutoLayoutRowHeight];
}

#pragma mark - function

#pragma mark - 设置自适应行高
- (void)setAutoLayoutRowHeight {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.scaleHeight > 0 && indexPath.row == 0) {
        return self.scaleHeight;
    } else if (indexPath.row == 3) {
        return self.tableView.rowHeight;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

//主界面更新
- (void)updateInMain:(StorageCardModel*)model {
    self.lblTitle.text = model.store_card_title;
    [self setImgStr:model.image];
    self.lblMoney.text = [NSString stringWithFormat:@"￥%.2f",model.money];
    NSString *detail = [model.detail stringByReplacingOccurrencesOfString:@"\\n" withString:@"\r\n"];
    [self.descLabel setText:detail];
    
    //[ImageLoadingUtils loadImage:self.imgDetail withURL:model.image];
    //NSString *detail = [model.detail stringByReplacingOccurrencesOfString:@"\\n" withString:@"<br>"];
    //[self.webView loadHTMLString:detail baseURL:nil];
}

#pragma mark - 计算图片高度并刷新界面
- (void)setImgStr:(NSString *)imgStr {
    [self.imgDetail sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image.size.height > 0) {
            CGFloat scale =  (KScreenWidth)/image.size.width;
            self.scaleHeight = image.size.height*scale;
            [self.imgDetail setImage:image];
            
            [self.tableView reloadData];
        }
    }];
}

@end
