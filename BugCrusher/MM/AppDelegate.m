//
//  AppDelegate.m
//  MM
//
//  Created by Philips on 12/12/13.
//  Copyright (c) 2013 Leo. All rights reserved.
//

#import "AppDelegate.h"

#import "Flurry.h"

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
    [self LoginToGameCenter_iOS_6_forth_way];
    
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:@"83TG3RHS5SSMFF85DZ4R"];
    
    return YES;
}

- (void) LoginToGameCenter_iOS_5
{
    
//    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
//    [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
//        if (localPlayer.isAuthenticated)
//        {
//            NSLog(@"OK");
//        }
//    }];

}

-(void) LoginToGameCenter_iOS_6_first_way
{
      __weak  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        localPlayer.authenticateHandler = ^(UIViewController *viewController,NSError *error) {
            if (localPlayer.authenticated) {
                //already authenticated
            } else if(viewController) {
    
            } else {
                //problem with authentication,probably bc the user doesn't use Game Center
            } 
        };
    
}
- (void) LoginToGameCenter_iOS_6_second_way
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer setAuthenticateHandler:(^(UIViewController* viewcontroller, NSError *error) {
        if (!error && viewcontroller)
        {
            
        }
        else
        {
            
        }
    })];
    
}


- (void) LoginToGameCenter_iOS_6_third_way
{
    __weak GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil)
        {
            //showAuthenticationDialogWhenReasonable: is an example method name. Create your own method that displays an authentication view when appropriate for your app.
            [self showAuthenticationDialogWhenReasonable: viewController];
        }
        else if (localPlayer.isAuthenticated)
        {
            //authenticatedPlayer: is an example method name. Create your own method that is called after the loacal player is authenticated.
            [self authenticatedPlayer: localPlayer];
        }
        else
        {
            [self disableGameCenter];
        }
    };
}



- (void) LoginToGameCenter_iOS_6_forth_way
{
    __weak typeof(self) weakSelf = self; // removes retain cycle error
    
    _localPlayer = [GKLocalPlayer localPlayer]; // localPlayer is the public GKLocalPlayer
    __weak GKLocalPlayer *weakPlayer = _localPlayer; // removes retain cycle error
    
    weakPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error)
    {
        if (viewController != nil)
        {
            [weakSelf showAuthenticationDialogWhenReasonable:viewController];
        }
        else if (weakPlayer.isAuthenticated)
        {
            [weakSelf authenticatedPlayer:weakPlayer];
        }
        else
        {
            [weakSelf disableGameCenter];
        }
    };

}

-(void)showAuthenticationDialogWhenReasonable:(UIViewController *)controller
{
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:controller animated:YES completion:nil];
}

-(void)authenticatedPlayer:(GKLocalPlayer *)player
{
    player = _localPlayer;
}

-(void)disableGameCenter
{
      // optional!
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
