//
//  TalkDetailViewController.m
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TalkDetailViewController.h"
#import "TalkCommentsViewController.h"
#import "TalkDetailModel.h"
#import "TalkGetDetail.h"


@implementation TalkDetailViewController

@synthesize talk;
@synthesize event;
@synthesize uiTitle;
@synthesize uiSpeaker;
@synthesize uiDate;
@synthesize uiDesc;
@synthesize uiRating;
@synthesize uiComments;
@synthesize uiNotRated;
@synthesize uiNumComments;
@synthesize uiLoading;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[self setupScreen:NO];
	
	[self.uiLoading startAnimating];
	
	self.uiRating.hidden      = YES;
	self.uiNotRated.hidden    = YES;
	self.uiNumComments.hidden = YES;
	self.uiComments.hidden    = YES;
	self.uiComments.enabled   = YES;

	TalkGetDetail *t = [APICaller TalkGetDetail:self];
	[t call:self.talk];
}

-(void) gotTalkDetailData:(TalkDetailModel *)tdm error:(APIError *)error {
	[self.uiLoading stopAnimating];
	
	//[self.talk release];
	self.talk = tdm;
	
	[self setupScreen:YES];
	
}

-(void)setupScreen:(BOOL)withExtraInfo {
	
	self.title = self.talk.title;
	self.uiTitle.text = self.talk.title;
	self.uiSpeaker.text = self.talk.speaker;
	
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"d MMM yyyy"];
	NSString *dateGiven = [outputFormatter stringFromDate:self.talk.given];
	[outputFormatter release];	
	
	self.uiDate.text = dateGiven;
	self.uiDesc.text = self.talk.desc;
	
	if (withExtraInfo) {
		
		if (self.talk.numComments == 1) {
			self.uiNumComments.text = [NSString stringWithFormat:@"1 comment"];
		} else {
			self.uiNumComments.text = [NSString stringWithFormat:@"%i comments", self.talk.numComments];
		}
		
		NSString *btnLabel;
		
		self.uiRating.hidden      = NO;
		self.uiNotRated.hidden    = NO;
		self.uiNumComments.hidden = NO;
		self.uiComments.hidden    = NO;
		self.uiComments.enabled   = YES;

		if (self.talk.allowComments) {
			
			if (self.talk.numComments > 0) {
				btnLabel = @"View / add comments";
			} else {
				btnLabel = @"Add comment";
			}
			
		} else {
			
			if (self.talk.numComments > 0) {
				
				btnLabel = @"View comments";
				
			} else {
				
				self.uiRating.hidden      = YES;
				self.uiNotRated.hidden    = YES;
				self.uiNumComments.hidden = YES;
				self.uiComments.hidden    = NO;
				self.uiComments.enabled   = NO;
				
				btnLabel = @"No comments";
			}
			
		}
		
		[self.uiComments setTitle:btnLabel forState:UIControlStateNormal];
		[self.uiComments setTitle:btnLabel forState:UIControlStateHighlighted];
		
		if (self.talk.rating >= 0 && self.talk.rating <= 5) {
			//self.uiRating.hidden   = NO;
			self.uiRating.image    = [UIImage imageNamed:[NSString stringWithFormat:@"rating-%d.gif", self.talk.rating]];
			self.uiNotRated.hidden = YES;
		} else {
			//self.uiNotRated.hidden = NO;
			self.uiRating.hidden   = YES;
		}
		
	} else {
		
		self.uiRating.hidden      = YES;
		self.uiNotRated.hidden    = YES;
		self.uiNumComments.hidden = YES;
		self.uiComments.hidden    = YES;
		self.uiComments.enabled   = YES;
		
	}
	
}

-(IBAction)uiViewComments:(id)sender {
	TalkCommentsViewController *vc = [[TalkCommentsViewController alloc] initWithNibName:@"TalkCommentsView" bundle:nil];
	vc.talk = self.talk;
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

