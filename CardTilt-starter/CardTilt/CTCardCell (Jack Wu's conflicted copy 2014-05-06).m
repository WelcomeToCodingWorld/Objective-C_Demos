//
//  CTCardCell.m
//  CardTilt
//
//  Created by Brian Broom on 8/16/13.
//  Copyright (c) 2013 Brian Broom. All rights reserved.
//

#import "CTCardCell.h"
#import <QuartzCore/QuartzCore.h>

@interface CTCardCell ()


@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) NSString *website;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (weak, nonatomic) IBOutlet UIImageView *fbImage;
@property (strong, nonatomic) NSString *twitter;
@property (weak, nonatomic) IBOutlet UIButton *twButton;
@property (weak, nonatomic) IBOutlet UILabel *webLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (strong, nonatomic) NSString *facebook;
@property (weak, nonatomic) IBOutlet UIImageView *twImage;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UIButton *webButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CTCardCell

- (void)setupWithDictionary:(NSDictionary *)dictionary
{
    self.mainView.layer.cornerRadius = 10;
    self.mainView.layer.masksToBounds = YES;    
    
    self.profilePhoto.image = [UIImage imageNamed:dictionary[@"image"]];
    
    self.nameLabel.text = dictionary[@"name"];
    self.titleLabel.text = dictionary[@"title"];
    self.locationLabel.text = dictionary[@"location"];
    
    NSString *aboutText = dictionary[@"about"];
    self.aboutLabel.text = [aboutText stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    
    self.website = dictionary[@"web"];
    if (self.website) {
        self.webLabel.text = self.website;
    } else {
        self.webLabel.hidden = YES;
        self.webButton.hidden = YES;
    }
    
    self.twitter = dictionary[@"twitter"];
    if (!self.twitter) {
        self.twImage.hidden = YES;
        self.twButton.hidden = YES;
    } else {
        self.twImage.hidden = NO;
        self.twButton.hidden = NO;
    }
    
    self.facebook = dictionary[@"facebook"];
    if (!self.facebook) {
        self.fbImage.hidden = YES;
        self.fbButton.hidden = YES;
    } else {
        self.fbImage.hidden = NO;
        self.fbButton.hidden = NO;
    }
}

- (IBAction)launchWeb:(id)sender
{
    if (self.website) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.website]];
    }
}

- (IBAction)launchTwitter:(id)sender
{
    if (self.twitter) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.twitter]];
    }
}


- (IBAction)launchFacebook:(id)sender
{
    if (self.facebook) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.facebook]];
    }
}

@end
