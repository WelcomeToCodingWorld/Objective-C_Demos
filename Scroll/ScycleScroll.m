//
//  NewsHeader.m
//  UniteRoute
//
//  Created by Li on 2016/11/11.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "NewsHeader.h"
#import "News.h"
#import "KSPageControl.h"
@interface NewsHeader ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) KSPageControl *pageControl;
@property (nonatomic,strong) UIImageView *leftView,*midView,*rightView;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) News *lastNews;
@property (nonatomic,strong) News *nextNews;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@end
@implementation NewsHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}
- (void)createView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    UIView *view = [[UIView alloc]init];
    [self addSubview:view];
    view.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.4];
    view.frame = CGRectMake(0, self.height-30, kScreenWidth, 30);
    self.pageControl = [[KSPageControl alloc]init];
    [view addSubview:self.pageControl];
    self.pageControl.frame = CGRectMake(kScreenWidth-kEdgeWidth, 0, 0, view.height);
    self.titleLabel = [UILabel labelWithTextColor:kWhiteColor font:[KSUserDefaults shareUserDefaults].twelveFont];
    [view addSubview:self.titleLabel];
    self.titleLabel.sd_layout.leftSpaceToView(view,kEdgeWidth).topEqualToView(view).heightIs(view.height).rightSpaceToView(self.pageControl,kEdgeWidth);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*3, 0);
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(willShowDetailMessage)];
    [self addGestureRecognizer:self.tap];
}
- (void)setHeaderNews:(NSArray *)headerNews {
    _headerNews = headerNews;
    self.scrollView.scrollEnabled = (_headerNews.count>1);
    News *news = _headerNews.firstObject;
    [self.midView sd_setImageWithURL:[NSURL URLWithString:news.contentPath] placeholderImage:nil];
    self.titleLabel.text = news.title;
    self.pageControl.numberOfPages = _headerNews.count;
    [self beginPlay];
}
#pragma mark--getter
- (UIImageView *)leftView {
    if (!_leftView) {
        _leftView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.scrollView addSubview:_leftView];
    }
    return _leftView;
}
- (UIImageView *)midView {
    if (!_midView) {
        _midView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.height)];
        [self.scrollView addSubview:_midView];
    }
    return _midView;
}
- (UIImageView *)rightView {
    if (!_rightView) {
        _rightView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, self.height)];
        [self.scrollView addSubview:_rightView];
    }
    return _rightView;
}
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(scrollPlay) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
#pragma nark--UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.currentIndex == 0) {
        self.lastNews = self.headerNews.lastObject;
    }else {
        self.lastNews = self.headerNews[self.currentIndex-1];
    }
    [self.leftView sd_setImageWithURL:[NSURL URLWithString:self.lastNews.contentPath] placeholderImage:nil];
    if (self.currentIndex == self.headerNews.count-1) {
        self.nextNews = self.headerNews.firstObject;
    }else {
        self.nextNews = self.headerNews[self.currentIndex+1];
    }
    [self.rightView sd_setImageWithURL:[NSURL URLWithString:self.nextNews.contentPath] placeholderImage:nil];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    News *showNews;
    if (index == 2) {
        showNews = self.nextNews;
        self.currentIndex ++;
        self.currentIndex = self.currentIndex%self.headerNews.count;
    }else {
        showNews = self.lastNews;
        self.currentIndex --;
        self.currentIndex = (self.currentIndex+self.headerNews.count)%self.headerNews.count;
    }
    [self.midView sd_setImageWithURL:[NSURL URLWithString:showNews.contentPath] placeholderImage:nil];
    [scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
    self.titleLabel.text = showNews.title;
    self.pageControl.currentPage = self.currentIndex;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}
//滚动播放
- (void)scrollPlay {
    [self scrollViewWillBeginDragging:self.scrollView];
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth*2, 0) animated:YES];
}
//添加点击事件
- (void)willShowDetailMessage {
    if ([self.delegate respondsToSelector:@selector(header:didSelectNews:)]) {
        [self.delegate header:self didSelectNews:self.headerNews[self.currentIndex]];
    }
}
#pragma mark--public
- (void)stopPlay {
    if (_timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)beginPlay {
    if (_timer) {
        return;
    }
    [self timer];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
