//
//  ViewController.m
//  AmapDemo
//
//  Created by ari 李 on 30/03/2017.
//  Copyright © 2017 ari 李. All rights reserved.
//

#import "ViewController.h"
#import "GeoServiceViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface ViewController ()
{
    
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *gasChargeBtn;
@property (strong, nonatomic) IBOutlet UIButton *parkingBtn;
@property (nonatomic,retain)AMapSearchAPI* searchApi;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self setupNav];
    [self setupView];
}
- (IBAction)parkingLotSearch:(id)sender {
    
}
- (IBAction)gasStationSearch:(id)sender {
}

- (void)initialize{
    
}

- (void)setupNav{
    self.title = @"高德";
}

- (void)setupView{
    
}


@end
