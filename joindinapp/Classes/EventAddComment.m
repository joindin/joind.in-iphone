//
//  EventAddComment.m
//  joindinapp
//
//  Created by Kevin on 14/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventAddComment.h"


@implementation EventAddComment

- (void)call:(EventDetailModel *)event comment:(NSString *)comment {
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
	[params setObject:[NSString stringWithFormat:@"%d", event.Id] forKey:@"event_id"];
	[params setObject:comment forKey:@"comment"];
	[self callAPI:@"event" action:@"addcomment" params:params needAuth:YES canCache:NO];
}

- (void)gotData:(NSObject *)obj {
	id _msg = [((NSDictionary *)obj) objectForKey:@"msg"];
	
	if ([_msg isKindOfClass:[NSString class]] && [_msg isEqualToString:@"Comment added!"]) {
		[self.delegate gotAddedEventComment:nil];
	} else {
		// Detect if obj.msg is an array, and if so then collapse it
		NSMutableString *msg = [NSMutableString stringWithCapacity:0];
		if ([_msg isKindOfClass:[NSArray class]]) {
			for(NSString *msgs in _msg) {
				if ([msg length] > 1) {
					[msg appendString:@", "];
				}
				[msg appendString:msgs];
			}
		} else {
			[msg appendString:_msg];
		}
		[self gotError:[APIError APIErrorWithMsg:msg type:ERR_UNKNOWN]];
	}
}

- (void)gotError:(APIError *)error {
	[self.delegate gotAddedEventComment:error];
}

@end

@implementation APICaller (APICaller_EventAddComment)
+ (EventAddComment *)EventAddComment:(id)_delegate {
	static EventAddComment *e = nil;
	if (e != nil) {
		[e cancel];
		[e release];
	}
	e = [[EventAddComment alloc] initWithDelegate:_delegate];
	return e;
}
@end
