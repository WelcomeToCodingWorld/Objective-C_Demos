//
//  Header.h
//  TableViewCellReuseTest
//
//  Created by ari 李 on 25/01/2018.
//  Copyright © 2018 ari 李. All rights reserved.
//

#ifndef Header_h
#define Header_h


#if DEBUG
#define KSLog(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)
#else
#define KSLog(...)
#endif /* KSLog(format, ...) */


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
#define kEdgeWidth     15.0f

/*
 颜色
 */
#define kWhiteColor  [UIColor colorWithHexString:@"#ffffff"]//白色
#define kGrayColor  [UIColor colorWithHexString:@"#878787"]//灰色字体颜色
#define kBGColor [UIColor colorWithHexString:@"#f5f5f5"]//背景色
#define kBlackColor [UIColor colorWithHexString:@"#333333"]//黑色
#define kBlueColor [UIColor colorWithHexString:@"#3c85ee"]//蓝色
#define kDarkGray [UIColor colorWithHexString:@"#999999"]//深灰色
#define kRedColor [UIColor colorWithHexString:@"#fe5a59"]//红色
#define kLightGray [UIColor colorWithHexString:@"#666666"]//浅灰色


/**
 弱引用
 */
#define kWeakSelf(weakSelf) __weak typeof (self)weakSelf = self
/*

/**
 单例简写
 */
#define KSUser [KSUserDefaults shareUserDefaults]

#endif /* Header_h */
