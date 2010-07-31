//
//  EventGetDetail.m
//  joindinapp
//
//  Created by Kevin on 16/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventGetDetail.h"


@implementation EventGetDetail

- (void)call:(NSUInteger)eventId {
	[self callAPI:@"event" action:@"getdetail" params:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", eventId] forKey:@"event_id"] needAuth:YES canCache:YES];
}

- (void)gotData:(NSObject *)obj {
	
	//NSLog(@"Event is %@", event);
	EventDetailModel *edm = [[EventDetailModel alloc] init];
	NSDictionary *event = [(NSArray *)obj objectAtIndex:0];

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
		edm.allowComments = ([[[event objectForKey:@"allow_comments"] lowercaseString] isEqualToString:@"1"]);
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
	} else if ([[event objectForKey:@"ccount"] isKindOfClass:[NSString class]]) {
		edm.numComments = [[event objectForKey:@"ccount"] integerValue];
	} else {
		edm.numComments = 0;
	}
	
	if ([[event objectForKey:@"event_lat"] isKindOfClass:[NSString class]]) {
		edm.event_lat = [[event objectForKey:@"event_lat"] floatValue];
	} else {
		edm.numComments = 0;
	}
	
	if ([[event objectForKey:@"event_long"] isKindOfClass:[NSString class]]) {
		edm.event_long = [[event objectForKey:@"event_long"] floatValue];
	} else {
		edm.numComments = 0;
	}
	
	
	if ([[event objectForKey:@"tracks"] isKindOfClass:[NSArray class]]) {
		NSArray *tks = [event objectForKey:@"tracks"];
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
			
			[edm.tracks addTrack:tkdm];
			[tkdm release];
		}
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
