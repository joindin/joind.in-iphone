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
#import "SettingsViewController.h"
#import "EventAttend.h"
#import "UISwitch-Extended.h"
#import "EventCommentsViewController.h"
#import "EventGetDetail.h"
#import "EventTalkViewCell.h"
#import "EventTalkDateHeaderViewCell.h"
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
@synthesize uiHashtag;

#pragma mark View loaders

- (void)viewDidLoad {
    [super viewDidLoad];
	//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(uiSettingsButtonPressed)];

	NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"EventDetailView" owner:self options:nil];
	self.uiTableHeaderView = [nibViews objectAtIndex: 1];
	((UITableView *)[self view]).tableHeaderView = self.uiTableHeaderView;
	
	self.uiAttending = [UISwitch switchWithLeftText:@"yes" andRight:@" no"];
	self.uiAttending.center = CGPointMake(263.0f, 258.0f);
	[[self view] addSubview:self.uiAttending];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.uiAttending.on = self.event.userAttend;
	self.title = self.event.name;
	self.uiTitle.text = self.event.name;
	self.uiDesc.text = self.event.description;
	self.uiLocation.text = self.event.location;
	
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"d MMM yyyy"];
	NSString *startDate = [outputFormatter stringFromDate:self.event.start];
	NSString *endDate   = [outputFormatter stringFromDate:self.event.end];
	[outputFormatter release];
	
	[self setupAttending];
	
	[self.uiAttending addTarget:self action:@selector(uiAttendingButtonPressed:) forControlEvents:UIControlEventValueChanged];
	
	if ([startDate compare:endDate] == NSOrderedSame) {
		self.uiDate.text = startDate;
	} else {
		self.uiDate.text = [NSString stringWithFormat:@"%@ - %@", startDate, endDate];
	}
	
	if (self.event.hashtag != nil && ![self.event.hashtag isEqualToString:@""]) {
		self.uiHashtag.hidden = NO;
		self.uiHashtag.text = self.event.hashtag;
	} else {
		self.uiHashtag.hidden = YES;
	}
	
	[self.uiLoading startAnimating];
	[self.talks sort];
	self.uiComments.hidden    = YES;
	EventGetDetail *ed = [APICaller EventGetDetail:self];
	[ed call:self.event.Id];
	
	[self.uiLoadTalksIndicator startAnimating];	
	EventGetTalks *e = [APICaller EventGetTalks:self];
	[e call:self.event];
	
	UserGetComments *u = [APICaller UserGetComments:self];
	[u call:nil];
	
	
}

- (void)gotEventDetailData:(EventDetailModel *)edm error:(APIError *)err {
	self.event = edm;
	[self.uiLoading stopAnimating];
	// Set button label
	NSString *btnLabel;
	if (edm.allowComments) {
		if (edm.numComments > 0) {
			btnLabel = @"View / add comments";
		} else {
			btnLabel = @"Add comment";
		}
		self.uiComments.enabled = YES;
	} else {
		if (edm.numComments > 0) {
			btnLabel = @"View comments";
			self.uiComments.enabled = YES;
		} else {
			btnLabel = @"No comments";
			self.uiComments.enabled = NO;
		}
	}
	self.uiComments.hidden = NO;
	[self.uiComments setTitle:btnLabel forState:UIControlStateNormal];
	[self.uiComments setTitle:btnLabel forState:UIControlStateHighlighted];
}

- (void)setupAttending {
	if (self.event.isAuthd == YES) {
		self.uiAttending.hidden = NO;
		self.uiAttendingLabel.hidden = NO;
	} else {
		self.uiAttending.hidden = YES;
		self.uiAttendingLabel.hidden = YES;
	}
	
	if ([self.event hasFinished]) {
		self.uiAttendingLabel.text = @"Attended";
	} else {
		self.uiAttendingLabel.text = @"Attending";
	}
	self.uiAttending.on = event.userAttend;
	
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
	NSArray *dates = [[allDates allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSString *relevantDate = [dates objectAtIndex:section];
	NSArray *talksOnDate = [allDates objectForKey:relevantDate];
	
	return ([talksOnDate count] + 1);
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([indexPath row] == 0) {
		
	} else {
		
		NSDictionary *allDates = [self.talks getTalksByDate];
		NSArray *dates = [[allDates allKeys] sortedArrayUsingSelector:@selector(compare:)];
		NSString *relevantDate = [dates objectAtIndex:[indexPath section]];
		NSArray *talksOnDate = [allDates objectForKey:relevantDate];
		TalkDetailModel *tdm = [talksOnDate objectAtIndex:([indexPath row] - 1)];
		
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
		UIView *bg = [[UIView alloc] initWithFrame:cell.frame];
		bg.backgroundColor = [UIColor blueColor]; // or any color
		cell.backgroundView = bg;
		[bg release];
		
		// Get date of first talk in this day
		NSDictionary *allDates = [self.talks getTalksByDate];
		NSArray *dates = [[allDates allKeys] sortedArrayUsingSelector:@selector(compare:)];
		NSString *relevantDate = [dates objectAtIndex:[indexPath section]];
		NSArray *talksOnDate = [allDates objectForKey:relevantDate];
		
		TalkDetailModel *tdm = [talksOnDate objectAtIndex:0];
		NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:tdm.given];
		NSString *dateString = [NSString stringWithFormat:@"%d-%d-%d", [dateComponents day], [dateComponents month], [dateComponents year]];
		
		cell.dateLabel.text = dateString;
		
		return cell;
		
	} else {
		
		// Get relevant talk on relevant date
		NSDictionary *allDates = [self.talks getTalksByDate];
		NSArray *dates = [[allDates allKeys] sortedArrayUsingSelector:@selector(compare:)];
		NSString *relevantDate = [dates objectAtIndex:[indexPath section]];
		NSArray *talksOnDate = [allDates objectForKey:relevantDate];
		
		TalkDetailModel *tdm = [talksOnDate objectAtIndex:([indexPath row] - 1)];
		
		static NSString *CellIdentifier = @"EventTalkCommentCell";
		
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([indexPath row] == 0) {
		return 17.0f;
	} else {
		return 45.0f;
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
	[e call:self.event];
}

- (IBAction)uiCommentsButtonPressed:(id)sender {
	EventCommentsViewController *ecvc = [[EventCommentsViewController alloc] initWithNibName:@"EventCommentsView" bundle:nil];
	ecvc.event = self.event;
	[self.navigationController pushViewController:ecvc animated:YES];
	[ecvc release];
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
		self.event.userAttend = !self.event.userAttend;
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

