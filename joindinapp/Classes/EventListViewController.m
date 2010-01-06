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
	
	NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"EventListView" owner:self options:nil];
	self.uiTableHeaderView = [nibViews objectAtIndex: 1];	
	((UITableView *)[self view]).tableHeaderView = self.uiTableHeaderView;
	
	[self.uiEventRange addTarget:self
						  action:@selector(rangeChanged)
				forControlEvents:UIControlEventValueChanged];
	
	[self rangeChanged];
	
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

- (void)gotEventListData:(EventListModel *)eventListData {
	self.confListData = eventListData;
	[(UITableView *)[self view] reloadData];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	if (self.confListData == nil) {
		//vc.textLabel.text = @"Fetching data...";
		//NSLog(@"Table cell is %@", test);
		return self.uiFetchingCell;
	} else {
		UITableViewCell *vc;
		vc = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
		[vc autorelease];
		
		EventDetailModel *edm = [self.confListData getEventDetailModelAtIndex:[indexPath row]];
		
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
		vc.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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

