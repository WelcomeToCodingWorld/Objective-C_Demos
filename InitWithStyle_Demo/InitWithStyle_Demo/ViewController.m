//
//  ViewController.m
//  InitWithStyle_Demo
//
//  Created by zz on 2017/1/5.
//  Copyright © 2017年 zzkj. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self setupNav];
    [self setupView];
}
#pragma mark- Private For View Creaating
- (void)initialize{
    
}
- (void)setupNav{
    self.title = @"TestCustomViewVC";
}

- (void)setupView{
    CustomView* customView = [CustomView customViewWithStyle:KSStyleDark];
    customView.frame = CGRectMake(20, 50, 375, 400);
    [self.view addSubview:customView];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"Memory Warning!");
}


@end
