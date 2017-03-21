//
//  LoginController.h
//  Demo
//
//  Created by LiuTao on 16/7/3.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController

/// 获取当前用户信息,未登录为空
+(id) currUserInfo;

/// 注销当前用户
+(void) logout;

/// 启动时自动登录处理
+(void) doAutoLogin:(void(^)(id userinfo))loginFinish;

/// 进入登录页面
+(id) loginControllerWithCallback:(void(^)(id userinfo)) callback;

@end
