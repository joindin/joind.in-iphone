//
//  TalkGetComments.m
//  joindinapp
//
//  Created by Kevin on 09/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TalkGetComments.h"


@implementation TalkGetComments

- (void)call:(TalkDetailModel *)talk {
	[self callAPI:@"talk" action:@"getcomments" params:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", talk.Id] forKey:@"talk_id"] needAuth:NO canCache:YES];
}

- (void)gotData:(NSObject *)obj {
	TalkCommentListModel *tclm = [[[TalkCommentListModel alloc] init] autorelease];
	
	NSDictionary *d = (NSDictionary *)obj;
	for (NSDictionary *comment in d) {
		TalkCommentDetailModel *tcdm = [[TalkCommentDetailModel alloc] init];
		
		if ([[comment objectForKey:@"ID"] isKindOfClass:[NSString class]]) {
			tcdm.Id = [[comment objectForKey:@"ID"] integerValue];
		} else {
			tcdm.Id = 0;
		}
		
		if ([[comment objectForKey:@"active"] isKindOfClass:[NSString class]]) {
			tcdm.active = ([[[comment objectForKey:@"active"] lowercaseString] compare:@"y"] == NSOrderedSame);
		} else if ([[comment objectForKey:@"active"] isKindOfClass:[NSNumber class]]) {
			tcdm.active = ([[comment objectForKey:@"active"] boolValue]);
		} else {
			NSLog(@"Can't recognise type %@", [[comment objectForKey:@"active"] class]);
		}		
		
		if ([[comment objectForKey:@"comment"] isKindOfClass:[NSString class]]) {
			tcdm.comment = [comment objectForKey:@"comment"];
		} else {
			tcdm.comment = @"";
		}
		
		if ([[comment objectForKey:@"type"] isKindOfClass:[NSString class]]) {
			tcdm.type = [comment objectForKey:@"type"];
		} else {
			tcdm.type = @"";
		}
		
		if ([[comment objectForKey:@"date_made"] isKindOfClass:[NSString class]]) {
			tcdm.made = [NSDate dateWithTimeIntervalSince1970:[[comment objectForKey:@"date_made"] integerValue]];
		} else {
			tcdm.made = nil;
		}
		
		if ([[comment objectForKey:@"private"] isKindOfClass:[NSString class]]) {
			tcdm.private = ([[[comment objectForKey:@"private"] lowercaseString] compare:@"y"] == NSOrderedSame);
		} else if ([[comment objectForKey:@"private"] isKindOfClass:[NSNumber class]]) {
			tcdm.private = ([[comment objectForKey:@"private"] boolValue]);
		} else {
			NSLog(@"Can't recognise type %@", [[comment objectForKey:@"private"] class]);
		}		
		
		if ([[comment objectForKey:@"rating"] isKindOfClass:[NSString class]]) {
			tcdm.rating = [[comment objectForKey:@"rating"] integerValue];
		} else {
			tcdm.rating = 0;
		}
		
		if ([[comment objectForKey:@"talk_id"] isKindOfClass:[NSString class]]) {
			tcdm.talkId = [[comment objectForKey:@"talk_id"] integerValue];
		} else {
			tcdm.talkId = 0;
		}
		
		if ([[comment objectForKey:@"uname"] isKindOfClass:[NSString class]]) {
			tcdm.username = [comment objectForKey:@"uname"];
		} else {
			tcdm.username = @"ANONYMOUS";
		}
		
		if ([[comment objectForKey:@"user_id"] isKindOfClass:[NSString class]]) {
			tcdm.userId = [[comment objectForKey:@"user_id"] integerValue];
		} else {
			tcdm.userId = 0;
		}
		
		
		//if (tdm.active && !tdm.private) {
		[tclm addComment:tcdm];
		//}
		[tcdm release];
		
	}
	[self.delegate gotTalkComments:tclm error:nil];
		
}

- (void)gotError:(NSObject *)error {
	NSLog(@"Got talk comments error %@", error);
}

@end

@implementation APICaller (APICaller_TalkGetComments)
+ (TalkGetComments *)TalkGetComments:(id)_delegate {
	static TalkGetComments *e = nil;
	if (e != nil) {
		[e cancel];
		[e release];
	}
	e = [[TalkGetComments alloc] initWithDelegate:_delegate];
	return e;
}
@end
