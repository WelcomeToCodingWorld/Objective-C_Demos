//
//  ViewController.m
//  Demo
//
//  Created by mac on 16-6-7.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "ViewController.h"
#import "LoginController.h"
#import "CityListController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic,strong) NSMutableArray* dataList;
@property (nonatomic,strong) UITableView* tableView;

@end

@implementation ViewController

#pragma mark - ******** 启动流程 ********

/// 是否必须登录
//#define MUST_LOGIN_FLAG 1

-(void) initAPP
{
    // 1.启动
    
    // 2.自动登录
    
    __weak ViewController* bSelf = self;
    [LoginController doAutoLogin:^(id userinfo) {
        if (userinfo) {
            // 自动登录成功
            bSelf.navigationItem.rightBarButtonItem.title = userinfo[@"username"];
            // 3.进入城市选择逻辑
            [self autoSelectCity];
        }else{
            // 3.未自动登录或自动登录失败
            // 3.如果 启动必须要登录,在此处处理
#ifdef MUST_LOGIN_FLAG
            // 3.如果必须要登录,弹出登录界面,登录完成,继续处理城市选择逻辑
            [self autoShowLoginPage];
#else
            // 3.如果非必须登录,直接进入城市选择逻辑
            [self autoSelectCity];
#endif
            
        }
    }];
    // 3.自动选择城市
    
    // 4.进入,刷新主页
    
}


/// 未登录,弹出登录页面(app必须登录才能使用)
-(void) autoShowLoginPage
{
    __weak ViewController* bSelf = self;
    LoginController* vc = [LoginController loginControllerWithCallback:^(id userinfo) {
        if (userinfo) {
            bSelf.navigationItem.rightBarButtonItem.title = userinfo[@"username"];
            [bSelf autoSelectCity];
        }
    }];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];

}


/// 模拟 定位,获取当前城市
-(void) getUserCity:(void(^)(id cityname))callback
{
    // 模拟定位操作,模拟根据经纬度获取城市操作
    if (callback) {
        callback(@"石家庄");
    }
}

/// 自动选择城市
-(void) autoSelectCity
{
    id cityInfo = [CityListController selectedCityInfo];
    // 如果本地未保存城市信息,自动定位,并自动选择城市
    if (!cityInfo) {
        // 模拟定位,
        [self getUserCity:^(id cityname) {
            if (!cityname) {
                cityname = @"石家庄";
            }
            [CityListController autoSelectCityWithName:cityname];
            [self refreshMainData];
        }];
        
        return;
    }
    [self refreshMainData];
}


/// 手动选择城市
-(void) doSelectCity
{
    __weak ViewController* bSelf = self;
    CityListController* vc = [CityListController cityControllerWithCallback:^(id cityinfo) {
        bSelf.navigationItem.leftBarButtonItem.title = cityinfo[@"cityname"];
        [bSelf refreshMainData];
    }];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

/// 登录或注销,
-(void) doLog_InOrOut
{
    id currUserInfo = [LoginController currUserInfo];
    if (!currUserInfo) {
        __weak ViewController* bSelf = self;
        LoginController* vc = [LoginController loginControllerWithCallback:^(id userinfo) {
            if (userinfo) {
                // 登录完成可能需要刷新更多数据
                bSelf.navigationItem.rightBarButtonItem.title = userinfo[@"username"];
            }
        }];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要注销当前用户?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

/// 注销操作
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [LoginController logout];
        self.navigationItem.rightBarButtonItem.title = @"登录";
    }
}



/// 首页数据获取和刷新
-(void) refreshMainData
{
    id cityInfo = [CityListController selectedCityInfo];
    [self.dataList removeAllObjects];
    
    for (int i=0; i<20; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"%@-%d",cityInfo[@"cityname"],i]];
    }
    [self.tableView reloadData];
}


#pragma mark - ******** 首页 ********


- (void)viewDidLoad {
    
    self.dataList = [NSMutableArray array];
    [super viewDidLoad];
    [self createMainView];
    [self initAPP];
}

- (void)createMainView {

    UITableView* tTableView = nil;
    CGRect tabFrame = self.view.bounds;
    tTableView = [[UITableView alloc] initWithFrame:tabFrame style:UITableViewStylePlain];
    [tTableView setBackgroundColor:[UIColor clearColor]];
    [tTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    [tTableView setSeparatorColor:[UIColor lightGrayColor]];
    [tTableView setDelegate:self];
    [tTableView setDataSource:self];
    [self.view addSubview:tTableView];
    self.tableView = tTableView;
    
    id leftTitle = @"选择";
    id cityInfo = [CityListController selectedCityInfo];
    if (cityInfo) {
        leftTitle = cityInfo[@"cityname"];
    }
    
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc] initWithTitle:leftTitle style:UIBarButtonItemStyleDone target:self action:@selector(doSelectCity)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    id rightTitle = @"登录";
    id currUserInfo = [LoginController currUserInfo];
    if (currUserInfo) {
        rightTitle = currUserInfo[@"username"];
    }

    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithTitle:rightTitle style:UIBarButtonItemStyleDone target:self action:@selector(doLog_InOrOut)];
    self.navigationItem.rightBarButtonItem = rightBtn;

}

#pragma mark --------------- UITableView Delegate ---------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section
{
    return self.dataList.count;
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
    tCell.textLabel.text = [self.dataList[indexPath.row] description];
    
    return tCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
