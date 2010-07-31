//
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
			ecdm.username = @"ANONYMOUS";
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
