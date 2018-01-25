//
//  UILabel+LableType.h
//  KSStrickoutLabel
//
//  Created by Li on 16/8/24.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Type)

+ (instancetype)labelWithTextColor:(UIColor *)textColor font:(UIFont*)font;
/**
 *  设置字体颜色和大小
 */
- (void)setTextColor:(UIColor *)textColor withFont:(UIFont *)font;
@end
