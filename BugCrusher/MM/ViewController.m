//
//  ViewController.m
//  MM
//
//  Created by Philips on 12/12/13.
//  Copyright (c) 2013 Leo. All rights reserved.
//


#import "ViewController.h"
#define kSampleAdUnitID @"ca-app-pub-7901724554260581/1607092555"


@interface ViewController ()


@end

@implementation ViewController


dispatch_queue_t myQueue;
dispatch_queue_t myQueue_s;

SystemSoundID soundID;


- (void)viewDidLoad
{
    [super viewDidLoad];
    myQueue = dispatch_queue_create("com", NULL);
    myQueue_s = dispatch_queue_create("sss", NULL);

   

    [self cheskItsZenOrArcade];
    [self checkDeviceIsIpadOrIphone];
    
    [self setupTheValues];
    
    [self setupSound];
    
    [self setupAdvertismentWith:k_app_comes_with_this_Ad]; // if don't want to show ADS banner , just comment this line!
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pauseAction:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pauseAction:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];

   
    int saved =   [[_hlp getStringFromFile:@"settings.plist" What:@"ADS"] intValue];
    
    
    if (!saved)
    {
        NSLog(@"we have ads");
        
        CGPoint origin = CGPointMake(0.0,
                                     self.view.frame.size.height -
                                     CGSizeFromGADAdSize(kGADAdSizeBanner).height);
        
        
        self.adBanner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:origin];
        
        self.adBanner.adUnitID = kSampleAdUnitID;
        self.adBanner.delegate = self;
        self.adBanner.rootViewController = self;
        [self.view addSubview:self.adBanner];
        [self.adBanner loadRequest:[self request]];
        self.bannerIsVisible = YES;
        
        
        
        
        
    }
    else
    {
        for (UIView *subview in [self.view subviews]) {
            if([subview isKindOfClass:[GADBannerView class]]) {
                [subview removeFromSuperview];
            }
        }
        
    }

    
    
    
}

-(void) setupSound
{
    
    if ( [[[NSUserDefaults standardUserDefaults] stringForKey:@"soundsStatuss"] intValue] == 0 ){
        
        _hasSound = YES;
        _pathh = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/crush.mp3"];
        _filePath = [NSURL fileURLWithPath:_pathh isDirectory:NO];
    }

    
  
   

}
-(void) setupAdvertismentWith:(NSInteger) mode
{
    
}




-(void) cheskItsZenOrArcade
{
    _zenModeActive = [[[NSUserDefaults standardUserDefaults] stringForKey:@"zenMode"] intValue];
}

// START iAD CODES
- (void) adSetup
{
   
    
}

- (GADRequest *)request
{
    GADRequest *request = [GADRequest request];
    /*
    // Make the request for a test ad. Put in an identifier for the simulator as well as any devices
    // you want to receive test ads.
    request.testDevices = @[
                            // TODO: Add your device/simulator test identifiers here. Your device identifier is printed to
                            // the console when the app is launched.
                            GAD_SIMULATOR_ID,
                            @"ebcf397ffc3c324af0dd217daa8f380a"
                            ];
   */
    
     
     return request;
    
    
    
}
#pragma mark admob delegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView;
{
    
    NSLog(@"adMob: ad received");
   
   
    
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"adMob error:  %@", error.localizedDescription);
    
    
}

- (void)adViewWillPresentScreen:(GADBannerView *)adView
{
    
    NSLog(@"adMob ad was clicked.");
    
    
}
-(void) checkDeviceIsIpadOrIphone
{
    if (IS_IPAD)
    {
        _scoreLbl.font = _scoreForGMView.font  = [UIFont fontWithName:@"Mousou Record__G" size:60];
        _numberOfBugs = 4;
        _numberOfBugsMax = 24;
        _tempIphoneIpadLess = 8;
        _tempIphoneIpadMore = 10;
        _multiPly = 4;
        

    }
    else
    {
        _scoreLbl.font = _scoreForGMView.font = [UIFont fontWithName:@"Mousou Record__G" size:30];
        _numberOfBugs = 2;
        _numberOfBugsMax = 12;
        _tempIphoneIpadLess = 4;
        _tempIphoneIpadMore = 4;
        _multiPly = 2;
    }
}
-(void) setupTheValues
{
    
    _bugsCol = [[NSMutableArray alloc] init];
    _bugTemp = [[Bug alloc] init];
    
    _numberOfBugsAfter = 0;
    _timerTemp = 4;
    _LetItHarder = YES;
    _speedMulti = 1;
    _LetItHarder = 0;
    

    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop)];
    [_displayLink setFrameInterval:1];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    _hlp = [[Helper alloc] init];
    
    _timesPlayed = [[_hlp getStringFromFile:@"settings.plist" What:@"PlayedTimes"] intValue];

    

}


-(void) GenerateBugs
{
    dispatch_async(dispatch_get_main_queue(), ^{

    for (int  i = 0 ; i < _numberOfBugs; i++) {
        Bug *bug = [[Bug alloc] initWithFrame:CGRectMake([self getRandomNumberBetween:50 maxNumber:(MAIN_WIDTH - 50)], [self getRandomNumberBetween:100 maxNumber:300] * -1 , 75, 100)];
       
        if ( i > _tempIphoneIpadMore)
        {
            if ([self getRandomNumberBetween:1 maxNumber:3] == 1 )
                [bug makeLadybirds];
            else
              [bug makeAnts];

        }
        
        else
        {
            [bug makeCoc];

        }
        [_bugsCol addObject:bug];
        [_bugView addSubview:bug];

        [bug setSpeed: 1 + rand() % _speedMulti];
    //    [bug.ant setFrame:CGRectMake(bug.ant.center.x, bug.ant.center.y, bug.ant.frame.size.width/2, bug.ant.frame.size.height/2)];
        
    }
    
    });
}


- (void) makeSituationHarder
{
    if (_numberOfBugs < _numberOfBugsMax){
      _numberOfBugs+=_multiPly;
    }
    
    _harder = 0;
    _speedMulti++;
    NSLog(@"Ants up");
    _LetItHarder++;
    [UIView animateWithDuration:1  delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
     {
         _changeRot+=90;
         _bugView.transform = CGAffineTransformMakeRotation(_changeRot * M_PI / 180);
         
     }
                     completion:^(BOOL finished){  }];
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button number Of %i", buttonIndex);
    if ( buttonIndex == 0)
    {
        [_hlp saveDataToFile:@"settings.plist" forTitle:@"PlayedTimes" what:[NSString stringWithFormat:@"%i",0]];

        return;
    }
    if ( buttonIndex == 2)
    {
        NSLog(@"Never Ask Again has been clicked.");
        [_hlp saveDataToFile:@"settings.plist" forTitle:@"Rated" what:@"1"];
        return;
    }
    
    [_hlp saveDataToFile:@"settings.plist" forTitle:@"Rated" what:@"1"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:k_OPEN_LINK_FOR_RATING]];
    
}


-(void) gameLoop
{
  

    _harder++;
    if ( _harder == 2000 && _LetItHarder < _tempIphoneIpadLess)
    {
        [self makeSituationHarder];
        
    }
    
    if ( _bugsCol.count < _tempIphoneIpadLess)
    {
        dispatch_async(myQueue,^ {
        [self GenerateBugs];
        });
        
    }

    _rotation++;

    if ( _zenModeActive)
    _bugView.transform = CGAffineTransformMakeRotation(_rotation * M_PI / 180);
    
     
    for ( NSInteger i = 0 ; i < _bugsCol.count ; i++)
    {
      Bug * bugTemps = [_bugsCol objectAtIndex:i];
        
        
                    [bugTemps walk];
        
        if ( bugTemps.center.y > MAIN_HEIGHT + bugTemps.frame.size.height)
        {
            if ( bugTemps.model == K_cockroach) _bugsPast++;

            [_bugsCol removeObjectAtIndex:i];
            [bugTemps removeFromSuperview];

            if ( _bugsPast > k_LOSE_AFTER_BUGS_PASSED)
            {
                [self gameOver];
                
            }
        }
        
       
        [self checkCockIsKilled:bugTemps index:i];
               
        if (bugTemps.killed == YES && (bugTemps.model == K_ladybird || bugTemps.model == K_ant))
        {
            [self gameOver];
            
        }

        
    }
    
    
     

    
}

- (void) checkCockIsKilled:(Bug*) bug_t index:(NSInteger) index
{
   
    if ( bug_t.killed == YES)
    {
       
        
        [UIView animateWithDuration:3  delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
         {
             
             bug_t.alpha = 0;
             
             [bug_t sendToBack];
             _score++;
             [_scoreLbl setText:[NSString stringWithFormat:@"%i",_score]];
             
             [_bugsCol removeObjectAtIndex:index];
             
            
             
                 dispatch_async(myQueue_s,^ {
                     
                     if ( _hasSound) {
                     AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(_filePath), &soundID);
                     //Use audio services to play the sound
                     AudioServicesPlaySystemSound(soundID);
                     }
                     
 });
             
         }
                         completion:^(BOOL finished){
                             
                             [bug_t removeFromSuperview];
                             
                         }];
        
    }
   
}

-(void) sayChick
{
    dispatch_async(dispatch_get_main_queue(), ^{
                 [_maul play];
    });
    
}

- (NSInteger)getRandomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return min + arc4random() % (max - min + 1);
}

-(void) gameOver
{
    NSLog(@"GAME OVER!");

    _timesPlayed++;
    [_hlp saveDataToFile:@"settings.plist" forTitle:@"PlayedTimes" what:[NSString stringWithFormat:@"%i",_timesPlayed]];
     
   
    if ( [[_hlp getStringFromFile:@"settings.plist" What:@"Rated"] isEqual:@"0"] && [[_hlp getStringFromFile:@"settings.plist" What:@"PlayedTimes"] intValue] == k_MANY_AFTER_GAME_RATE )
    
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Like Bug Crusher?" message:@"If you like Bug crusher, please rate it to show your support." delegate:self cancelButtonTitle:@"Maybe Later!" otherButtonTitles:@"Rate",@"Never Ask Again", nil];
       [alert show];

        
        }

    
    
    
    [self syncGameCenter];
    
    [UIView animateWithDuration:3  delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
     {
         
         
         _bugTemp.transform = CGAffineTransformMakeScale(2, 2);
         [self.view addSubview:_gameOverView];
         [_gameOverView setHidden:NO];
         
         
         
     }
                     completion:^(BOOL finished){
                         
                         
                         
                         [UIView animateWithDuration:.5  delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
                          {
                              [_gameOverViewMessage setHidden:NO];
                              [_gameOverViewMessage setAlpha:1];
                              [_scoreForGMView setText:[NSString stringWithFormat:@"%i",_score]];
                              
                              
                          }
                                          completion:^(BOOL finished){  }];
                         
                         
                         
                         
                     }];

    
    [_displayLink invalidate];
    
    
    if ( _score > [[_hlp getStringFromFile:@"settings.plist" What:@"score"] intValue] && !_zenModeActive)
    {
        [_hlp saveDataToFile:@"settings.plist" forTitle:@"scoreArcade" what:[NSString stringWithFormat:@"%i",_score]];
        NSLog(@"Score has been submited , Arcade");
    }
    else if ( _score > [[_hlp getStringFromFile:@"settings.plist" What:@"score"] intValue] && _zenModeActive)
    {
        [_hlp saveDataToFile:@"settings.plist" forTitle:@"scoreZen" what:[NSString stringWithFormat:@"%i",_score]];
        NSLog(@"Score has been submited , Zenmode");
    }

    [self keepAdsFront];

}


-(void)keepAdsFront
{
    [_adBanner bringToFront];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBugView:nil];
    [self setScoreLbl:nil];
    [self setScoreForGMView:nil];
    [self setGameOverView:nil];
    [self setGameOverViewMessage:nil];
    [self setPauseView:nil];
    [self setPauseBtn:nil];
    [self setPauseCounterTimerLabel:nil];
    [super viewDidUnload];
}
- (IBAction)tryAgain {
    
    UIStoryboard *storyboard = self.storyboard;
    ViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"GameLoop"];
    svc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:svc animated:YES completion:nil];


}
- (IBAction)pauseAction:(id)sender {
    
    [self.view addSubview:_gameOverView];
    [_gameOverView setHidden:NO];
    [_pauseView setHidden:NO];
    [_pauseView setAlpha:1];
    [_pauseBtn setHidden:YES];
    
    [_displayLink invalidate];
    [self keepAdsFront];
}
-(void)pauseCountDown
{
    _timerTemp--;
    
    
    _pauseCounterTimerLabel.text = [NSString stringWithFormat:@"%i",_timerTemp];
    
    [self BubbleHubble:_pauseCounterTimerLabel];
    
    if ( _timerTemp == 0)
    {
        
        [_pauseBtn setHidden:NO];
        
        [_gameOverView setHidden:YES];
        [_pauseView setAlpha:0];
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop)];
        [_displayLink setFrameInterval:1];
        
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _timerTemp = 4;
        [_pauseCounterTimerLabel setHidden:YES];
        [_pauseTimer invalidate];
        
    }
    
    
}
- ( void )BubbleHubble:(UIView*)hh
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishAnime)];
    
    hh.alpha = 0;
    
    [UIView commitAnimations];
    
}


- ( void ) finishAnime
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.1];
    [UIView setAnimationDelegate:self];
    
    _pauseCounterTimerLabel.alpha = 1;
    
    [UIView commitAnimations];
    
}


-(void) syncGameCenter
{
    // Here are 2 kinds of Game Center first for Arcade Mode , Second for zen mode.
    // Change the com.yourDomain.Domain.ArcadeStyle for the Arcade Mode
    
    if (_zenModeActive)
    {
        GKScore *scoreReport = [[GKScore alloc] initWithCategory:k_leaderbord_ZEN_Mode];
        scoreReport.value = _score;
        
        [scoreReport reportScoreWithCompletionHandler:^(NSError *error) {
            
            if (error == nil) {
                NSLog(@"Submit To GameCenter...");
            } else {
                NSLog(@"It can't Submit to Game center");
            }
            
        }
         ];
    } else
    {
        
        GKScore *scoreReport = [[GKScore alloc] initWithCategory:k_leaderbord_ARCADE_Mode];
        scoreReport.value = _score;
        
        [scoreReport reportScoreWithCompletionHandler:^(NSError *error) {
            
            if (error == nil) {
                NSLog(@"Submit To GameCenter...");
            } else {
                NSLog(@"It can't Submit to Game center");
            }
            
        }
         ];
    }
    
    

}



-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    
}

- (IBAction)PlayFromPause {
    _pauseTimer = [NSTimer scheduledTimerWithTimeInterval:60.0/60.0 target:self selector:@selector(pauseCountDown) userInfo:nil repeats:YES];
    [_pauseCounterTimerLabel setHidden:NO];
    
    [_pauseView setHidden:YES];
    _pauseCounterTimerLabel.text = [NSString stringWithFormat:@"%i",4];
}
- (IBAction)shareScore {
    
    NSString * text = [NSString stringWithFormat:@"My Score Is %i In Bug Crusher game", _score];
	UIImage * image = [UIImage imageNamed:@"rc.png"];
	NSArray * activityItems = @[text, image];
	UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    avc.excludedActivityTypes = @[ UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll];
	[self presentViewController:avc animated:YES completion:nil];
}

@end
