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


@implementation SplashScreenViewController

@synthesize uiLoading;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self performSelector:@selector(startApp) withObject:nil afterDelay:0.5f];

}

- (void)startApp {
	EventListViewController *rvc = [[EventListViewController alloc] initWithNibName:@"EventListView" bundle:nil];
	//rvc.confListData = eventListData;
	UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:rvc];
	[[[self view] window] addSubview:[navC view]];
	/*
	[navC release];
	[rvc release];
	 */
	[[self view] removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}


@end
