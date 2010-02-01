//
//  NewEventCommentViewCell.h
//  joindinapp
//
//  Created by Kevin on 27/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NewEventCommentViewCell : UITableViewCell {
	IBOutlet UIButton *uiSubmit;
	IBOutlet UITextView *uiComment;
	IBOutlet UIActivityIndicatorView *uiActivity;
	id EventCommentDelegate;
}

@property (nonatomic, retain) UIButton *uiSubmit;
@property (nonatomic, retain) UITextView *uiComment;
@property (nonatomic, retain) UIActivityIndicatorView *uiActivity;
@property (nonatomic, retain) id EventCommentDelegate;

- (IBAction) uiSubmitted:(id)sender;
- (void) doStuff;
- (void) textGotFocus:(NSNotification*)notification;

@end

@protocol CommentSubmitter
- (void)submitComment:(NSString *)comment activityIndicator:(UIActivityIndicatorView *)activity;
@end
