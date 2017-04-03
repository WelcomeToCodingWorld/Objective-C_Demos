//
//  ViewController.m
//  AmapDemo
//
//  Created by ari 李 on 30/03/2017.
//  Copyright © 2017 ari 李. All rights reserved.
//

#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface ViewController ()
{
    
}
@property (nonatomic,retain)AMapSearchAPI* searchApi;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self setupNav];
    [self setupView];
}

- (void)initialize{
    
}

- (void)setupNav{
    self.title = @"高德";
}

- (void)setupView{
    
}


@end
