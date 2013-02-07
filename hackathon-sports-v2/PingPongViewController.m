//
//  PingPongViewController.m
//  hackathon-sports
//
//  Created by Yufeng Chen on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define TIME_INTERVAL 0.01
#define ANIMATION_INTERVAL 0.25

#import "PingPongViewController.h"

@interface PingPongViewController ()

@property (nonatomic, retain) NSTimer *timer;
@property CGPoint ballDestination;
@property CGFloat ballDestinationZ;
@property CGPoint ballOrigin;
@property CGFloat ballOriginZ;
@property CGFloat ballZ;
@property CGFloat ballZSpeed;
@property CGSize ballOriginSize;
@property CGPoint shadowPosition;
@property BOOL ballDirection;
@property (nonatomic, retain) UIButton *randomButton;
@property (nonatomic, retain) NSDictionary *animationFramesO;
@property (nonatomic, retain) NSDictionary *animationFramesP;
@property int animationDelay;
@property int score;
@property (nonatomic, retain) NSUserDefaults *topScoreDefaults;
@property int highScore;
@property int opponentNumber;

@end

@implementation PingPongViewController

@synthesize timer, ball, ballDestination, ballDestinationZ, ballZ, ballDirection, ballOrigin, ballOriginZ, ballZSpeed, ballOriginSize;
@synthesize topLeft, topRight, bottomLeft, bottomRight, randomButton, opponent, animationFramesO, animationFramesP, animationDelay, player, score;
@synthesize shadowPosition, topScore, currentScore, topScoreDefaults, highScore, opponentNumber;
@synthesize scoreView, yourScore;

- (void)dealloc {
    [timer release], timer = nil;
    [ball release], ball = nil;
    [opponent release], opponent = nil;
    [player release], player = nil;
    [topRight release], topRight = nil;
    [topLeft release], topLeft = nil;
    [bottomRight release], bottomRight = nil;
    [bottomLeft release], bottomLeft = nil;
    [randomButton release], randomButton = nil;
    [animationFramesO release], animationFramesO = nil;
    [animationFramesP release], animationFramesP = nil;
    [topScoreDefaults release], topScoreDefaults = nil;
    [topScore release], topScore = nil;
    [currentScore release], currentScore = nil;
    [scoreView release], scoreView = nil;
    [yourScore release], yourScore = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.opponentNumber = arc4random() % 3 + 1;
    NSString *opponentLetter = @"b";
    if (self.opponentNumber == 3) {
        opponentLetter = @"a";
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.animationFramesO = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIImage imageNamed:[NSString stringWithFormat: @"pp_o%d_%@1.png", self.opponentNumber, opponentLetter]], @"topLeft",
                                [UIImage imageNamed:[NSString stringWithFormat: @"pp_o%d_%@2.png", self.opponentNumber, opponentLetter]], @"topRight",
                                [UIImage imageNamed:[NSString stringWithFormat: @"pp_o%d_%@3.png", self.opponentNumber, opponentLetter]], @"bottomLeft",
                                [UIImage imageNamed:[NSString stringWithFormat: @"pp_o%d_%@4.png", self.opponentNumber, opponentLetter]], @"bottomRight",
                                [UIImage imageNamed:[NSString stringWithFormat: @"pp_o%d_%@5.png", self.opponentNumber, opponentLetter]], @"windLeft",
                                [UIImage imageNamed:[NSString stringWithFormat: @"pp_o%d_%@6.png", self.opponentNumber, opponentLetter]], @"windRight",
                                nil];
        self.animationFramesP = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIImage imageNamed:@"pp_p1_1.png"], @"topLeft",
                                [UIImage imageNamed:@"pp_p1_2.png"], @"topRight",
                                [UIImage imageNamed:@"pp_p1_3.png"], @"bottomLeft",
                                [UIImage imageNamed:@"pp_p1_4.png"], @"bottomRight",
                                 nil];
        self.animationDelay = 0;
        self.score = 0;
        self.topScoreDefaults = [NSUserDefaults standardUserDefaults];
        if ([self.topScoreDefaults integerForKey:@"hackathonSportsPingPongHighScore"]) {
            self.highScore = [self.topScoreDefaults integerForKey:@"hackathonSportsPingPongHighScore"];
        } else {
            self.highScore = 0;
        }
    }
    return self;
}

- (CGFloat)arcDisplacementAtZ:(CGFloat)z {
    return - z * (z - self.ballOriginZ) / 25;
}

- (CGSize)sizeAtZ:(CGFloat)z {
    CGFloat factor = (self.ballZ + self.ballOriginZ) / 2 / self.ballOriginZ;
    return CGSizeMake(self.ballOriginSize.width* factor, self.ballOriginSize.height * factor);
}

- (IBAction)quit:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)update:(NSTimer*)timer {
    CGFloat rawDy = (self.ballDestination.y - self.ballOrigin.y) / self.ballOriginZ;
    CGFloat rawDx = (self.ballDestination.x - self.ballOrigin.x) / self.ballOriginZ;
    if (self.ballDirection) {
        self.ballZ -= self.ballZSpeed;
    } else {
        self.ballZ += self.ballZSpeed;
        rawDx = -rawDx;
        rawDy = -rawDy;
    }
    
    CGFloat dy = rawDy * self.ballZSpeed;
    CGFloat dx = rawDx * self.ballZSpeed;
    self.ball.bounds = CGRectMake(0, 0, self.ball.frame.size.width, self.ball.frame.size.height);
    self.shadowPosition = CGPointMake(self.shadowPosition.x + dx, self.shadowPosition.y + dy);
    self.ball.center = CGPointMake(self.shadowPosition.x, self.shadowPosition.y - [self arcDisplacementAtZ:self.ballZ]);
    self.ball.bounds = CGRectMake(0, 0, [self sizeAtZ:self.ballZ].width, [self sizeAtZ:self.ballZ].height);
    if (self.ballZ > self.ballOriginZ * 1.25) {
        [self.timer invalidate];
        if (self.score > self.highScore) {
            [self.topScoreDefaults setInteger:self.score forKey:@"hackathonSportsPingPongHighScore"];
            [self.topScoreDefaults synchronize];
        }
        self.scoreView.hidden = NO;
        self.yourScore.text = [NSString stringWithFormat:@"%d", self.score];
    }
    self.animationDelay++;
    if (self.ballZ < self.ballDestinationZ) {
        self.animationDelay = 0;
        self.ballDirection = NO;
        self.randomButton = [self makeRandomButton];
        self.ballOrigin = self.randomButton.center;
        if (self.randomButton == self.topRight || self.randomButton == self.bottomRight) {
            self.opponent.image = [self.animationFramesO objectForKey:@"windRight"];
        } else {
            self.opponent.image = [self.animationFramesO objectForKey:@"windLeft"];
        }
    } else if (self.animationDelay == ANIMATION_INTERVAL / TIME_INTERVAL){
        if (self.randomButton == self.topRight) {
            self.opponent.image = [self.animationFramesO objectForKey:@"topRight"];
        } else if (self.randomButton == self.topLeft) {
            self.opponent.image = [self.animationFramesO objectForKey:@"topLeft"];
        } else if (self.randomButton == self.bottomRight) {
            self.opponent.image = [self.animationFramesO objectForKey:@"bottomRight"];
        } else {
            self.opponent.image = [self.animationFramesO objectForKey:@"bottomLeft"];
        }
    }
}

- (UIButton *)makeRandomButton {
    int random = arc4random() % 4;
    if (random == 0) {
        return self.topRight;
    } else if (random == 1) {
        return self.topLeft;
    } else if (random == 2) {
        return self.bottomRight;
    } else {
        return self.bottomLeft;
    }
}

- (IBAction)hitBall:(UIButton *)sender {
    if ([sender isEqual:self.randomButton] && self.ballZ > self.ballOriginZ * .75 && self.ballDirection == NO) {
        self.ballDirection = YES;
        self.score++;
        self.ballZSpeed += 0.01;
        self.currentScore.text = [NSString stringWithFormat:@"%d", self.score];
    }
    if (sender == self.topRight) {
        self.player.image = [self.animationFramesP objectForKey:@"topRight"];
    } else if (sender == self.topLeft) {
        self.player.image = [self.animationFramesP objectForKey:@"topLeft"];
    } else if (sender == self.bottomRight) {
        self.player.image = [self.animationFramesP objectForKey:@"bottomRight"];
    } else {
        self.player.image = [self.animationFramesP objectForKey:@"bottomLeft"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scoreView.hidden = YES;
    self.ballOriginSize = self.ball.frame.size;
    self.ballZ = 100;
    self.ballZSpeed = 0.5;
    self.ballDestinationZ = 0;
    self.ballDestination = self.opponent.center;
    self.ballOriginZ = 100;
    self.ballDirection = YES;
    self.ball.center = [self makeRandomButton].center;
    self.ballOrigin = self.ball.center;
    self.ballOriginSize = self.ball.bounds.size;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIME_INTERVAL target:self selector:@selector(update:) userInfo:nil repeats:YES];
    self.shadowPosition = self.ball.center;
    self.topScore.text = [NSString stringWithFormat:@"%d", self.highScore];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
