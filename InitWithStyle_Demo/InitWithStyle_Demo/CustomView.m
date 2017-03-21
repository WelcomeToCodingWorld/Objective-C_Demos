//
//  CustomView.m
//  MAMapKit_2D_Demo
//
//  Created by zz on 2017/1/5.
//  Copyright © 2017年 Autonavi. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithStyle:(KSStyle)style{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

+ (instancetype)customViewWithStyle:(id)style{
    CustomView* custom = [[self alloc]initWithStyle:style];
    NSLog(@"%@",[custom class]);
    return  custom;
}

- (void)setupView{
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 100, 50)];
    label.backgroundColor = [UIColor orangeColor];
    label.text = @"Test";
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
}

@end
