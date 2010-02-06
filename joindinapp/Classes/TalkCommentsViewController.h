//
//  TalkCommentsViewController.h
//  joindinapp
//
//  Created by Kevin on 09/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TalkDetailModel.h"
#import "TalkCommentListModel.h"
#import "NewCommentViewCell.h"


@interface TalkCommentsViewController : UITableViewController <CommentSubmitter> {
	TalkDetailModel *talk;
	TalkCommentListModel *comments;
	NewCommentViewCell *newCommentCell;
	
	IBOutlet UILabel *uiComment;
	IBOutlet UILabel *uiAuthor;
	IBOutlet UIImageView *uiRating;
	IBOutlet UITableViewCell *uiCell;
	
	BOOL commentsLoaded;
	
}

@property (nonatomic, retain) TalkDetailModel *talk;
@property (nonatomic, retain) TalkCommentListModel *comments;
@property (nonatomic, retain) NewCommentViewCell *newCommentCell;

@property (nonatomic, retain) UILabel *uiComment;
@property (nonatomic, retain) UILabel *uiAuthor;
@property (nonatomic, retain) UIImageView *uiRating;
@property (nonatomic, retain) UITableViewCell *uiCell;

@property (nonatomic, assign) BOOL commentsLoaded;

- (void)submitComment:(NSString *)comment activityIndicator:(UIActivityIndicatorView *)activity rating:(NSUInteger)rating;

@end
