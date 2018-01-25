//
//  PCDSelectViewController.h
//  UniteRoute
//
//  Created by zz on 19/01/2018.
//  Copyright © 2018 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
@protocol PCDSelectViewControllerDelegate;
@interface PCDSelectViewController : UIViewController

@property (nonatomic,assign)id<PCDSelectViewControllerDelegate> delegate;
@end

typedef void(^ToggleBlock)(Province*,BOOL);
@interface ProvinceSectionHeader : UITableViewHeaderFooterView

@property (nonatomic,retain)Province* province;
- (void)configureToggleBlock:(ToggleBlock)block;
@end

@protocol PCDSelectViewControllerDelegate<NSObject>
- (void)didSelect:(Province*)province city:(City*)city area:(Area*)area;
@end

