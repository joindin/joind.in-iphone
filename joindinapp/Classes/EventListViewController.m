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

#import <SDWebImage/UIImageView+WebCache.h>

#import "EventListItemTableViewCell.h"
#import "EventListViewController.h"
#import "EventDetailViewController.h"
#import "EventListModel.h"
#import "EventDetailModel.h"
#import "EventGetList.h"
#import "SettingsViewController.h"

@implementation EventListViewController

@synthesize confListData;
@synthesize uiTableHeaderView;
@synthesize uiFetchingCell;
@synthesize eventListTableView;

- (IBAction)rangeChanged:(id)sender {
    [self refreshEvents];
}

- (void)refreshEvents {
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
		
	} else {
		
		if (self.uiEventRange.selectedSegmentIndex == 0) {
			// Chosen event range is "past" therefore reverse the event array
			[eventListData sort:false];
		}
		
		self.confListData = eventListData;
		[self.eventListTableView reloadData];
	}

    if (self.eventListTableView.refreshControl.isRefreshing) {
        [self.eventListTableView.refreshControl endRefreshing];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	SettingsViewController *vc = [[SettingsViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.eventListTableView.rowHeight = UITableViewAutomaticDimension;
    self.eventListTableView.estimatedRowHeight = 44.0;

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.eventListTableView.refreshControl = refreshControl;
    [refreshControl addTarget:self action:@selector(refreshEvents) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self rangeChanged:self.uiEventRange];
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

// NOTE: This is temporary only until the Settings view has been brought
// over to the storyboard
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"settingsSegue"]) {
        SettingsViewController *vc = [[SettingsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

        return NO;
    }

    return YES;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.confListData != nil) {
		EventDetailViewController *eventDetailViewController = [[EventDetailViewController alloc] init];
		EventDetailModel *edm = [self.confListData getEventDetailModelAtIndex:[indexPath row]];
		eventDetailViewController.event = edm;
		[self.navigationController pushViewController:eventDetailViewController animated:YES];
	}
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.confListData == nil) {
		return self.uiFetchingCell;
	}

    EventListItemTableViewCell *vc = (EventListItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"eventListItemCell" forIndexPath:indexPath];

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

    if ([startDate compare:endDate] == NSOrderedSame) {
        vc.subtitleLabel.text = startDate;
    } else {
        vc.subtitleLabel.text = [NSString stringWithFormat:@"%@ - %@", startDate, endDate];
    }

    vc.titleLabel.text = label;

    NSString *url = [NSString stringWithFormat:@"https://joind.in/inc/img/event_icons/%@", edm.icon];
    [vc.eventIcon sd_setImageWithURL:[NSURL URLWithString:url]
                    placeholderImage:[UIImage imageNamed:@"defaultEventIcon"]];

    return vc;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.confListData == nil) {
		return 0;
	}

    return [self.confListData getNumEvents];
}

@end

