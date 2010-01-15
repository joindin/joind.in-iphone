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
@synthesize uiRating1;
@synthesize uiRating2;
@synthesize uiRating3;
@synthesize uiRating4;
@synthesize uiRating5;
@synthesize rating;

- (IBAction) uiSubmitted:(id)sender {
	self.uiSubmit.hidden = YES;
	[self.commentDelegate submitComment:self.uiComment.text activityIndicator:self.uiActivity rating:self.rating];
}

- (IBAction) uiRatingPressed:(id)sender {
	if (self.uiRating1.state == 1) {
		self.rating = 1;
		[self.uiRating1 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating2 setImage:[UIImage imageNamed:@"rating-off.gif"] forState:0];
		[self.uiRating3 setImage:[UIImage imageNamed:@"rating-off.gif"] forState:0];
		[self.uiRating4 setImage:[UIImage imageNamed:@"rating-off.gif"] forState:0];
		[self.uiRating5 setImage:[UIImage imageNamed:@"rating-off.gif"] forState:0];
	}
	if (self.uiRating2.state == 1) {
		self.rating = 2;
		[self.uiRating1 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating2 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating3 setImage:[UIImage imageNamed:@"rating-off.gif"] forState:0];
		[self.uiRating4 setImage:[UIImage imageNamed:@"rating-off.gif"] forState:0];
		[self.uiRating5 setImage:[UIImage imageNamed:@"rating-off.gif"] forState:0];
	}
	if (self.uiRating3.state == 1) {
		self.rating = 3;
		[self.uiRating1 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating2 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating3 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating4 setImage:[UIImage imageNamed:@"rating-off.gif"] forState:0];
		[self.uiRating5 setImage:[UIImage imageNamed:@"rating-off.gif"] forState:0];
	}
	if (self.uiRating4.state == 1) {
		self.rating = 4;
		[self.uiRating1 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating2 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating3 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating4 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating5 setImage:[UIImage imageNamed:@"rating-off.gif"] forState:0];
	}
	if (self.uiRating5.state == 1) {
		self.rating = 5;
		[self.uiRating1 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating2 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating3 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating4 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
		[self.uiRating5 setImage:[UIImage imageNamed:@"rating-on.gif"]  forState:0];
	}
}

@end
