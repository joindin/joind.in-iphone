//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the organisation (joind.in) nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "joindinappAppDelegate.h"
#import "SplashScreenViewController.h"
#import "EventListViewController.h"


@implementation joindinappAppDelegate

@synthesize window;
@synthesize splashScreenViewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)applicationDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after app launch
    return YES;
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

@end

