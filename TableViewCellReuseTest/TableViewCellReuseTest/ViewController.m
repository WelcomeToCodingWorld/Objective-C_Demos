//
//  ViewController.m
//  TableViewCellReuseTest
//
//  Created by ari 李 on 25/01/2018.
//  Copyright © 2018 ari 李. All rights reserved.
//

#import "ViewController.h"
#import "NSString+ChineseCharactersToSpelling.h"
#import "NSString+PinYin.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testZH2PY];
}

- (void)testZH2PY {
    NSString* zh = @"重庆";
    KSLog(@"%f",[[NSDate date] timeIntervalSinceReferenceDate]);
    NSString* py = [NSString lowercaseSpellingWithChineseCharacters:zh];
    KSLog(@"%f",[[NSDate date] timeIntervalSinceReferenceDate]);
    py = [zh getFirstLetter];
    KSLog(@"%f",[[NSDate date] timeIntervalSinceReferenceDate]);
    KSLog(@"%@",py);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
