//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the organisation (joind.in) nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
@synthesize uiTracks;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[self setupScreen:NO];
	
	[self.uiLoading startAnimating];
	
	self.uiRating.hidden      = YES;
	self.uiNotRated.hidden    = YES;
	self.uiNumComments.hidden = YES;
	self.uiComments.hidden    = YES;
	self.uiComments.enabled   = YES;
	self.uiTracks.hidden      = YES;

	TalkGetDetail *t = [APICaller TalkGetDetail:self];
	[t call:self.talk.Id];
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
	
	NSString *dateGiven = [self.talk getDateString:self.event];
	NSString *timeGiven = [self.talk getTimeString:self.event];
	if (![timeGiven isEqualToString:@"12:00am"]) {
		dateGiven = [NSString stringWithFormat:@"%@ %@", dateGiven, timeGiven];
	}
	
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
        NSLog(@"%lu", (unsigned long)self.talk.rating);
		if (self.talk.rating >= 1 && self.talk.rating <= 5) {
			//self.uiRating.hidden   = NO;
			self.uiRating.image    = [UIImage imageNamed:[NSString stringWithFormat:@"rating-%d.gif", self.talk.rating]];
			self.uiNotRated.hidden = YES;
		} else {
			//self.uiNotRated.hidden = NO;
			self.uiRating.hidden   = YES;
		}
		
		if ([self.event hasTracks]) {
			self.uiTracks.text = [self.talk.tracks getStringTrackList];
			self.uiTracks.hidden = NO;
		} else {
			self.uiTracks.text = @"";
		}
		
	} else {
		
		self.uiRating.hidden      = YES;
		self.uiNotRated.hidden    = YES;
		self.uiNumComments.hidden = YES;
		self.uiComments.hidden    = YES;
		self.uiComments.enabled   = YES;
		self.uiTracks.hidden      = YES;
		
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

