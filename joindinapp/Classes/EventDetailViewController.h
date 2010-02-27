//
//  EventDetailViewController.h
//  joindinapp
//
//  Created by Kevin on 31/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailModel.h"
#import "TalkListModel.h"
#import "UserCommentListModel.h"
#import "APIError.h"
#import "EventAttend.h"

@interface EventDetailViewController : UITableViewController {
	EventDetailModel *event;
	TalkListModel *talks;
	UserCommentListModel *comments;
	
	// IB components
	IBOutlet UILabel  *uiTitle;
	IBOutlet UILabel  *uiDate;
	IBOutlet UILabel  *uiLocation;
	IBOutlet UILabel  *uiDesc;
	IBOutlet UIButton *uiDescButton;
	IBOutlet UIActivityIndicatorView *uiLoadTalksIndicator;
	IBOutlet UIView   *uiTableHeaderView;
	IBOutlet UISwitch *uiAttending;
	IBOutlet UILabel  *uiAttendingLabel;
	IBOutlet UIActivityIndicatorView *uiAttendingIndicator;
	IBOutlet UIButton *uiComments;
	IBOutlet UIActivityIndicatorView *uiLoading;
	IBOutlet UILabel  *uiHashtag;
	
	IBOutlet UIButton *uiHashtagButton;
}

- (IBAction)uiDescButtonPressed:(id)sender;
- (IBAction)uiAttendingButtonPressed:(id)sender;
- (IBAction)uiCommentsButtonPressed:(id)sender;
- (IBAction)uiHashtagButtonPressed:(id)sender;

- (void)gotTalksForEvent:(TalkListModel *)tlm error:(APIError *)error;
- (void)gotEventAttend:(APIError *)err;
- (void)setupAttending;

@property (nonatomic, retain) EventDetailModel *event;
@property (nonatomic, retain) TalkListModel *talks;
@property (nonatomic, retain) UserCommentListModel *comments;

@property (nonatomic, retain) UILabel  *uiTitle;
@property (nonatomic, retain) UILabel  *uiDate;
@property (nonatomic, retain) UILabel  *uiLocation;
@property (nonatomic, retain) UILabel  *uiDesc;
@property (nonatomic, retain) UIButton *uiDescButton;
@property (nonatomic, retain) UIActivityIndicatorView *uiLoadTalksIndicator;
@property (nonatomic, retain) UIView   *uiTableHeaderView;
@property (nonatomic, retain) UISwitch *uiAttending;
@property (nonatomic, retain) UILabel  *uiAttendingLabel;
@property (nonatomic, retain) UIActivityIndicatorView *uiAttendingIndicator;
@property (nonatomic, retain) UIButton *uiComments;
@property (nonatomic, retain) UIActivityIndicatorView *uiLoading;
@property (nonatomic, retain) UILabel  *uiHashtag;

@property (nonatomic, retain) UIButton *uiHashtagButton;

@end
