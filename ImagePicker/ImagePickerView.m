//
//  ImagePickerView.m
//  UniteRoute
//
//  Created by zz on 2016/12/8.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "ImagePickerView.h"
#define KEdgeWidth 15
@interface ImagePickerView ()
{
    UIView* _photosView;
}

@property (nonatomic,retain)NSMutableArray<UIImageView*>* imageViewsArr;
@property (nonatomic,assign)CGFloat verticalSpace;
@property (nonatomic,assign)CGFloat verticalEdgeInset;
@property (nonatomic,assign)CGFloat horizontalEdgeInset;
@property (nonatomic,assign)CGFloat itemWidth;
@property (nonatomic,assign)CGFloat HWRatio;
@property (nonatomic,assign)NSInteger itemsPerRow;
@property (nonatomic,retain)UIButton* photoAddButton;
@end
@implementation ImagePickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        [self setupView];
    }
    return self;
}

- (void)initialize{
    self.imageViewsArr = @[].mutableCopy;
    self.verticalSpace = 12;
    self.verticalEdgeInset = KEdgeWidth;
    self.horizontalEdgeInset = 12;
    self.itemWidth = 70;
    self.itemsPerRow = 4;
    self.HWRatio = 1;
}

- (void)setupView{
    [self addImageViewForPhotosView];
}


- (void)addImageViewForPhotosView{
    if (_imageViewsArr.count > 4) {
        _imageViewsArr.lastObject.userInteractionEnabled = YES;
        [_photoAddButton removeFromSuperview];
        _photoAddButton = nil;
        return;
    }
    UIImageView* imageView = [UIImageView new];
    if (self.currentImageView) {
        self.currentImageView.userInteractionEnabled = YES;
    }
    
    self.currentImageView = imageView;
    
    [_imageViewsArr addObject:imageView];
    
    [self addSubview:imageView];
    
    imageView.sd_layout.autoHeightRatio(1);
    
    UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(edit:)];
    longPressGesture.minimumPressDuration = 0.5;
    longPressGesture.allowableMovement = 5;
    [imageView addGestureRecognizer:longPressGesture];
    [self layoutPhotosView];
}

- (UIButton *)photoAddButton{
    if (!_photoAddButton) {
        _photoAddButton = [UIButton buttonAddTarget:self action:@selector(imagePick) withTitle:nil imageNamed:@"js_camera"];
        _photoAddButton.bounds = CGRectMake(0, 0, 22, 22);
        [self addSubview:_photoAddButton];
    }
    return _photoAddButton;
}

#pragma mark-- Public
- (void)setVerticalSpace:(CGFloat)verticalSpace verticalEdgeInset:(CGFloat)verticalEdgeInset horizontalEdgeInset:(CGFloat)horizontalEdgeInset itemWidth:(CGFloat)itemWidth HWRatio:(CGFloat)hwRatio{
    self.verticalSpace = verticalSpace;
    self.verticalEdgeInset = verticalEdgeInset;
    self.horizontalEdgeInset = horizontalEdgeInset;
    self.HWRatio = hwRatio;
    self.itemWidth = itemWidth;
}

- (void)layoutPhotosView{
    NSInteger index = 0;
    CGFloat horizontalSpace = (kScreenWidth - 2*self.horizontalEdgeInset - self.itemsPerRow*self.itemWidth)/(self.itemsPerRow - 1);
    for (UIImageView* imageView in self.imageViewsArr) {
        imageView.frame = CGRectMake(self.horizontalEdgeInset + (index%self.itemsPerRow)*(self.itemWidth + horizontalSpace),self.verticalEdgeInset +(index/self.itemsPerRow)*(self.itemWidth*self.HWRatio + self.verticalSpace) , self.itemWidth, self.itemWidth*self.HWRatio);
        index ++;
    }
    
    
    
    self.photoAddButton.center = self.imageViewsArr.lastObject.center;
    [self bringSubviewToFront:self.photoAddButton];
    self.height = self.imageViewsArr.lastObject.maxY + self.verticalEdgeInset;
}

#pragma mark-- RespondSelector
- (void)edit:(UILongPressGestureRecognizer*)gesture{
    if ([self.delegate respondsToSelector:@selector(imagePickerView:editWithGesture:imageViewsArr:)]) {
        [self.delegate imagePickerView:self editWithGesture:gesture imageViewsArr:self.imageViewsArr];
    }
}

- (void)imagePick{//选择照片或拍照
    if ([self.delegate respondsToSelector:@selector(imagePickWithCurrentImageView:)]) {
        [self.delegate imagePickWithCurrentImageView:self.currentImageView];
    }
}
                                      
@end
