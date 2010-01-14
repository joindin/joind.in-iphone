//
//  NewCommentViewCell.m
//  joindinapp
//
//  Created by Kevin on 11/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewCommentViewCell.h"


@implementation NewCommentViewCell

@synthesize uiSubmit;
@synthesize uiComment;
@synthesize uiActivity;
@synthesize commentDelegate;

- (IBAction) uiSubmitted:(id)sender {
	self.uiSubmit.hidden = YES;
	[self.commentDelegate submitComment:self.uiComment.text activityIndicator:self.uiActivity];
}

@end
