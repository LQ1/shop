//
//  ChooseLocationView.m
//  ChooseLocation
//
//  Created by Sekorm on 16/8/22.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "ChooseLocationView.h"
#import "AddressView.h"
#import "UIView+Frame.h"
#import "AddressTableViewCell.h"

#import "ShippingAddressEidtViewModel.h"
#import "AddressProvinceModel.h"
#import "AddressCityModel.h"
#import "AddressDistrictModel.h"

#define HYScreenW [UIScreen mainScreen].bounds.size.width

static  CGFloat  const  kHYTopViewHeight = 40; //顶部视图的高度
static  CGFloat  const  kHYTopTabbarHeight = 30; //地址标签栏的高度

@interface ChooseLocationView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,weak) AddressView * topTabbar;
@property (nonatomic,weak) UIScrollView * contentView;
@property (nonatomic,weak) UIView * underLine;
@property (nonatomic,strong) NSArray * dataSouce;
@property (nonatomic,strong) NSArray * cityDataSouce;
@property (nonatomic,strong) NSArray * districtDataSouce;
@property (nonatomic,strong) NSMutableArray * tableViews;
@property (nonatomic,strong) NSMutableArray * topTabbarItems;
@property (nonatomic,weak) UIButton * selectedBtn;

@end

@implementation ChooseLocationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)bindViewModel:(ShippingAddressEidtViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self fetchProvinces];
}

#pragma mark -数据获取
// 获取省份信息
- (void)fetchProvinces
{
    // 获取省份信息
    @weakify(self);
    [[self.viewModel fetchProvinceDataSource] subscribeNext:^(id x) {
        @strongify(self);
        self.dataSouce = [NSArray arrayWithArray:x];
        [self reloadData];
    } error:^(NSError *error) {
        CLog(@"获取省份信息失败");
    }];
}
// 刷新数据
- (void)reloadData
{
    [self.tableViews enumerateObjectsUsingBlock:^(UITableView *tableView, NSUInteger idx, BOOL * _Nonnull stop) {
        [tableView reloadData];
    }];
}

#pragma mark - setUp UI

- (void)setUp{
    
    // 所在地区
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, kHYTopViewHeight)];
    [self addSubview:topView];
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"所在地区";
    [titleLabel sizeToFit];
    [topView addSubview:titleLabel];
    titleLabel.lyCenterY = topView.lyHeight * 0.5;
    titleLabel.lyCenterX = topView.lyWidth * 0.5;
    UIView * separateLine = [self separateLine];
    [topView addSubview: separateLine];
    separateLine.lyTop = topView.lyHeight - separateLine.lyHeight;
    topView.backgroundColor = [UIColor whiteColor];

    // 标签栏
    AddressView * topTabbar = [[AddressView alloc]initWithFrame:CGRectMake(0, topView.lyHeight, self.frame.size.width, kHYTopViewHeight)];
    [self addSubview:topTabbar];
    _topTabbar = topTabbar;
    [self addTopBarItem];
    UIView * separateLine1 = [self separateLine];
    [topTabbar addSubview: separateLine1];
    separateLine1.lyTop = topTabbar.lyHeight - separateLine.lyHeight;
    [_topTabbar layoutIfNeeded];
    topTabbar.backgroundColor = [UIColor whiteColor];
    
    UIView * underLine = [[UIView alloc] initWithFrame:CGRectZero];
    [topTabbar addSubview:underLine];
    _underLine = underLine;
    underLine.lyHeight = 2.0f;
    UIButton * btn = self.topTabbarItems.lastObject;
    [self changeUnderLineFrame:btn];
    underLine.lyTop = separateLine1.lyTop - underLine.lyHeight;
    
    _underLine.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    
    // 主视图
    UIScrollView * contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topTabbar.frame), self.frame.size.width, self.lyHeight - kHYTopViewHeight - kHYTopTabbarHeight)];
    contentView.contentSize = CGSizeMake(HYScreenW, 0);
    [self addSubview:contentView];
    _contentView = contentView;
    _contentView.pagingEnabled = YES;
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addTableView];
    _contentView.delegate = self;
}

// 添加列表
- (void)addTableView{

    UITableView * tabbleView = [[UITableView alloc]initWithFrame:CGRectMake(self.tableViews.count * HYScreenW, 0, HYScreenW, _contentView.lyHeight)];
    [_contentView addSubview:tabbleView];
    [self.tableViews addObject:tabbleView];
    tabbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabbleView.delegate = self;
    tabbleView.dataSource = self;
    tabbleView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [tabbleView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressTableViewCell"];
}

// 添加标签栏显示
- (void)addTopBarItem{
    
    UIButton * topBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [topBarItem setTitle:@"请选择" forState:UIControlStateNormal];
    [topBarItem setTitleColor:[UIColor colorWithRed:43/255.0 green:43/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    [topBarItem setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateSelected];
    [topBarItem sizeToFit];
     topBarItem.lyCenterY = _topTabbar.lyHeight * 0.5;
    [self.topTabbarItems addObject:topBarItem];
    [_topTabbar addSubview:topBarItem];
    [topBarItem addTarget:self action:@selector(topBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - TableViewDatasouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if([self.tableViews indexOfObject:tableView] == 0){
        return self.dataSouce.count;
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        return self.cityDataSouce.count;
    }else if ([self.tableViews indexOfObject:tableView] == 2){
        return self.districtDataSouce.count;
    }
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BaseModel * item;
    //省级别
    if([self.tableViews indexOfObject:tableView] == 0){
        item = self.dataSouce[indexPath.row];
    //市级别
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        item = self.cityDataSouce[indexPath.row];
    //县级别
    }else if ([self.tableViews indexOfObject:tableView] == 2){
        item = self.districtDataSouce[indexPath.row];
    }
    cell.item = item;
    return cell;
}

#pragma mark - TableViewDelegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath * indexPath0 = [tableView indexPathForSelectedRow];
    @weakify(self);
    if([self.tableViews indexOfObject:tableView] == 0){
        // 省份table
        AddressProvinceModel * provinceItem = self.dataSouce[indexPath.row];
        [[self.viewModel fetchCityDataSourceWithProvinceID:provinceItem.province_id] subscribeNext:^(id x) {
            @strongify(self);
            //1.1 获取下一级别的数据源(市级别,如果是直辖市时,下级则为区级别)
            self.cityDataSouce = [NSArray arrayWithArray:x];
            //1.1 判断是否是第一次选择,不是,则重新选择省,切换省.
            
            if ([indexPath0 compare:indexPath] != NSOrderedSame && indexPath0) {
                
                for (int i = 0; i < self.tableViews.count && self.tableViews.count != 1; i++) {
                    [self removeLastItem];
                }
                [self addTopBarItem];
                [self addTableView];
                [self scrollToNextItem:provinceItem.province_name];
            }else if ([indexPath0 compare:indexPath] == NSOrderedSame && indexPath0){
                
                for (int i = 0; i < self.tableViews.count && self.tableViews.count != 1 ; i++) {
                    [self removeLastItem];
                }
                [self addTopBarItem];
                [self addTableView];
                [self scrollToNextItem:provinceItem.province_name];
            }else{
                // 之前未选中省，第一次选择省
                [self addTopBarItem];
                [self addTableView];
                [self scrollToNextItem:provinceItem.province_name];
            }
        } error:^(NSError *error) {
            CLog(@"获取市级数据失败");
        }];
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        // 市table
        AddressCityModel * cityItem = self.cityDataSouce[indexPath.row];
        [[self.viewModel fetchDistrictDataSourceWithCityID:cityItem.city_id] subscribeNext:^(id x) {
            @strongify(self);
            self.districtDataSouce = [NSArray arrayWithArray:x];
            
            if ([indexPath0 compare:indexPath] != NSOrderedSame && indexPath0) {
                
                for (int i = 0; i < self.tableViews.count - 1; i++) {
                    [self removeLastItem];
                }
                [self addTopBarItem];
                [self addTableView];
                [self scrollToNextItem:cityItem.city_name];
                
            }else if ([indexPath0 compare:indexPath] == NSOrderedSame && indexPath0){
                
                [self scrollToNextItem:cityItem.city_name];
            }else{
                [self addTopBarItem];
                [self addTableView];
                [self scrollToNextItem:cityItem.city_name];
            }
        } error:^(NSError *error) {
            CLog(@"获取市级数据失败");
        }];
    }else if ([self.tableViews indexOfObject:tableView] == 2){
        // 县级table
        AddressDistrictModel * item = self.districtDataSouce[indexPath.row];
        item.isSelected = YES;
        [self setUpAddress:item.district_name];
    }
    
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.tableViews indexOfObject:tableView] == 0){
       AddressProvinceModel *item = self.dataSouce[indexPath.row];
       item.isSelected = YES;
    }else if ([self.tableViews indexOfObject:tableView] == 1){
       AddressCityModel *item = self.cityDataSouce[indexPath.row];
       item.isSelected = YES;
    }else if ([self.tableViews indexOfObject:tableView] == 2){
       AddressDistrictModel *item = self.districtDataSouce[indexPath.row];
       item.isSelected = YES;
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.tableViews indexOfObject:tableView] == 0){
        AddressProvinceModel *item = self.dataSouce[indexPath.row];
        item.isSelected = NO;
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        AddressCityModel *item = self.cityDataSouce[indexPath.row];
        item.isSelected = NO;
    }else if ([self.tableViews indexOfObject:tableView] == 2){
        AddressDistrictModel *item = self.districtDataSouce[indexPath.row];
        item.isSelected = NO;
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}



#pragma mark - private 

//点击按钮,滚动到对应位置
- (void)topBarItemClick:(UIButton *)btn{
    
    NSInteger index = [self.topTabbarItems indexOfObject:btn];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.contentOffset = CGPointMake(index * HYScreenW, 0);
        [self changeUnderLineFrame:btn];
    }];
}

//调整指示条位置
- (void)changeUnderLineFrame:(UIButton  *)btn{
    
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    _underLine.lyLeft = btn.lyLeft;
    _underLine.lyWidth = btn.lyWidth;
}

//完成地址选择,执行chooseFinish代码块
- (void)setUpAddress:(NSString *)address{

    NSInteger index = self.contentView.contentOffset.x / HYScreenW;
    UIButton * btn = self.topTabbarItems[index];
    [btn setTitle:address forState:UIControlStateNormal];
    [btn sizeToFit];
    [_topTabbar layoutIfNeeded];
    [self changeUnderLineFrame:btn];
    NSMutableString * addressStr = [[NSMutableString alloc] init];
    for (UIButton * btn  in self.topTabbarItems) {
        if ([btn.currentTitle isEqualToString:@"县"] || [btn.currentTitle isEqualToString:@"市辖区"] ) {
            continue;
        }
        [addressStr appendString:btn.currentTitle];
        [addressStr appendString:@" "];
    }
    self.address = addressStr;
    
    // 传出当前选中信息
    AddressProvinceModel *selectedProvice = [self.dataSouce linq_where:^BOOL(AddressProvinceModel *model) {
        return model.isSelected == YES;
    }].linq_firstOrNil;
    self.viewModel.province_id = selectedProvice.province_id;
    
    AddressCityModel *selectedCity = [self.cityDataSouce linq_where:^BOOL(AddressCityModel *model) {
        return model.isSelected == YES;
    }].linq_firstOrNil;
    self.viewModel.city_id = selectedCity.city_id;

    AddressDistrictModel *selectedDistrict = [self.districtDataSouce linq_where:^BOOL(AddressProvinceModel *model) {
        return model.isSelected == YES;
    }].linq_firstOrNil;
    self.viewModel.district_id = selectedDistrict.district_id;

    self.viewModel.adressAreaName = self.address;
    
    [DLAlertShowAnimate disappear];
}

//当重新选择省或者市的时候，需要将下级视图移除。
- (void)removeLastItem{

    [self.tableViews.lastObject performSelector:@selector(removeFromSuperview) withObject:nil withObject:nil];
    [self.tableViews removeLastObject];
    
    [self.topTabbarItems.lastObject performSelector:@selector(removeFromSuperview) withObject:nil withObject:nil];
    [self.topTabbarItems removeLastObject];
}

//滚动到下级界面,并重新设置顶部按钮条上对应按钮的title
- (void)scrollToNextItem:(NSString *)preTitle{
    
    NSInteger index = self.contentView.contentOffset.x / HYScreenW;
    UIButton * btn = self.topTabbarItems[index];
    [btn setTitle:preTitle forState:UIControlStateNormal];
    [btn sizeToFit];
    [_topTabbar layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.contentSize = (CGSize){self.tableViews.count * HYScreenW,0};
        CGPoint offset = self.contentView.contentOffset;
        self.contentView.contentOffset = CGPointMake(offset.x + HYScreenW, offset.y);
        [self changeUnderLineFrame: [self.topTabbar.subviews lastObject]];
    }];
}


#pragma mark - 开始就有地址时.

- (void)setSelectAddress
{
    
    //2.1 添加市级别,地区级别列表
    [self addTableView];
    [self addTableView];

    self.dataSouce = self.viewModel.provinceDataSouce;
    self.cityDataSouce = self.viewModel.cityDataSouce;
    self.districtDataSouce = self.viewModel.districtDataSouce;
  
    //2.3 添加底部对应按钮
    [self addTopBarItem];
    [self addTopBarItem];
    
    AddressProvinceModel *selectedProvice = [self.dataSouce linq_where:^BOOL(AddressProvinceModel *model) {
        return model.isSelected == YES;
    }].linq_firstOrNil;
    NSString * provinceName = selectedProvice.province_name;
    UIButton * firstBtn = self.topTabbarItems.firstObject;
    [firstBtn setTitle:provinceName forState:UIControlStateNormal];
    
    AddressCityModel *selectedCity = [self.dataSouce linq_where:^BOOL(AddressCityModel *model) {
        return model.isSelected == YES;
    }].linq_firstOrNil;
    NSString * cityName = selectedCity.city_name;
    UIButton * midBtn = self.topTabbarItems[1];
    [midBtn setTitle:cityName forState:UIControlStateNormal];
    
    AddressDistrictModel *selectedDistrict = [self.dataSouce linq_where:^BOOL(AddressProvinceModel *model) {
        return model.isSelected == YES;
    }].linq_firstOrNil;
    NSString * districtName = selectedDistrict.district_name;
    UIButton * lastBtn = self.topTabbarItems.lastObject;
    [lastBtn setTitle:districtName forState:UIControlStateNormal];

    [self.topTabbarItems makeObjectsPerformSelector:@selector(sizeToFit)];
    [_topTabbar layoutIfNeeded];
    
    
    [self changeUnderLineFrame:lastBtn];
    
    //2.4 设置偏移量
    self.contentView.contentSize = (CGSize){self.tableViews.count * HYScreenW,0};
    CGPoint offset = self.contentView.contentOffset;
    self.contentView.contentOffset = CGPointMake((self.tableViews.count - 1) * HYScreenW, offset.y);

    [self setSelectedProvince:provinceName andCity:cityName andDistrict:districtName];
}

//初始化选中状态
- (void)setSelectedProvince:(NSString *)provinceName andCity:(NSString *)cityName andDistrict:(NSString *)districtName {
    
    for (AddressProvinceModel * item in self.dataSouce) {
        if ([item.province_name isEqualToString:provinceName]) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[self.dataSouce indexOfObject:item] inSection:0];
            UITableView * tableView  = self.tableViews.firstObject;
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            [self tableView:tableView didSelectRowAtIndexPath:indexPath];
            break;
        }
    }
    
    for (int i = 0; i < self.cityDataSouce.count; i++) {
        AddressCityModel * item = self.cityDataSouce[i];
        
        if ([item.city_name isEqualToString:cityName]) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UITableView * tableView  = self.tableViews[1];
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            [self tableView:tableView didSelectRowAtIndexPath:indexPath];
            break;
        }
    }
    
    for (int i = 0; i <self.districtDataSouce.count; i++) {
        AddressDistrictModel * item = self.districtDataSouce[i];
        if ([item.district_name isEqualToString:districtName]) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UITableView * tableView  = self.tableViews[2];
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            [self tableView:tableView didSelectRowAtIndexPath:indexPath];
            break;
        }
    }
}

#pragma mark - getter 方法

//分割线
- (UIView *)separateLine{
    
    UIView * separateLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1 / [UIScreen mainScreen].scale)];
    separateLine.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    return separateLine;
}

- (NSMutableArray *)tableViews{
    
    if (_tableViews == nil) {
        _tableViews = [NSMutableArray array];
    }
    return _tableViews;
}

- (NSMutableArray *)topTabbarItems{
    if (_topTabbarItems == nil) {
        _topTabbarItems = [NSMutableArray array];
    }
    return _topTabbarItems;
}

@end
