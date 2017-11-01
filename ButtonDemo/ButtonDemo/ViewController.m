//
//  ViewController.m
//  ButtonDemo
//
//  Created by ari 李 on 16/10/2016.
//  Copyright © 2016 ari 李. All rights reserved.
//

#import "ViewController.h"

#define DWIDTH [[UIScreen mainScreen]bounds].size.width
#define DHIGHT [[UIScreen mainScreen]bounds].size.height
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat marigin = 100;
    UIButton *btn1 = [self buttonViewImage:@"icon_full_star" title:@"星星heheghege"];
    btn1.frame = CGRectMake(marigin, 20,DWIDTH - 2*marigin , 40);
    [self.view addSubview:btn1];
    
}

- (UIButton *)buttonViewImage:(NSString *)imageName title:(NSString *)title{
    UIButton *button = [UIButton new];
    button.layer.cornerRadius = 7.0f;
    button.layer.borderColor = [[UIColor blackColor]CGColor];
    button.layer.borderWidth = 1;

    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.backgroundColor = [UIColor orangeColor];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.imageView.backgroundColor = [UIColor cyanColor];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    
    return button;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
