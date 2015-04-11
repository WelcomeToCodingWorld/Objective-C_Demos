//
//  CTCardCell.h
//  CardTilt
//
//  Created by Brian Broom on 8/16/13.
//  Copyright (c) 2013 Brian Broom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;

- (void)setupWithDictionary:(NSDictionary *)dictionary;

@end
