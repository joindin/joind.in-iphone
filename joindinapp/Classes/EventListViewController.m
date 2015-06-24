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
@synthesize eventListTableView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.uiEventRange addTarget:self action:@selector(rangeChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)rangeChanged {
	self.confListData = nil;
	[self.eventListTableView reloadData];
	
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
		[self.eventListTableView reloadData];
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
		
		if (edm.attending) {
			vc.accessoryType = UITableViewCellAccessoryCheckmark;
		} else {
			vc.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		
		NSString *label = edm.name;
		
		NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
		[outputFormatter setDateFormat:@"d MMM yyyy"];
		NSString *startDate = [outputFormatter stringFromDate:edm.startDate];
		NSString *endDate   = [outputFormatter stringFromDate:edm.endDate];
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
    [eventListTableView release];
    [super dealloc];
}


@end

