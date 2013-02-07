//
//  SportsViewController.h
//  hackathon-sports
//
//  Created by Zhixing Jin on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarCraftViewController.h"
#import "PingPongViewController.h"
#import "BasketballViewController.h"

@interface SportsViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton* scButton;
@property (retain, nonatomic) IBOutlet UIButton* ppButton;
@property (retain, nonatomic) IBOutlet UIButton* bbButton;
@property (retain, nonatomic) IBOutlet UIButton* sbButton;

@property (retain, nonatomic) IBOutlet UIImageView* bgImageView;
@property (retain, nonatomic) IBOutlet UIImageView* icon;

- (IBAction)loadStarCraft:(id)sender;
- (IBAction)loadPingPong:(id)sender;
- (IBAction)loadBasketBall:(id)sender;
- (IBAction)loadSoftBall:(id)sender;

- (void)showButtons:(BOOL)showBtn;

@end


