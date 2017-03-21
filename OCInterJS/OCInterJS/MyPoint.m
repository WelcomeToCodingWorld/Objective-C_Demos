//
//  MyPoint.m
//  OCInterJS
//
//  Created by zz on 2016/11/2.
//  Copyright © 2016年 zzkj. All rights reserved.
//

#import "MyPoint.h"

@interface MyPoint ()<MyPointExports>

@end

@implementation MyPoint
@dynamic x;
@dynamic y;
- (void)myPrivateMethod{
    
}

- (instancetype)initWithX:(double)x y:(double)y{
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
    }
    return self;
}

+ (MyPoint *)makePointWithX:(double)x y:(double)y{
    MyPoint *point = [[MyPoint alloc]initWithX:x y:y];
    return point;
}
@end
