//
//  KSPageControl.h
//  UniteRoute
//
//  Created by Li on 2016/11/11.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSPageControl : UIView
@property(nonatomic) NSInteger numberOfPages;          // default is 0
@property(nonatomic) NSInteger currentPage;            // default is 0. value pinned to 0..numberOfPages-1,called must after numberOfPages
@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor;
@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor;
@end
