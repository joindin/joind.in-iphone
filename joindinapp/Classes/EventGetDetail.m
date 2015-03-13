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

#import "EventGetDetail.h"


@implementation EventGetDetail

- (void)call:(NSString *)eventURI {
	[self callAPI:eventURI needAuth:YES];
}

- (void)gotData:(NSObject *)obj {
	
	//NSLog(@"Event is %@", event);
	EventDetailModel *edm = [[EventDetailModel alloc] init];
	NSDictionary *event = [(NSArray *)[(NSDictionary *)obj objectForKey:@"events"] objectAtIndex:0];

    if ([[event objectForKey:@"name"] isKindOfClass:[NSString class]]) {
        edm.name = [event objectForKey:@"name"];
    } else {
        edm.name = @"";
    }
    
    if ([[event objectForKey:@"start_date"] isKindOfClass:[NSString class]]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
        edm.startDate = [dateFormatter dateFromString:[event objectForKey:@"start_date"]];
    } else {
        edm.startDate = nil;
    }
    
    if ([[event objectForKey:@"end_date"] isKindOfClass:[NSString class]]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
        edm.endDate = [dateFormatter dateFromString:[event objectForKey:@"end_date"]];
    } else {
        edm.endDate = nil;
    }
    
    if ([[event objectForKey:@"location"] isKindOfClass:[NSString class]]) {
        edm.location = [event objectForKey:@"location"];
    } else {
        edm.location = @"";
    }
    
    if ([[event objectForKey:@"description"] isKindOfClass:[NSString class]]) {
        edm.description = [event objectForKey:@"description"];
    } else {
        edm.description = @"";
    }
    
    if ([[event objectForKey:@"stub"] isKindOfClass:[NSString class]]) {
        edm.stub    = [event objectForKey:@"stub"];
    } else {
        edm.stub    = @"";
    }
    
    if ([[event objectForKey:@"tz_continent"] isKindOfClass:[NSString class]]) {
        edm.tzContinent  = [event objectForKey:@"tz_continent"];
    } else {
        edm.tzContinent  = @"";
    }
    
    if ([[event objectForKey:@"tz_place"] isKindOfClass:[NSString class]]) {
        edm.tzPlace = [event objectForKey:@"tz_place"];
    } else {
        edm.tzPlace = @"";
    }
    
    if ([[event objectForKey:@"icon"] isKindOfClass:[NSString class]]) {
        edm.icon    = [event objectForKey:@"icon"];
    } else {
        edm.icon    = @"none.gif";
    }
    
    if ([[event objectForKey:@"hashtag"] isKindOfClass:[NSString class]]) {
        edm.hashtag = [event objectForKey:@"hashtag"];
    } else {
        edm.hashtag = nil;
    }
    
    if ([[event objectForKey:@"cfp_start_date"] isKindOfClass:[NSString class]]) {
        edm.cfpStartDate = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"cfp_start_date"] integerValue]];
    } else {
        edm.cfpStartDate = nil;
    }
    
    if ([[event objectForKey:@"cfp_end_date"] isKindOfClass:[NSString class]]) {
        edm.cfpEndDate  = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"cfp_end_date"] integerValue]];
    } else {
        edm.cfpEndDate  = nil;
    }
    
    if ([[event objectForKey:@"comments_enabled"] isKindOfClass:[NSNumber class]]) {
        edm.commentsEnabled = ([[event objectForKey:@"comments_enabled"] integerValue] == 1);
    } else {
        edm.commentsEnabled = NO;
    }

    if ([[event objectForKey:@"attendee_count"] isKindOfClass:[NSNumber class]]) {
        edm.attendeeCount   = [[event objectForKey:@"attendee_count"] integerValue];
    } else {
        edm.attendeeCount   = 0;
    }

    if ([[event objectForKey:@"event_comments_count"] isKindOfClass:[NSNumber class]]) {
        edm.eventCommentsCount = [[event objectForKey:@"event_comments_count"] integerValue];
    } else {
        edm.eventCommentsCount = 0;
    }

    // URIs
    if ([[event objectForKey:@"uri"] isKindOfClass:[NSString class]]) {
        edm.uri     = [event objectForKey:@"uri"];
    } else {
        edm.uri     = nil;
    }
    if ([[event objectForKey:@"verbose_uri"] isKindOfClass:[NSString class]]) {
        edm.verboseURI = [event objectForKey:@"verbose_uri"];
    } else {
        edm.verboseURI = nil;
    }
    if ([[event objectForKey:@"comments_uri"] isKindOfClass:[NSString class]]) {
        edm.commentsURI = [event objectForKey:@"comments_uri"];
    } else {
        edm.commentsURI = nil;
    }
    if ([[event objectForKey:@"talks_uri"] isKindOfClass:[NSString class]]) {
        edm.talksURI = [event objectForKey:@"talks_uri"];
    } else {
        edm.talksURI = nil;
    }
    if ([[event objectForKey:@"tracks_uri"] isKindOfClass:[NSString class]]) {
        edm.tracksURI = [event objectForKey:@"tracks_uri"];
    } else {
        edm.tracksURI = nil;
    }
    if ([[event objectForKey:@"attending_uri"] isKindOfClass:[NSString class]]) {
        edm.attendingURI = [event objectForKey:@"attending_uri"];
    } else {
        edm.attendingURI = nil;
    }
    if ([[event objectForKey:@"website_uri"] isKindOfClass:[NSString class]]) {
        edm.websiteURI = [event objectForKey:@"website_uri"];
    } else {
        edm.websiteURI = nil;
    }
    if ([[event objectForKey:@"humane_website_uri"] isKindOfClass:[NSString class]]) {
        edm.humaneWebsiteURI = [event objectForKey:@"humane_website_uri"];
    } else {
        edm.humaneWebsiteURI = nil;
    }
    if ([[event objectForKey:@"attendees_uri"] isKindOfClass:[NSString class]]) {
        edm.attendeesURI = [event objectForKey:@"attendees_uri"];
    } else {
        edm.attendeesURI = nil;
    }
    
    // Attending?
    edm.attending  = [[event objectForKey:@"attending"] boolValue];
	
	[self.delegate gotEventDetailData:edm error:nil];
	
	[edm release];
}

- (void)gotError:(APIError *)error {
	//NSLog(@"here");
	[self.delegate gotEventDetailData:nil error:error];
}

@end

@implementation APICaller (APICaller_EventGetDetail)
+ (EventGetDetail *)EventGetDetail:(id)_delegate {
	static EventGetDetail *e = nil;
	if (e != nil) {
		[e cancel];
		[e release];
	}	
	e = [[EventGetDetail alloc] initWithDelegate:_delegate];
	return e;
}
@end
