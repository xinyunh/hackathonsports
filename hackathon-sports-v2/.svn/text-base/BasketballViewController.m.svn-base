//
//  StarCraftViewController.m
//  hackathon-sports
//
//  Created by Zhixing Jin on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BasketballViewController.h"
#define GRAVITY 1.5

@interface  BasketballViewController ()
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) BOOL throw;
@property (nonatomic, assign) BOOL inGame;
@property (nonatomic, assign) int playerNumber;
@property (nonatomic, assign) int leftTime;
@property (nonatomic, assign) int aiActionNumber;
@property (nonatomic, assign) int ballsInTheBottom;
@property (retain, nonatomic) IBOutlet UIImageView *aiPlayer;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSMutableArray *balls;
@property (retain, nonatomic) NSTimer* timer;
@property (retain, nonatomic) IBOutlet UIImageView *hoop_1;
@property (retain, nonatomic) IBOutlet UIImageView *hoop_2;
@property (retain, nonatomic) IBOutlet UILabel *score_player_1;
@property (retain, nonatomic) IBOutlet UILabel *score_player_2;
@property (retain, nonatomic) IBOutlet UILabel *timeLeft;
@property (retain, nonatomic) IBOutlet UILabel *result;
@property (retain, nonatomic) IBOutlet UIButton *replayButton;
@property (retain, nonatomic) IBOutlet UIButton *backbutton;
@property (retain, nonatomic) IBOutlet UIButton *startButton;
@property (retain, nonatomic) IBOutlet UIButton *changeOpponent;

@property (retain, nonatomic) NSArray *spinningBall;
@property (retain, nonatomic) NSArray *aiActions;
@end

@implementation  BasketballViewController

@synthesize startPoint;
@synthesize endPoint;
@synthesize throw;
@synthesize inGame;
@synthesize balls;
@synthesize timer;
@synthesize hoop_1;
@synthesize hoop_2;
@synthesize score_player_1;
@synthesize score_player_2;
@synthesize timeLeft;
@synthesize result;
@synthesize replayButton;
@synthesize backbutton;
@synthesize startButton;
@synthesize changeOpponent;
@synthesize leftTime;
@synthesize playerNumber;
@synthesize aiPlayer;
@synthesize spinningBall;
@synthesize aiActions;
@synthesize aiActionNumber;
@synthesize ballsInTheBottom;

- (void) initParameter {
    self.leftTime = 601;
    result.hidden = TRUE;
    replayButton.hidden = TRUE;
    throw = FALSE;
    inGame = FALSE;
    score_player_1.text = @"0";
    score_player_2.text = @"0";
    aiActionNumber = 0;
    ballsInTheBottom = 7;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view addGestureRecognizer:[[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(throwBasketball:)] autorelease]];
        self.balls = [NSMutableArray array];
        self.spinningBall = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"bb_ball_01.png"],
                         [UIImage imageNamed:@"bb_ball_02.png"],
                         [UIImage imageNamed:@"bb_ball_03.png"],
                         [UIImage imageNamed:@"bb_ball_04.png"],
                         [UIImage imageNamed:@"bb_ball_05.png"],
                         [UIImage imageNamed:@"bb_ball_06.png"],
                         [UIImage imageNamed:@"bb_ball_07.png"],
                         [UIImage imageNamed:@"bb_ball_08.png"],
                         [UIImage imageNamed:@"bb_ball_09.png"],
                         nil];
        self.playerNumber = (arc4random() % 4) + 1;
        self.aiActions = [NSArray arrayWithObjects:
                         [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b01.png", self.playerNumber]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b02.png", self.playerNumber]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b03.png", self.playerNumber]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b04.png", self.playerNumber]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b05.png", self.playerNumber]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b06.png", self.playerNumber]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b07.png", self.playerNumber]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b08.png", self.playerNumber]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b09.png", self.playerNumber]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b10.png", self.playerNumber]],
                         [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b11.png", self.playerNumber]],
                         nil];
        self.aiPlayer.image = [aiActions objectAtIndex:0];
        [self initParameter];
    }
    return self;
}

- (void)dealloc {
    [balls release], balls = nil;
    [timer release], timer = nil;
    [score_player_1 release], score_player_1 = nil;
    [score_player_2 release], score_player_2 = nil;
    [timeLeft release], timeLeft = nil;
    [spinningBall release], spinningBall = nil;
    [aiPlayer release], aiPlayer = nil;
    [hoop_1 release],hoop_1 = nil;
    [hoop_2 release],hoop_2 = nil;
    [result release], result = nil;
    [replayButton release], replayButton = nil;
    [backbutton release], result = nil;
    [startButton release], startButton = nil;
    [aiPlayer release], aiPlayer = nil;
    [changeOpponent release];
    [super dealloc];
}

- (void)throwBasketball:(UIPanGestureRecognizer *)gesture {
    if (inGame == FALSE) {
        return;
    }
    if (gesture.state == UIGestureRecognizerStateBegan) {
        startPoint = [gesture locationInView:self.view];
        if (startPoint.y > 300 && ballsInTheBottom > 0) {
            throw = TRUE;
        } else {
            throw = FALSE;
        }
    } else if (gesture.state == UIGestureRecognizerStateEnded && throw == TRUE) {
        endPoint = [gesture locationInView:self.view];
        if (startPoint.y < endPoint.y) {
            throw = false;
            return;
        }
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(startPoint.x-32, startPoint.y-32, 64, 64);
        [button setImage:[self.spinningBall objectAtIndex:0] forState:UIControlStateNormal];
        [button setUserInteractionEnabled:FALSE];
        [balls addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                            button, @"button",
                            [NSNumber numberWithFloat:(endPoint.x - startPoint.x) * 0.1], @"deltaX",
                            [NSNumber numberWithFloat:(endPoint.y - startPoint.y) * 0.1 - 17], @"deltaY",
                            [NSNumber numberWithInt:0], @"back",
                            [NSNumber numberWithInt:0], @"getPoints",
                            nil]];
        [self.view addSubview:button];
        ballsInTheBottom--;
        NSLog(@"%d",ballsInTheBottom);
        throw = FALSE;
    }
}

- (int) getPoints {
    if (leftTime >= 150) {
        return 2;
    } else if (leftTime >= 0) {
        return 3;
    } else {
        return 0;
    }
}

- (void) ballIsMoving {
    for (int i = 0; i < balls.count; i++) {
        NSMutableDictionary *ball = [balls objectAtIndex:i];
        UIButton* button = [ball objectForKey:@"button"];
        int status = [[ball objectForKey:@"status"] intValue];
        status = status + 1;
        [ball setObject:[NSNumber numberWithInt:status] forKey:@"status"];
        [button setImage:[self.spinningBall objectAtIndex:status % 9] forState:UIControlStateNormal];
        if ([[ball objectForKey:@"back"] intValue] != 0) {
            if ([[ball objectForKey:@"getPoints"] intValue] != 0) {
                button.center = CGPointMake(button.center.x,
                                            button.center.y - [(NSNumber*)[ball objectForKey:@"deltaY"] floatValue]);
                
            } else {
                button.center = CGPointMake(button.center.x + [(NSNumber*)[ball objectForKey:@"deltaX"] floatValue],
                                            button.center.y - [(NSNumber*)[ball objectForKey:@"deltaY"] floatValue]);
                if (button.center.y > 80 && button.center.y < 120) {
                    if (button.center.x > 68 && button.center.x< 108) {
                        [self.view bringSubviewToFront:hoop_1];
                        button.center = CGPointMake(88,button.center.y);
                        [ball setObject:[NSNumber numberWithInt:1] forKey:@"getPoints"];
                        self.score_player_1.text = [NSString stringWithFormat:@"%d", [self.score_player_1.text integerValue] + [self getPoints]];
                    }
                    
                    if (button.center.x > 222 && button.center.x< 262) {
                        [self.view bringSubviewToFront:hoop_2];
                        button.center = CGPointMake(242,button.center.y);
                        [ball setObject:[NSNumber numberWithInt:1] forKey:@"getPoints"];
                        self.score_player_2.text = [NSString stringWithFormat:@"%d", [self.score_player_2.text integerValue] + [self getPoints]];
                    }
                }
            }
            if (button.center.y > 320) {
                [balls removeObjectAtIndex:i];
                [button removeFromSuperview];
                ballsInTheBottom++;
                NSLog(@"%d",ballsInTheBottom);
            }
        } else {
            button.center = CGPointMake(button.center.x + [(NSNumber*)[ball objectForKey:@"deltaX"] floatValue],
                                        button.center.y + [(NSNumber*)[ball objectForKey:@"deltaY"] floatValue] + GRAVITY * status);
            [self.view bringSubviewToFront:button];
            if (GRAVITY * (status+1) + [(NSNumber*)[ball objectForKey:@"deltaY"] floatValue] > 0) {
                [ball setObject:[NSNumber numberWithInt:1] forKey:@"back"];
            }
        }
    }
}

- (void) aiIsThrowing {
    if (leftTime <= 0 && aiActionNumber % 11 == 0) {
        return;
    } else {
        aiActionNumber++;
        self.aiPlayer.image = [self.aiActions objectAtIndex:aiActionNumber % 11];
        if (aiActionNumber % 11 == 2) {
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(250, 330, 64, 64);
            float offsetX = (float)(arc4random() % 31) - 15.0f;
            float offsetY = (float)(arc4random() % 31) - 15.0f;
            [button setImage:[self.spinningBall objectAtIndex:0] forState:UIControlStateNormal];
            [button setUserInteractionEnabled:FALSE];
            [balls addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                              button, @"button",
                              [NSNumber numberWithFloat:(offsetX - 15) * 0.1], @"deltaX",
                              [NSNumber numberWithFloat:(offsetY - 150) * 0.1 - 17], @"deltaY",
                              [NSNumber numberWithInt:0], @"back",
                              [NSNumber numberWithInt:0], @"getPoints",
                              nil]];
            [self.view addSubview:button];
            ballsInTheBottom--;
        }
        [self.view bringSubviewToFront:aiPlayer];        
    }
}

- (void)update:(NSTimer*)timer {
    [self ballIsMoving];
    [self aiIsThrowing];
    leftTime = leftTime - 1;
    if (leftTime > 0) {
        if ((leftTime % 600)/10 > 9) {
            self.timeLeft.text = [NSString stringWithFormat:@"%d:%d",leftTime/600,(leftTime % 600)/10];
        } else {
            self.timeLeft.text = [NSString stringWithFormat:@"%d:0%d",leftTime/600,(leftTime % 600)/10];
        }
        
    } else if (leftTime == 0){
        self.result.hidden = FALSE;
        self.replayButton.hidden = FALSE;
        self.backbutton.hidden = FALSE;
        self.changeOpponent.hidden = FALSE;
        self.inGame = FALSE;
        [self.view bringSubviewToFront:result];
        [self.view bringSubviewToFront:replayButton];
        [self.view bringSubviewToFront:backbutton];
        [self.view bringSubviewToFront:changeOpponent];
        if ([self.score_player_1.text integerValue] > [self.score_player_2.text integerValue]) {
            self.result.text = @"You wins!";
        } else if ([self.score_player_1.text integerValue] < [self.score_player_2.text integerValue]) {
            self.result.text = @"Computer wins!";
        } else {
            self.result.text = @"Draw";
        }
    } else {
        [self.view bringSubviewToFront:result];
        [self.view bringSubviewToFront:replayButton];
        [self.view bringSubviewToFront:backbutton];
        [self.view bringSubviewToFront:changeOpponent];
    }
}

- (IBAction)startGame {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update:) userInfo:nil repeats:YES];
    startButton.hidden = TRUE;
    backbutton.hidden = TRUE;
    changeOpponent.hidden = TRUE;
    inGame = TRUE;
}

- (IBAction)replayGame {
    [self initParameter];
    backbutton.hidden = TRUE;
    changeOpponent.hidden = TRUE;
    inGame = TRUE;
}

- (IBAction)backToMenu {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)changeAiOpponent {
    self.playerNumber = (self.playerNumber) % 4 + 1;
    self.aiActions = [NSArray arrayWithObjects:
                      [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b01.png", self.playerNumber]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b02.png", self.playerNumber]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b03.png", self.playerNumber]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b04.png", self.playerNumber]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b05.png", self.playerNumber]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b06.png", self.playerNumber]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b07.png", self.playerNumber]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b08.png", self.playerNumber]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b09.png", self.playerNumber]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b10.png", self.playerNumber]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"bb_p%d_b11.png", self.playerNumber]],
                      nil];
    self.aiPlayer.image = [aiActions objectAtIndex:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [self setScore_player_1:nil];
    [self setScore_player_2:nil];
    [self setHoop_1:nil];
    [self setHoop_2:nil];
    [self setResult:nil];
    [self setReplayButton:nil];
    [self setBackbutton:nil];
    [self setStartButton:nil];
    [self setAiPlayer:nil];
    [self setChangeOpponent:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
