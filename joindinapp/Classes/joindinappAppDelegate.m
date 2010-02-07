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
	
    //[[NSUserDefaults standardUserDefaults] setObject:URLString forKey:@"url"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
	
	/*
	NSURL *logurl = [NSURL URLWithString:@"http://kevin.rivendell.local/?url2"];
	NSError *error;
	NSMutableURLRequest* liveRequest = [[NSMutableURLRequest alloc] initWithURL:logurl];
	[liveRequest setCachePolicy:NSURLRequestReloadIgnoringCacheData];
	[liveRequest setValue:@"headervalue" forHTTPHeaderField:@"headerfield"];
	NSURLResponse* response;
	NSData* myData = [NSURLConnection sendSynchronousRequest:liveRequest returningResponse:&response error:&error];
	NSString * checkResponse = [[NSString alloc] initWithData:myData encoding:NSASCIIStringEncoding];
	*/
	
    return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[splashScreenViewController release];
	[window release];
	[super dealloc];
}


@end

