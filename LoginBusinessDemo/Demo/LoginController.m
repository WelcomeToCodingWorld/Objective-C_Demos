//
//  LoginController.m
//  Demo
//
//  Created by LiuTao on 16/7/3.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "LoginController.h"
#import "Header.h"

@interface LoginController ()

/// 登录完毕 => 回调
@property (nonatomic,copy) void(^callback)(id userinfo);

@end

@implementation LoginController

#pragma mark - ******** 用户管理 ********

/// 用户信息,静态(可以用单例的属性)
static id kUserInfo;

/// 当前用户信息,未登录为空
+(id) currUserInfo;
{
    return kUserInfo;
}

/// 保存当前用户信息,内存
+(void) saveUserInfo:(id)userinfo
{
    if (userinfo) {
        userinfo = @{@"username":@"张三",@"userid":@"100001"};
    }
    kUserInfo = userinfo;
}


/// 注销当前用户
+(void) logout;
{
    [self saveUserInfo:nil];
    // 取出最后一次登录用户,删除自动登录,密码
    id lastUser = [[self lastLoginUser] mutableCopy];
    lastUser[@"autologin"] = @"";
    lastUser[@"passwd"] = @"";
    [self saveLoginUser:lastUser];
}

/// 最后一次登录的用户
+(id) lastLoginUser;
{
    id users = U_GET_OBJ(LOGIN_USERS);
    id lastID = U_GET_OBJ(LOGIN_LAST_USERS);
    id lastUsers = [users filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"loginid == %@",lastID]];
    return [lastUsers firstObject];
}

/// 保存用户信息
+(void) saveLoginUser:(id)loginUser
{
    // 所有用户
    id users = [NSMutableArray arrayWithArray:U_GET_OBJ(LOGIN_USERS)];
    // 覆盖保存
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self.loginid==%@",loginUser[@"loginid"]];
    id sameUsers = [users filteredArrayUsingPredicate:predicate];
    if (sameUsers) {
        [users removeObject:[sameUsers firstObject]];
    }
    [users addObject:loginUser];
    // 写入文件, 用户数据,和最后一次登录的用户
    U_SET_OBJ(LOGIN_USERS, users);
    
    // 保存最后一次登录的loginid
    id lastID = loginUser[@"loginid"];
    U_SET_OBJ(LOGIN_LAST_USERS, lastID);
}

/// 启动时自动登录处理
+(void) doAutoLogin:(void(^)(id userinfo))loginFinish
{
    /// 取出最后一次登录的用户,判断自动登录状态, 1:自动登录,并回调 2:回调
    id lastUser = [self lastLoginUser];
    if ([lastUser[@"autologin"] boolValue]) {
        id loginid = lastUser[@"loginid"];
        id passwd = lastUser[@"passwd"];
        NSLog(@" ==> 自动登录 loginid=%@ passwd=%@",loginid,passwd);
        
        [self doLoginWithLoginid:loginid withPasswd:passwd withCallback:^(id userinfo) {
            loginFinish(userinfo);
        }];
        
    }else{
        loginFinish(nil);
    }
}

/// 进入登录页面
+(id) loginControllerWithCallback:(void(^)(id userinfo)) callback;
{
    LoginController* controller = [[[self class] alloc] init];
    controller.callback = callback;
    return controller;
}

+(void) doLoginWithLoginid:(NSString*) loginid withPasswd:(NSString*)passwd withCallback:(void(^)(id userinfo))callback
{
    // ----- 登录请求
    // ---- 模拟登录,模拟返回数据

    NSLog(@" ==> 登录成功");
    id userinfo = @"1";
    
    // 保存用户信息
    [self saveUserInfo:userinfo];

    // 保存用户账号
    id loginUser = LOGIN_USER_CREATE(loginid, passwd);
    [LoginController saveLoginUser:loginUser];

    if (callback) {
        callback([self currUserInfo]);
    }
}

#pragma mark - ******** 登录页面 ********

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
}

#pragma mark - ******** 响应 ********

-(void) cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    id loginid = @"13912312311";
    id passwd = @"123123";
    
    NSLog(@" ==> 手动登录 loginid=%@ passwd=%@",loginid,passwd);

    __weak LoginController* bSelf = self;
    [LoginController doLoginWithLoginid:loginid withPasswd:passwd withCallback:^(id userinfo) {
        if (userinfo) {
            if (bSelf.callback) {
                bSelf.callback(userinfo);
            }
            [bSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            NSLog(@" ==> 登录失败");
        }
    }];
}



@end
