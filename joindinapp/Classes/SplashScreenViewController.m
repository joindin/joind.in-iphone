//
//  SplashScreenViewController.m
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark URL-launched methods

- (void) performPendingActions {
	if (self.havePendingAction) {
		self.havePendingAction = NO;
		if (self.pendingEventId > 0) {
			[self reallyGotoEventScreenWithEventId:self.pendingEventId];
		} else if (self.pendingTalkId > 0) {
			[self reallyGotoTalkScreenWithTalkId:self.pendingTalkId];
		}
	}
}

#pragma mark URL-launched event

- (void) gotoEventScreenWithEventId:(NSUInteger)eventId {
	self.havePendingAction = YES;
	self.pendingEventId = eventId;
}

- (void) reallyGotoEventScreenWithEventId:(NSUInteger)eventId {
	EventGetDetail *ed = [APICaller EventGetDetail:self];
	[ed call:eventId];
}

- (void) gotoEventScreenWithEventDetailModel:(EventDetailModel *)edm {
	EventDetailViewController *eventDetailViewController = [[EventDetailViewController alloc] init];
	eventDetailViewController.event = edm;
	[self.navC pushViewController:eventDetailViewController animated:YES];
	//[eventDetailViewController release];	
}

- (void)gotEventDetailData:(EventDetailModel *)edm error:(APIError *)err {
	if (edm != nil) {
		[self gotoEventScreenWithEventDetailModel:edm];
	}
}

#pragma mark URL-launched talk

- (void) gotoTalkScreenWithTalkId:(NSUInteger)talkId {
	self.havePendingAction = YES;
	self.pendingTalkId = talkId;
}

- (void) reallyGotoTalkScreenWithTalkId:(NSUInteger)talkId {
	TalkGetDetail *td = [APICaller TalkGetDetail:self];
	[td call:talkId];
}

- (void) gotoTalkScreenWithTalkDetailModel:(TalkDetailModel *)tdm {
	TalkDetailViewController *talkDetailViewController = [[TalkDetailViewController alloc] init];
	talkDetailViewController.talk = tdm;
	[self.navC pushViewController:talkDetailViewController animated:YES];
	//[talkDetailViewController release];	
}

- (void)gotTalkDetailData:(TalkDetailModel *)tdm error:(APIError *)err {
	if (tdm != nil) {
		[self gotoTalkScreenWithTalkDetailModel:tdm];
	}
}

@end
