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

#import "EventDetailViewController.h"
#import "EventDescriptionViewController.h"
#import "TalkDetailViewController.h"
#import "EventDetailModel.h"
#import "TalkListModel.h"
#import "APICaller.h"
#import "EventGetTalks.h"
#import "SettingsViewController.h"
#import "NowNextViewController.h"
#import "EventAttend.h"
#import "UISwitch-Extended.h"
#import "EventCommentsViewController.h"
#import "EventGetDetail.h"
#import "EventTalkViewCell.h"
#import "EventTalkViewCellWithTrack.h"
#import "EventTalkDateHeaderViewCell.h"
#import "EventLocationViewController.h"
#import "UserGetComments.h"
#import <UIKit/UIKit.h>

@implementation EventDetailViewController

@synthesize event;
@synthesize talks;
@synthesize comments;
@synthesize uiTitle;
@synthesize uiDate;
@synthesize uiLocation;
@synthesize uiDesc;
@synthesize uiDescButton;
@synthesize uiLoadTalksIndicator;
@synthesize uiTableHeaderView;
@synthesize uiAttending;
@synthesize uiAttendingLabel;
@synthesize uiAttendingIndicator;
@synthesize uiComments;
@synthesize uiLoading;
@synthesize uiLocationButton;

#pragma mark View loaders

- (void)viewDidLoad {
    [super viewDidLoad];
	//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(uiSettingsButtonPressed)];

	NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"EventDetailView" owner:self options:nil];
	self.uiTableHeaderView = [nibViews objectAtIndex: 1];
	((UITableView *)[self view]).tableHeaderView = self.uiTableHeaderView;
	
	[self view].backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.uiAttending.on = self.event.attending;
	self.title = self.event.name;
	self.uiTitle.text = self.event.name;
	self.uiDesc.text = self.event.description;
	self.uiLocation.text = self.event.location;
	
	if (self.event.latitude != 0) {
		self.uiLocationButton.hidden = NO;
	} else {
		self.uiLocationButton.hidden = YES;
	}
	
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"d MMM yyyy"];
	NSString *startDate = [outputFormatter stringFromDate:self.event.startDate];
	NSString *endDate   = [outputFormatter stringFromDate:self.event.endDate];
	[outputFormatter release];
	
	[self setupAttending];
	
	[self.uiAttending addTarget:self action:@selector(uiAttendingButtonPressed:) forControlEvents:UIControlEventValueChanged];
	
	if ([startDate compare:endDate] == NSOrderedSame) {
		self.uiDate.text = startDate;
	} else {
		self.uiDate.text = [NSString stringWithFormat:@"%@ - %@", startDate, endDate];
	}
	
	[self.uiLoading startAnimating];
	[self.talks sort];
	self.uiComments.hidden    = YES;
	EventGetDetail *ed = [APICaller EventGetDetail:self];
	[ed call:self.event.verboseURI];
	
	[self.uiLoadTalksIndicator startAnimating];	
	EventGetTalks *e = [APICaller EventGetTalks:self];
	[e call:self.event];
	
//	UserGetComments *u = [APICaller UserGetComments:self];
//	[u call:nil];
	
	if ([self.event isNowOn]) {
		for (TalkDetailModel *tdm in self.talks.talks) {
			if ([tdm onNow] || [tdm onNext]) {
				self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Now/next" style:UIBarButtonItemStylePlain target:self action:@selector(nowNextBtnPressed)];
				break;
			}
		}
	}
	
}

- (void)gotEventDetailData:(EventDetailModel *)edm error:(APIError *)err {
	self.event = edm;
	[self.uiLoading stopAnimating];
	// Set button label
	NSString *btnLabel;
	
	if (edm.commentsEnabled) {
		if (edm.eventCommentsCount > 0) {
			btnLabel = @"View / add comments";
		} else {
			btnLabel = @"Add comment";
		}
		self.uiComments.enabled = YES;
	} else {
		if (edm.eventCommentsCount > 0) {
			btnLabel = @"View comments";
			self.uiComments.enabled = YES;
		} else {
			btnLabel = @"No comments";
			self.uiComments.enabled = NO;
		}
	}
	//btnLabel = @"Comments / Tweets / Photos";self.uiComments.enabled = YES;
	self.uiComments.hidden = NO;
	[self.uiComments setTitle:btnLabel forState:UIControlStateNormal];
	[self.uiComments setTitle:btnLabel forState:UIControlStateHighlighted];
	
	if (self.event.latitude != 0) {
		self.uiLocationButton.hidden = NO;
	} else {
		self.uiLocationButton.hidden = YES;
	}

	
}

- (void)nowNextBtnPressed {
	NowNextViewController *nowNextViewController = [[NowNextViewController alloc] initWithNibName:@"NowNextView" bundle:nil];
	nowNextViewController.event = self.event;
	nowNextViewController.talks = self.talks;
	[self.navigationController pushViewController:nowNextViewController animated:YES];
	[nowNextViewController release];
}

- (void)setupAttending {
    self.uiAttending.on = self.event.attending;
	if ([self.event hasFinished]) {
        self.uiAttendingLabel.text = @"Attended:";
        self.uiAttending.enabled = NO;
    } else {
        self.uiAttendingLabel.text = @"Attending:";

        // Enable/disable the control according to logged-in status
        NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
        NSString *accessToken = [userPrefs stringForKey:@"access_token"];
        BOOL signedIn = (accessToken != nil && [accessToken length] > 0); // true if we have an access token.
        self.uiAttending.enabled = signedIn;
    }
}

- (void)gotUserComments:(UserCommentListModel *)uclm error:(APIError *)err {
	if (uclm == nil) {
		// Can ignore errors - probably to do with the user not being logged-in
	} else {
		self.comments = uclm;
		[(UITableView *)self.view reloadData];
	}
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	if (self.talks == nil) {
		return 0;
	} else {
		NSDictionary *allDates = [self.talks getTalksByDate];

		return [allDates count];
	}
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	NSDictionary *allDates = [self.talks getTalksByDate];
	NSArray *allKeys = [allDates allKeys];
	NSArray *dates = [allKeys sortedArrayUsingSelector:@selector(compare:)];
	NSString *relevantDate = [dates objectAtIndex:section];
	NSArray *talksOnDate = [allDates objectForKey:relevantDate];
	
	return ([talksOnDate count] + 1);
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([indexPath row] == 0) {
		
	} else {
		
		TalkDetailModel *tdm = [self.talks getTalkForDayAndRowByIndex:[indexPath section] rowIndex:([indexPath row] - 1)];
		
		TalkDetailViewController *talkDetailViewController = [[TalkDetailViewController alloc] initWithNibName:@"TalkDetailView" bundle:nil];
		talkDetailViewController.talk  = tdm;
		talkDetailViewController.event = self.event;
		[self.navigationController pushViewController:talkDetailViewController animated:YES];
		[tableView deselectRowAtIndexPath:indexPath animated:YES]; // Deselect the talk row in the event detail screen
		[talkDetailViewController release];
	}
	
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([indexPath row] == 0) {
		static NSString *CellIdentifier2 = @"EventTalkDateHeaderViewCell";
		
		EventTalkDateHeaderViewCell *cell = (EventTalkDateHeaderViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EventTalkCell" owner:nil options:nil];
			for (id currentObject in topLevelObjects) {
				if ([currentObject isKindOfClass:[EventTalkDateHeaderViewCell class]]) {
					cell = (EventTalkDateHeaderViewCell *)currentObject;
					break;
				}
			}
		}
		
		// Set background color
		/*
		UIView *bg = [[UIView alloc] initWithFrame:cell.frame];
		bg.backgroundColor = [UIColor groupTableViewBackgroundColor]; // or any color
		cell.backgroundView = bg;
		[bg release];
		 */
		
		// Get date of first talk in this day
		TalkDetailModel *tdm = [self.talks getTalkForDayAndRowByIndex:[indexPath section] rowIndex:0];
	 	cell.dateLabel.text = [tdm getDateString:self.event];
		
		return cell;
		
	} else {
		
		// Get relevant talk on relevant date
		TalkDetailModel *tdm = [self.talks getTalkForDayAndRowByIndex:[indexPath section] rowIndex:([indexPath row] - 1)];
		
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
			cell.uiSpeaker.text = [tdm getPrimarySpeakerString];
			cell.uiRating.image  = [UIImage imageNamed:[NSString stringWithFormat:@"rating-%d.gif", (int) tdm.rating]];
			cell.uiNumComments.text = [NSString stringWithFormat:@"%d", (int) tdm.commentCount];
			
			cell.uiTime.text     = [tdm getTimeString:self.event];
			
			if ([tdm.type isEqualToString:@"Talk"]) {
				cell.uiTalkType.image  = [UIImage imageNamed:@"talk.gif"];
			} else if ([tdm.type isEqualToString:@"Keynote"]) {
				cell.uiTalkType.image  = [UIImage imageNamed:@"keynote.gif"];
			} else if ([tdm.type isEqualToString:@"Social Event"]) {
				cell.uiTalkType.image  = [UIImage imageNamed:@"social-event.gif"];
			} else if ([tdm.type isEqualToString:@"Workshop"]) {
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
			
			if ([tdm onNow]) {
				cell.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
			} else {
				cell.backgroundColor = [UIColor whiteColor];
			}

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
			cell.uiSpeaker.text = [tdm getPrimarySpeakerString];

			cell.uiRating.image  = [UIImage imageNamed:[NSString stringWithFormat:@"rating-%d.gif", (int) tdm.rating]];
			cell.uiNumComments.text = [NSString stringWithFormat:@"%d", (int) tdm.commentCount];
			
			cell.uiTime.text     = [tdm getTimeString:self.event];
			
			if ([tdm.type isEqualToString:@"Talk"]) {
				cell.uiTalkType.image  = [UIImage imageNamed:@"talk.gif"];
			} else if ([tdm.type isEqualToString:@"Keynote"]) {
				cell.uiTalkType.image  = [UIImage imageNamed:@"keynote.gif"];
			} else if ([tdm.type isEqualToString:@"Social Event"]) {
				cell.uiTalkType.image  = [UIImage imageNamed:@"social-event.gif"];
			} else if ([tdm.type isEqualToString:@"Workshop"]) {
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
			
			if ([tdm onNow]) {
				cell.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
			} else {
				cell.backgroundColor = [UIColor whiteColor];
			}
			
			return cell;
		}
	}
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([indexPath row] == 0) {
		return 17.0f;
	} else {
		if ([self.event hasTracks]) {
			return 60.0f;
		} else {
			return 45.0f;
		}
	}
}

#pragma mark User-action handlers

- (void)uiSettingsButtonPressed {
	SettingsViewController *vc = [[SettingsViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];	
}

- (IBAction)uiDescButtonPressed:(id)sender {
	EventDescriptionViewController *edvc = [[EventDescriptionViewController alloc] initWithNibName:@"EventDescriptionView" bundle:nil];
	edvc.event = self.event;
	[self.navigationController pushViewController:edvc animated:YES];
	[edvc release];
}

- (IBAction)uiAttendingButtonPressed:(id)sender {
	[self.uiAttendingIndicator startAnimating];
	EventAttend *e = [APICaller EventAttend:self];
	[e call:self.event isNowAttending:self.uiAttending.isOn];
}

- (IBAction)uiCommentsButtonPressed:(id)sender {
	EventCommentsViewController *ecvc = [[EventCommentsViewController alloc] initWithNibName:@"EventCommentsView" bundle:nil];
	ecvc.event = self.event;
	[self.navigationController pushViewController:ecvc animated:YES];
	[ecvc release];
}

- (IBAction)uiLocationButtonPressed:(id)sender {
	EventLocationViewController *locVC = [[EventLocationViewController alloc] initWithNibName:@"EventLocationView" bundle:nil];
	locVC.event = self.event;
	[self.navigationController pushViewController:locVC animated:YES];
	[locVC release];
}

#pragma mark Utility methods

- (void)gotTalksForEvent:(TalkListModel *)tlm error:(APIError *)error{
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
		[self.uiLoadTalksIndicator stopAnimating];
		self.talks = tlm;
		[(UITableView *)self.view reloadData];
	}
}

- (void)gotEventAttend:(APIError *)err {
	[self.uiAttendingIndicator stopAnimating];
	if (err == nil) {
		self.event.attending = !self.event.attending;
		//[APICaller clearCache];
		[self setupAttending];
	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	SettingsViewController *vc = [[SettingsViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}


@end

