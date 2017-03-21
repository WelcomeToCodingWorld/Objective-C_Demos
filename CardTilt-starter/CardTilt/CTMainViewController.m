//
//  CTMainViewController.m
//  CardTilt
//
//  Created by Brian Broom on 8/16/13.
//  Copyright (c) 2013 Brian Broom. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "CTMainViewController.h"
#import "CTTableViewDataSource.h"
#import "CTCardCell.h"

@interface CTMainViewController () <UITableViewDelegate>

@property (assign, nonatomic) CATransform3D initialTransformation;
@property (strong, nonatomic) NSMutableSet *shownIndexes;

@property (strong, nonatomic) CTTableViewDataSource * dataSource;

@end

@implementation CTMainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [[CTTableViewDataSource alloc] init];
    self.view.dataSource = self.dataSource;
    self.view.delegate = self;

    self.view.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    
    CGFloat rotationAngleDegrees = -15;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPositioning = CGPointMake(-20, -20);
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
    self.initialTransformation = transform;
    
    self.shownIndexes = [NSMutableSet set];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.shownIndexes containsObject:indexPath]) {        
        UIView *card = [(CTCardCell* )cell mainView];
        
        card.layer.transform = self.initialTransformation;
        card.layer.opacity = 0.8;
        
        [UIView animateWithDuration:0.4 animations:^{
            card.layer.transform = CATransform3DIdentity;
            card.layer.opacity = 1;
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    NSString *aboutText = self.dataSource.members[indexPath.row][@"about"];
    NSString *newAboutText = [aboutText stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    
    CGRect boundingRect = [newAboutText boundingRectWithSize:CGSizeMake(268, 4000)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:font}
                                                     context:nil];
    
    CGSize aboutSize = boundingRect.size;
    
    return (280-15+aboutSize.height);
}

@end
