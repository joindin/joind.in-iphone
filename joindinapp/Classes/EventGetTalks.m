//
//  EventGetTalks.m
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventGetTalks.h"
#import "EventDetailModel.h"
#import "TalkListModel.h"
#import "TalkDetailModel.h"

@implementation EventGetTalks

- (void)call:(EventDetailModel *)event {
	[self callAPI:@"event" action:@"gettalks" params:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", event.Id] forKey:@"event_id"]];
}

- (void)gotData:(NSObject *)obj {
	TalkListModel *tlm = [[[TalkListModel alloc] init] autorelease];
	
	NSDictionary *d = (NSDictionary *)obj;
	for (NSDictionary *talk in d) {
		TalkDetailModel *tdm = [[TalkDetailModel alloc] init];
		tdm.title      = [talk objectForKey:@"talk_title"];
		tdm.speaker    = [talk objectForKey:@"speaker"];
		tdm.Id         = [[talk objectForKey:@"tid"] integerValue];
		tdm.eventId    = [[talk objectForKey:@"eid"] integerValue];
		tdm.slidesLink = [talk objectForKey:@"slides_link"];
		tdm.given      = [NSDate dateWithTimeIntervalSince1970:[[talk objectForKey:@"date_given"]   integerValue]];
		tdm.desc       = [talk objectForKey:@"talk_desc"];
		tdm.langName   = [talk objectForKey:@"lang_name"];
		tdm.lang       = [[talk objectForKey:@"lang"] integerValue];
		if ([talk objectForKey:@"rank"] != [NSNull null]) {
			tdm.rating = [[talk objectForKey:@"rank"] integerValue];
		}
		tdm.type       = [talk objectForKey:@"tcid"];
		
		[tlm addTalk:tdm];
		[tdm release];
		
	}
	[self.delegate gotTalksForEvent:tlm];
}

- (void)gotError:(NSObject *)error {
	NSLog(@"error");
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
