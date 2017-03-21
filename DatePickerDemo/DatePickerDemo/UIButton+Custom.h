//
//  UIButton+Custom.h
//  CarTransactionService1_0
//
//  Created by Li on 16/6/23.
//  Copyright © 2016年 ZhiZiKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Custom)
/**
 *  custom type button
 */
+ (instancetype) buttonAddTarget:(id)target action:(SEL)action withTitle:(NSString *)title imageNamed:(NSString *)imageName;
/**
 *  设置按钮是否可用，同时改变button的背景颜色，无需管理是否可用时，不要调用
 */
@property (nonatomic,assign) BOOL KSEnabled;
@end
