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

#import "SplashScreenViewController.h"
#import "EventListViewController.h"
#import "APICaller.h"
#import "EventGetList.h"
#import "EventListModel.h"
#import "EventDetailModel.h"
#import "EventDetailViewController.h"
#import "EventGetDetail.h"
#import "TalkDetailModel.h"
#import "TalkDetailViewController.h"
#import "TalkGetDetail.h"

@implementation SplashScreenViewController

@synthesize uiLoading;
@synthesize navC;
@synthesize havePendingAction;
@synthesize pendingEventId;
@synthesize pendingTalkId;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//self.havePendingAction = NO;
	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	EventListViewController *rvc = [[EventListViewController alloc] initWithNibName:@"EventListView" bundle:nil];
	self.navC = [[UINavigationController alloc] initWithRootViewController:rvc];
	
	[self performSelector:@selector(startApp) withObject:nil afterDelay:0.7f];
	
}

- (void)startApp {
	//rvc.confListData = eventListData;
	/*
	[navC release];
	[rvc release];
	 */
	[[[self view] window] addSubview:[self.navC view]];
	[[self view] removeFromSuperview];
	
	[self performSelector:@selector(performPendingActions) withObject:nil afterDelay:0.1f];
}

- (IBAction) pressedWebsite {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://joind.in/"]];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


#pragma mark -
#pragma mark URL-launched methods

- (void) performPendingActions {
	if (self.havePendingAction) {
		self.havePendingAction = NO;
	}
}

@end
