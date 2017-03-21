//
//  CustomView.h
//  MAMapKit_2D_Demo
//
//  Created by zz on 2017/1/5.
//  Copyright © 2017年 Autonavi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  NS_ENUM(NSInteger,KSStyle){
    KSStyleLight = 0,
    KSStyleDark = 1
};
@interface CustomView : UIView
- (instancetype)initWithStyle:(KSStyle)style;
+ (instancetype)customViewWithStyle:(id)style;
@end
