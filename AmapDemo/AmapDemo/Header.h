//
//  Header.h
//  AmapDemo
//
//  Created by ari 李 on 04/04/2017.
//  Copyright © 2017 ari 李. All rights reserved.
//

#ifndef Header_h
#define Header_h
#define AMAP_KEY @"1a7915af1b1b97c653c875ddc82badc2";
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

#endif /* Header_h */
