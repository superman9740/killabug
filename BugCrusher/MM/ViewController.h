//
//  ViewController.h
//  MM
//
//  Created by Philips on 12/12/13.
//  Copyright (c) 2013 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <iAd/iAd.h>


#import "Helper.h"
#import "Bug.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "UIView+Hierarchy.h"
#import <dispatch/dispatch.h>


#import "defined.h"

#import "GADBannerView.h"
#import "GADRequest.h"


@interface ViewController : UIViewController <GKLeaderboardViewControllerDelegate,UIAlertViewDelegate, GADBannerViewDelegate>
@property ( nonatomic , assign )BOOL bannerIsVisible;
- (IBAction)shareScore;

@property ( nonatomic , assign ) int numberOfBugsAfter;
@property(nonatomic, strong) GADBannerView *adBanner;

@property (weak, nonatomic) IBOutlet UIView *bugView;
- (IBAction)pauseAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *scoreForGMView;
@property (weak, nonatomic) IBOutlet UIView *pauseView;
- (IBAction)PlayFromPause;
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;
@property (weak, nonatomic) IBOutlet UIView *gameOverViewMessage;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;

@property (weak, nonatomic) IBOutlet UILabel *pauseCounterTimerLabel;
- (IBAction)tryAgain;
@property (weak, nonatomic) IBOutlet UIView *gameOverView;
- (GADRequest *)request;

@property ( nonatomic , strong )  id displayLink;
@property ( nonatomic , assign )  int numberOfBugs;
@property ( nonatomic , assign )  int numberOfBugsMax;
@property ( nonatomic , assign )  int score;
@property ( nonatomic , assign )  int bugsPast;
@property ( nonatomic , assign )  int timerTemp;
@property ( nonatomic , assign )  int tempIphoneIpadLess;
@property ( nonatomic , assign )  int tempIphoneIpadMore;
@property ( nonatomic , assign )  int zenModeActive;
@property ( nonatomic , assign )  int harder;
@property ( nonatomic , assign )  int multiPly;
@property ( nonatomic , assign )  int rotation;
@property ( nonatomic , assign )  int speedMulti;
@property ( nonatomic , assign )  int LetItHarder;
@property ( nonatomic , assign )  int changeRot;
@property ( nonatomic , strong )  NSTimer *pauseTimer;
@property ( nonatomic , strong )  NSMutableArray *bugsCol;
@property ( nonatomic , strong )  Helper *hlp;
@property ( nonatomic , strong )  Bug *bugTemp;
@property ( nonatomic , strong ) AVAudioPlayer *maul;
@property ( nonatomic , assign ) NSString *pathh;
@property ( nonatomic , strong ) NSURL *filePath;
@property ( nonatomic , assign ) bool hasSound;


@property ( nonatomic , assign ) int timesPlayed;


-(void)adSetup;

@end
