//
//  ViewController.m
//  ButtonDemo
//
//  Created by ari 李 on 16/10/2016.
//  Copyright © 2016 ari 李. All rights reserved.
//

#define MAS_SHORTHAND
#import "ViewController.h"
#import <Masonry/Masonry.h>
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
    
    
    UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.bounds = CGRectMake(0, 0, 75, 27);
    
    UIButton* saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    saveBtn.bounds = CGRectMake(0, 0, 75, 27);
    
    UIButton* clearBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    clearBtn.bounds = CGRectMake(0, 0, 75, 27);
    
    [self.view addSubview:cancelBtn];
    [self.view addSubview:saveBtn];
    [self.view addSubview:clearBtn];
    
    UILayoutGuide* space1 = [[UILayoutGuide alloc]init];
    UILayoutGuide* space2 = [[UILayoutGuide alloc]init];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:space1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:20]];
    
    [self.view makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.view addLayoutGuide:space1];
    [self.view addLayoutGuide:space2];
    [space1.widthAnchor constraintEqualToAnchor:space2.widthAnchor].active = true;
    [saveBtn.trailingAnchor constraintEqualToAnchor:space1.leadingAnchor].active = true;
    [cancelBtn.leadingAnchor constraintEqualToAnchor:space1.trailingAnchor].active = true;
    [cancelBtn.trailingAnchor constraintEqualToAnchor:space2.leadingAnchor].active = true;
    [clearBtn.leadingAnchor constraintEqualToAnchor:space2.trailingAnchor].active = true;
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
