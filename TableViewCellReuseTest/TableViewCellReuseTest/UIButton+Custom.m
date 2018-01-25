//
//  UIButton+Custom.m
//  CarTransactionService1_0
//
//  Created by Li on 16/6/23.
//  Copyright © 2016年 ZhiZiKeJi. All rights reserved.
//

#import "UIButton+Custom.h"
#import <objc/runtime.h>
static NSString *badgeValueKey = @"badgeValue";
@implementation UIButton (Custom)

+ (instancetype) buttonAddTarget:(id)target action:(SEL)action withTitle:(NSString *)title imageNamed:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}
@end
