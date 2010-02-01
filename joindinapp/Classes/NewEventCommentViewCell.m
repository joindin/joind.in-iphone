//
//  NewEventCommentViewCell.m
//  joindinapp
//
//  Created by Kevin on 27/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewEventCommentViewCell.h"


@implementation NewEventCommentViewCell
@synthesize uiSubmit;
@synthesize uiComment;
@synthesize uiActivity;
@synthesize EventCommentDelegate;

- (IBAction) uiSubmitted:(id)sender {
	self.uiSubmit.hidden = YES;
	[self.EventCommentDelegate submitComment:self.uiComment.text activityIndicator:self.uiActivity];
}

// Poor-man's initialiser
- (void) doStuff {
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(textGotFocus:)
												 name:UITextViewTextDidBeginEditingNotification
											   object:self.uiComment];
}

- (void) textGotFocus:(NSNotification*)notification {
	if ([self.uiComment.text isEqualToString:@"Type comment..."]) {
		self.uiComment.text = @"";
	}
}

@end
