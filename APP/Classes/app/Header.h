//
//  Header.h
//  APP
//
//  Created by LiuTao on 16/6/24.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#ifndef Header_h
#define Header_h

#pragma mark - ******** DEVICE 处理 ********

// 屏幕宽度
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
// 导航栏
#define NAV_H   44
// Tabbar
#define TABBAR_H    49/// 根据iphone6 效果图的尺寸 算出实际设备中尺寸
#define F_I6_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/375.f)) * 2 ) ) / 2.f )
/// 根据iphone5 效果图的尺寸 算出实际设备中尺寸
#define F_I5_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/320.f)) * 2 ) ) / 2.f )

#pragma mark - ******** 单例 ********

#ifndef SINGLETON_FOR_CLASS

/// oc 类,消息机制,都是runtime<运行时>实现的
#import <objc/runtime.h>

#define SINGLETON_FOR_CLASS_HEADER(__CLASSNAME__)	\
\
+ (__CLASSNAME__*) getInstance;	\
+ (void) purgeGetInstance;


#define SINGLETON_FOR_CLASS(__CLASSNAME__)	\
\
static __CLASSNAME__* _##__CLASSNAME__##_getInstance = nil;	\
\
+ (__CLASSNAME__*) getInstanceNoSynch	\
{	\
return (__CLASSNAME__*) _##__CLASSNAME__##_getInstance;	\
}	\
\
+ (__CLASSNAME__*) getInstanceSynch	\
{	\
@synchronized(self){	\
if(nil == _##__CLASSNAME__##_getInstance){	\
_##__CLASSNAME__##_getInstance = [[self alloc] init];	\
}else{	\
NSAssert2(1==0, @"SynthesizeSingleton: %@ ERROR: +(%@ *)getInstance method did not get swizzled.", self, self);	\
}	\
}	\
return (__CLASSNAME__*) _##__CLASSNAME__##_getInstance;	\
}	\
\
+ (__CLASSNAME__*) getInstance	\
{	\
return [self getInstanceSynch]; \
}	\
\
+ (id)allocWithZone:(NSZone*) zone	\
{	\
@synchronized(self){	\
if (nil == _##__CLASSNAME__##_getInstance){	\
_##__CLASSNAME__##_getInstance = [super allocWithZone:zone];	\
if(nil != _##__CLASSNAME__##_getInstance){	\
Method newGetInstanceMethod = class_getClassMethod(self, @selector(getInstanceNoSynch));	\
method_setImplementation(class_getClassMethod(self, @selector(getInstance)), method_getImplementation(newGetInstanceMethod));	\
}	\
}	\
}	\
return _##__CLASSNAME__##_getInstance;	\
}	\
\
+ (void)purgeGetInstance	\
{	\
@synchronized(self){	\
if(nil != _##__CLASSNAME__##_getInstance){	\
Method newSharedInstanceMethod = class_getClassMethod(self, @selector(getInstanceSynch));	\
method_setImplementation(class_getClassMethod(self, @selector(getInstance)), method_getImplementation(newSharedInstanceMethod));	\
_##__CLASSNAME__##_getInstance = nil;	\
}	\
}	\
}	\
\
- (id)copyWithZone:(NSZone *)zone	\
{	\
return self;	\
}

#endif


#endif /* Header_h */
