//
//  CityListController.h
//  Demo
//
//  Created by LiuTao on 16/7/3.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityListController : UIViewController


/// 获取选择的城市数据
+(id) selectedCityInfo;

/// 自动选择城市: 城市名称
+(id) autoSelectCityWithName:(id)cityname;

/// 进入城市选择页面
+(id) cityControllerWithCallback:(void(^)(id cityinfo)) callback;

@end
