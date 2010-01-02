//
//  EventGetEventList.m
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventGetEventList.h"
#import "EventListModel.h"
#import "EventDetailModel.h"

@implementation EventGetEventList

- (void)call:(NSString *)eventType {
	[self callAPI:@"event" action:@"getlist" params:[NSDictionary dictionaryWithObject:eventType forKey:@"event_type"]];
}

- (void)gotData:(NSObject *)obj {
	NSLog(@"Got data: %@", obj);
	
	NSDictionary *d = (NSDictionary *)obj;
	
	EventListModel *elm = [[[EventListModel alloc] init] autorelease];
	
	for (NSDictionary *event in d) {
		
		//NSLog(@"Event is %@", event);
		EventDetailModel *edm = [[EventDetailModel alloc] init];
		edm.name        = [event objectForKey:@"event_name"];
		edm.start       = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"event_start"] integerValue]];
		edm.end         = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"event_end"]   integerValue]];
		edm.Id          = [[event objectForKey:@"ID"] integerValue];
		edm.location    = [event objectForKey:@"event_loc"];
		edm.description = [event objectForKey:@"event_desc"];
		edm.active      = [[event objectForKey:@"active"] integerValue];
		edm.stub        = [event objectForKey:@"event_stub"];
		edm.tzOffset    = [[event objectForKey:@"event_tz"] integerValue];
		
		if (edm.active == 1) {
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

@implementation APICaller (APICaller_EventGetEventList)
+ (EventGetEventList *)EventGetEventList:(id)_delegate {
	EventGetEventList *e = [[EventGetEventList alloc] initWithDelegate:_delegate];
	return e;
}
@end