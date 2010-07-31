//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the <ORGANIZATION> nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "TalkGetDetail.h"


@implementation TalkGetDetail

- (void)call:(NSUInteger)talkId {
	[self callAPI:@"talk" action:@"getdetail" params:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", talkId] forKey:@"talk_id"] needAuth:YES canCache:YES];
}

- (void)gotData:(NSObject *)obj {
	TalkDetailModel *tdm = [[TalkDetailModel alloc] init];
	
	NSDictionary *talk = [(NSArray *)obj objectAtIndex:0];
	
	if ([[talk objectForKey:@"talk_title"] isKindOfClass:[NSString class]]) {
		tdm.title         = [talk objectForKey:@"talk_title"];
	} else {
		tdm.title         = @"";
	}
	
	if ([[talk objectForKey:@"speaker"] isKindOfClass:[NSString class]]) {
		tdm.speaker       = [talk objectForKey:@"speaker"];
	} else {
		tdm.speaker       = @"";
	}
	
	if ([[talk objectForKey:@"ID"] isKindOfClass:[NSString class]]) {
		tdm.Id            = [[talk objectForKey:@"ID"] integerValue];
	} else {
		tdm.Id            = 0;
	}
	
	if ([[talk objectForKey:@"event_id"] isKindOfClass:[NSString class]]) {
		tdm.eventId       = [[talk objectForKey:@"event_id"] integerValue];
	} else {
		tdm.eventId       = 0;
	}
	
	if ([[talk objectForKey:@"slides_link"] isKindOfClass:[NSString class]]) {
		tdm.slidesLink    = [talk objectForKey:@"slides_link"];
	} else {
		tdm.slidesLink    = @"";
	}
	
	if ([[talk objectForKey:@"date_given"] isKindOfClass:[NSString class]]) {
		tdm.given         = [NSDate dateWithTimeIntervalSince1970:[[talk objectForKey:@"date_given"]   integerValue]];
	} else {
		tdm.given         = 0;
	}
	
	if ([[talk objectForKey:@"talk_desc"] isKindOfClass:[NSString class]]) {
		tdm.desc          = [talk objectForKey:@"talk_desc"];
	} else {
		tdm.desc          = @"";
	}
	
	if ([[talk objectForKey:@"lang_name"] isKindOfClass:[NSString class]]) {
		tdm.langName      = [talk objectForKey:@"lang_name"];
	} else {
		tdm.langName      = @"";
	}
	
	if ([[talk objectForKey:@"lang"] isKindOfClass:[NSString class]]) {
		tdm.lang          = [[talk objectForKey:@"lang"] integerValue];
	} else {
		tdm.lang          = 0;
	}
	
	if ([[talk objectForKey:@"tavg"] isKindOfClass:[NSString class]]) {
		tdm.rating        = [[talk objectForKey:@"tavg"] integerValue];
	} else {
		tdm.rating        = 0;
	}
	
	if ([[talk objectForKey:@"tcid"] isKindOfClass:[NSString class]]) {
		tdm.type          = [talk objectForKey:@"tcid"];
	} else {
		tdm.type          = @"";
	}
	
	if ([[talk objectForKey:@"active"] isKindOfClass:[NSString class]]) {
		tdm.active        = ([[[talk objectForKey:@"active"] lowercaseString] compare:@"y"] == NSOrderedSame);
	} else {
		tdm.active        = NO;
	}
	
	if ([[talk objectForKey:@"owner_id"] isKindOfClass:[NSString class]]) {
		tdm.speakerId     = [[talk objectForKey:@"owner_id"] integerValue];
	} else {
		tdm.speakerId     = 0;
	}
	
	if ([[talk objectForKey:@"private"] isKindOfClass:[NSString class]]) {
		tdm.private       = ([[[talk objectForKey:@"private"] lowercaseString] compare:@"y"] == NSOrderedSame);
	} else {
		tdm.private       = NO;
	}
	
	if ([[talk objectForKey:@"lang_abbr"] isKindOfClass:[NSString class]]) {
		tdm.langAbbr      = [talk objectForKey:@"lang_abbr"];
	} else {
		tdm.langAbbr      = @"";
	}
	
	if ([[talk objectForKey:@"ccount"] isKindOfClass:[NSString class]]) {
		tdm.numComments   = [[talk objectForKey:@"ccount"] integerValue];
	} else {
		tdm.numComments   = 0;
	}
	
	if ([[talk objectForKey:@"last_comment_date"] isKindOfClass:[NSString class]]) {
		tdm.lastComment   = [NSDate dateWithTimeIntervalSince1970:[[talk objectForKey:@"last_comment_date"]   integerValue]];
	} else {
		tdm.lastComment   = 0;
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
	
	if ([[talk objectForKey:@"now_next"] isKindOfClass:[NSString class]]) {
		tdm.nowNext       = [[talk objectForKey:@"now_next"] lowercaseString];
	} else {
		tdm.nowNext       = @"";
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

