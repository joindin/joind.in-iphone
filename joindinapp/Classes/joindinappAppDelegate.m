//
//  joindinappAppDelegate.m
//  joindinapp
//
//  Created by Kevin on 31/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "joindinappAppDelegate.h"
#import "SplashScreenViewController.h"
#import "EventListViewController.h"


@implementation joindinappAppDelegate

@synthesize window;
@synthesize splashScreenViewController;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[splashScreenViewController view]];
    [window makeKeyAndVisible];
	[self performSelector:@selector(startApp) withObject:nil afterDelay:0.2f];
}

- (void)startApp {
	[[splashScreenViewController view] removeFromSuperview];
	
	EventListViewController *rvc = [[EventListViewController alloc] initWithNibName:@"EventListView" bundle:nil];
	UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:rvc];
	[window addSubview:[navC view]];
	
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[splashScreenViewController release];
	[window release];
	[super dealloc];
}


@end

