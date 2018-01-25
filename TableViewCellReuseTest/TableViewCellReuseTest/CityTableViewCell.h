//
//  CityTableViewCell.h
//  UniteRoute
//
//  Created by zz on 19/01/2018.
//  Copyright © 2018 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class City;
@class Area;
typedef void(^ChooseBlock) (Area*,City*);
@interface CityTableViewCell : UITableViewCell
@property (nonatomic,retain)City* city;
- (void)configureTapBlock:(ChooseBlock)tapBlock;
@end
