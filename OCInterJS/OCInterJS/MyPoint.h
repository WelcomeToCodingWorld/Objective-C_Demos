//
//  MyPoint.h
//  OCInterJS
//
//  Created by zz on 2016/11/2.
//  Copyright © 2016年 zzkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@class MyPoint;

@protocol MyPointExports;
@interface MyPoint : NSObject
- (void)myPrivateMethod;
@end

@protocol MyPointExports<JSExport>
@property double x;
@property double y;
- (NSString *)description;
+ (MyPoint *)makePointWithX:(double)x y:(double)y;
- (instancetype)initWithX:(double)x y:(double)y;
@end
