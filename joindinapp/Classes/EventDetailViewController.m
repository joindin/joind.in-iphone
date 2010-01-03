//
//  AnotherViewController.m
//  joindinapp
//
//  Created by Kevin on 31/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EventDetailViewController.h"
#import "EventDescriptionViewController.h"
#import "TalkDetailViewController.h"
#import "EventDetailModel.h"
#import "TalkListModel.h"
#import "APICaller.h"
#import "EventGetTalks.h"

@implementation EventDetailViewController

@synthesize event;
@synthesize talks;
@synthesize uiTitle;
@synthesize uiDate;
@synthesize uiLocation;
@synthesize uiDesc;
@synthesize uiDescButton;
@synthesize uiScroller;
@synthesize uiViewWithContent;
@synthesize uiLoadTalksIndicator;

#pragma mark View loaders

- (void)viewDidLoad {
    [super viewDidLoad];

	uiFixedView = [self createFixedView];
	self.uiScroller = [[UIScrollView alloc] initWithFrame:[self.view frame]];
	self.uiScroller.canCancelContentTouches = NO;
	//self.uiScroller.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	
	[self resizeScroller];
	
	[self.uiScroller addSubview:uiFixedView];
	[self.view addSubview:self.uiScroller];
	
	EventGetTalks *e = [APICaller EventGetTalks:self];
	[e call:self.event];
	[self.uiLoadTalksIndicator startAnimating];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.title = event.name;
	self.uiTitle.text = event.name;
	self.uiDesc.text = event.description;
	self.uiLocation.text = event.location;
	
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"d MMM yyyy"];
	NSString *startDate = [outputFormatter stringFromDate:event.start];
	NSString *endDate   = [outputFormatter stringFromDate:event.end];
	[outputFormatter release];
	
	if ([startDate compare:endDate] == NSOrderedSame) {
		self.uiDate.text = startDate;
	} else {
		self.uiDate.text = [NSString stringWithFormat:@"%@ - %@", startDate, endDate];
	}
	
}

- (UIView*) createFixedView {
	NSArray* nibContents = [[NSBundle mainBundle] loadNibNamed:@"EventDetailViewFixed" owner:self options:nil];
	NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
	return (UIView*)[nibEnumerator nextObject];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (self.talks == nil) {
		return 0;
	} else {
		return 1;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.talks getNumTalks];
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	TalkDetailViewController *talkDetailViewController = [[TalkDetailViewController alloc] initWithNibName:@"TalkDetailView" bundle:nil];
	talkDetailViewController.talk = [self.talks getTalkDetailModelAtIndex:[indexPath row]];
	[self.navigationController pushViewController:talkDetailViewController animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES]; // Deselect the talk row in the event detail screen
	[talkDetailViewController release];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *vc;
	vc = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
	[vc autorelease];
	
	TalkDetailModel *tdm = [self.talks getTalkDetailModelAtIndex:[indexPath row]];
	
	vc.textLabel.text = tdm.title;
	vc.textLabel.adjustsFontSizeToFitWidth = NO;
	vc.textLabel.font = [UIFont systemFontOfSize:14];
	
	vc.detailTextLabel.text = tdm.speaker;
	vc.detailTextLabel.adjustsFontSizeToFitWidth = NO;
	vc.detailTextLabel.font = [UIFont systemFontOfSize:12];
	
	vc.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	vc.selectionStyle = UITableViewCellSelectionStyleBlue;
	
	return vc;
	
}

#pragma mark User-action handlers

- (IBAction)uiDescButtonPressed:(id)sender {
	EventDescriptionViewController *edvc = [[EventDescriptionViewController alloc] initWithNibName:@"EventDescriptionView" bundle:nil];
	edvc.event = self.event;
	[self.navigationController pushViewController:edvc animated:YES];
	[edvc release];
}

#pragma mark Utility methods

- (void)resizeScroller {
	self.uiScroller.contentSize = CGSizeMake(320, 220 + (44 * [self.talks getNumTalks]));
}

- (void)gotTalksForEvent:(TalkListModel *)tlm {
	[self.uiLoadTalksIndicator stopAnimating];
	self.talks = tlm;
	[(UITableView *)self.uiViewWithContent reloadData];
	[self resizeScroller];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}


@end

