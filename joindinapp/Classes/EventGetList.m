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

#import "EventGetList.h"
#import "EventListModel.h"
#import "EventDetailModel.h"
#import "JSON.h"

@implementation EventGetList

- (void)call:(NSString *)eventType {
	[self callAPI:@"events" params:[NSDictionary dictionaryWithObject:eventType forKey:@"filter"] needAuth:YES];
}

- (void)gotData:(NSObject *)obj {
	
	NSDictionary *d = (NSDictionary *)obj;
    NSDictionary *events = (NSDictionary *)[d objectForKey:@"events"];
	
	EventListModel *elm = [[[EventListModel alloc] init] autorelease];
	
	NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];

	
	for (NSDictionary *event in events) {
		
		//NSLog(@"Event is %@", event);
		EventDetailModel *edm = [[EventDetailModel alloc] init];
		
		if ([[event objectForKey:@"name"] isKindOfClass:[NSString class]]) {
			edm.name = [event objectForKey:@"name"];
		} else {
			edm.name = @"";
		}
		
		
		if ([[event objectForKey:@"start_date"] isKindOfClass:[NSString class]]) {
			edm.start = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"start_date"]   integerValue]];
		} else {
			edm.start = nil;
		}
		
		if ([[event objectForKey:@"end_date"] isKindOfClass:[NSString class]]) {
			edm.end = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"end_date"]   integerValue]];
		} else {
			edm.end = nil;
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
			edm.tzCont  = [event objectForKey:@"tz_continent"];
		} else {
			edm.tzCont  = @"";
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
		
		if ([[event objectForKey:@"uri"] isKindOfClass:[NSString class]]) {
			edm.url     = [event objectForKey:@"uri"];
		} else {
			edm.url     = nil;
		}
		
		if ([[event objectForKey:@"cfp_start_date"] isKindOfClass:[NSString class]]) {
			edm.cfpStart = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"cfp_start_date"] integerValue]];
		} else {
			edm.cfpStart = nil;
		}
		
		if ([[event objectForKey:@"cfp_end_date"] isKindOfClass:[NSString class]]) {
			edm.cfpEnd  = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"cfp_end_date"] integerValue]];
		} else {
			edm.cfpEnd  = nil;
		}
		
        // FIXME boolean
		if ([[event objectForKey:@"comments_enabled"] isKindOfClass:[NSString class]]) {
			edm.allowComments = ([[[event objectForKey:@"comments_enabled"] lowercaseString] isEqualToString:@"y"]);
		} else {
			edm.allowComments = NO;
		}
		
		if ([[event objectForKey:@"attendee_count"] isKindOfClass:[NSString class]]) {
			edm.numAttend   = [[event objectForKey:@"attendee_count"] integerValue];
		} else {
			edm.numAttend   = 0;
		}
		
		if ([[event objectForKey:@"event_comments_count"] isKindOfClass:[NSString class]]) {
			edm.numComments = [[event objectForKey:@"event_comments_count"] integerValue];
		} else {
			edm.numComments = 0;
		}
		
		// Attending?
		edm.userAttend  = [[event objectForKey:@"attending"] boolValue];

		[elm addEvent:edm];
		
		[edm release];
	}
	
	//[elm sort];
	
	[self.delegate gotEventListData:elm error:nil];
	
}

- (void)gotError:(APIError *)error {
	[self.delegate gotEventListData:nil error:error];
}


@end

@implementation APICaller (APICaller_EventGetList)
+ (EventGetList *)EventGetList:(id)_delegate {
	static EventGetList *e = nil;
	if (e != nil) {
		[e cancel];
		[e release];
	}	
	e = [[EventGetList alloc] initWithDelegate:_delegate];
	return e;
}
@end
