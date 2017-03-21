//
//  ViewController.m
//  DocumentVCDemo
//
//  Created by zz on 2016/11/7.
//  Copyright © 2016年 zzkj. All rights reserved.
//

#import "ViewController.h"
#import "PreviewViewController.h"
@interface ViewController ()<UIDocumentInteractionControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"Button" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    btn.titleLabel.textAlignment = 1;
    btn.titleLabel.layer.cornerRadius = 7.0f;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(20, 100, 200, 30);
    [self.view addSubview:btn];
}

- (void)clicked{
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"ReservationTime" withExtension:@"json"];
    NSLog(@"%@===%d===%s",url,__LINE__,__func__);
    UIDocumentInteractionController *docVC = [UIDocumentInteractionController interactionControllerWithURL:url];
    docVC.delegate = self;
    CGRect navRect = self.navigationController.navigationBar.frame;
    navRect.size = CGSizeMake(1500.0f, 40.0f);
    [docVC presentOptionsMenuFromRect:navRect inView:self.view  animated:YES];
    [docVC presentPreviewAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return [PreviewViewController new];
}

//- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
//    return self.view;
//}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.frame;
}

@end
