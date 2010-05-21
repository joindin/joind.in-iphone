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
	
	// This is what happens when launched from a URL:
	//[self application:application handleOpenURL:[NSURL URLWithString:@"joindin://event/110"]];
	
	[window addSubview:[splashScreenViewController view]];
	[window makeKeyAndVisible];
	
	// Go straight to an event: (note that you probably want to remove the joindin:// handler if you do this)
	//[splashScreenViewController gotoEventScreenWithEventId:142];

}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}

// Handle someone opening a "joindin://talk/123" or "joindin://event/123" URL
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{
	if (url == nil) {
		return NO;
	}
	
    NSString *URLString = [url absoluteString];
	
	NSArray *components = [URLString componentsSeparatedByString:@"/"];
	
	NSString *type  = [components objectAtIndex:2];
	NSString *reqid = [components objectAtIndex:3];
	
	if (type != nil) {
		if (reqid != nil) {
			if ([type isEqualToString:@"event"]) {
				[splashScreenViewController gotoEventScreenWithEventId:[reqid integerValue]];
				return YES;
			} else if ([type isEqualToString:@"talk"]) {
				[splashScreenViewController gotoTalkScreenWithTalkId:[reqid integerValue]];
				return YES;
			}
		}
	}
	
    return NO;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[splashScreenViewController release];
	[window release];
	[super dealloc];
}


@end

