//
//  ViewController.m
//  DatePickerDemo
//
//  Created by zz on 2016/10/21.
//  Copyright © 2016年 zzkj. All rights reserved.
//

#import "ViewController.h"
#import "ReservationTimePicker.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
}



- (void)setupView{
    ReservationTimePicker *picker = [ReservationTimePicker new];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:picker];
}


@end
