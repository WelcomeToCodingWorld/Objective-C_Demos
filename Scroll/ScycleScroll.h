//
//  NewsHeader.h
//  UniteRoute
//
//  Created by Li on 2016/11/11.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;
@protocol NewsHeaderDelegate;
@interface NewsHeader : UIView
@property (nonatomic,strong) NSArray *headerNews;
@property (nonatomic,assign) id<NewsHeaderDelegate>delegate;
/**
 停止轮播，应在dealloc之前调用，最好确保在不在屏幕中时立即停止
 */
- (void)stopPlay;
/**
 开始轮播，已处理，不会多次开启
 */
- (void)beginPlay;
@end
@protocol NewsHeaderDelegate <NSObject>

/**
 选中当前轮播到的资讯

 @param header 当前类对象
 @param news 选中的资讯
 */
- (void)header:(NewsHeader *)header didSelectNews:(News *)news;

@end
