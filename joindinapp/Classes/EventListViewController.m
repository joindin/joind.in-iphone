//
//  EventListViewController.m
//  joindinapp
//
//  Created by Kevin on 31/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "EventListViewController.h"
#import "EventDetailViewController.h"
#import "EventListModel.h"
#import "EventDetailModel.h"
#import "EventGetList.h"
#import "SettingsViewController.h"

@implementation EventListViewController

@synthesize confListData;
@synthesize uiEventRange;
@synthesize uiTableHeaderView;
@synthesize uiFetchingCell;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = @"Events";
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(btnPressed)];
	
	NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"EventListView" owner:self options:nil];
	self.uiTableHeaderView = [nibViews objectAtIndex: 1];	
	((UITableView *)[self view]).tableHeaderView = self.uiTableHeaderView;
	
	[self.uiEventRange addTarget:self
						  action:@selector(rangeChanged)
				forControlEvents:UIControlEventValueChanged];
	
	
}

- (void)btnPressed {
	SettingsViewController *vc = [[SettingsViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];	
}

- (void)rangeChanged {
	self.confListData = nil;
	[(UITableView *)[self view] reloadData];
	
	EventGetList *e = [APICaller EventGetList:self];

	switch (self.uiEventRange.selectedSegmentIndex) {
		case 0:	// Past
			[e call:@"past"];
			break;
		case 1:	// Hot
			[e call:@"hot"];
			break;
		case 2:	// Upcoming
			[e call:@"upcoming"];
			break;
		default:
			NSLog(@"Oops");
			break;
	}
}

- (void)gotEventListData:(EventListModel *)eventListData error:(APIError *)error {
	if (error != nil) {
		//NSLog(@"Error: %@", error.msg);
		UIAlertView *alert;
		if (error.type == ERR_CREDENTIALS) {
			alert = [[UIAlertView alloc] initWithTitle:@"Error" message:(NSString *)error.msg 
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		} else {
			alert = [[UIAlertView alloc] initWithTitle:@"Error" message:(NSString *)error.msg 
														   delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
		}
		[alert show];
		[alert release];
		
	} else {
		
		if (self.uiEventRange.selectedSegmentIndex == 0) {
			// Chosen event range is "past" therefore reverse the event array
			[eventListData sort:false];
		}
		
		self.confListData = eventListData;
		[(UITableView *)[self view] reloadData];
	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	SettingsViewController *vc = [[SettingsViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self rangeChanged];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (self.confListData == nil) {
		return 1;
	} else {
		return 1;
	}
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.confListData != nil) {
		EventDetailViewController *eventDetailViewController = [[EventDetailViewController alloc] init];
		EventDetailModel *edm = [self.confListData getEventDetailModelAtIndex:[indexPath row]];
		eventDetailViewController.event = edm;
		[self.navigationController pushViewController:eventDetailViewController animated:YES];
		[eventDetailViewController release];
	}
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	if (self.confListData == nil) {
		return self.uiFetchingCell;
	} else {
		UITableViewCell *vc;
		vc = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
		[vc autorelease];
		
		EventDetailModel *edm = [self.confListData getEventDetailModelAtIndex:[indexPath row]];
		
		if (edm.userAttend) {
			vc.accessoryType = UITableViewCellAccessoryCheckmark;
		} else {
			vc.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		
		NSString *label = edm.name;
		
		NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
		[outputFormatter setDateFormat:@"d MMM yyyy"];
		NSString *startDate = [outputFormatter stringFromDate:edm.start];
		NSString *endDate   = [outputFormatter stringFromDate:edm.end];
		[outputFormatter release];
		
		if ([startDate compare:endDate] == NSOrderedSame) {
			vc.detailTextLabel.text = startDate;
		} else {
			vc.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", startDate, endDate];
		}
		
		vc.textLabel.text = label;
		return vc;
	}
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.confListData == nil) {
		return 1;
	} else {
		return [self.confListData getNumEvents];
	}
}

- (void)dealloc {
    [super dealloc];
}


@end

