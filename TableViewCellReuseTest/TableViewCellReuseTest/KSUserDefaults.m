//
//  KSUserDefaults.m
//  UniteRoute
//
//  Created by Li on 16/9/20.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "KSUserDefaults.h"

@implementation KSUserDefaults
+ (instancetype)shareUserDefaults {
    static KSUserDefaults *__share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!__share) {
            __share = [[KSUserDefaults alloc]init];
        }
    });
    return __share;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        if (kScreenWidth == 320) {
            _seventeenFont = [UIFont systemFontOfSize:16];
            _sixteenFont = [UIFont systemFontOfSize:15];
            _fifteenFont = [UIFont systemFontOfSize:14];
            _fourteenFont = [UIFont systemFontOfSize:12];
            _thirteenFont = [UIFont systemFontOfSize:12];
            _twelveFont = [UIFont systemFontOfSize:11];
            _elevenFont = [UIFont systemFontOfSize:10];
        }else if (kScreenWidth == 375) {
            _seventeenFont = [UIFont systemFontOfSize:17];
            _sixteenFont = [UIFont systemFontOfSize:16];
            _fifteenFont = [UIFont systemFontOfSize:15];
            _fourteenFont = [UIFont systemFontOfSize:14];
            _thirteenFont = [UIFont systemFontOfSize:13];
            _twelveFont = [UIFont systemFontOfSize:12];
            _elevenFont = [UIFont systemFontOfSize:11];
        }else if (kScreenWidth == 414) {
            _seventeenFont = [UIFont systemFontOfSize:17];
            _sixteenFont = [UIFont systemFontOfSize:16];
            _fifteenFont = [UIFont systemFontOfSize:15];
            _fourteenFont = [UIFont systemFontOfSize:14];
            _thirteenFont = [UIFont systemFontOfSize:13];
            _twelveFont = [UIFont systemFontOfSize:13];
            _elevenFont = [UIFont systemFontOfSize:12];
        }
    }
    return self;
}

@end
