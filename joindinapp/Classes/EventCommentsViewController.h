//
//  EventCommentsViewController.h
//  joindinapp
//
//  Created by Kevin on 25/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailModel.h"
#import "EventCommentListModel.h"
#import "NewEventCommentViewCell.h"


@interface EventCommentsViewController : UITableViewController {
	EventDetailModel *event;
	EventCommentListModel *comments;
	BOOL commentsLoaded;
	NewEventCommentViewCell *newCommentCell;
	
	IBOutlet UILabel *uiComment;
	IBOutlet UILabel *uiAuthor;
	IBOutlet UITableViewCell *uiCell;
	
}

@property (nonatomic, retain) EventDetailModel *event;
@property (nonatomic, retain) EventCommentListModel *comments;
@property (nonatomic, assign) BOOL commentsLoaded;
@property (nonatomic, assign) NewEventCommentViewCell *newCommentCell;

@property (nonatomic, retain) UILabel *uiComment;
@property (nonatomic, retain) UILabel *uiAuthor;
@property (nonatomic, retain) UITableViewCell *uiCell;

- (void)submitComment:(NSString *)comment activityIndicator:(UIActivityIndicatorView *)activity;
- (void)addBtnPressed;
- (void)refreshBtnPressed;
- (void)focusNewComment;


@end
