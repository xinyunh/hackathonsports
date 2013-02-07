//
//  StarCraftViewController.m
//  hackathon-sports
//
//  Created by Zhixing Jin on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StarCraftViewController.h"

#define FPS 10
#define MAX_ZERG_NUM 20
#define MAX_DURATION 1000
#define STEP_DURATION 100

int typeNum = 2;
int statusNum = 6;
int zergWidth = 64;
int zergHeight = 64;
int initZergNum = 5;
float initZergGenerationRate = 0.1;
float initZergSpeed = 0.1;

@interface StarCraftViewController ()

@property (retain, nonatomic) NSTimer* timer;
@property (retain, nonatomic) NSArray *zergWalk;
@property (retain, nonatomic) NSArray *zergDeath;
@property CGPoint centerPos;
@property int commandCenterLife;
@property int timePassed;
@property int zergKilled;
@property int zergNum;
@property float zergSpeed;
@property float zergGenerationRate;
@property int ccBloodWidth;

@end

@implementation StarCraftViewController
@synthesize zergs;
@synthesize timer;

@synthesize killResult;
@synthesize backButton;

@synthesize ccBlood;
@synthesize ccBloodBorder;
@synthesize statistics;
@synthesize background;
@synthesize ccGotHit;

@synthesize currentScore;
@synthesize highestScore;
@synthesize currentTime;

@synthesize centerPos;
@synthesize zergWalk;
@synthesize zergDeath;
@synthesize commandCenterLife;
@synthesize timePassed;
@synthesize zergKilled;
@synthesize zergSpeed;
@synthesize zergNum;
@synthesize zergGenerationRate;
@synthesize ccBloodWidth;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.zergs = [NSMutableArray array];
        NSMutableArray* walkArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < typeNum; i++) {
            [walkArray addObject:[NSMutableArray array]];
            for (int j = 0; j < statusNum; j++) {
                [[walkArray objectAtIndex:i] addObject:[UIImage imageNamed:[NSString stringWithFormat:@"sc_z%i_0%i.png", i+1, j+1]]];
            }
        }
        self.zergWalk = walkArray;
        [walkArray release];
        
        NSMutableArray* deathArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < typeNum; i++) {
            [deathArray addObject:[NSMutableArray array]];
            for (int j = 0; j < statusNum; j++) {
                [[deathArray objectAtIndex:i] addObject:[UIImage imageNamed:[NSString stringWithFormat:@"sc_z%i_d0%i.png", i+1, j+1]]];
            }
        }
        self.zergDeath = deathArray;
        [deathArray release];
        self.commandCenterLife = 5;
        self.timePassed = 0;
        self.zergKilled = 0;
        self.zergNum = initZergNum;
        self.zergSpeed = initZergSpeed;
        self.zergGenerationRate = initZergGenerationRate;
        self.ccBloodWidth = 100;
    }
    return self;
}

- (void)dealloc {
    [zergs release], zergs = nil;
    [timer release], timer = nil;
    
    [zergWalk release], zergWalk = nil;
    [zergDeath release], zergDeath = nil;
    
    [currentTime release], currentTime = nil;
    [currentScore release], currentScore = nil;
    [highestScore release], highestScore = nil;
    [killResult release], killResult = nil;
    [backButton release], backButton = nil;
    [super dealloc];
}

- (void)createZerg {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // todo    
    int zergX = -zergHeight;
    int zergY = -zergWidth;
    
    int appearingSide = rand() % 4;
    if (appearingSide == 0 || appearingSide == 2) {
        zergY = rand() % (int)([UIScreen mainScreen].bounds.size.height + zergHeight) - zergHeight;
        if (appearingSide == 2) {
            zergX = [UIScreen mainScreen].bounds.size.width;
        }
    } else {
        zergX = rand() % (int)([UIScreen mainScreen].bounds.size.width + zergWidth) - zergWidth;
        if (appearingSide == 2) {
            zergY = [UIScreen mainScreen].bounds.size.height;
        }
    }
    
    button.frame = CGRectMake(zergX, zergY, zergWidth, zergHeight);
    int type = ((float)rand()/RAND_MAX > 1.0 / typeNum);
    [button setImage:[[self.zergWalk objectAtIndex:type] objectAtIndex:0] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(destroyZerg:) forControlEvents:UIControlEventTouchDown];
        
    [zergs addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:button, @"button",
                      [NSNumber numberWithFloat:(centerPos.x - button.center.x) * self.zergSpeed / FPS], @"deltaX",
                      [NSNumber numberWithFloat:(centerPos.y - button.center.y) * self.zergSpeed / FPS], @"deltaY",
                      [NSNumber numberWithInt:0], @"status",
                      [NSNumber numberWithInt:type], @"type",
                      [NSNumber numberWithBool:NO], @"death",
                      nil]];
    
    //NSLog(@"new zerg created");
    //[zergs setObject:@"adgad" forKey:button];
    [self.view insertSubview:button belowSubview:self.statistics];
}

- (void)destroyZerg:(id)sender{
    for (int i = 0; i < zergs.count; i++) {
        NSMutableDictionary* zerg = [zergs objectAtIndex:i];
        UIButton* button = [zerg objectForKey:@"button"];
        if ((button == sender) && ![[zerg objectForKey:@"death"] boolValue]) {
            self.zergKilled ++;
            self.currentScore.text = [NSString stringWithFormat:@"%i", self.zergKilled];
            [zerg setObject:[NSNumber numberWithBool:YES] forKey:@"death"];
            [zerg setObject:[NSNumber numberWithInt:0] forKey:@"status"];
            [button setImage:[[self.zergDeath objectAtIndex:[[zerg objectForKey:@"type"] intValue]] objectAtIndex:0] forState:UIControlStateNormal];
            break;
        }
    }
}

- (void)showResult {
    for (int i = 0; i < zergs.count; i++) {
        UIButton* button = [(NSMutableDictionary*)[zergs objectAtIndex:i] objectForKey:@"button"];
        [button removeFromSuperview];
    }
    [zergs removeAllObjects];
    
    self.statistics.hidden = YES;
    self.currentTime.hidden = YES;
    self.currentScore.hidden = YES;
    self.highestScore.hidden = YES;
    self.ccBlood.hidden = YES;
    self.ccBloodBorder.hidden = YES;
    
    self.killResult.text = [NSString stringWithFormat:@"%d", self.zergKilled];
    self.killResult.hidden = NO;
    self.backButton.hidden = NO;
    self.ccGotHit.hidden = YES;
    
    self.background.image = [UIImage imageNamed:@"sc_results_bg.png"];
    
    NSUserDefaults *record = [NSUserDefaults standardUserDefaults];
    int hScore = [[record objectForKey:@"starcraft"] intValue];
    hScore = MAX(hScore, self.zergKilled);
    
    [record setObject:[NSNumber numberWithInt:hScore] forKey:@"starcraft"];
    [record synchronize];
}

- (void)getHit {
    self.commandCenterLife --;
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < statusNum; i++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"sc_hit_0%i.png", i+1]]];
    }
    
    self.ccGotHit.hidden = NO;
    self.ccGotHit.animationImages = images;
    self.ccGotHit.animationDuration = 1.0;
    self.ccGotHit.animationRepeatCount = 1;
    [self.ccGotHit startAnimating];
    
    CGRect bFrame = self.ccBlood.frame;
    bFrame.size.width = (float)self.commandCenterLife / 5 * self.ccBloodWidth;
    self.ccBlood.frame = bFrame;
}

- (void)update:(NSTimer*)timer {
    self.timePassed ++;
    if (self.timePassed > MAX_DURATION) {
        [self.timer invalidate];
        [self showResult];
    }
    self.currentTime.text = [NSString stringWithFormat:@"%i", (int)((MAX_DURATION - self.timePassed)/FPS)];
    int rate = self.timePassed / STEP_DURATION + 1;
    self.zergSpeed = initZergSpeed * rate;
    self.zergNum = initZergNum * rate;
    self.zergGenerationRate = initZergGenerationRate * rate; 
    
    //NSLog(@"update");
    for (int i = 0; i < zergs.count; i++) {
        NSMutableDictionary *zerg = [zergs objectAtIndex:i];
        UIButton* button = [zerg objectForKey:@"button"];
        
        int status = [[zerg objectForKey:@"status"] intValue] + 1;
        
        if ([[zerg objectForKey:@"death"] boolValue]) { // the zerg is dead;
            if (status < statusNum) {   // animating
                [button setImage:[[self.zergDeath objectAtIndex:[[zerg objectForKey:@"type"] intValue]] objectAtIndex:status] forState:UIControlStateNormal];
            } else {    // disappear
                [zergs removeObject:zerg];
                [button removeFromSuperview];
                break;
            }            
        } else {
            status %= statusNum;
            button.center = CGPointMake(button.center.x + [(NSNumber*)[zerg objectForKey:@"deltaX"] floatValue], button.center.y + [(NSNumber*)[zerg objectForKey:@"deltaY"] floatValue]);
            [button setImage:[[self.zergWalk objectAtIndex:[[zerg objectForKey:@"type"] intValue]] objectAtIndex:status] forState:UIControlStateNormal];
        }
        [zerg setObject:[NSNumber numberWithInt:status] forKey:@"status"];
        
        if (self.centerPos.x > button.center.x) {
            button.imageView.transform = CGAffineTransformIdentity;
            button.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        }
        
        if (fabs(self.centerPos.x - button.center.x) + fabs(self.centerPos.y - button.center.y) < zergWidth / 2) {
            [zergs removeObjectAtIndex:i];
            [button removeFromSuperview];
            [self getHit];
            if (self.commandCenterLife == 0) {
                [self.timer invalidate];
                [self showResult];
            }
        }
    }
    if (zergs.count <= self.zergNum) {
        float rate = (float)rand() / RAND_MAX;
        //NSLog(@"%g", rate);
        if (rate < self.zergGenerationRate) {
            [self createZerg];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/FPS target:self selector:@selector(update:) userInfo:nil repeats:YES];
    self.killResult.hidden = YES;
    self.backButton.hidden = YES;
    
    self.currentScore.text = [NSString stringWithFormat:@"%i", 0];
    self.currentTime.text = [NSString stringWithFormat:@"%i", 99];
    NSUserDefaults *record = [NSUserDefaults standardUserDefaults];
    if ([record objectForKey:@"starcraft"]) {
        self.highestScore.text = [NSString stringWithFormat:@"%@", [record objectForKey:@"starcraft"]];
    } else {
        self.highestScore.text = @"0";
    }
    
    if (!self.highestScore.text || [self.highestScore.text isEqual:@""]) {
        self.highestScore.text = [NSString stringWithFormat:@"%i", 0];
    }
    
    [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.centerPos = self.view.center;
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
