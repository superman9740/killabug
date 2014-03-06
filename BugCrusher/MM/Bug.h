//
//  Ant.h
//  MM
//
//  Created by Philips on 12/12/13.
//  Copyright (c) 2013 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface Bug : UIView
@property ( nonatomic, strong) UIImageView *bug;
@property ( nonatomic, strong) UIImageView *bugCrushed;

@property ( nonatomic, assign) int speed;
@property ( nonatomic, assign ) bool killed;
@property ( nonatomic , strong )   AVAudioPlayer  *theaudio_l;
@property ( nonatomic , assign ) int model;
@property ( nonatomic, assign )int speedX ;
@property ( nonatomic, assign )float speedAngle;
@property ( nonatomic, assign )int range;
@property ( nonatomic, assign )float angle;
@property ( nonatomic, assign )float xpos;
@property ( nonatomic, assign )float ypos;
@property ( nonatomic, assign )int centerY;
@property ( nonatomic, assign )int cubicValue;
@property ( nonatomic, assign )BOOL LeftOrRight;





-(void) makeAnts;
-(void) makeLadybirds;
-(void) makeCoc;
-(void) walkSin;
-(void) walkRandomize;
- (void) walkNormal;
- (void) walkCubic;
-(void) walk;
@end
