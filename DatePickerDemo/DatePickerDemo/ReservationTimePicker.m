//
//  ReservationTimePicker.m
//  DatePickerDemo
//
//  Created by zz on 2016/10/21.
//  Copyright © 2016年 zzkj. All rights reserved.
//

/*
 屏幕宽高
 */
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenHeight   kScreenBounds.size.height
#define kScreenWidth   kScreenBounds.size.width
#define kNavHeight     64.0f
#define kTabHeight     49.0f
#define kCellHeight       44.0f
#define kScalWidth       (kScreenWidth/375.0)
#define kScalHeight       (kScreenHeight/667.0)


/*
 颜色
 */
#define kWhiteColor  [UIColor colorWithHexString:@"#ffffff"]//白色
#define kGrayColor  [UIColor colorWithHexString:@"#878787"]//灰色字体颜色
#define kBGColor [UIColor colorWithHexString:@"#ebebeb"]//背景色
#define kBlackColor [UIColor colorWithHexString:@"#292929"]//黑色
#define kBlueColor [UIColor colorWithHexString:@"#3c85ee"]//蓝色

#import "ReservationTimePicker.h"
#import "UIButton+Custom.h"
#import "UIColor+Hex.h"
@interface ReservationTimePicker ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_picker;
}
@property (nonatomic,retain)id data;
@property (nonatomic,retain)NSString *selectedInterval;
@end

@implementation ReservationTimePicker

- (instancetype)init{
    self = [super init];
    if (self) {
        self.frame = kScreenBounds;
        self.backgroundColor = [UIColor colorWithHexString:@"#292929" alpha:0.75];
        [self readData];
        [self setupView];
    }
    return self;
}

- (void)readData{
    NSString*timeJson = [[NSBundle mainBundle]pathForResource:@"ReservationTime" ofType:@"json"];
    NSData *timeData = [NSData dataWithContentsOfFile:timeJson];
    NSError *error = nil;
    id data = nil;
    if (timeData) {
        data = [NSJSONSerialization JSONObjectWithData:timeData options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"读取文件成功%@",data);
    }else{
        NSLog(@"读取文件失败");
    }
    
    if (error) {
        NSLog(@"%@",error);
    }else{
        NSMutableArray *tempArr = @[].mutableCopy;
        for (NSDictionary *dic in data[@"ReservationTimeInterval"]) {
            NSString *timeInterval = [dic[@"beginTime"] stringByAppendingFormat:@"~%@",dic[@"endTime"]];
            
            [tempArr addObject:timeInterval];
        }
        if (tempArr.count) {
            _data = tempArr;
        }else{
            NSLog(@"没有获取到数据");
        }
    }
}

- (void)setupView{
    UIView *backView = [UIView new];
    backView.frame = CGRectMake(0, kScreenHeight-250, kScreenWidth, 250);
    [self addSubview:backView];
    
    
    _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight-200, kScreenWidth, 200)];
    _picker.delegate = self;
    _picker.dataSource = self;
    [backView addSubview:_picker];
    
    for (int i =0; i<2; i++) {
        UIButton *button = [UIButton buttonAddTarget:self action:@selector(buttonClick:) withTitle:(i==0)?@"取消":@"确定" imageNamed:nil];
        button.tag = i;
        button.center = CGPointMake(kScreenWidth/4+kScreenWidth/2*i, kScreenHeight-220);
        button.bounds = CGRectMake(0, 0, 160*kScalWidth, 40);
        [self addSubview:button];
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [button setTitleColor:kBlackColor forState:UIControlStateNormal];
    }
    self.hidden = YES;
}

- (void)show {
    if (self.hidden) {
        [self.superview bringSubviewToFront:self];
        self.hidden = NO;
    }
}
#pragma mark- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_data count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _data[row];
}


#pragma mark- UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedInterval = _data[row];
}

@end
