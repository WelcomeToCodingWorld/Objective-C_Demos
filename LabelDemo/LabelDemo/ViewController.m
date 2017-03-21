//
//  ViewController.m
//  LabelDemo
//
//  Created by zz on 2016/11/11.
//  Copyright © 2016年 zzkj. All rights reserved.
//

#import "ViewController.h"
#import <SDAutoLayout.h>
#import <CoreText/CoreText.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 3;
    [self.view addSubview:label];
    label.layer.borderColor = [UIColor blueColor].CGColor;
    label.layer.borderWidth = 1;
    
    NSString* text = @"Avegant";

    NSMutableParagraphStyle* paraStyle = [[NSMutableParagraphStyle alloc]init];
    paraStyle.lineSpacing = 8.0f;
    paraStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSDictionary* attrDic = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:paraStyle};
    NSAttributedString* attrStr = [[NSAttributedString alloc]initWithString:text attributes:attrDic];
    label.attributedText = attrStr;
    
    CGSize size = [label sizeThatFits:CGSizeMake(280, LONG_MAX)];
    label.frame = CGRectMake(10, 100, size.width, size.height);
    NSLog(@"%@",NSStringFromCGRect(label.frame));
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
