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
@synthesize uiHashtag;

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
	
	if (self.event.hashtag != nil && ![self.event.hashtag isEqualToString:@""]) {
		self.uiHashtag.hidden = NO;
		self.uiHashtag.text = self.event.hashtag;
	} else {
		self.uiHashtag.hidden = YES;
	}
	
	// 332, 357, 416
	CGRect _frame = self.uiDescription.frame;
	if (self.uiHashtag.hidden) {
		if (self.uiWebsite.hidden) {
			_frame.size.height = 416;
		} else {
			_frame.size.height = 357;
		}
	} else {
		_frame.size.height = 332;
	}
	self.uiDescription.frame = _frame;
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
