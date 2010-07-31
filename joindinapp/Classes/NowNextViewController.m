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

#import "NowNextViewController.h"
#import "EventTalkViewCellWithTrack.h"
#import "EventTalkViewCell.h"
#import "UserTalkCommentDetailModel.h"
#import "UserGetComments.h"
#import "TalkDetailViewController.h"

@implementation NowNextViewController

@synthesize event;
@synthesize talks;
@synthesize comments;

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
	self.title = self.event.name;
	UserGetComments *u = [APICaller UserGetComments:self];
	[u call:nil];
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


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		// Now
		return [self.talks.talksNow count];
	} else {
		// Next
		return [self.talks.talksNext count];
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"Now";
	} else {
		return @"Next";
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    TalkDetailModel *tdm;
	// Get relevant talk on relevant date
	if ([indexPath section] == 0) {
		tdm = [self.talks.talksNow objectAtIndex:[indexPath row]];
	} else {
		tdm = [self.talks.talksNext objectAtIndex:[indexPath row]];
	}
	
	if ([self.event hasTracks]) {
		
		static NSString *CellIdentifier = @"EventTalkViewCellWithTrack";
		
		EventTalkViewCellWithTrack *cell = (EventTalkViewCellWithTrack *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EventTalkCell" owner:nil options:nil];
			for (id currentObject in topLevelObjects) {
				if ([currentObject isKindOfClass:[EventTalkViewCellWithTrack class]]) {
					cell = (EventTalkViewCellWithTrack *)currentObject;
					break;
				}
			}
		}
		
		cell.uiTalkName.text = tdm.title;
		cell.uiSpeaker.text  = tdm.speaker;
		cell.uiRating.image  = [UIImage imageNamed:[NSString stringWithFormat:@"rating-%d.gif", tdm.rating]];
		cell.uiNumComments.text = [NSString stringWithFormat:@"%d", tdm.numComments];
		
		cell.uiTime.text     = [tdm getTimeString:self.event];
		
		if ([tdm.type isEqualToString:@"Talk"]) {
			cell.uiTalkType.image  = [UIImage imageNamed:@"talk.gif"];
		} else if ([tdm.type isEqualToString:@"Keynote"]) {
			cell.uiTalkType.image  = [UIImage imageNamed:@"keynote.gif"];
		} else if ([tdm.type isEqualToString:@"Social Event"]) {
			cell.uiTalkType.image  = [UIImage imageNamed:@"social-event.gif"];
		} else if ([tdm.type isEqualToString:@"Event Related"]) {
			cell.uiTalkType.image  = [UIImage imageNamed:@"workshop.gif"];
		} else {
			cell.uiTalkType.image  = nil;
		}
		
		UserTalkCommentDetailModel *utcdm = [self.comments getCommentForTalk:tdm];
		
		if (utcdm == nil) {
			cell.uiCommentBubble.image = [UIImage imageNamed:@"icon-comment.gif"];
		} else {
			cell.uiCommentBubble.image = [UIImage imageNamed:@"icon-comment-user.gif"];
		}
		
		cell.uiTracks.text = [tdm.tracks getStringTrackList];
		
		return cell;
	} else {
		static NSString *CellIdentifier = @"EventTalkViewCell";
		
		EventTalkViewCell *cell = (EventTalkViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EventTalkCell" owner:nil options:nil];
			for (id currentObject in topLevelObjects) {
				if ([currentObject isKindOfClass:[EventTalkViewCell class]]) {
					cell = (EventTalkViewCell *)currentObject;
					break;
				}
			}
		}
		
		cell.uiTalkName.text = tdm.title;
		cell.uiSpeaker.text  = tdm.speaker;
		cell.uiRating.image  = [UIImage imageNamed:[NSString stringWithFormat:@"rating-%d.gif", tdm.rating]];
		cell.uiNumComments.text = [NSString stringWithFormat:@"%d", tdm.numComments];
		
		cell.uiTime.text     = [tdm getTimeString:self.event];
		
		if ([tdm.type isEqualToString:@"Talk"]) {
			cell.uiTalkType.image  = [UIImage imageNamed:@"talk.gif"];
		} else if ([tdm.type isEqualToString:@"Keynote"]) {
			cell.uiTalkType.image  = [UIImage imageNamed:@"keynote.gif"];
		} else if ([tdm.type isEqualToString:@"Social Event"]) {
			cell.uiTalkType.image  = [UIImage imageNamed:@"social-event.gif"];
		} else if ([tdm.type isEqualToString:@"Event Related"]) {
			cell.uiTalkType.image  = [UIImage imageNamed:@"workshop.gif"];
		} else {
			cell.uiTalkType.image  = nil;
		}
		
		UserTalkCommentDetailModel *utcdm = [self.comments getCommentForTalk:tdm];
		
		if (utcdm == nil) {
			cell.uiCommentBubble.image = [UIImage imageNamed:@"icon-comment.gif"];
		} else {
			cell.uiCommentBubble.image = [UIImage imageNamed:@"icon-comment-user.gif"];
		}
		
		return cell;
	}
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	TalkDetailModel *tdm;
	if ([indexPath section] == 0) {
		tdm = [self.talks.talksNow objectAtIndex:[indexPath row]];
	} else {
		tdm = [self.talks.talksNext objectAtIndex:[indexPath row]];
	}
	
	TalkDetailViewController *talkDetailViewController = [[TalkDetailViewController alloc] initWithNibName:@"TalkDetailView" bundle:nil];
	talkDetailViewController.talk  = tdm;
	talkDetailViewController.event = self.event;
	[self.navigationController pushViewController:talkDetailViewController animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES]; // Deselect the talk row in the event detail screen
	[talkDetailViewController release];
	
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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


- (void)gotUserComments:(UserCommentListModel *)uclm error:(APIError *)err {
	if (uclm == nil) {
		// Can ignore errors - probably to do with the user not being logged-in
	} else {
		self.comments = uclm;
		[(UITableView *)self.view reloadData];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self.event hasTracks]) {
		return 60.0f;
	} else {
		return 45.0f;
	}
}


- (void)dealloc {
    [super dealloc];
}


@end

