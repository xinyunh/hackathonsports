//
//  AppDelegate.m
//  hackathon-sports
//
//  Created by Zhixing Jin on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navcon = _navcon;

- (void)dealloc
{
    [_window release];
    [_navcon release], _navcon = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.navcon = [[[UINavigationController alloc] init] autorelease];
    self.navcon.navigationBarHidden = YES;
    
    SportsViewController *svc = [[SportsViewController alloc] initWithNibName:@"SportsViewController" bundle:nil];
    [self.navcon pushViewController:svc animated:NO];
    [svc release];
    
    [self.window addSubview:self.navcon.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
