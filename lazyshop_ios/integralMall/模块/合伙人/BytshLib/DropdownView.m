//
//  DropdownView.m
//  
//
//  Created by liu on 16/12/13.
//
//

#import "DropdownView.h"


@implementation DropdownView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)init{
    self = [super init];
    return self;
}

- (id)initWithFrame:(CGRect)frame withArrayCodes:(NSMutableArray*)arrayCodes{
    self = [self initWithFrame:frame];
    /*_tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    
    
    [self addSubview:_tabView];
    */
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
    
    self.dataSource = self;
    self.delegate = self;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 0.7f;
    _arrayCodes = arrayCodes;

    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayCodes.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CodeName *code = [_arrayCodes objectAtIndex:indexPath.row];
    
    static NSString *szCELL_IDENTIFIER = @"CELL_DROP_DOWN";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:szCELL_IDENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:szCELL_IDENTIFIER];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.text = code.szName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CodeName *cn = [_arrayCodes objectAtIndex:indexPath.row];
    if (self.delegateItemSelected) {
        [self.delegateItemSelected onItemSelected:tableView withCodeName:cn];
    }
    
}

@end
