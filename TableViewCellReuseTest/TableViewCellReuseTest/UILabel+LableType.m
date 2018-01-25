//
//  UILabel+LableType.m
//  KSStrickoutLabel
//
//  Created by Li on 16/8/24.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "UILabel+LableType.h"
@implementation UILabel (Type)
+ (instancetype)labelWithTextColor:(UIColor *)textColor font:(UIFont*)font {
    UILabel *label = [[UILabel alloc]init];
    label.textColor = textColor;
    label.font = font;
    return label;
}
- (void)setTextColor:(UIColor *)textColor withFont:(UIFont *)font {
    self.textColor = textColor;
    self.font = font;
}
@end
