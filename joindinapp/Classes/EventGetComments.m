//
//  EventGetComments.m
//  joindinapp
//
//  Created by Kevin on 25/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventGetComments.h"


@implementation EventGetComments

- (void)call:(EventDetailModel *)event {
	[self callAPI:@"event" action:@"getcomments" params:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", event.Id] forKey:@"event_id"] needAuth:NO canCache:YES];
}

- (void)gotData:(NSObject *)obj {
	EventCommentListModel *eclm = [[[EventCommentListModel alloc] init] autorelease];
	
	NSDictionary *d = (NSDictionary *)obj;
	for (NSDictionary *comment in d) {
		EventCommentDetailModel *ecdm = [[EventCommentDetailModel alloc] init];
		
		if ([[comment objectForKey:@"ID"] isKindOfClass:[NSString class]]) {
			ecdm.Id = [[comment objectForKey:@"ID"] integerValue];
		} else {
			ecdm.Id = 0;
		}
		
		if ([[comment objectForKey:@"active"] isKindOfClass:[NSString class]]) {
			ecdm.active = [[[comment objectForKey:@"active"] lowercaseString] isEqualToString:@"y"];
		} else if ([[comment objectForKey:@"active"] isKindOfClass:[NSNumber class]]) {
			ecdm.active = ([[comment objectForKey:@"active"] boolValue]);
		} else {
			NSLog(@"Can't recognise type %@", [[comment objectForKey:@"active"] class]);
		}		
		
		if ([[comment objectForKey:@"comment"] isKindOfClass:[NSString class]]) {
			ecdm.comment = [comment objectForKey:@"comment"];
		} else {
			ecdm.comment = @"";
		}
		
		if ([[comment objectForKey:@"date_made"] isKindOfClass:[NSString class]]) {
			ecdm.made = [NSDate dateWithTimeIntervalSince1970:[[comment objectForKey:@"date_made"] integerValue]];
		} else {
			ecdm.made = nil;
		}
		
		if ([[comment objectForKey:@"private"] isKindOfClass:[NSString class]]) {
			ecdm.private = [[[comment objectForKey:@"private"] lowercaseString] isEqualToString:@"y"];
		} else if ([[comment objectForKey:@"private"] isKindOfClass:[NSNumber class]]) {
			ecdm.private = ([[comment objectForKey:@"private"] boolValue]);
		} else {
			NSLog(@"Can't recognise type %@", [[comment objectForKey:@"private"] class]);
		}		
		
		if ([[comment objectForKey:@"event_id"] isKindOfClass:[NSString class]]) {
			ecdm.eventId = [[comment objectForKey:@"event_id"] integerValue];
		} else {
			ecdm.eventId = 0;
		}
		
		if ([[comment objectForKey:@"cname"] isKindOfClass:[NSString class]]) {
			ecdm.username = [comment objectForKey:@"cname"];
		} else {
			ecdm.username = @"";
		}
		
		if ([[comment objectForKey:@"user_id"] isKindOfClass:[NSString class]]) {
			ecdm.userId = [[comment objectForKey:@"user_id"] integerValue];
		} else {
			ecdm.userId = 0;
		}
		
		
		//if (tdm.active && !tdm.private) {
		[eclm addComment:ecdm];
		//}
		[ecdm release];
		
	}
	[self.delegate gotEventComments:eclm error:nil];
	
}

- (void)gotError:(NSObject *)error {
	NSLog(@"Got event comments error %@", error);
}

@end

@implementation APICaller (APICaller_EventGetComments)
+ (EventGetComments *)EventGetComments:(id)_delegate {
	static EventGetComments *e = nil;
	if (e != nil) {
		[e cancel];
		[e release];
	}
	e = [[EventGetComments alloc] initWithDelegate:_delegate];
	return e;
}
@end
