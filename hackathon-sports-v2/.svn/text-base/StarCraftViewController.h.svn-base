//
//  StarCraftViewController.h
//  hackathon-sports
//
//  Created by Zhixing Jin on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarCraftViewController : UIViewController {
}

@property (retain, nonatomic) NSMutableArray *zergs;

@property (retain, nonatomic) IBOutlet UILabel *killResult;
@property (retain, nonatomic) IBOutlet UIButton *backButton;

@property (retain, nonatomic) IBOutlet UIButton *ccBlood;
@property (retain, nonatomic) IBOutlet UIImageView *statistics;
@property (retain, nonatomic) IBOutlet UIImageView *ccBloodBorder;
@property (retain, nonatomic) IBOutlet UIImageView *background;
@property (retain, nonatomic) IBOutlet UIImageView *ccGotHit;

@property (retain, nonatomic) IBOutlet UILabel *currentScore;
@property (retain, nonatomic) IBOutlet UILabel *highestScore;
@property (retain, nonatomic) IBOutlet UILabel *currentTime;

- (void)createZerg;
- (void)destroyZerg:(id)sender;
- (void)update:(NSTimer*)timer;

@end
