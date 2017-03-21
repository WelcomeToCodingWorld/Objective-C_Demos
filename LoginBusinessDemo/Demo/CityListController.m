//
//  CityListController.m
//  Demo
//
//  Created by LiuTao on 16/7/3.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "CityListController.h"

#import "Header.h"

@interface CityListController ()<UITableViewDelegate,UITableViewDataSource>

/// 选择城市完毕 => 回调
@property (nonatomic,copy) void(^callback)(id cityinfo);

/// 数据源
@property (nonatomic,strong) NSArray* cityList;

@end

@implementation CityListController

/// 进入城市选择页面
+(id) cityControllerWithCallback:(void(^)(id cityinfo)) callback;
{
    CityListController* controller = [[[self class] alloc] init];
    controller.callback = callback;
    return controller;
}


-(void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UITableView* tTableView = nil;
    CGRect tabFrame = self.view.bounds;
    tTableView = [[UITableView alloc] initWithFrame:tabFrame style:UITableViewStylePlain];
    [tTableView setBackgroundColor:[UIColor clearColor]];
    [tTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    [tTableView setSeparatorColor:[UIColor lightGrayColor]];
    [tTableView setDelegate:self];
    [tTableView setDataSource:self];
    [self.view addSubview:tTableView];
    
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = leftBtn;

}

#pragma mark - ******** 响应 ********

-(void) cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ******** 请求 ********


static NSArray* kCityList;

/// 城市数据 缓存 (为空时初始化,存储到静态变量中,以后直接返回)
+(NSArray*) allCity
{
    if (!kCityList) {
        NSData* jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.json" ofType:nil]];
        kCityList = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    }
    return kCityList;
}

/// table的数据源 懒加载
-(NSArray*) cityList
{
    if (!_cityList) {
        _cityList = [CityListController allCity];
    }
    return _cityList;
}


#pragma mark --------------- UITableView Delegate ---------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section
{
    return self.cityList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tIdentifier = @"Identifier";
    UITableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:tIdentifier];
    
    if(!tCell)
    {
        tCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tIdentifier];
        tCell.selectionStyle = UITableViewCellSelectionStyleGray;
        tCell.editingAccessoryType = UITableViewCellEditingStyleDelete;
    }
    tCell.textLabel.text = self.cityList[indexPath.row][@"cityname"];
    
    return tCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cityinfo = self.cityList[indexPath.row];
    U_SET_OBJ(CITY_SELECTED, cityinfo);

    if (self.callback) {
        self.callback(cityinfo);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ******** 选择城市 ********


/// 获取选择的城市数据
+(id) selectedCityInfo;
{
    return U_GET_OBJ(CITY_SELECTED);
}

/// 自动选择城市: 城市名称
+(id) autoSelectCityWithName:(id)cityname;
{
    id allCity = [self allCity];
    NSString* sql = [NSString stringWithFormat:@"cityname like [cd] '*%@*' ",cityname];
    id citys = [allCity filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:sql]];
    if ([citys count] > 0) {
        U_SET_OBJ(CITY_SELECTED, [citys firstObject]);
        return [citys firstObject];
    }
    NSLog(@"该城市未开通服务");
    return nil;
}



@end
