//
//  BaseController.h
//  APP
//
//  Created by LiuTao on 16/6/24.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReqManager.h"

@interface BaseController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView* tableView;

@end

@interface NSObject (doRequest)

/// 发起请求
-(void) doRequest:(Command*)cmd;

@end

// 自定义导航的
// 主题切换的
// 其他通用处理

