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
	self.uiAttending.center = CGPointMake(270.0f, 247.0f);
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
	self.uiComments.hidden    = YES;
	EventGetDetail *ed = [APICaller EventGetDetail:self];
	[ed call:self.event];
	
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
		return 1;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.talks getNumTalks];
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	TalkDetailViewController *talkDetailViewController = [[TalkDetailViewController alloc] initWithNibName:@"TalkDetailView" bundle:nil];
	talkDetailViewController.talk  = [self.talks getTalkDetailModelAtIndex:[indexPath row]];
	talkDetailViewController.event = self.event;
	[self.navigationController pushViewController:talkDetailViewController animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES]; // Deselect the talk row in the event detail screen
	[talkDetailViewController release];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	TalkDetailModel *tdm = [self.talks getTalkDetailModelAtIndex:[indexPath row]];

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
	
	UserTalkCommentDetailModel *utcdm = [self.comments getCommentForTalk:tdm];

	if (utcdm == nil) {
		cell.uiCommentBubble.image = [UIImage imageNamed:@"icon-comment.gif"];
	} else {
		cell.uiCommentBubble.image = [UIImage imageNamed:@"icon-comment-user.gif"];
	}
	
	return cell;
	//cell.uiRating.image = [UIImage imageNamed:[NSString stringWithFormat:@"rating-%d.gif", [self.comments getTalkCommentAtIndex:[indexPath row]].rating]];
	
	/*
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
	*/
	
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

