//
//  EventAttend.m
//  joindinapp
//
//  Created by Kevin on 08/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventAttend.h"
#import "APICaller.h"

@implementation EventAttend

- (void)call:(EventDetailModel *)event {
	[self callAPI:@"event" action:@"attend" params:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", event.Id] forKey:@"eid"] needAuth:YES canCache:NO];
}

- (void)gotData:(NSObject *)obj {
	NSDictionary *d = (NSDictionary *)obj;
	if ([[d objectForKey:@"msg"] isEqualToString:@"Success"]) {
		[self.delegate gotEventAttend:nil];
	} else {
		APIError *e = [APIError APIErrorWithMsg:[d objectForKey:@"msg"] type:ERR_UNKNOWN];
		[self.delegate gotEventAttend:e];
	}
}

- (void)gotError:(NSObject *)error {
	NSLog(@"Got error %@", error);
}

@end

@implementation APICaller (APICaller_EventAttend)
+ (EventAttend *)EventAttend:(id)_delegate {
	static EventAttend *e = nil;
	if (e != nil) {
		[e cancel];
		[e release];
	}
	e = [[EventAttend alloc] initWithDelegate:_delegate];
	return e;
}
@end

