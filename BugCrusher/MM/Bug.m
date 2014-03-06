//
//  Ant.m
//  MM
//
//  Created by Philips on 12/12/13.
//  Copyright (c) 2013 Leo. All rights reserved.
//

#define K_cockroach 1
#define K_ant 2
#define K_ladybird 3

#import "Bug.h"
@implementation Bug

@synthesize bug;
@synthesize speed;
@synthesize killed;
@synthesize model;
@synthesize theaudio_l;
@synthesize speedX,speedAngle,range,angle,xpos,ypos,centerY;
@synthesize cubicValue;
@synthesize LeftOrRight;
@synthesize bugCrushed;
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
       speedX = 4;
       speedAngle= 0.1;
       range = rand() % 50;
       angle = 0;
       xpos = self.center.y;
       ypos = self.center.x;
       centerY = rand() % 1200;
       LeftOrRight = YES;
        
       
        
        if ( [[[NSUserDefaults standardUserDefaults] stringForKey:@"soundsStatuss"] intValue] == 0 ){
            
           
      
        NSString *path = [[NSBundle mainBundle] pathForResource:@"crush" ofType:@"mp3"];


        path = [[NSBundle mainBundle] pathForResource:@"ladyC" ofType:@"mp3"];
        theaudio_l =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
       
       [theaudio_l prepareToPlay];
            
        }

      // [self setBackgroundColor:[UIColor blueColor]];
                
    }
    return self;
}

-(void) makeAnts
{
    
    model = K_ant;
    
    bug = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 100)];
    
    
    
    NSArray * imageArray  = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"ant0.png"],
                             [UIImage imageNamed:@"ant1.png"],
                             [UIImage imageNamed:@"ant2.png"],
                             [UIImage imageNamed:@"ant3.png"],
                             [UIImage imageNamed:@"ant4.png"],
                             
                             
                             nil];
    bug.animationImages = imageArray;
    bug.animationDuration = .3;
    bug.contentMode = UIViewContentModeScaleAspectFit;
    [bug startAnimating];
    [self addSubview:bug];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:bug.frame];
    
    [self addSubview:btn];
    
    [btn addTarget:self action:@selector(buttonClickAnt) forControlEvents:UIControlEventTouchDown];
    bugCrushed = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@
                                                     "antC.png"]];
    [self addSubview:bugCrushed];
    [bugCrushed setHidden:YES];
    
//   [btn setBackgroundColor:[UIColor redColor]];
//   [btn setAlpha:.5];

    
}
-(void) buttonClickAnt
{
    [bug stopAnimating];
    speed = 0;
    killed = YES;
    [theaudio_l     play];
    
    [bugCrushed setHidden:NO];

}
-(void) makeCoc
{
    
    model = K_cockroach;
    
    bug = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 100)];
    
    
    
    NSArray * imageArray  = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"coc0.png"],
                             [UIImage imageNamed:@"coc1.png"],
                             [UIImage imageNamed:@"coc2.png"],
                             [UIImage imageNamed:@"coc3.png"],
                             [UIImage imageNamed:@"coc4.png"],
                             
                             
                             nil];
    bug.animationImages = imageArray;
    bug.animationDuration = .3;
    bug.contentMode = UIViewContentModeScaleAspectFit;
    [bug startAnimating];
    [self addSubview:bug];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:bug.frame];
    [btn addTarget:self action:@selector(buttonClickCock) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
    bugCrushed = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@
                                                     "cocC.png"]];
    [self addSubview:bugCrushed];
    [bugCrushed setHidden:YES];
    //   [btn setBackgroundColor:[UIColor redColor]];
    //   [btn setAlpha:.5];
    
    
}
-(void) buttonClickCock
{
    
    [bug stopAnimating];
    
    
    speed = 0;
    killed = YES;
    
    [bugCrushed setHidden:NO];
}

-(void) makeLadybirds
{
    model = K_ladybird;

    
    bug = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 100)];
    
    
    
    NSArray * imageArray  = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"r1.png"],
                             [UIImage imageNamed:@"r2.png"],
                             [UIImage imageNamed:@"r3.png"],
                             [UIImage imageNamed:@"r4.png"],                             
                             
                             nil];
    bug.animationImages = imageArray;
    bug.animationDuration = .3;
    bug.contentMode = UIViewContentModeScaleAspectFit;
    [bug startAnimating];
    [self addSubview:bug];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:bug.frame];
    [btn addTarget:self action:@selector(buttonClickLadybird) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
    bugCrushed = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@
                                                     "rc.png"]];
    [self addSubview:bugCrushed];
    [bugCrushed setHidden:YES];

 //       [btn setBackgroundColor:[UIColor redColor]];
  // [btn setAlpha:.5];
    
    
}
-(void)buttonClickLadybird
{
    [bug stopAnimating];
    
    speed = 0;
    killed = YES;
    
    [theaudio_l  play];
    [bugCrushed setHidden:NO];


}

-(void) walkRandomize
{
  

     self.transform = CGAffineTransformMakeRotation(self.center.y * M_PI / 180);
    
}
-(void) walkSin
{
    xpos += speedX +  speed;
    ypos = centerY + sin(angle) * range;
    angle += speedAngle;
    self.center = CGPointMake(ypos, xpos );
  
}



- (void) walkNormal
{
    [self setCenter:CGPointMake(self.center.x, self.center.y + 1 + speed)];

}



- (void) walkCubic
{
    cubicValue+=2;
    if (cubicValue < 70)
    {
        
        [self setCenter:CGPointMake(self.center.x , self.center.y + 1 + speed )];
        
    }
    
    else if ( cubicValue > 70 && cubicValue < 120)
    {
        if ( LeftOrRight)
        {
            [self setCenter:CGPointMake(self.center.x + 1 + speed , self.center.y)];
             self.transform = CGAffineTransformMakeRotation(-90 * M_PI / 180);
        }
        else{
            [self setCenter:CGPointMake(self.center.x - 1 - speed  , self.center.y)];
             self.transform = CGAffineTransformMakeRotation(90 * M_PI / 180);
        }
       
        
       

        }
    else if (cubicValue == 120)
    {
        LeftOrRight = !LeftOrRight;
        self.transform = CGAffineTransformIdentity;

        cubicValue = 0;
    }
    
    
}

-(void) walk
{
    if ( model == K_ant)
    {
        [self walkSin];
    }
    else if ( model == K_cockroach)
    {
        [self walkNormal];
    }
     else
     {
         [self walkCubic];

     }
    
}


     
     



@end
