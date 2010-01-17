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
	
	TalkGetDetail *t = [APICaller TalkGetDetail:self];
	[t call:self.talk];
}

-(void) gotTalkDetailData:(TalkDetailModel *)tdm error:(APIError *)error {
	[self.uiLoading stopAnimating];
	
	[self.talk release];
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
		
		if (self.talk.allowComments) {
			[self.uiComments setTitle:@"View / add comments" forState:UIControlStateNormal];
			[self.uiComments setTitle:@"View / add comments" forState:UIControlStateHighlighted];
			[self.uiComments setTitle:@"View / add comments" forState:UIControlStateDisabled];
			[self.uiComments setTitle:@"View / add comments" forState:UIControlStateSelected];
		} else {
			[self.uiComments setTitle:@"View comments" forState:UIControlStateNormal];
			[self.uiComments setTitle:@"View comments" forState:UIControlStateHighlighted];
			[self.uiComments setTitle:@"View comments" forState:UIControlStateDisabled];
			[self.uiComments setTitle:@"View comments" forState:UIControlStateSelected];
		}
		
		if (true || [self.talk hasFinished]) {
			self.uiNumComments.text = [NSString stringWithFormat:@"%i comments", self.talk.numComments];
			
			self.uiRating.hidden      = NO;
			self.uiNotRated.hidden    = NO;
			self.uiNumComments.hidden = NO;
			self.uiComments.hidden    = NO;		
			
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
		}
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

