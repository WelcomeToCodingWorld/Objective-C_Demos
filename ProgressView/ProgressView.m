//
//  ProgressView.m
//  UniteRoute
//
//  Created by zz on 2016/12/10.
//  Copyright © 2016年 Klaus. All rights reserved.

#import "ProgressView.h"
static CGFloat ImageWidth = 8;
static CGFloat SeparatorLineWidth = 1;
@interface ProgressView ()
@property (nonatomic,retain)NSMutableArray<UILabel*>* titleLabelsArr;
@property (nonatomic,retain)NSMutableArray<UIView*>* itemViewsArr;
@property (nonatomic,retain)NSMutableArray<UIImageView*>* indicatorIVsArr;
@property (nonatomic,retain)NSMutableArray<UIView*>* innerTopSeparatorViewsArr;
@property (nonatomic,retain)NSMutableArray<UIView*>* innerBottomSeparatorViewsArr;
@property (nonatomic,retain)NSMutableArray<UIView*>* outerSeparatorViewsArr;
@property (nonatomic,retain)UIButton* operateButton;
@end

@implementation ProgressView
- (instancetype)initWithProgressStatusArr:(NSArray<NSArray*>*)statusArr{
    self = [super init];
    if (self) {
        [self initialize];
        self.progressStatusArr = statusArr;
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.titleLabelsArr = @[].mutableCopy;
    self.itemViewsArr = @[].mutableCopy;
    self.indicatorIVsArr = @[].mutableCopy;
    self.innerTopSeparatorViewsArr = @[].mutableCopy;
    self.innerBottomSeparatorViewsArr = @[].mutableCopy;
    self.outerSeparatorViewsArr = @[].mutableCopy;
}

- (void)setupView{
    UIView* lastView = self;
    NSInteger index =  0;
    for (NSArray* item in self.progressStatusArr) {//创建itemViews
        UIView* itemView;
        if (index == 0) {
            itemView = [self itemViewWithItemsArr:item withFont:KSUser.twelveFont color:kBlueColor];
            [self.itemViewsArr addObject:itemView];
            [self addSubview:itemView];
            itemView.sd_layout
            .leftEqualToView(self)
            .rightEqualToView(self)
            .topSpaceToView(self,12);
        }else{
            itemView = [self itemViewWithItemsArr:item withFont:KSUser.twelveFont color:kDarkGray];
            [self.itemViewsArr addObject:itemView];
            [self addSubview:itemView];
            itemView.sd_layout
            .leftEqualToView(lastView)
            .rightEqualToView(lastView)
            .topSpaceToView(lastView,6);
        }
        lastView = itemView;
        index ++;
    }
    
    for (int i = 0; i< self.itemViewsArr.count;i ++) {//创建outerSeparatorLines
        UIView *separatorLine = nil;
        separatorLine = [UIView new];
        separatorLine.backgroundColor = [UIColor colorWithHexString:@"#d2d2d2"];
        [self addSubview:separatorLine];
        [self.outerSeparatorViewsArr addObject:separatorLine];
    }
    [self refreshOutlinesLayout];
    
    [self finishHandle];

    [self setupIndicatorViewWithStatusArr:self.progressStatusArr];
}

- (void)setupIndicatorViewWithStatusArr:(NSArray*)statusArr{
    for (int i = 0; i < self.itemViewsArr.count; i ++) {//创建IVs
        UIImageView* indicatorIV = [UIImageView new];
        [self.indicatorIVsArr addObject:indicatorIV];
        [self.itemViewsArr[i] addSubview:indicatorIV];
        if (i == 0) {
            indicatorIV.image = [UIImage imageNamed:@"icon_ztgz"];
        }else{
            indicatorIV.image = [UIImage imageNamed:@"icon_ztgz_normal"];

        }
    }
    [self refreshIVsLayout];
    
    
    for (int i = 1; i < self.indicatorIVsArr.count; i ++) {//创建innerTopLines
        UIView *innerTopLine = nil;
        innerTopLine = [UIView new];
        innerTopLine.backgroundColor = [UIColor colorWithHexString:@"#d2d2d2"];
        [self.itemViewsArr[i] addSubview:innerTopLine];
        [self.innerTopSeparatorViewsArr addObject:innerTopLine];
    }
    [self refreshInnerTopLinesSepatorLayout];
    
    
    for (int i = 0; i < self.indicatorIVsArr.count; i ++) {//创建innerBottomLines
        UIView *innerBottomLine = nil;
        innerBottomLine = [UIView new];
        innerBottomLine.backgroundColor = [UIColor colorWithHexString:@"#d2d2d2"];
        [self.itemViewsArr[i] addSubview:innerBottomLine];
        [self.innerBottomSeparatorViewsArr addObject:innerBottomLine];
  
    }
    [self refreshInnerBottomLinesSepatorLayout];
}

- (void)refreshOutlinesLayout{//布局outerLines
    NSInteger idx = 0;
    for (UIView* lineView in self.outerSeparatorViewsArr) {
        lineView.sd_layout
        .topSpaceToView(self.itemViewsArr[idx],0)
        .leftSpaceToView(self,kEdgeWidth + (ImageWidth - SeparatorLineWidth)/2)
        .widthIs(SeparatorLineWidth);
        
        if (idx < self.outerSeparatorViewsArr.count - 1) {
            lineView.sd_layout
            .bottomSpaceToView(self.itemViewsArr[idx + 1],0);
        }else{
            if(!self.finished){
                lineView.sd_layout
                .bottomEqualToView(self);
                [self setupAutoHeightWithBottomView:self.itemViewsArr.lastObject bottomMargin:50];
            }else{
                lineView.sd_layout
                .heightIs(0);
                if (_operateButton) {
                    [self setupAutoHeightWithBottomView:self.operateButton bottomMargin:24];
                }else{
                    [self setupAutoHeightWithBottomView:self.itemViewsArr.lastObject bottomMargin:50];
                }
            }
        }
        idx ++;
    }
}

- (void)refreshInnerBottomLinesSepatorLayout{//布局innerBottomLines
    NSInteger idx = 0;
    for (UIView* separatorLine in self.innerBottomSeparatorViewsArr) {
        separatorLine.sd_resetLayout
        .topSpaceToView(self.indicatorIVsArr[idx],0)
        .centerXEqualToView(self.indicatorIVsArr[idx])
        .widthIs(SeparatorLineWidth)
        .bottomEqualToView(self.itemViewsArr[idx]);
        if (idx == self.innerBottomSeparatorViewsArr.count - 1&&self.finished) {
            separatorLine.sd_resetLayout
            .topSpaceToView(self.indicatorIVsArr[idx],0)
            .centerXEqualToView(self.indicatorIVsArr[idx])
            .widthIs(SeparatorLineWidth)
            .heightIs(0);
        }
        idx ++;
    }
}

- (void)refreshInnerTopLinesSepatorLayout{//布局innerTopLines
    for (int i = 1;i < self.indicatorIVsArr.count; i ++) {
        self.innerTopSeparatorViewsArr[i-1].sd_resetLayout
        .topEqualToView(self.itemViewsArr[i])
        .centerXEqualToView(self.indicatorIVsArr[i])
        .widthIs(SeparatorLineWidth)
        .bottomSpaceToView(self.indicatorIVsArr[i],0);
    }
}

- (void)refreshIVsLayout{//布局indicatorViews
    NSInteger idx = 0;
    for (UIImageView* indicatorIV in self.indicatorIVsArr) {//布局IVs
        indicatorIV.sd_resetLayout
        .leftSpaceToView(self.itemViewsArr[idx],kEdgeWidth)
        .widthIs(ImageWidth)
        .heightEqualToWidth();
        
        indicatorIV.sd_cornerRadius = @(ImageWidth/2);
        
        if (!self.indicateAtMiddle) {
            indicatorIV.sd_layout
            .centerYEqualToView(self.titleLabelsArr[idx]);
        }else{
            indicatorIV.sd_layout
            .centerYEqualToView(self.itemViewsArr[idx]);
        }
        idx ++;
    }
}

#pragma mark-- Setter

- (void)setFinished:(BOOL)finished{
    _finished = finished;
    
    [self finishHandle];
    [self refreshInnerBottomLinesSepatorLayout];
    [self refreshOutlinesLayout];
}

- (void)finishHandle{
    if (self.finished) {
        if (self.buttonTitle&&![self.buttonTitle isEqualToString:@""]) {//创建OperateButton
            self.operateButton.sd_layout
            .topSpaceToView(self.itemViewsArr.lastObject,24)
            .centerXEqualToView(self)
            .widthIs(120)
            .heightIs(30);
            [self.operateButton setTitle:self.buttonTitle forState:UIControlStateNormal];
        }
    }else{
        if (_operateButton) {
            [_operateButton removeFromSuperview];
            _operateButton = nil;
        }
    }
}

- (void)setIndicateAtMiddle:(BOOL)indicateAtMiddle{
    _indicateAtMiddle = indicateAtMiddle;
    [self refreshIVsLayout];
}

- (void)setProgressStatusArr:(NSArray<NSArray *> *)progressStatusArr{
    _progressStatusArr = progressStatusArr;
    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
    [self setupView];
}

- (void)setButtonTitle:(NSString *)buttonTitle{
    _buttonTitle = buttonTitle;
    if (_operateButton) {
        [_operateButton setTitle:buttonTitle forState:UIControlStateNormal];
    }
}

#pragma mark-- Getter
- (UIButton *)operateButton{
    if (!_operateButton) {
        _operateButton = [UIButton buttonAddTarget:self action:@selector(operate) withTitle:nil imageNamed:nil];
        _operateButton.backgroundColor = kBlueColor;
        [_operateButton setTitle:self.buttonTitle forState:UIControlStateNormal];
        [_operateButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _operateButton.titleLabel.font = KSUser.fourteenFont;
        _operateButton.layer.cornerRadius = 5.0f;
        _operateButton.layer.masksToBounds = YES;
        [self addSubview:_operateButton];
    }
    return _operateButton;
}



#pragma mark-- Private For View Creating
- (UIView*)itemViewWithItemsArr:(NSArray*)items withFont:(UIFont*)font color:(UIColor*)color{
    UIView* view = [UIView new];
    UIView* lastView = view;
    NSInteger index = 0;
    for (NSString* text in items) {
        UILabel* label = [UILabel new];
        label.text = text;
        label.textColor = color;
        label.font = font;
        [view addSubview:label];
        if (index == 0) {
            [self.titleLabelsArr addObject:label];
            label.sd_layout
            .leftSpaceToView(lastView,2*kEdgeWidth + ImageWidth)
            .topSpaceToView(lastView,12)
            .autoHeightRatio(0);
            [label setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
        }else{
            label.sd_layout
            .leftEqualToView(lastView)
            .topSpaceToView(lastView,12)
            .autoHeightRatio(0);
            [label setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
        }
        lastView = label;
        index ++;
    }
    [view setupAutoHeightWithBottomView:view.subviews.lastObject bottomMargin:12];
    return view;
}

#pragma mark-- RedpondSelector
- (void)operate{
    if ([self.delegate respondsToSelector:@selector(didSelectFooterOperationButton)]) {
        [self.delegate didSelectFooterOperationButton];
    }
}

@end
