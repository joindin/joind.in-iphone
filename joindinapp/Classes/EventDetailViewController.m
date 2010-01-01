//
//  AnotherViewController.m
//  joindinapp
//
//  Created by Kevin on 31/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EventDetailViewController.h"
#import "TalkDetailViewController.h"
#import "EventDetailModel.h"
#import "EventDetailViewCell.h"
#import "TalkListModel.h"
#import "APICaller.h"


@implementation EventDetailViewController

@synthesize event;
@synthesize talks;

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.title = event.name;
	self.talks = [APICaller GetTalksForEvent:event];
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

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 3;
	}
	if (section == 1) {
		return [self.talks getNumTalks];
	}
	return 0;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([indexPath section] == 1) {
		TalkDetailViewController *talkDetailViewController = [[TalkDetailViewController alloc] initWithNibName:@"TalkDetailView" bundle:nil];
		talkDetailViewController.talk = [self.talks getTalkDetailModelAtIndex:[indexPath row]];
		[self.navigationController pushViewController:talkDetailViewController animated:YES];
		[talkDetailViewController release];
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
	
	/*
	*/
	
	if (indexPath.section == 0) {
		EventDetailViewCell *vc = (EventDetailViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cellView"];
		if(vc == nil) {
			[[NSBundle mainBundle] loadNibNamed:@"EventDetailViewCell" owner:self options:nil];
			vc = tblCell;
		}
		
		switch ([indexPath row]) {
			case 0:
				vc.title = event.name;
				
				NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
				[outputFormatter setDateFormat:@"d MMM yyyy"];
				NSString *startDate = [outputFormatter stringFromDate:event.start];
				NSString *endDate   = [outputFormatter stringFromDate:event.end];
				[outputFormatter release];
				
				if ([startDate compare:endDate] == NSOrderedSame) {
					vc.desc = startDate;
				} else {
					vc.desc = [NSString stringWithFormat:@"%@ - %@", startDate, endDate];
				}
				break;
			case 1:
				vc.title = @"Location";
				vc.desc = event.location;
				break;
			case 2:
				vc.title = @"Description";
				vc.desc = event.description;
				break;
			default:
				vc.title = @"default";
				break;
		}
		vc.accessoryType = UITableViewCellAccessoryNone;
		vc.selectionStyle = UITableViewCellSelectionStyleNone;
		return vc;
	} else if (indexPath.section == 1) {
		UITableViewCell *vc;
		vc = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
		[vc autorelease];
		
		TalkDetailModel *tdm = [self.talks getTalkDetailModelAtIndex:[indexPath row]];
		
		vc.textLabel.text = tdm.title;
		vc.detailTextLabel.text = tdm.speaker;
		vc.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		vc.selectionStyle = UITableViewCellSelectionStyleBlue;
		return vc;
	}
	return nil; // Should never happen
	
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		return 70;
	}
	return 50;
}
*/

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(section == 1) {
		return @"Talks";
	}
	return nil;
}

- (void)dealloc {
    [super dealloc];
}


@end

