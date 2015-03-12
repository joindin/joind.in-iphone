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

#import "EventGetTalks.h"
#import "EventDetailModel.h"
#import "TalkListModel.h"
#import "TalkDetailModel.h"

@implementation EventGetTalks
@synthesize event;

- (void)call:(EventDetailModel *)_event {
	self.event = _event;
	[self callAPI:_event.talksURI needAuth:YES];
}

- (void)gotData:(NSObject *)obj {
	TalkListModel *tlm = [[[TalkListModel alloc] initWithEvent:self.event] autorelease];
	
	NSDictionary *d = [(NSDictionary *)obj objectForKey:@"talks"];
	for (NSDictionary *talk in d) {
		TalkDetailModel *tdm = [[TalkDetailModel alloc] init];
		
		if ([[talk objectForKey:@"talk_title"] isKindOfClass:[NSString class]]) {
			tdm.title         = [talk objectForKey:@"talk_title"];
		} else {
			tdm.title         = @"";
		}
		//NSLog(@"Speaker is a %@", [[talk objectForKey:@"speaker"] objectForKey:@"speaker_name"]);
		if ([[talk objectForKey:@"speakers"] isKindOfClass:[NSArray class]]) {
            tdm.speakers = [talk objectForKey:@"speakers"];
        } else {
            tdm.speakers = [[NSArray alloc] init];
        }
		
		if ([[talk objectForKey:@"start_date"] isKindOfClass:[NSString class]]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
            tdm.startDate = [dateFormatter dateFromString:[talk objectForKey:@"start_date"]];
		} else {
			tdm.startDate         = nil;
		}
		
		if ([[talk objectForKey:@"talk_description"] isKindOfClass:[NSString class]]) {
			tdm.description          = [talk objectForKey:@"talk_description"];
		} else {
			tdm.description          = @"";
		}
		
		if ([[talk objectForKey:@"comment_count"] isKindOfClass:[NSString class]]) {
			tdm.commentCount   = [[talk objectForKey:@"comment_count"] integerValue];
		} else {
			tdm.commentCount   = 0;
		}
		
		if ([[talk objectForKey:@"comments_enabled"] isKindOfClass:[NSNumber class]]) {
			tdm.allowComments = [[talk objectForKey:@"comments_enabled"] boolValue];
		} else {
			tdm.allowComments = NO;
		}
		
		if ([[talk objectForKey:@"average_rating"] isKindOfClass:[NSNumber class]]) {
			tdm.rating = [[talk objectForKey:@"average_rating"] integerValue];
		} else {
			tdm.rating = 0;
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
								
				[tdm.tracks addTrack:tkdm];
				[tkdm release];
			}
		}
		
        if ([[talk objectForKey:@"uri"] isKindOfClass:[NSString class]]) {
            tdm.uri         = [talk objectForKey:@"uri"];
        } else {
            tdm.uri         = @"";
        }
        NSLog(@"keys: %@", [talk allKeys]);
        NSLog(@"URI: %@", [talk objectForKey:@"uri"]);
        if ([[talk objectForKey:@"verbose_uri"] isKindOfClass:[NSString class]]) {
            tdm.verbose_uri         = [talk objectForKey:@"verbose_uri"];
        } else {
            tdm.verbose_uri         = @"";
        }
        if ([[talk objectForKey:@"website_uri"] isKindOfClass:[NSString class]]) {
            tdm.website_uri         = [talk objectForKey:@"website_uri"];
        } else {
            tdm.website_uri         = @"";
        }
        if ([[talk objectForKey:@"comments_uri"] isKindOfClass:[NSString class]]) {
            tdm.comments_uri         = [talk objectForKey:@"comments_uri"];
        } else {
            tdm.comments_uri         = @"";
        }
        if ([[talk objectForKey:@"starred_uri"] isKindOfClass:[NSString class]]) {
            tdm.starred_uri         = [talk objectForKey:@"starred_uri"];
        } else {
            tdm.starred_uri         = @"";
        }
        if ([[talk objectForKey:@"verbose_comments_uri"] isKindOfClass:[NSString class]]) {
            tdm.verbose_comments_uri         = [talk objectForKey:@"verbose_comments_uri"];
        } else {
            tdm.verbose_comments_uri         = @"";
        }
        if ([[talk objectForKey:@"event_uri"] isKindOfClass:[NSString class]]) {
            tdm.event_uri         = [talk objectForKey:@"event_uri"];
        } else {
            tdm.event_uri         = @"";
        }

        [tlm addTalk:tdm];
		[tdm release];
		
	}
	[tlm sort];
	[self.delegate gotTalksForEvent:tlm error:nil];
}

- (void)gotError:(APIError *)error {
	[self.delegate gotTalksForEvent:nil error:error];
}
	
@end

@implementation APICaller (APICaller_EventGetTalks)
+ (EventGetTalks *)EventGetTalks:(id)_delegate {
	static EventGetTalks *e = nil;
	if (e != nil) {
		[e cancel];
		[e release];
	}
	e = [[EventGetTalks alloc] initWithDelegate:_delegate];
	return e;
}
@end
