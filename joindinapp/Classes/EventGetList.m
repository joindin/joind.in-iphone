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

#import "EventGetList.h"
#import "EventListModel.h"
#import "EventDetailModel.h"
#import "JSON.h"

@implementation EventGetList

- (void)call:(NSString *)eventType {
	[self callAPI:@"event" action:@"getlist" params:[NSDictionary dictionaryWithObject:eventType forKey:@"event_type"] needAuth:YES];
}

- (void)gotData:(NSObject *)obj {
	
	NSDictionary *d = (NSDictionary *)obj;
	
	EventListModel *elm = [[[EventListModel alloc] init] autorelease];
	
	NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
	BOOL limit = [userPrefs boolForKey:@"limitevents"];

	
	for (NSDictionary *event in d) {
		
		//NSLog(@"Event is %@", event);
		EventDetailModel *edm = [[EventDetailModel alloc] init];
		
		if ([[event objectForKey:@"event_name"] isKindOfClass:[NSString class]]) {
			edm.name = [event objectForKey:@"event_name"];
		} else {
			edm.name = @"";
		}
		
		
		if ([[event objectForKey:@"event_start"] isKindOfClass:[NSString class]]) {
			edm.start = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"event_start"]   integerValue]];
		} else {
			edm.start = nil;
		}
		
		if ([[event objectForKey:@"event_end"] isKindOfClass:[NSString class]]) {
			edm.end = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"event_end"]   integerValue]];
		} else {
			edm.end = nil;
		}
		
		if ([[event objectForKey:@"ID"] isKindOfClass:[NSString class]]) {
			edm.Id = [[event objectForKey:@"ID"] integerValue];
		} else {
			edm.Id = 0;
		}
		
		if ([[event objectForKey:@"event_loc"] isKindOfClass:[NSString class]]) {
			edm.location = [event objectForKey:@"event_loc"];
		} else {
			edm.location = @"";
		}
		
		if ([[event objectForKey:@"event_desc"] isKindOfClass:[NSString class]]) {
			edm.description = [event objectForKey:@"event_desc"];
		} else {
			edm.description = @"";
		}
		
		if ([[event objectForKey:@"active"] isKindOfClass:[NSString class]]) {
			edm.active  = ([[event objectForKey:@"active"] integerValue] == 1);
		} else {
			edm.active  = NO;
		}
		
		if ([[event objectForKey:@"event_stub"] isKindOfClass:[NSString class]]) {
			edm.stub    = [event objectForKey:@"event_stub"];
		} else {
			edm.stub    = @"";
		}
		
		if ([[event objectForKey:@"event_tz_cont"] isKindOfClass:[NSString class]]) {
			edm.tzCont  = [event objectForKey:@"event_tz_cont"];
		} else {
			edm.tzCont  = @"";
		}
		
		if ([[event objectForKey:@"event_tz_place"] isKindOfClass:[NSString class]]) {
			edm.tzPlace = [event objectForKey:@"event_tz_place"];
		} else {
			edm.tzPlace = @"";
		}
		
		if ([[event objectForKey:@"event_icon"] isKindOfClass:[NSString class]]) {
			edm.icon    = [event objectForKey:@"event_icon"];
		} else {
			edm.icon    = @"none.gif";
		}
		
		if ([[event objectForKey:@"pending"] isKindOfClass:[NSString class]]) {
			edm.pending = ([[[event objectForKey:@"pending"] lowercaseString] isEqualToString:@"y"]);
		} else {
			edm.pending = NO;
		}
		
		if ([[event objectForKey:@"event_hashtag"] isKindOfClass:[NSString class]]) {
			edm.hashtag = [event objectForKey:@"event_hashtag"];
		} else {
			edm.hashtag = nil;
		}
		
		if ([[event objectForKey:@"event_href"] isKindOfClass:[NSString class]]) {
			edm.url     = [event objectForKey:@"event_href"];
		} else {
			edm.url     = nil;
		}
		
		if ([[event objectForKey:@"event_cfp_start"] isKindOfClass:[NSString class]]) {
			edm.cfpStart = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"event_cfp_start"] integerValue]];
		} else {
			edm.cfpStart = nil;
		}
		
		if ([[event objectForKey:@"event_cfp_end"] isKindOfClass:[NSString class]]) {
			edm.cfpEnd  = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"event_cfp_end"] integerValue]];
		} else {
			edm.cfpEnd  = nil;
		}
		
		if ([[event objectForKey:@"event_voting"] isKindOfClass:[NSString class]]) {
			edm.voting  = ([[[event objectForKey:@"event_voting"] lowercaseString] isEqualToString:@"y"]);
		} else {
			edm.voting  = NO;
		}
		
		if ([[event objectForKey:@"private"] isKindOfClass:[NSString class]]) {
			edm.private = ([[[event objectForKey:@"private"] lowercaseString] isEqualToString:@"y"]);
		} else {
			edm.private = NO;
		}
		
		if ([[event objectForKey:@"allow_comments"] isKindOfClass:[NSString class]]) {
			edm.allowComments = ([[[event objectForKey:@"allow_comments"] lowercaseString] isEqualToString:@"y"]);
		} else {
			edm.allowComments = NO;
		}
		
		if ([[event objectForKey:@"num_attend"] isKindOfClass:[NSString class]]) {
			edm.numAttend   = [[event objectForKey:@"num_attend"] integerValue];
		} else {
			edm.numAttend   = 0;
		}
		
		if ([[event objectForKey:@"num_comments"] isKindOfClass:[NSString class]]) {
			edm.numComments = [[event objectForKey:@"num_comments"] integerValue];
		} else {
			edm.numComments = 0;
		}
		
		// User attending logic is a bit weird in the API - there appears to be 3 possible responses:
		// 1     = "User logged in, user attending event"
		// 0     = "User not logged in"
		// false = "User logged in, user not attending event"
		
		if ([event objectForKey:@"user_attending"] == nil) {
			edm.isAuthd     = NO;
			edm.userAttend  = NO;
		} else {
			id attend = [event objectForKey:@"user_attending"];
			//NSLog(@"attending %i %@ type %@", attend, attend, [attend class]);
			
			if ([attend isKindOfClass:[NSString class]]) {
				
				edm.isAuthd    = NO;
				edm.userAttend = NO;
				
			} else if ([attend isKindOfClass:[NSNumber class]]) {
				
				edm.isAuthd    = YES;
				edm.userAttend = [attend boolValue];
				
			} else {
				
				NSLog(@"Can't recognise type %@", [attend class]);
				edm.isAuthd    = NO;
				edm.userAttend = NO;
			}
			
		}
		
		//NSLog(@"Attending %i Authd %i Obj %@ type %@", edm.userAttend, edm.isAuthd, [event objectForKey:@"user_attending"], [[event objectForKey:@"user_attending"] class]);
		
		if (edm.active && !edm.pending && !edm.private && ((!limit) || (limit && edm.userAttend))) {
			[elm addEvent:edm];
		}
		
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
