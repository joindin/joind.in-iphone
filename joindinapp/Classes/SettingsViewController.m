//
//  SettingsViewController.m
//  joindinapp
//
//  Created by Kevin on 06/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

@synthesize uiUser;
@synthesize uiPass;
@synthesize uiLimitEvents;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
	self.uiUser.text = [userPrefs stringForKey:@"username"];
	self.uiPass.text = [userPrefs stringForKey:@"password"];
	self.uiLimitEvents.on = [userPrefs boolForKey:@"limitevents"];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
	[userPrefs setObject:self.uiUser.text forKey:@"username"];
	[userPrefs setObject:self.uiPass.text forKey:@"password"];
	[userPrefs setBool:self.uiLimitEvents.on forKey:@"limitevents"];
	[userPrefs synchronize];
}

/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



- (void)dealloc {
    [super dealloc];
}


@end

