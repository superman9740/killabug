//
//  MenuViewController.h
//  MM
//
//  Created by Philips on 12/14/13.
//  Copyright (c) 2013 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface MenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *gameCenterShow;
@property (weak, nonatomic) IBOutlet UIButton *soundONOFF;


- (IBAction)showGCAction;
- (IBAction)soundBtn:(id)sender;
- (IBAction)zenModeStart:(id)sender;
- (IBAction)arcadeModeStart:(id)sender;
- (IBAction)facebookOpen;
- (IBAction)googlePlustOpen;
- (IBAction)twitterOpen;
- (IBAction)sendEmail;

@property (weak, nonatomic) IBOutlet UIButton *removeAdsBtn;

@end
