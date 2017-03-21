//
//  KSPageControl.m
//  UniteRoute
//
//  Created by Li on 2016/11/11.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "KSPageControl.h"
@interface KSPageControl ()
@property (nonatomic,strong) NSMutableArray *dots;
@property (nonatomic,assign) CGRect selectedBounds;
@property (nonatomic,assign) CGRect normalBounds;
@end
@implementation KSPageControl
- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentPage = -1;
        self.pageIndicatorTintColor = kWhiteColor;
        self.currentPageIndicatorTintColor = kRedColor;
    }
    return self;
}
- (UIView *)singleDotWithIndex:(NSInteger)index {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.pageIndicatorTintColor;
    view.bounds = self.normalBounds;
    view.center = CGPointMake(3*view.width+12*index, self.height/2);
    view.cornerRadius = view.size.width/2;
    [self addSubview:view];
    return view;
}
#pragma mark--setter
- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage == currentPage) {
        return;
    }
    if (_currentPage>=0) {
        UIView *lastDot = self.dots[_currentPage];
        lastDot.bounds = self.normalBounds;
        lastDot.backgroundColor = self.pageIndicatorTintColor;
        lastDot.cornerRadius = lastDot.width/2;
    }
    UIView *aDot = self.dots[currentPage];
    aDot.bounds = self.selectedBounds;
    aDot.cornerRadius = aDot.width/2;
    aDot.backgroundColor = self.currentPageIndicatorTintColor;
    _currentPage = currentPage;
}
- (void)setNumberOfPages:(NSInteger)numberOfPages {
    if (_numberOfPages != numberOfPages) {
        if (_numberOfPages > numberOfPages) {
            [self.dots removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(numberOfPages, _numberOfPages-numberOfPages)]];
        }else {
            for (int i =0; i<numberOfPages-_numberOfPages; i++) {
                UIView *dot = [self singleDotWithIndex:i+_numberOfPages];
                [self.dots addObject:dot];
            }
        }
        _numberOfPages = numberOfPages;
        CGFloat width = _numberOfPages*self.normalBounds.size.width+self.selectedBounds.size.width*(_numberOfPages+1);
        self.frame = CGRectMake(self.maxX-width, self.y, width, self.height);
    }
    [self setCurrentPage:0];
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    if (_pageIndicatorTintColor != pageIndicatorTintColor) {
        _pageIndicatorTintColor = pageIndicatorTintColor;
    }
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    if (_currentPageIndicatorTintColor != currentPageIndicatorTintColor) {
        _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    }
}
#pragma mark--getter
- (CGRect)selectedBounds {
    return CGRectMake(0,0,8, 8);
}
- (CGRect)normalBounds {
    return CGRectMake(0,0,4, 4);
}
- (NSMutableArray *)dots {
    if (!_dots) {
        _dots = [NSMutableArray array];
    }
    return _dots;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
