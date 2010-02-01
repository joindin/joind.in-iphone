//
//  EventDescriptionViewController.m
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventDescriptionViewController.h"


@implementation EventDescriptionViewController
@synthesize event;
@synthesize uiDescription;
@synthesize uiWebsite;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.title = self.event.name;
	self.uiDescription.text = self.event.description;
	if (self.event.url != nil && ![self.event.url isEqualToString:@""]) {
		self.uiWebsite.hidden = NO;
	} else {
		self.uiWebsite.hidden = YES;
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction) uiWebsitePressed:(id)sender {
	if (self.event.url != nil && ![self.event.url isEqualToString:@""]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.event.url]];
	}
}

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
