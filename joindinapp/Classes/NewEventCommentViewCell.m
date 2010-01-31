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

@end
