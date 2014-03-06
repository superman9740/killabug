//
//  ScoreViewController.h
//  MM
//
//  Created by Philips on 12/18/13.
//  Copyright (c) 2013 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface ScoreViewController : UIViewController<GKLeaderboardViewControllerDelegate>
- (IBAction)showGC;
@property (weak, nonatomic) IBOutlet UILabel *localScoreText;
@property (weak, nonatomic) IBOutlet UILabel *localScoreTextZen;

@end
