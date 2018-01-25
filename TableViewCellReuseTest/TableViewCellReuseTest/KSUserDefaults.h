//
//  KSUserDefaults.h
//  UniteRoute
//
//  Created by Li on 16/9/20.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSUserDefaults : NSObject
/**
 初始化方法，获取单例
 */
+ (instancetype)shareUserDefaults;
#pragma mark - 字体大小，此处标注的是375屏幕宽度下的字体
/**
 17号字体
 */
@property (nonatomic,strong,readonly) UIFont *seventeenFont;
/**
 16号字体
 */
@property (nonatomic,strong,readonly) UIFont *sixteenFont;
/**
 15号字体
 */
@property (nonatomic,strong,readonly) UIFont *fifteenFont;
/**
 14号字体
 */
@property (nonatomic,strong,readonly) UIFont *fourteenFont;
/**
 13号字体
 */
@property (nonatomic,strong,readonly) UIFont *thirteenFont;
/**
 12号字体
 */
@property (nonatomic,strong,readonly) UIFont *twelveFont;
/**
 11号字体
 */
@property (nonatomic,strong,readonly) UIFont *elevenFont;

#pragma mark - 网络状态
/**
 网络状态,在启动时为未知状态
 */

@end
