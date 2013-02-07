//
//  PingPongViewController.h
//  hackathon-sports
//
//  Created by Yufeng Chen on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingPongViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIImageView *ball;
@property (nonatomic, retain) IBOutlet UIImageView *opponent;
@property (nonatomic, retain) IBOutlet UIImageView *player;
@property (nonatomic, retain) IBOutlet UIButton *topRight;
@property (nonatomic, retain) IBOutlet UIButton *topLeft;
@property (nonatomic, retain) IBOutlet UIButton *bottomRight;
@property (nonatomic, retain) IBOutlet UIButton *bottomLeft;
@property (nonatomic, retain) IBOutlet UILabel *currentScore;
@property (nonatomic, retain) IBOutlet UILabel *topScore;
@property (nonatomic, retain) IBOutlet UIView *scoreView;
@property (nonatomic, retain) IBOutlet UILabel *yourScore;

- (IBAction)hitBall:(UIButton *)sender;
- (IBAction)quit:(UIButton *)sender;

@end

