//
//  UIView+ZYExtention.m
//  UniteRoute
//
//  Created by zz on 2016/12/1.
//  Copyright © 2016年 Klaus. All rights reserved.
//test

#import "UIView+ZYExtention.h"
#define KEdgeWidth 15
@implementation UIView (ZYExtention)

+ (UIView*)viewWithTitle:(NSString*)title titleFont:(UIFont*)titleFont titleColor:(UIColor*)titleColor subTitle:(NSString*)subTitle subTitleFont:(UIFont*)subTitleFont subTitltColor:(UIColor*)subTitltColor{
    UIView* titleView = [[UIView alloc] init];
    
    UILabel* titleLabel = [UILabel labelWithTextColor:titleColor?titleColor:kBlackColor font:titleFont?titleFont:KSUser.fourteenFont];
    titleLabel.text = title;
    
    UILabel* subTitleLabel = [UILabel labelWithTextColor:subTitltColor?subTitltColor:kBlackColor font:subTitleFont?subTitleFont:KSUser.fourteenFont];
    subTitleLabel.text = subTitle;
    
    [titleView sd_addSubviews:@[titleLabel,subTitleLabel]];
    {
        titleLabel.sd_layout
        .leftSpaceToView(titleView,KEdgeWidth)
        .centerYEqualToView(titleView)
        .autoHeightRatio(0);
        [titleLabel setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
        
        subTitleLabel.sd_layout
        .rightSpaceToView(titleView,KEdgeWidth)
        .centerYEqualToView(titleView)
        .autoHeightRatio(0);
        [subTitleLabel setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
    }
    
    return titleView;
}

+ (CGFloat)labelHeightWithAttributes:(NSDictionary*)attrDic line:(NSUInteger)lineNum{
    NSString* testStr = @"Line0";
    if (lineNum > 1) {
        for (int i = 0; i < lineNum - 1; i ++) {
            [testStr stringByAppendingFormat:@"\nLine%d",i + 1];
        }
    }
    UILabel* label = [[UILabel alloc]init];
    label.numberOfLines = lineNum;
    if (attrDic) {
        label.attributedText = [[NSAttributedString alloc]initWithString:testStr attributes:attrDic];
    }else{
        label.text = testStr;
    }
    [label sizeToFit];
    return label.frame.size.height;
}

+ (UIView*)viewWithTitle:(NSString*)title leftSubTitle:(NSString*)leftSubTitle leftSubAlignmentLeft:(BOOL)alignmentLeft leftSubLeftSpace:(CGFloat)leftSpace rightSubTitle:(NSString*)rightSubTitle colors:(NSArray<UIColor*>*)colors fonts:(NSArray<UIFont*>*)fonts{
    UIView* view = [[UIView alloc] init];
    
    NSMutableArray* titlesArr = @[].mutableCopy;
    if (title) {
        [titlesArr addObject:title];
    }
    if (leftSubTitle) {
        [titlesArr addObject:leftSubTitle];
    }
    if (rightSubTitle) {
        [titlesArr addObject:rightSubTitle];
    }

    NSMutableArray<UILabel*>* labelsArr = @[].mutableCopy;
    for (int i = 0; i < titlesArr.count; i ++) {
        UILabel* label = [UILabel labelWithTextColor:colors[i] font:fonts[i]];
        label.tag = 10 + i;
        label.text = titlesArr[i];
        [labelsArr addObject:label];
        [view addSubview:label];
    }
    
    {
        if (labelsArr.count > 0) {
            labelsArr[0].sd_layout
            .leftSpaceToView(view,KEdgeWidth)
            .centerYEqualToView(view)
            .autoHeightRatio(0);
            [labelsArr[0] setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
        }
        
        if (labelsArr.count > 1) {
            if (leftSubTitle) {
                if (alignmentLeft) {
                    labelsArr[1].sd_layout
                    .leftSpaceToView(view,leftSpace)
                    .centerYEqualToView(view)
                    .autoHeightRatio(0);
                    [labelsArr[1] setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
                }else{
                    labelsArr[1].sd_layout
                    .leftSpaceToView(labelsArr[0],leftSpace)
                    .centerYEqualToView(view)
                    .autoHeightRatio(0);
                    [labelsArr[1] setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
                }
                
            }else if (rightSubTitle){
                labelsArr[1].sd_layout
                .rightSpaceToView(view,KEdgeWidth)
                .centerYEqualToView(view)
                .autoHeightRatio(0);
                [labelsArr[1] setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
                if (labelsArr.count == 2) {
                    return view;
                }
            }
        }
        
        if (labelsArr.count > 2) {
            labelsArr[2].sd_layout
            .rightSpaceToView(view,KEdgeWidth)
            .centerYEqualToView(view)
            .autoHeightRatio(0);
            [labelsArr[2] setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
        } 
    }
    
    return view;
}

+ (UIView*)viewWithTitle:(NSString*)title leftSubTitle:(NSString*)leftSubTitle rightSubTitle:(NSString*)rightSubTitle colors:(NSArray<UIColor*>*)colors fonts:(NSArray<UIFont*>*)fonts rightClosureImage:(NSString*)closureImageName{
    UIView* view = [[UIView alloc] init];
    NSMutableArray* titlesArr = @[].mutableCopy;
    if (title) {
        [titlesArr addObject:title];
    }
    if (leftSubTitle) {
        [titlesArr addObject:leftSubTitle];
    }
    if (rightSubTitle) {
        [titlesArr addObject:rightSubTitle];
    }
    
    UIImageView* closureIV = nil;
    UIImage* image = nil;
    if (closureImageName&&closureImageName.length > 0) {
        closureIV = [[UIImageView alloc]init];
        image = [UIImage imageNamed:closureImageName];
        closureIV.image = image;
        [view addSubview:closureIV];
    }
    
    NSMutableArray<UILabel*>* labelsArr = @[].mutableCopy;
    for (int i = 0; i < titlesArr.count; i ++) {
        UILabel* label = [UILabel labelWithTextColor:colors[i] font:fonts[i]];
        label.tag = 10 + i;
        label.text = titlesArr[i];
        [labelsArr addObject:label];
        [view addSubview:label];
    }
    
    {
        /*布局ClosureImamgeView*/
        if (image) {
            closureIV.sd_layout
            .rightSpaceToView(view, kEdgeWidth)
            .centerYEqualToView(view)
            .widthIs(image.size.width)
            .heightIs(image.size.height);
        }
        
        /*布局第一个Label */
        if (labelsArr.count > 0) {//titleLabel或者leftSubLabel或者rightSubTitle
            if (title) {//目前只处理这种情况
                labelsArr[0].sd_layout
                .leftSpaceToView(view,KEdgeWidth)
                .centerYEqualToView(view)
                .autoHeightRatio(0);
                [labelsArr[0] setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
            }else if (leftSubTitle){
                labelsArr[0].sd_layout
                .leftSpaceToView(view,100)
                .centerYEqualToView(view)
                .autoHeightRatio(0);
                [labelsArr[0] setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
                
            }else if (rightSubTitle){
                labelsArr[0].sd_layout
                .leftSpaceToView(view,KEdgeWidth)
                .centerYEqualToView(view)
                .autoHeightRatio(0);
                [labelsArr[0] setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
            }
        }
        
        /*布局第二个Label */
        if (labelsArr.count > 1) {
            if (labelsArr.count > 2) {//leftSubLabel
                labelsArr[1].sd_layout
                .leftSpaceToView(labelsArr[0],KEdgeWidth)
                .centerYEqualToView(view)
                .autoHeightRatio(0);
                
                if (image) {
                    labelsArr[1].sd_layout.rightSpaceToView(image, kEdgeWidth);
                }else{
                    labelsArr[1].sd_layout.rightSpaceToView(view, kEdgeWidth);
                }
            }else{
                if (!rightSubTitle) {//leftSubLabel左侧根据titleLable布局
                    labelsArr[1].sd_layout
                    .leftSpaceToView(labelsArr[0],kEdgeWidth)
                    .centerYEqualToView(view)
                    .autoHeightRatio(0);
                    
                    [labelsArr[1] setSingleLineAutoResizeWithMaxWidth:kScreenWidth];
                }else{//rightSubLabel根据titleLabel或leftSubLabel布局
                    labelsArr[1].textAlignment = NSTextAlignmentRight;
                    labelsArr[1].sd_layout
                    .leftSpaceToView(labelsArr[0],KEdgeWidth)
                    .centerYEqualToView(view)
                    .autoHeightRatio(0);
                    if (image) {
                        labelsArr[1].sd_layout.rightSpaceToView(closureIV, 0);
                    }else{
                        labelsArr[1].sd_layout.rightSpaceToView(view, kEdgeWidth);
                    }
                }
            }
        }
        
        /*布局第三个Label */
        if (labelsArr.count > 2) {//rightSubLabel
            labelsArr[2].textAlignment = NSTextAlignmentRight;
            labelsArr[2].sd_layout
            .leftSpaceToView(labelsArr[1],KEdgeWidth)
            .centerYEqualToView(view)
            .autoHeightRatio(0);
            
            if (image) {
                labelsArr[2].sd_layout.rightSpaceToView(image, kEdgeWidth);
            }else{
                labelsArr[2].sd_layout.rightSpaceToView(view, kEdgeWidth);
            }
        }
    }
    
    return view;
}

+ (UIView *)addSeparatorLineBelow:(BOOL)below view:(UIView *)view toParentView:(UIView*)parentView margin:(CGFloat)margin leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin height:(CGFloat)height
{
    UIView *line = [UIView new];
//    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    line.backgroundColor = [UIColor colorWithHexString:@"#dcdcdc"];
    [parentView addSubview:line];
    
    line.sd_layout
    .leftSpaceToView(parentView, leftMargin)
    .rightSpaceToView(parentView, rightMargin)
    .heightIs(height);
    
    if (below) {
        line.sd_layout.topSpaceToView(view,margin);
    }else{
        line.sd_layout.bottomSpaceToView(view,margin);
    }
    
    return line;
}

+ (UIView *)addSeparatorLineRight:(BOOL)right toView:(UIView *)view parentView:(UIView*)parentView margin:(CGFloat)margin topMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin width:(CGFloat)width
{
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:@"#dcdcdc"];
    
    [parentView addSubview:line];
    
    line.sd_layout
    .bottomSpaceToView(parentView,bottomMargin)
    .widthIs(width)
    .topSpaceToView(parentView,topMargin);
    
    if (right) {
        line.sd_layout.leftSpaceToView(view,margin);
    }else{
        line.sd_layout.rightSpaceToView(view,margin);
    }
    
    return line;
}

@end
