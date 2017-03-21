//
//  ProgressView.h
//  UniteRoute
//
//  Created by zz on 2016/12/10.
//  Copyright © 2016年 Klaus. All rights reserved.
//如果finished且想要operateButton,则应该先设置buttonTitle,再设置finished,若buttonTitle不满足条件，则不会创建operateButton

#import <UIKit/UIKit.h>
@protocol ProgressViewDelegate;
@interface ProgressView : UIView
@property (nonatomic,retain)NSArray<NSArray*>* progressStatusArr;
@property (nonatomic,assign)BOOL finished;
@property (nonatomic,assign)BOOL indicateAtMiddle;
@property (nonatomic,copy)NSString* buttonTitle;
@property (nonatomic,assign)id<ProgressViewDelegate> delegate;

- (instancetype)initWithProgressStatusArr:(NSArray<NSArray*>*)statusArr;
@end

@protocol ProgressViewDelegate <NSObject>
@optional
- (void)didSelectFooterOperationButton;
@end
