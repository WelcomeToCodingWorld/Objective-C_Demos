//
//  ViewController.m
//  OCInterJS
//
//  Created by zz on 2016/11/2.
//  Copyright © 2016年 zzkj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate,ObjecExportMethod>
@property (nonatomic,retain)UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"Test" withExtension:@"html"]]];
}

#pragma mark- UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    jsContext[@"method"] = self;
    
    NSString *jsScript = @"document.title";
    //方式一：用JSContext对象执行脚本
    NSString *title = [jsContext evaluateScript:jsScript].toString;
    self.navigationItem.title = title;

    //方式二：用webView的实例方法执行脚本
    title = [webView stringByEvaluatingJavaScriptFromString:jsScript];
}

#pragma mark- ObjcExportMethod
- (void)showNumber1:(NSNumber *)n1 andNumber2:(NSNumber *)n2{
    NSLog(@"Number1= %d,Number2 = %d",n1.intValue,n2.intValue);
}

- (NSNumber *)returnSumWithNum1:(NSNumber *)n1 andNum2:(NSNumber *)n2{
    return @(n1.intValue + n2.intValue);
}

/**
 *  从JavaScript接收一个字典
 */
- (void)dictTest:(NSDictionary *)dict
{
    NSLog(@"%@",dict);
}
/**
 *  从JavaScript接收一个数组
 */
- (void)arrayTest:(NSArray *)array
{
    NSLog(@"%@", array);
}

/**
 *  无参导出方法
 */
- (void)show
{
    NSLog(@"%s", __func__);
}
/**
 *  返回一个OC字符串到JavaScript
 */
- (NSString *)returnString
{
    return @"从OC返回成功";
}
/**
 *  返回一个OC数组到JavaScript
 */
- (NSArray *)returnArray
{
    return @[@(1), @"hello"];
}
/**
 *  返回一个OC字典到JavaScript
 */
- (NSDictionary *)returnDict
{
    return @{
             @"name" : @"jack",
             @"date" : @[@(1), @"hello"]
             };
}
@end
