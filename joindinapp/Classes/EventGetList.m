//
//  EventGetList.m
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventGetList.h"
#import "EventListModel.h"
#import "EventDetailModel.h"
#import "JSON.h"

@implementation EventGetList

- (void)call:(NSString *)eventType {
	[self callAPI:@"event" action:@"getlist" params:[NSDictionary dictionaryWithObject:eventType forKey:@"event_type"]];
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
			edm.start = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"event_start"]   integerValue]];;
		} else {
			edm.start = nil;
		}
		
		if ([[event objectForKey:@"event_end"] isKindOfClass:[NSString class]]) {
			edm.end = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"event_end"]   integerValue]];;
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
		
		if ([[event objectForKey:@"event_tz"] isKindOfClass:[NSString class]]) {
			edm.tzOffset = [[event objectForKey:@"event_tz"] integerValue];
		} else {
			edm.tzOffset = 0;
		}
		
		if ([[event objectForKey:@"event_icon"] isKindOfClass:[NSString class]]) {
			edm.icon    = [event objectForKey:@"event_icon"];
		} else {
			edm.icon    = @"none.gif";
		}
		
		if ([[event objectForKey:@"pending"] isKindOfClass:[NSString class]]) {
			edm.pending = ([[[event objectForKey:@"pending"] lowercaseString] compare:@"y"] == NSOrderedSame);
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
			edm.voting  = ([[[event objectForKey:@"event_voting"] lowercaseString] compare:@"y"] == NSOrderedSame);
		} else {
			edm.voting  = NO;
		}
		
		if ([[event objectForKey:@"private"] isKindOfClass:[NSString class]]) {
			edm.private = ([[[event objectForKey:@"private"] lowercaseString] compare:@"y"] == NSOrderedSame);
		} else {
			edm.private = NO;
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
		
		if ([[event objectForKey:@"user_attending"] isKindOfClass:[NSString class]]) {
			edm.userAttend  = ([[[event objectForKey:@"user_attending"] lowercaseString] compare:@"y"] == NSOrderedSame);
		} else {
			edm.userAttend  = NO;
		}
		
		

		
		if (edm.active && !edm.pending && !edm.private && ((!limit) || (limit && edm.userAttend))) {
			[elm addEvent:edm];
		}
		
		[edm release];
	}
	
	[self.delegate gotEventListData:elm];
	
}

- (void)gotError:(NSObject *)error {
	NSLog(@"Got error");
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
