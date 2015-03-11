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

#import "TalkGetDetail.h"


@implementation TalkGetDetail

- (void)call:(NSString *)talkURI {
    [self callAPI:talkURI needAuth:YES];
}

- (void)gotData:(NSObject *)obj {
	TalkDetailModel *tdm = [[TalkDetailModel alloc] init];

	NSDictionary *talk = [[(NSDictionary *)obj objectForKey:@"talks"] objectAtIndex:0];
	
	if ([[talk objectForKey:@"talk_title"] isKindOfClass:[NSString class]]) {
		tdm.title         = [talk objectForKey:@"talk_title"];
	} else {
		tdm.title         = @"";
	}
	
	if ([[talk objectForKey:@"speakers"] isKindOfClass:[NSArray class]]) {
        tdm.speakers = [[NSArray alloc] initWithArray:[talk objectForKey:@"speakers"]];
	} else {
		tdm.speakers       = [[NSArray alloc] init];
	}
	
	if ([[talk objectForKey:@"slides_link"] isKindOfClass:[NSString class]]) {
		tdm.slidesLink    = [talk objectForKey:@"slides_link"];
	} else {
		tdm.slidesLink    = @"";
	}
	
	if ([[talk objectForKey:@"date_given"] isKindOfClass:[NSString class]]) {
		tdm.startDate         = [NSDate dateWithTimeIntervalSince1970:[[talk objectForKey:@"date_given"]   integerValue]];
	} else {
		tdm.startDate         = 0;
	}
	
	if ([[talk objectForKey:@"talk_description"] isKindOfClass:[NSString class]]) {
		tdm.description          = [talk objectForKey:@"talk_description"];
	} else {
		tdm.description          = @"";
	}
	
	if ([[talk objectForKey:@"lang"] isKindOfClass:[NSString class]]) {
		tdm.lang          = [[talk objectForKey:@"lang"] integerValue];
	} else {
		tdm.lang          = 0;
	}
	
	if ([[talk objectForKey:@"average_rating"] isKindOfClass:[NSString class]]) {
		tdm.rating        = [[talk objectForKey:@"average_rating"] integerValue];
	} else {
		tdm.rating        = 0;
	}
	
	if ([[talk objectForKey:@"type"] isKindOfClass:[NSString class]]) {
		tdm.type          = [talk objectForKey:@"type"];
	} else {
		tdm.type          = @"";
	}
	
    if ([[talk objectForKey:@"stub"] isKindOfClass:[NSString class]]) {
        tdm.stub          = [talk objectForKey:@"stub"];
    } else {
        tdm.stub          = @"";
    }
    
	if ([[talk objectForKey:@"comment_count"] isKindOfClass:[NSString class]]) {
		tdm.commentCount   = [[talk objectForKey:@"comment_count"] integerValue];
	} else {
		tdm.commentCount   = 0;
	}
	
	if ([[talk objectForKey:@"allow_comments"] isKindOfClass:[NSString class]]) {
		if ([[[talk objectForKey:@"allow_comments"] lowercaseString] isEqualToString:@"y"] || [[[talk objectForKey:@"allow_comments"] lowercaseString] isEqualToString:@"1"]) {
			tdm.allowComments = YES;
		} else {
			tdm.allowComments = NO;
		}
	} else {
		tdm.allowComments = NO;
	}
	
	if ([[talk objectForKey:@"tracks"] isKindOfClass:[NSArray class]]) {
		NSArray *tks = [talk objectForKey:@"tracks"];
		TrackDetailModel *tkdm;
		for (NSDictionary *tk in tks) {
			tkdm = [[TrackDetailModel alloc] init];
			
			if ([[tk objectForKey:@"track_name"] isKindOfClass:[NSString class]]) {
				tkdm.name = [tk objectForKey:@"track_name"];
			} else {
				tkdm.name = @"";
			}
			
			if ([[tk objectForKey:@"track_desc"] isKindOfClass:[NSString class]]) {
				tkdm.desc = [tk objectForKey:@"track_desc"];
			} else {
				tkdm.desc = @"";
			}
			
			if ([[tk objectForKey:@"track_color"] isKindOfClass:[NSString class]]) {
				tkdm.color = [tk objectForKey:@"track_color"];
			} else {
				tkdm.color = @"";
			}
			
			if ([[tk objectForKey:@"ID"] isKindOfClass:[NSString class]]) {
				tkdm.Id = [[tk objectForKey:@"ID"] integerValue];
			} else {
				tkdm.Id = 0;
			}
			
			[tdm.tracks addTrack:tkdm];
			[tkdm release];
		}
	}
	
	[self.delegate gotTalkDetailData:tdm error:nil];
	[tdm release];

}

- (void)gotError:(NSObject *)error {
	
}

@end

@implementation APICaller (APICaller_TalkGetDetail)
+ (TalkGetDetail *)TalkGetDetail:(id)_delegate {
	static TalkGetDetail *t = nil;
	if (t != nil) {
		[t cancel];
		[t release];
	}	
	t = [[TalkGetDetail alloc] initWithDelegate:_delegate];
	return t;
}
@end

