//
//  MenuViewController.m
//  MM
//
//  Created by Philips on 12/14/13.
//  Copyright (c) 2013 Leo. All rights reserved.
//


#import "MenuViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import "Helper.h"
#import "defined.h"
#import "PurchasedViewController.h"

AVAudioPlayer  *MainAudio;
@interface MenuViewController ()
{
    UIApplication * _application;
}
@property ( nonatomic ,  strong) Helper *menuHelperSetup;

@end

@implementation MenuViewController
@synthesize soundONOFF;
@synthesize menuHelperSetup;
@synthesize removeAdsBtn;
bool firstOne = YES;

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    menuHelperSetup = [[Helper alloc] init];
    [menuHelperSetup makeFileWithName:@"settings.plist" andWriteToIt:[menuHelperSetup settings]];

    

    
    UIImage *OFF = [UIImage imageNamed:@"sound_off.png"];
    UIImage *ON = [UIImage imageNamed:@"sound_on.png"];
    
    if ( firstOne )
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"];
        
        MainAudio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        
        MainAudio.numberOfLoops = -1;
        [MainAudio.delegate self];
        [MainAudio play];
        firstOne = NO;
        NSLog(@"First One");
        
    }
    
    
    if ( [[[NSUserDefaults standardUserDefaults] stringForKey:@"soundsStatuss"] intValue] == 0 ){
        
        [soundONOFF setImage:ON forState:UIControlStateNormal];
        
        
    } else if ( [[[NSUserDefaults standardUserDefaults] stringForKey:@"soundsStatuss"] intValue] == 1 )
    {
        [soundONOFF setImage:OFF forState:UIControlStateNormal];
        [MainAudio setVolume:0.0];
    }
    
    
    menuHelperSetup = [[Helper alloc] init];
    int saved =   [[menuHelperSetup getStringFromFile:@"settings.plist" What:@"ADS"] intValue];
    
    
    if (!saved)
    {
        [removeAdsBtn setEnabled:YES];
        [removeAdsBtn setImage:[UIImage imageNamed:@"adsBtn.png"] forState:UIControlStateDisabled];
        
    } else
    {
        [removeAdsBtn setEnabled:NO];
        [removeAdsBtn setImage:[UIImage imageNamed:@"ADS_OFF.png"] forState:UIControlStateDisabled];
    }

    

 	// Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setGameCenterShow:nil];
    [self setSoundONOFF:nil];
    [self setRemoveAdsBtn:nil];
    [super viewDidUnload];
}


- (IBAction)showGCAction {
            
        
         
    


}



- (IBAction)soundBtn:(id)sender {
    UIImage *OFF = [UIImage imageNamed:@"sound_off.png"];
    UIImage *ON = [UIImage imageNamed:@"sound_on.png"];
    
    if ( [[[NSUserDefaults standardUserDefaults] stringForKey:@"soundsStatuss"] intValue] == 0 ){
        
        [soundONOFF setImage:OFF forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"soundsStatuss"];
        [MainAudio setVolume:0.0];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"soundsStatuss"] intValue] == 1)
    {
        [soundONOFF setImage:ON forState:UIControlStateNormal];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:0] forKey:@"soundsStatuss"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [MainAudio setVolume:1.0];
        
    }

}
- (IBAction)zenModeStart:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"zenMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIStoryboard *storyboard = self.storyboard;
    ViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"GameLoop"];
    svc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:svc animated:YES completion:nil];

}

- (IBAction)arcadeModeStart:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:0] forKey:@"zenMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIStoryboard *storyboard = self.storyboard;
    ViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"GameLoop"];
    svc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:svc animated:YES completion:nil];
}

- (IBAction)facebookOpen {
    
    NSURL *myUrl = [NSURL URLWithString:k_facebook_page_follow_profile_ID];
    
    if(![[UIApplication sharedApplication] openURL:myUrl]){
        NSLog(@"open Faild...");
        myUrl = [NSURL URLWithString:k_facebook_page_follow_link];
        
        if(![[UIApplication sharedApplication] openURL:myUrl]){
            NSLog(@"open Faild...");
        }
        
    }
    

}

- (IBAction)googlePlustOpen {
    
    NSURL *myUrl = [NSURL URLWithString:k_google_plus_link];
           
        if(![[UIApplication sharedApplication] openURL:myUrl]){
            NSLog(@"google plus Faild...");
        }
        
    

}

- (IBAction)twitterOpen {
    NSURL *myUrl = [NSURL URLWithString:k_twitter_link];
    
        
        if(![[UIApplication sharedApplication] openURL:myUrl]){
            NSLog(@"Twitter Faild...");
        }
        

    
}

- (IBAction)sendEmail {
    if (!_application) _application = [UIApplication sharedApplication];
    NSString * urlString = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", k_EmailAddress , k_EmailSubject, [self URLEncodedString:@"HI" withPlusEncoding:NO]];
    [_application openURL:[NSURL URLWithString:urlString]];
    
}


- (NSString *) URLEncodedString:(NSString *)source withPlusEncoding:(BOOL)plusFlag {
	const unsigned char * cSource = (const unsigned char *) [source UTF8String];
	int sourceLen = strlen((const char *) cSource);
	NSMutableString * outString = [NSMutableString stringWithCapacity:sourceLen];
    
	for (int i = 0; i < sourceLen; ++i) {
		const unsigned char thisChar = cSource[i];
		if (plusFlag && (thisChar == ' ')) {
			[outString appendString:@"+"];
		} else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
				   (thisChar >= 'a' && thisChar <= 'z') || (thisChar >= 'A' && thisChar <= 'Z') ||
				   (thisChar >= '0' && thisChar <= '9')) {
			[outString appendFormat:@"%c", thisChar];
		} else {
			[outString appendFormat:@"%%%02X", thisChar];
		}
	}
	return outString;
}

@end
