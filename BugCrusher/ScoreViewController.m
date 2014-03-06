//
//  ScoreViewController.m
//  MM
//
//  Created by Philips on 12/18/13.
//  Copyright (c) 2013 Leo. All rights reserved.
//

#import "ScoreViewController.h"
#import "Helper.h"
@interface ScoreViewController ()
@property ( nonatomic, strong) Helper *hlp;

@end

@implementation ScoreViewController
@synthesize hlp;
@synthesize localScoreText;
@synthesize localScoreTextZen;
-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    hlp = [[Helper alloc] init];
    
    [hlp makeFileWithName:@"settings.plist" andWriteToIt:[hlp settings]];
    localScoreText.text = [hlp getStringFromFile:@"settings.plist" What:@"scoreArcade"];
    localScoreTextZen.text = [hlp getStringFromFile:@"settings.plist" What:@"scoreZen"];

    
            localScoreText.font = localScoreTextZen.font  = [UIFont fontWithName:@"Mousou Record__G" size:30];

    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showGC {
    GKLeaderboardViewController  *leaderboard = [[GKLeaderboardViewController alloc] init];
    if ( leaderboard != nil)
    {
        leaderboard.leaderboardDelegate = self;
        leaderboard.viewState = GKGameCenterViewControllerStateLeaderboards;
        leaderboard.leaderboardTimeScope = GKLeaderboardTimeScopeToday;
        leaderboard.leaderboardCategory = @"com.leo.Termite.ArcadeMode";
        [self presentViewController:leaderboard animated:YES completion:nil];

    }
    

}

- (void)viewDidUnload {
    [self setLocalScoreText:nil];
    [self setLocalScoreTextZen:nil];
    [super viewDidUnload];
}
@end
