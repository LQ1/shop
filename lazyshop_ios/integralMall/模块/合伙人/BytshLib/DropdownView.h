//
//  DropdownView.h
//  
//
//  Created by liu on 16/12/13.
//
//

#import <UIKit/UIKit.h>
#import "DBHelper.h"

@protocol DropdownViewSelectedDelegate <NSObject>

- (void)onItemSelected:(UITableView*)tableView withCodeName:(CodeName*)codeName;

@end

@interface DropdownView : UITableView<UITableViewDataSource,UITableViewDelegate>{
    //UITableView *_tabView;
    NSMutableArray *_arrayCodes;
}

@property id<DropdownViewSelectedDelegate> delegateItemSelected;

- (id)init;
- (id)initWithFrame:(CGRect)frame withArrayCodes:(NSMutableArray*)arrayCodes;
@end
