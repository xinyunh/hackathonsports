//
//  SportsViewController.m
//  hackathon-sports
//
//  Created by Zhixing Jin on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SportsViewController.h"

#define DELAY 1.0

@interface SportsViewController ()

@end

@implementation SportsViewController

@synthesize scButton;
@synthesize ppButton;
@synthesize bbButton;
@synthesize sbButton;
@synthesize bgImageView;
@synthesize icon;

//@synthesize scvc;
//@synthesize ppvc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showButtons:NO];
    [self performSelector:@selector(goToSelectScreen) withObject:NULL afterDelay:DELAY];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)goToSelectScreen {
    self.bgImageView.image = [UIImage imageNamed:@"menu_bkgrd.png"];
    [self showButtons:YES];
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

- (void)showButtons:(BOOL)showBtn {
    self.scButton.hidden = !showBtn;
    self.ppButton.hidden = !showBtn;
    self.bbButton.hidden = !showBtn;
    self.sbButton.hidden = !showBtn;
}

- (void)startGame: (UIViewController*) vc {
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)loadStarCraft:(id)sender {
    self.icon.image = [UIImage imageNamed:@"menu_display_sc.png"];
    StarCraftViewController* scvc = [[StarCraftViewController alloc] initWithNibName:@"StarCraftViewController" bundle:nil];
    [self performSelector:@selector(startGame:) withObject:scvc afterDelay:DELAY];
}

- (IBAction)loadPingPong:(id)sender {
    self.icon.image = [UIImage imageNamed:@"menu_display_pp.png"];
    PingPongViewController* ppvc = [[PingPongViewController alloc] initWithNibName:@"PingPongViewController" bundle:nil];
    [self performSelector:@selector(startGame:) withObject:ppvc afterDelay:DELAY];
}

- (IBAction)loadBasketBall:(id)sender {
    self.icon.image = [UIImage imageNamed:@"menu_display_bb.png"];
    BasketballViewController* bbvc = [[BasketballViewController alloc] initWithNibName:@"BasketballViewController" bundle:nil];
    [self performSelector:@selector(startGame:) withObject:bbvc afterDelay:DELAY];
}

- (IBAction)loadSoftBall:(id)sender {
    
}

@end
