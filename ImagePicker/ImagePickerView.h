//
//  ImagePickerView.h
//  UniteRoute
//
//  Created by zz on 2016/12/8.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  ImagePickerViewDelegate;
@interface ImagePickerView : UIView


@property (nonatomic,retain)UIImageView* currentImageView;
@property (nonatomic,assign)id<ImagePickerViewDelegate> delegate;



/**
 布局ImageView
 */
- (void)layoutPhotosView;


/**
 设置基本属性

 @param verticalSpace       照片竖直间距
 @param verticalEdgeInset   照片竖直间隙
 @param horizontalEdgeInset 照片水平间隙
 @param itemWidth           照片宽度
 @param hwRatio             高宽比
 */
- (void)setVerticalSpace:(CGFloat)verticalSpace verticalEdgeInset:(CGFloat)verticalEdgeInset horizontalEdgeInset:(CGFloat)horizontalEdgeInset itemWidth:(CGFloat)itemWidth HWRatio:(CGFloat)hwRatio;


/**
 继续添加新的照片
 */
- (void)addImageViewForPhotosView;
@end

@protocol  ImagePickerViewDelegate<NSObject>
- (void)imagePickWithCurrentImageView:(UIImageView*)currentImageView;

- (void)imagePickerView:(ImagePickerView*)imagePickerView editWithGesture:(UILongPressGestureRecognizer *)gesture imageViewsArr:(NSMutableArray<UIImageView *> *)imageViewsArr;


@end

