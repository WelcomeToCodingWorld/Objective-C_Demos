//
//  BaseController.m
//  APP
//
//  Created by LiuTao on 16/6/24.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

-(void) loadView
{
    [super loadView];
    // 一般项目都会有通用的背景色
    self.view.backgroundColor = [UIColor whiteColor];
    // 通用处理!!!!!!!!!!!!!!!!!
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 通用处理!!!!!!!!!!!!!!!!!
}


#pragma mark - ******** tableview ********

-(UITableView*) tableView
{
    if (!_tableView) {
        UITableView* tTableView = nil;
        tTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tTableView setDelegate:self];
        [tTableView setDataSource:self];
        [self.view addSubview:tTableView];
        _tableView = tTableView;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSLog(@"警告:table的数据源方法未实现");
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"警告:table的数据源方法未实现");
    return nil;
}

@end

@implementation NSObject (doRequest)

/// 发起请求
-(void) doRequest:(Command*)cmd;
{
    // 对请求的返回做通用处理
    // 1.取出原来的block,拷贝
    // 2.添加一些通用错误等处理
    CMDBlock callBack = [cmd.callback copy];
    [cmd setRespCallback:^(BaseRespModel* item) {
        if (!item.isSuccess) {
            // 处理网络错误
            // 其他错误
        }
        if (callBack) {
            callBack(item);
        }
    }];
    [ReqManager doRequest:cmd];
}

@end