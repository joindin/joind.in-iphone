//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the organisation (joind.in) nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
